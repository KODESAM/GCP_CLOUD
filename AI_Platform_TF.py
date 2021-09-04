AI Platform: Qwik Start
This lab gives you an introductory, end-to-end experience of training and prediction on AI Platform. The lab will use a census dataset to:

Create a TensorFlow 2.x training application and validate it locally.
Run your training job on a single worker instance in the cloud.
Deploy a model to support prediction.
Request an online prediction and see the response.
import os
Step 1: Get your training data
The relevant data files, adult.data and adult.test, are hosted in a public Cloud Storage bucket.

You can read the files directly from Cloud Storage or copy them to your local environment. For this lab you will download the samples for local training, and later upload them to your own Cloud Storage bucket for cloud training.

Run the following command to download the data to a local file directory and set variables that point to the downloaded data files:

%%bash
​
mkdir data
gsutil -m cp gs://cloud-samples-data/ml-engine/census/data/* data/
Copying gs://cloud-samples-data/ml-engine/census/data/adult.test.csv...
Copying gs://cloud-samples-data/ml-engine/census/data/adult.data.csv...
Copying gs://cloud-samples-data/ml-engine/census/data/test.json...
Copying gs://cloud-samples-data/ml-engine/census/data/census.train.csv...
Copying gs://cloud-samples-data/ml-engine/census/data/census.test.csv...
Copying gs://cloud-samples-data/ml-engine/census/data/test.csv...
/ [6/6 files][ 10.7 MiB/ 10.7 MiB] 100% Done                                    
Operation completed over 6 objects/10.7 MiB.                                     
%%bash
​
export TRAIN_DATA=$(pwd)/data/adult.data.csv
export EVAL_DATA=$(pwd)/data/adult.test.csv
Inspect what the data looks like by looking at the first couple of rows:

%%bash
​
head data/adult.data.csv
39, State-gov, 77516, Bachelors, 13, Never-married, Adm-clerical, Not-in-family, White, Male, 2174, 0, 40, United-States, <=50K
50, Self-emp-not-inc, 83311, Bachelors, 13, Married-civ-spouse, Exec-managerial, Husband, White, Male, 0, 0, 13, United-States, <=50K
38, Private, 215646, HS-grad, 9, Divorced, Handlers-cleaners, Not-in-family, White, Male, 0, 0, 40, United-States, <=50K
53, Private, 234721, 11th, 7, Married-civ-spouse, Handlers-cleaners, Husband, Black, Male, 0, 0, 40, United-States, <=50K
28, Private, 338409, Bachelors, 13, Married-civ-spouse, Prof-specialty, Wife, Black, Female, 0, 0, 40, Cuba, <=50K
37, Private, 284582, Masters, 14, Married-civ-spouse, Exec-managerial, Wife, White, Female, 0, 0, 40, United-States, <=50K
49, Private, 160187, 9th, 5, Married-spouse-absent, Other-service, Not-in-family, Black, Female, 0, 0, 16, Jamaica, <=50K
52, Self-emp-not-inc, 209642, HS-grad, 9, Married-civ-spouse, Exec-managerial, Husband, White, Male, 0, 0, 45, United-States, >50K
31, Private, 45781, Masters, 14, Never-married, Prof-specialty, Not-in-family, White, Female, 14084, 0, 50, United-States, >50K
42, Private, 159449, Bachelors, 13, Married-civ-spouse, Exec-managerial, Husband, White, Male, 5178, 0, 40, United-States, >50K
Step 2: Run a local training job
A local training job loads your Python training program and starts a training process in an environment that's similar to that of a live Cloud AI Platform cloud training job.

Step 2.1: Create files to hold the Python program
To do that, let's create three files. The first, called util.py, will contain utility methods for cleaning and preprocessing the data, as well as performing any feature engineering needed by transforming and normalizing the data.

%%bash
mkdir -p trainer
touch trainer/__init__.py
%%writefile trainer/util.py
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
​
import os
from six.moves import urllib
import tempfile
​
import numpy as np
import pandas as pd
import tensorflow as tf
​
# Storage directory
DATA_DIR = os.path.join(tempfile.gettempdir(), 'census_data')
​
# Download options.
DATA_URL = (
    'https://storage.googleapis.com/cloud-samples-data/ai-platform/census'
    '/data')
