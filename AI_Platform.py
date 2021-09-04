AI Platform: Qwik Start
This lab gives you an introductory, end-to-end experience of training and prediction on AI Platform. The lab will use a census dataset to:

Create a TensorFlow 2.x training application and validate it locally.
Run your training job on a single worker instance in the cloud.
Deploy a model to support prediction.
Request an online prediction and see the response.
1
import os
Step 1: Get your training data
The relevant data files, adult.data and adult.test, are hosted in a public Cloud Storage bucket.

You can read the files directly from Cloud Storage or copy them to your local environment. For this lab you will download the samples for local training, and later upload them to your own Cloud Storage bucket for cloud training.

Run the following command to download the data to a local file directory and set variables that point to the downloaded data files:

1
%%bash
2
​
3
mkdir data
4
gsutil -m cp gs://cloud-samples-data/ml-engine/census/data/* data/
Outputs changed
Output added
Copying gs://cloud-samples-data/ml-engine/census/data/adult.test.csv...
Copying gs://cloud-samples-data/ml-engine/census/data/adult.data.csv...
Copying gs://cloud-samples-data/ml-engine/census/data/test.json...
Copying gs://cloud-samples-data/ml-engine/census/data/census.train.csv...
Copying gs://cloud-samples-data/ml-engine/census/data/census.test.csv...
Copying gs://cloud-samples-data/ml-engine/census/data/test.csv...
/ [6/6 files][ 10.7 MiB/ 10.7 MiB] 100% Done                                    
Operation completed over 6 objects/10.7 MiB.                                     
1
%%bash
2
​
3
export TRAIN_DATA=$(pwd)/data/adult.data.csv
4
export EVAL_DATA=$(pwd)/data/adult.test.csv
Inspect what the data looks like by looking at the first couple of rows:

1
%%bash
2
​
3
head data/adult.data.csv
Outputs changed
Output added
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

1
%%bash
2
mkdir -p trainer
3
touch trainer/__init__.py
1
%%writefile trainer/util.py
2
from __future__ import absolute_import
3
from __future__ import division
4
from __future__ import print_function
5
​
6
import os
7
from six.moves import urllib
8
import tempfile
9
​
10
import numpy as np
11
import pandas as pd
12
import tensorflow as tf
13
​
14
# Storage directory
15
DATA_DIR = os.path.join(tempfile.gettempdir(), 'census_data')
16
​
17
# Download options.
18
DATA_URL = (
19
    'https://storage.googleapis.com/cloud-samples-data/ai-platform/census'
20
    '/data')
