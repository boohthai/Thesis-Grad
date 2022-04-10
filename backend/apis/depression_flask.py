from flask import Flask, request, jsonify
from tensorflow.keras.models import load_model
from transformers import AutoTokenizer
from scipy.special import softmax
import tensorflow_addons as tfa
import json
import numpy as np
import pandas as pd
from tensorflow.keras.preprocessing.sequence import pad_sequences
from tensorflow.keras.preprocessing.text import Tokenizer


# Load depression model
lstm_model = load_model(
    "../models/lstm_model_e10_b8_n60_50_d0.1_0.1_lr0.001.h5")

d_df = pd.read_csv("../data/vietaitweet.csv")
tweets = d_df['tweet_vi'].values

# Load tokenizer
# tokenizer = AutoTokenizer.from_pretrained(
#     "../tokenizers/", truncation=True, do_lower_case=True)

# Preprocess text (username and link placeholders)


def preprocess(text):
    new_text = []
    for t in text.split(" "):
        t = '@user' if t.startswith('@') and len(t) > 1 else t
        t = 'http' if t.startswith('http') else t
        new_text.append(t)
    return " ".join(new_text)

# Function to return output


def text_encoder(text):
    tokenizer = Tokenizer(num_words=100000)
    tokenizer.fit_on_texts(tweets)
    tweet_sequences = tokenizer.texts_to_sequences([text])
    padding_sequences = pad_sequences(
        tweet_sequences, padding='post', maxlen=200)
    return padding_sequences


def get_depression_score(text):
    print(text)
    preprocessed_text = preprocess(text)
    encoded_text = text_encoder(preprocessed_text)
    score = lstm_model.predict(encoded_text)[0][0]
    depression = 1 if score > 0.5 else 0

    return depression, score


# Create an instance of this class
app = Flask(__name__)

array = {"output": ""}


# Use the route() decorator to tell Flask what URL should trigger our function
@app.route('/', methods=['POST', 'GET'])
def index():
    final_result = ""
    request_data = json.loads(request.data.decode('utf-8'))
    text_from_app = request_data['text']
    print(f"Input text: {text_from_app}")

    depression, score = get_depression_score(text_from_app)
    print(f"Depression: {depression}")
    print(f"Score: {score}")

    final_result = "Depressed" if depression == 1 else "Non-Depressed"

    array['depression'] = final_result
    array['score'] = str(score)

    return jsonify(array)

if __name__ == '__main__':
    # print(get_depression_score(
    #      "Dù sao thì cuối cùng cô ấy cũng thấy cô đơn và chán nản đến mức một ngày nọ, cô ấy nhốt mình trong phòng và tự bắn mình. "))
    app.run(host='0.0.0.0',port = 8000, debug=True)