TRAINING_FILE = 'adult.data.csv'
EVAL_FILE = 'adult.test.csv'
TRAINING_URL = '%s/%s' % (DATA_URL, TRAINING_FILE)
EVAL_URL = '%s/%s' % (DATA_URL, EVAL_FILE)
​
# These are the features in the dataset.
# Dataset information: https://archive.ics.uci.edu/ml/datasets/census+income
_CSV_COLUMNS = [
    'age', 'workclass', 'fnlwgt', 'education', 'education_num',
    'marital_status', 'occupation', 'relationship', 'race', 'gender',
    'capital_gain', 'capital_loss', 'hours_per_week', 'native_country',
    'income_bracket'
]
​
# This is the label (target) we want to predict.
_LABEL_COLUMN = 'income_bracket'
​
# These are columns we will not use as features for training. There are many
# reasons not to use certain attributes of data for training. Perhaps their
# values are noisy or inconsistent, or perhaps they encode bias that we do not
# want our model to learn. For a deep dive into the features of this Census
# dataset and the challenges they pose, see the Introduction to ML Fairness
# Notebook: https://colab.research.google.com/github/google/eng-edu/blob
# /master/ml/cc/exercises/intro_to_fairness.ipynb
UNUSED_COLUMNS = ['fnlwgt', 'education', 'gender']
​
_CATEGORICAL_TYPES = {
    'workclass': pd.api.types.CategoricalDtype(categories=[
        'Federal-gov', 'Local-gov', 'Never-worked', 'Private', 'Self-emp-inc',
        'Self-emp-not-inc', 'State-gov', 'Without-pay'
    ]),
    'marital_status': pd.api.types.CategoricalDtype(categories=[
        'Divorced', 'Married-AF-spouse', 'Married-civ-spouse',
        'Married-spouse-absent', 'Never-married', 'Separated', 'Widowed'
    ]),
    'occupation': pd.api.types.CategoricalDtype([
        'Adm-clerical', 'Armed-Forces', 'Craft-repair', 'Exec-managerial',
        'Farming-fishing', 'Handlers-cleaners', 'Machine-op-inspct',
        'Other-service', 'Priv-house-serv', 'Prof-specialty', 'Protective-serv',
        'Sales', 'Tech-support', 'Transport-moving'
    ]),
    'relationship': pd.api.types.CategoricalDtype(categories=[
        'Husband', 'Not-in-family', 'Other-relative', 'Own-child', 'Unmarried',
        'Wife'
    ]),
    'race': pd.api.types.CategoricalDtype(categories=[
        'Amer-Indian-Eskimo', 'Asian-Pac-Islander', 'Black', 'Other', 'White'
    ]),
    'native_country': pd.api.types.CategoricalDtype(categories=[
        'Cambodia', 'Canada', 'China', 'Columbia', 'Cuba', 'Dominican-Republic',
        'Ecuador', 'El-Salvador', 'England', 'France', 'Germany', 'Greece',
        'Guatemala', 'Haiti', 'Holand-Netherlands', 'Honduras', 'Hong',
        'Hungary',
        'India', 'Iran', 'Ireland', 'Italy', 'Jamaica', 'Japan', 'Laos',
        'Mexico',
        'Nicaragua', 'Outlying-US(Guam-USVI-etc)', 'Peru', 'Philippines',
        'Poland',
        'Portugal', 'Puerto-Rico', 'Scotland', 'South', 'Taiwan', 'Thailand',
        'Trinadad&Tobago', 'United-States', 'Vietnam', 'Yugoslavia'
    ]),
    'income_bracket': pd.api.types.CategoricalDtype(categories=[
        '<=50K', '>50K'
    ])
}
​
​
def _download_and_clean_file(filename, url):
    """Downloads data from url, and makes changes to match the CSV format.
​
    The CSVs may use spaces after the comma delimters (non-standard) or include
    rows which do not represent well-formed examples. This function strips out
    some of these problems.
​
    Args:
      filename: filename to save url to
      url: URL of resource to download
    """
    temp_file, _ = urllib.request.urlretrieve(url)
    with tf.io.gfile.GFile(temp_file, 'r') as temp_file_object:
        with tf.io.gfile.GFile(filename, 'w') as file_object:
            for line in temp_file_object:
                line = line.strip()
                line = line.replace(', ', ',')
                if not line or ',' not in line:
                    continue
                if line[-1] == '.':
                    line = line[:-1]
                line += '\n'
                file_object.write(line)
    tf.io.gfile.remove(temp_file)
​
​
def download(data_dir):
    """Downloads census data if it is not already present.
​
    Args:
      data_dir: directory where we will access/save the census data
    """
    tf.io.gfile.makedirs(data_dir)
​
    training_file_path = os.path.join(data_dir, TRAINING_FILE)
    if not tf.io.gfile.exists(training_file_path):
        _download_and_clean_file(training_file_path, TRAINING_URL)
​
    eval_file_path = os.path.join(data_dir, EVAL_FILE)
    if not tf.io.gfile.exists(eval_file_path):
        _download_and_clean_file(eval_file_path, EVAL_URL)
​
    return training_file_path, eval_file_path
​
​
def preprocess(dataframe):
    """Converts categorical features to numeric. Removes unused columns.
​
    Args:
      dataframe: Pandas dataframe with raw data
​
    Returns:
      Dataframe with preprocessed data
    """
    dataframe = dataframe.drop(columns=UNUSED_COLUMNS)
​
    # Convert integer valued (numeric) columns to floating point
    numeric_columns = dataframe.select_dtypes(['int64']).columns
    dataframe[numeric_columns] = dataframe[numeric_columns].astype('float32')
​
    # Convert categorical columns to numeric
    cat_columns = dataframe.select_dtypes(['object']).columns
    dataframe[cat_columns] = dataframe[cat_columns].apply(lambda x: x.astype(
        _CATEGORICAL_TYPES[x.name]))
    dataframe[cat_columns] = dataframe[cat_columns].apply(lambda x: x.cat.codes)
    return dataframe