21
TRAINING_FILE = 'adult.data.csv'
22
EVAL_FILE = 'adult.test.csv'
23
TRAINING_URL = '%s/%s' % (DATA_URL, TRAINING_FILE)
24
EVAL_URL = '%s/%s' % (DATA_URL, EVAL_FILE)
25
​
26
# These are the features in the dataset.
27
# Dataset information: https://archive.ics.uci.edu/ml/datasets/census+income
28
_CSV_COLUMNS = [
29
    'age', 'workclass', 'fnlwgt', 'education', 'education_num',
30
    'marital_status', 'occupation', 'relationship', 'race', 'gender',
31
    'capital_gain', 'capital_loss', 'hours_per_week', 'native_country',
32
    'income_bracket'
33
]
34
​
35
# This is the label (target) we want to predict.
36
_LABEL_COLUMN = 'income_bracket'
37
​
38
# These are columns we will not use as features for training. There are many
39
# reasons not to use certain attributes of data for training. Perhaps their
40
# values are noisy or inconsistent, or perhaps they encode bias that we do not
41
# want our model to learn. For a deep dive into the features of this Census
42
# dataset and the challenges they pose, see the Introduction to ML Fairness
43
# Notebook: https://colab.research.google.com/github/google/eng-edu/blob
44
# /master/ml/cc/exercises/intro_to_fairness.ipynb
45
UNUSED_COLUMNS = ['fnlwgt', 'education', 'gender']
46
​
47
_CATEGORICAL_TYPES = {
48
    'workclass': pd.api.types.CategoricalDtype(categories=[
49
        'Federal-gov', 'Local-gov', 'Never-worked', 'Private', 'Self-emp-inc',
50
        'Self-emp-not-inc', 'State-gov', 'Without-pay'
51
    ]),
52
    'marital_status': pd.api.types.CategoricalDtype(categories=[
53
        'Divorced', 'Married-AF-spouse', 'Married-civ-spouse',
54
        'Married-spouse-absent', 'Never-married', 'Separated', 'Widowed'
55
    ]),
56
    'occupation': pd.api.types.CategoricalDtype([
57
        'Adm-clerical', 'Armed-Forces', 'Craft-repair', 'Exec-managerial',
58
        'Farming-fishing', 'Handlers-cleaners', 'Machine-op-inspct',
59
        'Other-service', 'Priv-house-serv', 'Prof-specialty', 'Protective-serv',
60
        'Sales', 'Tech-support', 'Transport-moving'
61
    ]),
62
    'relationship': pd.api.types.CategoricalDtype(categories=[
63
        'Husband', 'Not-in-family', 'Other-relative', 'Own-child', 'Unmarried',
64
        'Wife'
65
    ]),
66
    'race': pd.api.types.CategoricalDtype(categories=[
67
        'Amer-Indian-Eskimo', 'Asian-Pac-Islander', 'Black', 'Other', 'White'
68
    ]),
69
    'native_country': pd.api.types.CategoricalDtype(categories=[
70
        'Cambodia', 'Canada', 'China', 'Columbia', 'Cuba', 'Dominican-Republic',
71
        'Ecuador', 'El-Salvador', 'England', 'France', 'Germany', 'Greece',
72
        'Guatemala', 'Haiti', 'Holand-Netherlands', 'Honduras', 'Hong',
73
        'Hungary',
74
        'India', 'Iran', 'Ireland', 'Italy', 'Jamaica', 'Japan', 'Laos',
75
        'Mexico',
76
        'Nicaragua', 'Outlying-US(Guam-USVI-etc)', 'Peru', 'Philippines',
77
        'Poland',
78
        'Portugal', 'Puerto-Rico', 'Scotland', 'South', 'Taiwan', 'Thailand',
79
        'Trinadad&Tobago', 'United-States', 'Vietnam', 'Yugoslavia'
80
    ]),
81
    'income_bracket': pd.api.types.CategoricalDtype(categories=[
82
        '<=50K', '>50K'
83
    ])
84
}
85
​
86
​
87
def _download_and_clean_file(filename, url):
88
    """Downloads data from url, and makes changes to match the CSV format.
89
​
90
    The CSVs may use spaces after the comma delimters (non-standard) or include
91
    rows which do not represent well-formed examples. This function strips out
92
    some of these problems.
93
​
94
    Args:
95
      filename: filename to save url to
96
      url: URL of resource to download
97
    """
98
    temp_file, _ = urllib.request.urlretrieve(url)
99
    with tf.io.gfile.GFile(temp_file, 'r') as temp_file_object:
100
        with tf.io.gfile.GFile(filename, 'w') as file_object:
101
            for line in temp_file_object:
102
                line = line.strip()
103
                line = line.replace(', ', ',')
104
                if not line or ',' not in line:
105
                    continue
106
                if line[-1] == '.':
107
                    line = line[:-1]
108
                line += '\n'
109
                file_object.write(line)
110
    tf.io.gfile.remove(temp_file)
111
​
112
​
113
def download(data_dir):
114
    """Downloads census data if it is not already present.
115
​
116
    Args:
117
      data_dir: directory where we will access/save the census data
118
    """
119
    tf.io.gfile.makedirs(data_dir)
120
​
121
    training_file_path = os.path.join(data_dir, TRAINING_FILE)
122
    if not tf.io.gfile.exists(training_file_path):
123
        _download_and_clean_file(training_file_path, TRAINING_URL)
124
​
125
    eval_file_path = os.path.join(data_dir, EVAL_FILE)
