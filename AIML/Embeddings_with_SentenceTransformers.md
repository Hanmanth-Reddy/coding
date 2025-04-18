# 🧠 Introduction to Embeddings with SentenceTransformers

In Machine Learning, an **embedding** is a vector (an array of numbers) that represents real-world objects such as **words, sentences, images, or videos**.

The interesting property of these embeddings is that **similar or related real-world entities will produce embeddings that share similarities** as well. These embeddings can be compared using various similarity or distance metrics (e.g., cosine similarity, Euclidean distance).

---

## 📦 Install SentenceTransformers

```bash
pip install sentence-transformers
pip freeze > requirements.txt
```

---

## 🤖 Selecting a Model

[SentenceTransformers](https://www.sbert.net/) is a very popular framework built on top of HuggingFace and PyTorch.

- There are many pretrained compatible models available on the [HuggingFace SentenceTransformers hub](https://huggingface.co/sentence-transformers).
- A great starting point is the **`all-MiniLM-L6-v2`** model:
  - It offers a good compromise between **speed** and **quality**.
  - It generates embeddings with **384 dimensions** — an important factor that directly affects **storage** and **performance**.

---

## 📥 Loading the Model

```python
from sentence_transformers import SentenceTransformer

# Load the model (downloads on first use)
model = SentenceTransformer('all-MiniLM-L6-v2')
```

> ⚠️ The model will be downloaded and cached the first time you load it.

---

## 🧮 Generating Embeddings

```python
sentence = 'The quick brown fox jumps over the lazy dog'
embedding = model.encode(sentence)

print(f'Embedding shape: {embedding.shape}')
```

- The `embedding` will be a **NumPy array of 384 dimensions**.
- You can now compare this vector with others to determine semantic similarity.

---

## 🔍 Example: Comparing Two Sentences

```python
from sklearn.metrics.pairwise import cosine_similarity

sentence1 = "A quick brown fox."
sentence2 = "A fast brown animal."

embedding1 = model.encode(sentence1)
embedding2 = model.encode(sentence2)

similarity = cosine_similarity([embedding1], [embedding2])

print(f"Cosine Similarity: {similarity[0][0]:.4f}")
```

---

## ✅ Summary

- Embeddings allow machines to understand real-world objects in vector form.
- SentenceTransformers provides an easy and powerful interface for creating text embeddings.
- The `all-MiniLM-L6-v2` model is a solid choice for fast and efficient semantic understanding tasks.

---

🔗 **Learn more** at: [https://www.sbert.net](https://www.sbert.net)