​
​
def standardize(dataframe):
    """Scales numerical columns using their means and standard deviation to get
    z-scores: the mean of each numerical column becomes 0, and the standard
    deviation becomes 1. This can help the model converge during training.
​
    Args:
      dataframe: Pandas dataframe
​
    Returns:
      Input dataframe with the numerical columns scaled to z-scores
    """
    dtypes = list(zip(dataframe.dtypes.index, map(str, dataframe.dtypes)))
    # Normalize numeric columns.
    for column, dtype in dtypes:
        if dtype == 'float32':
            dataframe[column] -= dataframe[column].mean()
            dataframe[column] /= dataframe[column].std()
    return dataframe
​
​
def load_data():
    """Loads data into preprocessed (train_x, train_y, eval_y, eval_y)
    dataframes.
​
    Returns:
      A tuple (train_x, train_y, eval_x, eval_y), where train_x and eval_x are
      Pandas dataframes with features for training and train_y and eval_y are
      numpy arrays with the corresponding labels.
    """
    # Download Census dataset: Training and eval csv files.
    training_file_path, eval_file_path = download(DATA_DIR)
​
    # This census data uses the value '?' for missing entries. We use
    # na_values to
    # find ? and set it to NaN.
    # https://pandas.pydata.org/pandas-docs/stable/generated/pandas.read_csv
    # .html
    train_df = pd.read_csv(training_file_path, names=_CSV_COLUMNS,
                           na_values='?')
    eval_df = pd.read_csv(eval_file_path, names=_CSV_COLUMNS, na_values='?')
​
    train_df = preprocess(train_df)
    eval_df = preprocess(eval_df)
​
    # Split train and eval data with labels. The pop method copies and removes
    # the label column from the dataframe.
    train_x, train_y = train_df, train_df.pop(_LABEL_COLUMN)
    eval_x, eval_y = eval_df, eval_df.pop(_LABEL_COLUMN)
​
    # Join train_x and eval_x to normalize on overall means and standard
    # deviations. Then separate them again.
    all_x = pd.concat([train_x, eval_x], keys=['train', 'eval'])
    all_x = standardize(all_x)
    train_x, eval_x = all_x.xs('train'), all_x.xs('eval')
​
    # Reshape label columns for use with tf.data.Dataset
    train_y = np.asarray(train_y).astype('float32').reshape((-1, 1))
    eval_y = np.asarray(eval_y).astype('float32').reshape((-1, 1))
​
    return train_x, train_y, eval_x, eval_y
Writing trainer/util.py
The second file, called model.py, defines the input function and the model architecture. In this example, we use tf.data API for the data pipeline and create the model using the Keras Sequential API. We define a DNN with an input layer and 3 additonal layers using the Relu activation function. Since the task is a binary classification, the output layer uses the sigmoid activation.

%%writefile trainer/model.py
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
​
import tensorflow as tf
​
​
def input_fn(features, labels, shuffle, num_epochs, batch_size):
    """Generates an input function to be used for model training.
​
    Args:
      features: numpy array of features used for training or inference
      labels: numpy array of labels for each example
      shuffle: boolean for whether to shuffle the data or not (set True for
        training, False for evaluation)
      num_epochs: number of epochs to provide the data for
      batch_size: batch size for training
​
    Returns:
      A tf.data.Dataset that can provide data to the Keras model for training or
        evaluation
    """
    if labels is None:
        inputs = features
    else:
        inputs = (features, labels)
    dataset = tf.data.Dataset.from_tensor_slices(inputs)
​
    if shuffle:
        dataset = dataset.shuffle(buffer_size=len(features))
​
    # We call repeat after shuffling, rather than before, to prevent separate
    # epochs from blending together.
    dataset = dataset.repeat(num_epochs)
    dataset = dataset.batch(batch_size)
    return dataset
​
​
def create_keras_model(input_dim, learning_rate):
    """Creates Keras Model for Binary Classification.
​
    The single output node + Sigmoid activation makes this a Logistic
    Regression.
​
    Args:
      input_dim: How many features the input has
      learning_rate: Learning rate for training
​
    Returns:
      The compiled Keras model (still needs to be trained)
    """
    Dense = tf.keras.layers.Dense
    model = tf.keras.Sequential(
        [
            Dense(100, activation=tf.nn.relu, kernel_initializer='uniform',
                  input_shape=(input_dim,)),
            Dense(75, activation=tf.nn.relu),
            Dense(50, activation=tf.nn.relu),
            Dense(25, activation=tf.nn.relu),
            Dense(1, activation=tf.nn.sigmoid)
        ])
​
    # Custom Optimizer:
    # https://www.tensorflow.org/api_docs/python/tf/train/RMSPropOptimizer
    optimizer = tf.keras.optimizers.RMSprop(lr=learning_rate)
​
    # Compile Keras model
    model.compile(
        loss='binary_crossentropy', optimizer=optimizer, metrics=['accuracy'])
    return model
Writing trainer/model.py
The last file, called task.py, trains on data loaded and preprocessed in util.py. Using the tf.distribute.MirroredStrategy() scope, it is possible to train on a distributed fashion. The trained model is then saved in a TensorFlow SavedModel format.