126
    if not tf.io.gfile.exists(eval_file_path):
127
        _download_and_clean_file(eval_file_path, EVAL_URL)
128
​
129
    return training_file_path, eval_file_path
130
​
131
​
132
def preprocess(dataframe):
133
    """Converts categorical features to numeric. Removes unused columns.
134
​
135
    Args:
136
      dataframe: Pandas dataframe with raw data
137
​
138
    Returns:
139
      Dataframe with preprocessed data
140
    """
141
    dataframe = dataframe.drop(columns=UNUSED_COLUMNS)
142
​
143
    # Convert integer valued (numeric) columns to floating point
144
    numeric_columns = dataframe.select_dtypes(['int64']).columns
145
    dataframe[numeric_columns] = dataframe[numeric_columns].astype('float32')
146
​
147
    # Convert categorical columns to numeric
148
    cat_columns = dataframe.select_dtypes(['object']).columns
149
    dataframe[cat_columns] = dataframe[cat_columns].apply(lambda x: x.astype(
150
        _CATEGORICAL_TYPES[x.name]))
151
    dataframe[cat_columns] = dataframe[cat_columns].apply(lambda x: x.cat.codes)
152
    return dataframe
153
​
154
​
155
def standardize(dataframe):
156
    """Scales numerical columns using their means and standard deviation to get
157
    z-scores: the mean of each numerical column becomes 0, and the standard
158
    deviation becomes 1. This can help the model converge during training.
159
​
160
    Args:
161
      dataframe: Pandas dataframe
162
​
163
    Returns:
164
      Input dataframe with the numerical columns scaled to z-scores
165
    """
166
    dtypes = list(zip(dataframe.dtypes.index, map(str, dataframe.dtypes)))
167
    # Normalize numeric columns.
168
    for column, dtype in dtypes:
169
        if dtype == 'float32':
170
            dataframe[column] -= dataframe[column].mean()
171
            dataframe[column] /= dataframe[column].std()
172
    return dataframe
173
​
174
​
175
def load_data():
176
    """Loads data into preprocessed (train_x, train_y, eval_y, eval_y)
177
    dataframes.
178
​
179
    Returns:
180
      A tuple (train_x, train_y, eval_x, eval_y), where train_x and eval_x are
181
      Pandas dataframes with features for training and train_y and eval_y are
182
      numpy arrays with the corresponding labels.
183
    """
184
    # Download Census dataset: Training and eval csv files.
185
    training_file_path, eval_file_path = download(DATA_DIR)
186
​
187
    # This census data uses the value '?' for missing entries. We use
188
    # na_values to
189
    # find ? and set it to NaN.
190
    # https://pandas.pydata.org/pandas-docs/stable/generated/pandas.read_csv
191
    # .html
192
    train_df = pd.read_csv(training_file_path, names=_CSV_COLUMNS,
193
                           na_values='?')
194
    eval_df = pd.read_csv(eval_file_path, names=_CSV_COLUMNS, na_values='?')
195
​
196
    train_df = preprocess(train_df)
197
    eval_df = preprocess(eval_df)
198
​
199
    # Split train and eval data with labels. The pop method copies and removes
200
    # the label column from the dataframe.
201
    train_x, train_y = train_df, train_df.pop(_LABEL_COLUMN)
202
    eval_x, eval_y = eval_df, eval_df.pop(_LABEL_COLUMN)
203
​
204
    # Join train_x and eval_x to normalize on overall means and standard
205
    # deviations. Then separate them again.
206
    all_x = pd.concat([train_x, eval_x], keys=['train', 'eval'])
207
    all_x = standardize(all_x)
208
    train_x, eval_x = all_x.xs('train'), all_x.xs('eval')
209
​
210
    # Reshape label columns for use with tf.data.Dataset
211
    train_y = np.asarray(train_y).astype('float32').reshape((-1, 1))
212
    eval_y = np.asarray(eval_y).astype('float32').reshape((-1, 1))
213
​
214
    return train_x, train_y, eval_x, eval_y