%%writefile trainer/task.py
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
​
import argparse
import os
​
from . import model
from . import util
​
import tensorflow as tf
​
​
def get_args():
    """Argument parser.
​
    Returns:
      Dictionary of arguments.
    """
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--job-dir',
        type=str,
        required=True,
        help='local or GCS location for writing checkpoints and exporting '
             'models')
    parser.add_argument(
        '--num-epochs',
        type=int,
        default=20,
        help='number of times to go through the data, default=20')
    parser.add_argument(
        '--batch-size',
        default=128,
        type=int,
        help='number of records to read during each training step, default=128')
    parser.add_argument(
        '--learning-rate',
        default=.01,
        type=float,
        help='learning rate for gradient descent, default=.01')
    parser.add_argument(
        '--verbosity',
        choices=['DEBUG', 'ERROR', 'FATAL', 'INFO', 'WARN'],
        default='INFO')
    args, _ = parser.parse_known_args()
    return args
​
​
def train_and_evaluate(args):
    """Trains and evaluates the Keras model.
​
    Uses the Keras model defined in model.py and trains on data loaded and
    preprocessed in util.py. Saves the trained model in TensorFlow SavedModel
    format to the path defined in part by the --job-dir argument.
​
    Args:
      args: dictionary of arguments - see get_args() for details
    """
​
    train_x, train_y, eval_x, eval_y = util.load_data()
​
    # dimensions
    num_train_examples, input_dim = train_x.shape
    num_eval_examples = eval_x.shape[0]
​
    # Create the Keras Model
    keras_model = model.create_keras_model(
        input_dim=input_dim, learning_rate=args.learning_rate)
​
    # Pass a numpy array by passing DataFrame.values
    training_dataset = model.input_fn(
        features=train_x.values,
        labels=train_y,
        shuffle=True,
        num_epochs=args.num_epochs,
        batch_size=args.batch_size)
​
    # Pass a numpy array by passing DataFrame.values
    validation_dataset = model.input_fn(
        features=eval_x.values,
        labels=eval_y,
        shuffle=False,
        num_epochs=args.num_epochs,
        batch_size=num_eval_examples)
​
    # Setup Learning Rate decay.
    lr_decay_cb = tf.keras.callbacks.LearningRateScheduler(
        lambda epoch: args.learning_rate + 0.02 * (0.5 ** (1 + epoch)),
        verbose=True)
​
    # Setup TensorBoard callback.
    tensorboard_cb = tf.keras.callbacks.TensorBoard(
        os.path.join(args.job_dir, 'keras_tensorboard'),
        histogram_freq=1)
​
    # Train model
    keras_model.fit(
        training_dataset,
        steps_per_epoch=int(num_train_examples / args.batch_size),
        epochs=args.num_epochs,
        validation_data=validation_dataset,
        validation_steps=1,
        verbose=1,
        callbacks=[lr_decay_cb, tensorboard_cb])
​
    export_path = os.path.join(args.job_dir, 'keras_export')
    tf.keras.models.save_model(keras_model, export_path)
    print('Model exported to: {}'.format(export_path))
​
​
​
if __name__ == '__main__':
    strategy = tf.distribute.MirroredStrategy()
    with strategy.scope():
        args = get_args()
        tf.compat.v1.logging.set_verbosity(args.verbosity)
        train_and_evaluate(args)
​
Writing trainer/task.py
Step 2.2: Run a training job locally using the Python training program
NOTE When you run the same training job on AI Platform later in the lab, you'll see that the command is not much different from the above.

Specify an output directory and set a MODEL_DIR variable to hold the trained model, then run the training job locally by running the following command (by default, verbose logging is turned off. You can enable it by setting the --verbosity tag to DEBUG):

%%bash
​
MODEL_DIR=output
gcloud ai-platform local train \
    --module-name trainer.task \
    --package-path trainer/ \
    --job-dir $MODEL_DIR \
    -- \
    --train-files $TRAIN_DATA \
    --eval-files $EVAL_DATA \
    --train-steps 1000 \
    --eval-steps 100
Train for 254 steps, validate for 1 steps

Epoch 00001: LearningRateScheduler reducing learning rate to 0.02.
Epoch 1/20
254/254 [==============================] - 8s 30ms/step - loss: 0.4863 - accuracy: 0.7997 - val_loss: 0.4189 - val_accuracy: 0.8248

Epoch 00002: LearningRateScheduler reducing learning rate to 0.015.
Epoch 2/20
254/254 [==============================] - 3s 11ms/step - loss: 0.3627 - accuracy: 0.8348 - val_loss: 0.3804 - val_accuracy: 0.8387

Epoch 00003: LearningRateScheduler reducing learning rate to 0.0125.
Epoch 3/20
254/254 [==============================] - 2s 8ms/step - loss: 0.3438 - accuracy: 0.8414 - val_loss: 0.3451 - val_accuracy: 0.8365

Epoch 00004: LearningRateScheduler reducing learning rate to 0.01125.
Epoch 4/20
254/254 [==============================] - 2s 10ms/step - loss: 0.3388 - accuracy: 0.8418 - val_loss: 0.3444 - val_accuracy: 0.8456

Epoch 00005: LearningRateScheduler reducing learning rate to 0.010625.
Epoch 5/20
254/254 [==============================] - 3s 12ms/step - loss: 0.3347 - accuracy: 0.8452 - val_loss: 0.3309 - val_accuracy: 0.8509

Epoch 00006: LearningRateScheduler reducing learning rate to 0.0103125.
Epoch 6/20
254/254 [==============================] - 3s 10ms/step - loss: 0.3324 - accuracy: 0.8471 - val_loss: 0.3260 - val_accuracy: 0.8481

Epoch 00007: LearningRateScheduler reducing learning rate to 0.01015625.
Epoch 7/20
254/254 [==============================] - 2s 10ms/step - loss: 0.3312 - accuracy: 0.8470 - val_loss: 0.3325 - val_accuracy: 0.8460

Epoch 00008: LearningRateScheduler reducing learning rate to 0.010078125.
Epoch 8/20
254/254 [==============================] - 2s 8ms/step - loss: 0.3316 - accuracy: 0.8458 - val_loss: 0.3257 - val_accuracy: 0.8491

Epoch 00009: LearningRateScheduler reducing learning rate to 0.0100390625.
Epoch 9/20
254/254 [==============================] - 3s 11ms/step - loss: 0.3280 - accuracy: 0.8481 - val_loss: 0.3271 - val_accuracy: 0.8487

Epoch 00010: LearningRateScheduler reducing learning rate to 0.01001953125.
Epoch 10/20
254/254 [==============================] - 3s 11ms/step - loss: 0.3271 - accuracy: 0.8477 - val_loss: 0.3247 - val_accuracy: 0.8498

Epoch 00011: LearningRateScheduler reducing learning rate to 0.010009765625.
Epoch 11/20
254/254 [==============================] - 3s 11ms/step - loss: 0.3294 - accuracy: 0.8488 - val_loss: 0.3223 - val_accuracy: 0.8523

Epoch 00012: LearningRateScheduler reducing learning rate to 0.010004882812500001.
Epoch 12/20
254/254 [==============================] - 3s 10ms/step - loss: 0.3251 - accuracy: 0.8497 - val_loss: 0.3282 - val_accuracy: 0.8530

Epoch 00013: LearningRateScheduler reducing learning rate to 0.01000244140625.
Epoch 13/20
254/254 [==============================] - 2s 10ms/step - loss: 0.3255 - accuracy: 0.8487 - val_loss: 0.3192 - val_accuracy: 0.8515

Epoch 00014: LearningRateScheduler reducing learning rate to 0.010001220703125.
Epoch 14/20
254/254 [==============================] - 3s 10ms/step - loss: 0.3259 - accuracy: 0.8491 - val_loss: 0.3231 - val_accuracy: 0.8523

Epoch 00015: LearningRateScheduler reducing learning rate to 0.0100006103515625.
Epoch 15/20
254/254 [==============================] - 3s 11ms/step - loss: 0.3271 - accuracy: 0.8485 - val_loss: 0.3279 - val_accuracy: 0.8487

Epoch 00016: LearningRateScheduler reducing learning rate to 0.01000030517578125.
Epoch 16/20
254/254 [==============================] - 3s 10ms/step - loss: 0.3251 - accuracy: 0.8496 - val_loss: 0.3234 - val_accuracy: 0.8509

Epoch 00017: LearningRateScheduler reducing learning rate to 0.010000152587890625.
Epoch 17/20
254/254 [==============================] - 3s 10ms/step - loss: 0.3230 - accuracy: 0.8495 - val_loss: 0.3251 - val_accuracy: 0.8539

Epoch 00018: LearningRateScheduler reducing learning rate to 0.010000076293945313.
Epoch 18/20
254/254 [==============================] - 2s 9ms/step - loss: 0.3253 - accuracy: 0.8487 - val_loss: 0.3235 - val_accuracy: 0.8531

Epoch 00019: LearningRateScheduler reducing learning rate to 0.010000038146972657.
Epoch 19/20
254/254 [==============================] - 3s 10ms/step - loss: 0.3249 - accuracy: 0.8499 - val_loss: 0.3347 - val_accuracy: 0.8501

Epoch 00020: LearningRateScheduler reducing learning rate to 0.010000019073486329.
Epoch 20/20
254/254 [==============================] - 3s 10ms/step - loss: 0.3244 - accuracy: 0.8500 - val_loss: 0.3293 - val_accuracy: 0.8462
Model exported to: output/keras_export
2021-09-04 03:31:23.860960: I tensorflow/core/platform/profile_utils/cpu_utils.cc:94] CPU Frequency: 2299995000 Hz
2021-09-04 03:31:23.861339: I tensorflow/compiler/xla/service/service.cc:168] XLA service 0x55cb44fa4490 initialized for platform Host (this does not guarantee that XLA will be used). Devices:
2021-09-04 03:31:23.861372: I tensorflow/compiler/xla/service/service.cc:176]   StreamExecutor device (0): Host, Default Version
2021-09-04 03:31:23.862279: I tensorflow/core/common_runtime/process_util.cc:147] Creating new thread pool with default inter op setting: 2. Tune using inter_op_parallelism_threads for best performance.
WARNING:tensorflow:There are non-GPU devices in `tf.distribute.Strategy`, not using nccl allreduce.
2021-09-04 03:31:28.737289: I tensorflow/core/profiler/lib/profiler_session.cc:225] Profiler session started.
2021-09-04 03:31:35.573099: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:31:37.535756: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:31:39.963431: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:31:43.051260: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:31:45.668381: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:31:48.126797: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:31:50.290836: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:31:53.008727: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:31:55.910493: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:31:58.734188: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:32:01.425128: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:32:03.818775: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:32:06.321229: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:32:09.035474: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:32:11.738922: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:32:14.379213: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:32:16.684089: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:32:19.264984: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:32:21.844768: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:32:22.031842: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:32:22.271888: W tensorflow/core/kernels/data/generator_dataset_op.cc:103] Error occurred when finalizing GeneratorDataset iterator: Cancelled: Operation was cancelled
2021-09-04 03:32:22.720660: W tensorflow/python/util/util.cc:319] Sets are not currently considered sequences, but this may change in the future, so consider avoiding using them.
WARNING:tensorflow:From /opt/conda/lib/python3.7/site-packages/tensorflow_core/python/ops/resource_variable_ops.py:1786: calling BaseResourceVariable.__init__ (from tensorflow.python.ops.resource_variable_ops) with constraint is deprecated and will be removed in a future version.
Instructions for updating:
If using Keras pass *_constraint arguments to layers.
INFO:tensorflow:Assets written to: output/keras_export/assets
Check if the output has been written to the output folder:

%%bash
​
ls output/keras_export/
assets
saved_model.pb
variables
Step 2.3: Prepare input for prediction
To receive valid and useful predictions, you must preprocess input for prediction in the same way that training data was preprocessed. In a production system, you may want to create a preprocessing pipeline that can be used identically at training time and prediction time.

For this exercise, use the training package's data-loading code to select a random sample from the evaluation data. This data is in the form that was used to evaluate accuracy after each epoch of training, so it can be used to send test predictions without further preprocessing.

Run the following snippet of code to preprocess the raw data from the adult.test.csv file. Here, we are grabbing 5 examples to run predictions on:

from trainer import util
_, _, eval_x, eval_y = util.load_data()
​
prediction_input = eval_x.sample(5)
prediction_targets = eval_y[prediction_input.index]
Check the numerical representation of the features by printing the preprocessed data:

print(prediction_input)
            age  workclass  education_num  marital_status  occupation  \
7547   3.016289          3      -0.419365               6           7   
4395  -1.213881          3       0.358743               4          11   
12262 -0.630409          3      -0.419365               2           2   
9487   0.682402          3       1.136850               0           9   
6355  -0.703343          3      -0.419365               2          11   

       relationship  race  capital_gain  capital_loss  hours_per_week  \
7547              1     2     -0.144807     -0.217119       -2.051786   
4395              3     4     -0.144807     -0.217119       -0.034043   
12262             0     4     -0.144807     -0.217119       -0.437592   
9487              1     4     -0.144807      5.318297       -0.841140   
6355              0     4     -0.144807     -0.217119       -0.034043   

       native_country  
7547               38  
4395               38  
12262              38  
9487               38  
6355               38  
Notice that categorical fields, like occupation, have already been converted to integers (with the same mapping that was used for training). Numerical fields, like age, have been scaled to a z-score. Some fields have been dropped from the original data.

Export the prediction input to a newline-delimited JSON file:

import json
​
with open('test.json', 'w') as json_file:
  for row in prediction_input.values.tolist():
    json.dump(row, json_file)
    json_file.write('\n')
Inspect the .json file:

%%bash
​
cat test.json
[3.0162887573242188, 3.0, -0.4193645119667053, 6.0, 7.0, 1.0, 2.0, -0.14480669796466827, -0.2171185314655304, -2.051786422729492, 38.0]
[-1.2138808965682983, 3.0, 0.3587425947189331, 4.0, 11.0, 3.0, 4.0, -0.14480669796466827, -0.2171185314655304, -0.034042954444885254, 38.0]
[-0.6304092407226562, 3.0, -0.4193645119667053, 2.0, 2.0, 0.0, 4.0, -0.14480669796466827, -0.2171185314655304, -0.43759164214134216, 38.0]
[0.6824020743370056, 3.0, 1.1368497610092163, 0.0, 9.0, 1.0, 4.0, -0.14480669796466827, 5.318296909332275, -0.8411403298377991, 38.0]
[-0.7033432126045227, 3.0, -0.4193645119667053, 2.0, 11.0, 0.0, 4.0, -0.14480669796466827, -0.2171185314655304, -0.034042954444885254, 38.0]
Step 2.4: Use your trained model for prediction
Once you've trained your TensorFlow model, you can use it for prediction on new data. In this case, you've trained a census model to predict income category given some information about a person.

Run the following command to run prediction on the test.json file we created above:

Note: If you get a "Bad magic number in .pyc file" error, go to the terminal and run:

cd ../../usr/lib/google-cloud-sdk/lib/googlecloudsdk/command_lib/ml_engine/

sudo rm *.pyc

%%bash
​
gcloud ai-platform local predict \
    --model-dir output/keras_export/ \
    --json-instances ./test.json