Outputs changed
Output added
Writing trainer/util.py
The second file, called model.py, defines the input function and the model architecture. In this example, we use tf.data API for the data pipeline and create the model using the Keras Sequential API. We define a DNN with an input layer and 3 additonal layers using the Relu activation function. Since the task is a binary classification, the output layer uses the sigmoid activation.

1
%%writefile trainer/model.py
2
from __future__ import absolute_import
3
from __future__ import division
4
from __future__ import print_function
5
​
6
import tensorflow as tf
7
​
8
​
9
def input_fn(features, labels, shuffle, num_epochs, batch_size):
10
    """Generates an input function to be used for model training.
11
​
12
    Args:
13
      features: numpy array of features used for training or inference
14
      labels: numpy array of labels for each example
15
      shuffle: boolean for whether to shuffle the data or not (set True for
16
        training, False for evaluation)
17
      num_epochs: number of epochs to provide the data for
18
      batch_size: batch size for training
19
​
20
    Returns:
21
      A tf.data.Dataset that can provide data to the Keras model for training or
22
        evaluation
23
    """
24
    if labels is None:
25
        inputs = features
26
    else:
27
        inputs = (features, labels)
28
    dataset = tf.data.Dataset.from_tensor_slices(inputs)
29
​
30
    if shuffle:
31
        dataset = dataset.shuffle(buffer_size=len(features))
32
​
33
    # We call repeat after shuffling, rather than before, to prevent separate
34
    # epochs from blending together.
35
    dataset = dataset.repeat(num_epochs)
36
    dataset = dataset.batch(batch_size)
37
    return dataset
38
​
39
​
40
def create_keras_model(input_dim, learning_rate):
41
    """Creates Keras Model for Binary Classification.
42
​
43
    The single output node + Sigmoid activation makes this a Logistic
44
    Regression.
45
​
46
    Args:
47
      input_dim: How many features the input has
48
      learning_rate: Learning rate for training
49
​
50
    Returns:
51
      The compiled Keras model (still needs to be trained)
52
    """
53
    Dense = tf.keras.layers.Dense
54
    model = tf.keras.Sequential(
55
        [
56
            Dense(100, activation=tf.nn.relu, kernel_initializer='uniform',
57
                  input_shape=(input_dim,)),
58
            Dense(75, activation=tf.nn.relu),
59
            Dense(50, activation=tf.nn.relu),
60
            Dense(25, activation=tf.nn.relu),
61
            Dense(1, activation=tf.nn.sigmoid)
62
        ])
63
​
64
    # Custom Optimizer:
65
    # https://www.tensorflow.org/api_docs/python/tf/train/RMSPropOptimizer
66
    optimizer = tf.keras.optimizers.RMSprop(lr=learning_rate)
67
​
68
    # Compile Keras model
69
    model.compile(
70
        loss='binary_crossentropy', optimizer=optimizer, metrics=['accuracy'])
71
    return model
Outputs changed
Output added
Writing trainer/model.py
The last file, called task.py, trains on data loaded and preprocessed in util.py. Using the tf.distribute.MirroredStrategy() scope, it is possible to train on a distributed fashion. The trained model is then saved in a TensorFlow SavedModel format.

1
%%writefile trainer/task.py
2
from __future__ import absolute_import
3
from __future__ import division
4
from __future__ import print_function
5
​
6
import argparse
7
import os
8
​
9
from . import model
10
from . import util
11
​
12
import tensorflow as tf
13
​
14
​
15
def get_args():
16
    """Argument parser.
17
​
18
    Returns:
19
      Dictionary of arguments.
20
    """
21
    parser = argparse.ArgumentParser()
22
    parser.add_argument(
23
        '--job-dir',
24
        type=str,
25
        required=True,
26
        help='local or GCS location for writing checkpoints and exporting '
27
             'models')
28
    parser.add_argument(
29
        '--num-epochs',
30
        type=int,
31
        default=20,
32
        help='number of times to go through the data, default=20')
33
    parser.add_argument(
34
        '--batch-size',
35
        default=128,
36
        type=int,
37
        help='number of records to read during each training step, default=128')
38
    parser.add_argument(
39
        '--learning-rate',
40
        default=.01,
41
        type=float,
42
        help='learning rate for gradient descent, default=.01')
43
    parser.add_argument(
44
        '--verbosity',
45
        choices=['DEBUG', 'ERROR', 'FATAL', 'INFO', 'WARN'],
46
        default='INFO')
47
    args, _ = parser.parse_known_args()
48
    return args
49
​
50
​
51
def train_and_evaluate(args):
52
    """Trains and evaluates the Keras model.
53
​
54
    Uses the Keras model defined in model.py and trains on data loaded and
55
    preprocessed in util.py. Saves the trained model in TensorFlow SavedModel
56
    format to the path defined in part by the --job-dir argument.
57
​
58
    Args:
59
      args: dictionary of arguments - see get_args() for details
60
    """
61
​
62
    train_x, train_y, eval_x, eval_y = util.load_data()
63
​
64
    # dimensions
65
    num_train_examples, input_dim = train_x.shape
66
    num_eval_examples = eval_x.shape[0]
67
​
68
    # Create the Keras Model
69
    keras_model = model.create_keras_model(
70
        input_dim=input_dim, learning_rate=args.learning_rate)
71
​
72
    # Pass a numpy array by passing DataFrame.values
73
    training_dataset = model.input_fn(
74
        features=train_x.values,
75
        labels=train_y,
76
        shuffle=True,
77
        num_epochs=args.num_epochs,
78
        batch_size=args.batch_size)
79
​
80
    # Pass a numpy array by passing DataFrame.values
81
    validation_dataset = model.input_fn(
82
        features=eval_x.values,
83
        labels=eval_y,
84
        shuffle=False,
85
        num_epochs=args.num_epochs,
86
        batch_size=num_eval_examples)
87
​
88
    # Setup Learning Rate decay.
89
    lr_decay_cb = tf.keras.callbacks.LearningRateScheduler(
90
        lambda epoch: args.learning_rate + 0.02 * (0.5 ** (1 + epoch)),
91
        verbose=True)
92
​
93
    # Setup TensorBoard callback.
94
    tensorboard_cb = tf.keras.callbacks.TensorBoard(
95
        os.path.join(args.job_dir, 'keras_tensorboard'),
96
        histogram_freq=1)
97
​
98
    # Train model
99
    keras_model.fit(
100
        training_dataset,
101
        steps_per_epoch=int(num_train_examples / args.batch_size),
102
        epochs=args.num_epochs,
103
        validation_data=validation_dataset,
104
        validation_steps=1,
105
        verbose=1,
106
        callbacks=[lr_decay_cb, tensorboard_cb])
107
​
108
    export_path = os.path.join(args.job_dir, 'keras_export')
109
    tf.keras.models.save_model(keras_model, export_path)
110
    print('Model exported to: {}'.format(export_path))
111
​
112
​
113
​
114
if __name__ == '__main__':
115
    strategy = tf.distribute.MirroredStrategy()
116
    with strategy.scope():
117
        args = get_args()
118
        tf.compat.v1.logging.set_verbosity(args.verbosity)
119
        train_and_evaluate(args)
120
​
Outputs changed
Output added
Writing trainer/task.py
Step 2.2: Run a training job locally using the Python training program
NOTE When you run the same training job on AI Platform later in the lab, you'll see that the command is not much different from the above.

Specify an output directory and set a MODEL_DIR variable to hold the trained model, then run the training job locally by running the following command (by default, verbose logging is turned off. You can enable it by setting the --verbosity tag to DEBUG):

1
%%bash
2
​
3
MODEL_DIR=output
4
gcloud ai-platform local train \
5
    --module-name trainer.task \
6
    --package-path trainer/ \
7
    --job-dir $MODEL_DIR \
8
    -- \
9
    --train-files $TRAIN_DATA \
10
    --eval-files $EVAL_DATA \
11
    --train-steps 1000 \
12
    --eval-steps 100
Outputs changed
Output added
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
Output added
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