DENSE_4
[0.01698511838912964]
[0.003936160821467638]
[0.1294272243976593]
[0.10183995962142944]
[0.12949572503566742]
If the signature defined in the model is not serving_default then you must specify it via --signature-name flag, otherwise the command may fail.
WARNING: WARNING:tensorflow:From /opt/conda/lib/python3.7/site-packages/tensorflow_core/python/compat/v2_compat.py:96: disable_resource_variables (from tensorflow.python.ops.variable_scope) is deprecated and will be removed in a future version.
Instructions for updating:
non-resource variables are not supported in the long term
2021-09-04 03:36:04.928211: I tensorflow/core/platform/profile_utils/cpu_utils.cc:94] CPU Frequency: 2299995000 Hz
2021-09-04 03:36:04.928471: I tensorflow/compiler/xla/service/service.cc:168] XLA service 0x55a7f9c83450 initialized for platform Host (this does not guarantee that XLA will be used). Devices:
2021-09-04 03:36:04.928498: I tensorflow/compiler/xla/service/service.cc:176]   StreamExecutor device (0): Host, Default Version
2021-09-04 03:36:04.928691: I tensorflow/core/common_runtime/process_util.cc:147] Creating new thread pool with default inter op setting: 2. Tune using inter_op_parallelism_threads for best performance.
WARNING:tensorflow:From /usr/lib/google-cloud-sdk/lib/third_party/ml_sdk/cloud/ml/prediction/frameworks/tf_prediction_lib.py:236: load (from tensorflow.python.saved_model.loader_impl) is deprecated and will be removed in a future version.
Instructions for updating:
This function will only be available through the v1 compatibility library as tf.compat.v1.saved_model.loader.load or tf.compat.v1.saved_model.load. There will be a new function for importing SavedModels in Tensorflow 2.0.
WARNING:tensorflow:From /usr/lib/google-cloud-sdk/lib/third_party/ml_sdk/cloud/ml/prediction/frameworks/tf_prediction_lib.py:236: load (from tensorflow.python.saved_model.loader_impl) is deprecated and will be removed in a future version.
Instructions for updating:
This function will only be available through the v1 compatibility library as tf.compat.v1.saved_model.loader.load or tf.compat.v1.saved_model.load. There will be a new function for importing SavedModels in Tensorflow 2.0.
WARNING:root:Error updating signature __saved_model_init_op: The name 'NoOp' refers to an Operation, not a Tensor. Tensor names must be of the form "<op_name>:<output_index>".

Since the model's last layer uses a sigmoid function for its activation, outputs between 0 and 0.5 represent negative predictions ("<=50K") and outputs between 0.5 and 1 represent positive ones (">50K").

Step 3: Run your training job in the cloud
Now that you've validated your model by running it locally, you will now get practice training using Cloud AI Platform.

Note: The initial job request will take several minutes to start, but subsequent jobs run more quickly. This enables quick iteration as you develop and validate your training job.

First, set the following variables:

%%bash
export PROJECT=$(gcloud config list project --format "value(core.project)")
echo "Your current GCP Project Name is: "${PROJECT}
Your current GCP Project Name is: qwiklabs-gcp-00-670e876d6cbd
YOUR_PROJECT_NAME
PROJECT = "qwiklabs-gcp-00-670e876d6cbd"  # Replace with your project name
BUCKET_NAME=PROJECT+"-aiplatform"
REGION="us-central1"
os.environ["PROJECT"] = PROJECT
os.environ["BUCKET_NAME"] = BUCKET_NAME
os.environ["REGION"] = REGION
os.environ["TFVERSION"] = "2.1"
os.environ["PYTHONVERSION"] = "3.7"
Step 3.1: Set up a Cloud Storage bucket
The AI Platform services need to access Cloud Storage (GCS) to read and write data during model training and batch prediction.

Create a bucket using BUCKET_NAME as the name for the bucket and copy the data into it.

%%bash
​
if ! gsutil ls | grep -q gs://${BUCKET_NAME}; then
    gsutil mb -l ${REGION} gs://${BUCKET_NAME}
fi
gsutil cp -r data gs://$BUCKET_NAME/data
Creating gs://qwiklabs-gcp-00-670e876d6cbd-aiplatform/...
Copying file://data/adult.data.csv [Content-Type=text/csv]...
Copying file://data/census.train.csv [Content-Type=text/csv]...                 
Copying file://data/test.json [Content-Type=application/json]...                
Copying file://data/test.csv [Content-Type=text/csv]...                         
- [4 files][  7.2 MiB/  7.2 MiB]                                                
==> NOTE: You are performing a sequence of gsutil operations that may
run significantly faster if you instead use gsutil -m cp ... Please
see the -m section under "gsutil help options" for further information
about when gsutil -m can be advantageous.

Copying file://data/census.test.csv [Content-Type=text/csv]...
Copying file://data/adult.test.csv [Content-Type=text/csv]...                   
\ [6 files][ 10.7 MiB/ 10.7 MiB]                                                
Operation completed over 6 objects/10.7 MiB.                                     
Set the TRAIN_DATA and EVAL_DATA variables to point to the files:

%%bash
​
export TRAIN_DATA=gs://$BUCKET_NAME/data/adult.data.csv
export EVAL_DATA=gs://$BUCKET_NAME/data/adult.test.csv
Use gsutil again to copy the JSON test file test.json to your Cloud Storage bucket:

%%bash
​
gsutil cp test.json gs://$BUCKET_NAME/data/test.json
Copying file://test.json [Content-Type=application/json]...
/ [1 files][  690.0 B/  690.0 B]                                                
Operation completed over 1 objects/690.0 B.                                      
Set the TEST_JSON variable to point to that file:

%%bash
​
export TEST_JSON=gs://$BUCKET_NAME/data/test.json
Go back to the lab instructions and check your progress by testing the completed tasks:

- "Set up a Google Cloud Storage".

- "Upload the data files to your Cloud Storage bucket".

Step 3.2: Run a single-instance trainer in the cloud
With a validated training job that runs in both single-instance and distributed mode, you're now ready to run a training job in the cloud. For this example, we will be requesting a single-instance training job.

Use the default BASIC scale tier to run a single-instance training job. The initial job request can take a few minutes to start, but subsequent jobs run more quickly. This enables quick iteration as you develop and validate your training job.

Select a name for the initial training run that distinguishes it from any subsequent training runs. For example, we can use date and time to compose the job id.

Specify a directory for output generated by AI Platform by setting an OUTPUT_PATH variable to include when requesting training and prediction jobs. The OUTPUT_PATH represents the fully qualified Cloud Storage location for model checkpoints, summaries, and exports. You can use the BUCKET_NAME variable you defined in a previous step. It's a good practice to use the job name as the output directory.

Run the following command to submit a training job in the cloud that uses a single process. This time, set the --verbosity tag to DEBUG so that you can inspect the full logging output and retrieve accuracy, loss, and other metrics. The output also contains a number of other warning messages that you can ignore for the purposes of this sample:

%%bash
​
JOB_ID=census_$(date -u +%y%m%d_%H%M%S)
OUTPUT_PATH=gs://$BUCKET_NAME/$JOB_ID
gcloud ai-platform jobs submit training $JOB_ID \
    --job-dir $OUTPUT_PATH \
    --runtime-version $TFVERSION \
    --python-version $PYTHONVERSION \
    --module-name trainer.task \
    --package-path trainer/ \
    --region $REGION \
    -- \
    --train-files $TRAIN_DATA \
    --eval-files $EVAL_DATA \
    --train-steps 1000 \
    --eval-steps 100 \
    --verbosity DEBUG
jobId: census_210904_033906
state: QUEUED
Job [census_210904_033906] submitted successfully.
Your job is still active. You may view the status of your job with the command

  $ gcloud ai-platform jobs describe census_210904_033906

or continue streaming the logs with the command

  $ gcloud ai-platform jobs stream-logs census_210904_033906
Set an environment variable with the jobId generated above:

YOUR_JOB_ID
os.environ["JOB_ID"] = "census_210904_033906" # Replace with your job id
You can monitor the progress of your training job by watching the logs on the command line by running:

gcloud ai-platform jobs stream-logs $JOB_ID

Or monitor it in the Console at AI Platform > Jobs. Wait until your AI Platform training job is done. It is finished when you see a green check mark by the jobname in the Cloud Console, or when you see the message Job completed successfully from the Cloud Shell command line.

Go back to the lab instructions and check your progress by testing the completed task:

- "Run a single-instance trainer in the cloud".

Step 3.3: Deploy your model to support prediction
By deploying your trained model to AI Platform to serve online prediction requests, you get the benefit of scalable serving. This is useful if you expect your trained model to be hit with many prediction requests in a short period of time.

Create an AI Platform model:

os.environ["MODEL_NAME"] = "census"
%%bash
​
gcloud ai-platform models create $MODEL_NAME --regions=$REGION
Using endpoint [https://ml.googleapis.com/]
Created ai platform model [projects/qwiklabs-gcp-00-670e876d6cbd/models/census].
Set the environment variable MODEL_BINARIES to the full path of your exported trained model binaries $OUTPUT_PATH/keras_export/.

You'll deploy this trained model.

Run the following command to create a version v1 of your model:

%%bash
​
OUTPUT_PATH=gs://$BUCKET_NAME/$JOB_ID
MODEL_BINARIES=$OUTPUT_PATH/keras_export/
gcloud ai-platform versions create v1 \
--model $MODEL_NAME \
--origin $MODEL_BINARIES \
--runtime-version $TFVERSION \
--python-version $PYTHONVERSION \
--region=global
Using endpoint [https://ml.googleapis.com/]
Creating version (this might take a few minutes)......
......................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................done.
It may take several minutes to deploy your trained model. When done, you can see a list of your models using the models list command:

%%bash
​
gcloud ai-platform models list
Using endpoint [https://us-central1-ml.googleapis.com/]
Listed 0 items.
Go back to the lab instructions and check your progress by testing the completed tasks:

- "Create an AI Platform model".

- "Create a version v1 of your model".

Step 3.4: Send an online prediction request to your deployed model
You can now send prediction requests to your deployed model. The following command sends a prediction request using the test.json.

The response includes the probabilities of each label (>50K and <=50K) based on the data entry in test.json, thus indicating whether the predicted income is greater than or less than 50,000 dollars.

%%bash
​
gcloud ai-platform predict \
--model $MODEL_NAME \
--version v1 \
--json-instances ./test.json \
--region global
DENSE_4
[0.0082244873046875]
[0.003594825277104974]
[0.07933718711137772]
[0.24165230989456177]
[0.08867701888084412]
Using endpoint [https://ml.googleapis.com/]