1
%%bash
2
​
3
ls output/keras_export/
Outputs changed
Output added
assets
saved_model.pb
variables
Step 2.3: Prepare input for prediction
To receive valid and useful predictions, you must preprocess input for prediction in the same way that training data was preprocessed. In a production system, you may want to create a preprocessing pipeline that can be used identically at training time and prediction time.

For this exercise, use the training package's data-loading code to select a random sample from the evaluation data. This data is in the form that was used to evaluate accuracy after each epoch of training, so it can be used to send test predictions without further preprocessing.

Run the following snippet of code to preprocess the raw data from the adult.test.csv file. Here, we are grabbing 5 examples to run predictions on:

1
from trainer import util
2
_, _, eval_x, eval_y = util.load_data()
3
​
4
prediction_input = eval_x.sample(5)
5
prediction_targets = eval_y[prediction_input.index]
Check the numerical representation of the features by printing the preprocessed data:

1
print(prediction_input)
Outputs changed
Output added
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

1
import json
2
​
3
with open('test.json', 'w') as json_file:
4
  for row in prediction_input.values.tolist():
5
    json.dump(row, json_file)
6
    json_file.write('\n')
Inspect the .json file:

1
%%bash
2
​
3
cat test.json
Outputs changed
Output added
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

1
%%bash
2
​
3
gcloud ai-platform local predict \
4
    --model-dir output/keras_export/ \
5
    --json-instances ./test.json
Outputs changed
Output added
DENSE_4
[0.01698511838912964]
[0.003936160821467638]
[0.1294272243976593]
[0.10183995962142944]
[0.12949572503566742]
Output added
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

1
%%bash
2
export PROJECT=$(gcloud config list project --format "value(core.project)")
3
echo "Your current GCP Project Name is: "${PROJECT}
Outputs changed
Output added
Your current GCP Project Name is: qwiklabs-gcp-00-670e876d6cbd
1
PROJECT = "YOUR_PROJECT_NAME"  # Replace with your project name
2
BUCKET_NAME=PROJECT+"-aiplatform"
3
REGION="us-central1"
⇛⇚
1
PROJECT = "qwiklabs-gcp-00-670e876d6cbd"  # Replace with your project name
2
BUCKET_NAME=PROJECT+"-aiplatform"
3
REGION="us-central1"
1
os.environ["PROJECT"] = PROJECT
2
os.environ["BUCKET_NAME"] = BUCKET_NAME
3
os.environ["REGION"] = REGION
4
os.environ["TFVERSION"] = "2.1"
5
os.environ["PYTHONVERSION"] = "3.7"
Step 3.1: Set up a Cloud Storage bucket
The AI Platform services need to access Cloud Storage (GCS) to read and write data during model training and batch prediction.

Create a bucket using BUCKET_NAME as the name for the bucket and copy the data into it.

1
%%bash
2
​
3
if ! gsutil ls | grep -q gs://${BUCKET_NAME}; then
4
    gsutil mb -l ${REGION} gs://${BUCKET_NAME}
5
fi
6
gsutil cp -r data gs://$BUCKET_NAME/data
Outputs changed
Output added
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

1
%%bash
2
​
3
export TRAIN_DATA=gs://$BUCKET_NAME/data/adult.data.csv
4
export EVAL_DATA=gs://$BUCKET_NAME/data/adult.test.csv
Use gsutil again to copy the JSON test file test.json to your Cloud Storage bucket:

1
%%bash
2
​
3
gsutil cp test.json gs://$BUCKET_NAME/data/test.json
Outputs changed
Output added
Copying file://test.json [Content-Type=application/json]...
/ [1 files][  690.0 B/  690.0 B]                                                
Operation completed over 1 objects/690.0 B.                                      
Set the TEST_JSON variable to point to that file:

1
%%bash
2
​
3
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

1
%%bash
2
​
3
JOB_ID=census_$(date -u +%y%m%d_%H%M%S)
4
OUTPUT_PATH=gs://$BUCKET_NAME/$JOB_ID
5
gcloud ai-platform jobs submit training $JOB_ID \
6
    --job-dir $OUTPUT_PATH \
7
    --runtime-version $TFVERSION \
8
    --python-version $PYTHONVERSION \
9
    --module-name trainer.task \
10
    --package-path trainer/ \
11
    --region $REGION \
12
    -- \
13
    --train-files $TRAIN_DATA \
14
    --eval-files $EVAL_DATA \
15
    --train-steps 1000 \
16
    --eval-steps 100 \
17
    --verbosity DEBUG
Outputs changed
Output added
jobId: census_210904_033906
state: QUEUED
Output added
Job [census_210904_033906] submitted successfully.
Your job is still active. You may view the status of your job with the command

  $ gcloud ai-platform jobs describe census_210904_033906

or continue streaming the logs with the command

  $ gcloud ai-platform jobs stream-logs census_210904_033906
Set an environment variable with the jobId generated above:

1
os.environ["JOB_ID"] = "YOUR_JOB_ID" # Replace with your job id
⇛⇚
1
os.environ["JOB_ID"] = "census_210904_033906" # Replace with your job id
You can monitor the progress of your training job by watching the logs on the command line by running:

gcloud ai-platform jobs stream-logs $JOB_ID

Or monitor it in the Console at AI Platform > Jobs. Wait until your AI Platform training job is done. It is finished when you see a green check mark by the jobname in the Cloud Console, or when you see the message Job completed successfully from the Cloud Shell command line.

Go back to the lab instructions and check your progress by testing the completed task:

- "Run a single-instance trainer in the cloud".

Step 3.3: Deploy your model to support prediction
By deploying your trained model to AI Platform to serve online prediction requests, you get the benefit of scalable serving. This is useful if you expect your trained model to be hit with many prediction requests in a short period of time.

Create an AI Platform model:

1
os.environ["MODEL_NAME"] = "census"
1
%%bash
2
​
3
gcloud ai-platform models create $MODEL_NAME --regions=$REGION
Outputs changed
Output added
Using endpoint [https://ml.googleapis.com/]
Created ai platform model [projects/qwiklabs-gcp-00-670e876d6cbd/models/census].
Set the environment variable MODEL_BINARIES to the full path of your exported trained model binaries $OUTPUT_PATH/keras_export/.

You'll deploy this trained model.

Run the following command to create a version v1 of your model:

1
%%bash
2
​
3
OUTPUT_PATH=gs://$BUCKET_NAME/$JOB_ID
4
MODEL_BINARIES=$OUTPUT_PATH/keras_export/
5
gcloud ai-platform versions create v1 \
6
--model $MODEL_NAME \
7
--origin $MODEL_BINARIES \
8
--runtime-version $TFVERSION \
9
--python-version $PYTHONVERSION \
10
--region=global
Outputs changed
Output added
Using endpoint [https://ml.googleapis.com/]
Creating version (this might take a few minutes)......
......................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................done.
It may take several minutes to deploy your trained model. When done, you can see a list of your models using the models list command:

1
%%bash
2
​
3
gcloud ai-platform models list
Outputs changed
Output added
Using endpoint [https://us-central1-ml.googleapis.com/]
Listed 0 items.
Go back to the lab instructions and check your progress by testing the completed tasks:

- "Create an AI Platform model".

- "Create a version v1 of your model".

Step 3.4: Send an online prediction request to your deployed model
You can now send prediction requests to your deployed model. The following command sends a prediction request using the test.json.

The response includes the probabilities of each label (>50K and <=50K) based on the data entry in test.json, thus indicating whether the predicted income is greater than or less than 50,000 dollars.

1
%%bash
2
​
3
gcloud ai-platform predict \
4
--model $MODEL_NAME \
5
--version v1 \
6
--json-instances ./test.json \
7
--region global
Outputs changed
Output added
DENSE_4
[0.0082244873046875]
[0.003594825277104974]
[0.07933718711137772]
[0.24165230989456177]
[0.08867701888084412]
Output added
Using endpoint [https://ml.googleapis.com/]
