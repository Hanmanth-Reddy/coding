# GenAI:
Generative AI refers to any AI system that can generate content — text, images, audio, video, code, etc. 
It includes LLMs, but it also covers other AI models like:
•	**Text-based GenAI models** → Large Language Models (LLMs) like GPT(Generative Pre-trained Transformer), BERT (Bidirectional Encoder Representations from Transformers),LLaMA (Large Language Model Meta AI), Gemini,Claude
•	**Image-based GenAI models** → DALL·E, MidJourney, Stable Diffusion
•	**Music GenAI models** → Google's MusicLM, OpenAI's Jukebox, WaveNet
•	**Video GenAI models** → Runway ML, Sora
•	**Code GenAI models** → GitHub Copilot, Code Llama,Codex, AlphaCode

_______________________________________________________________________________________________________________________________________________________________
## What is LLM(Large Language Model):
LLM is a subset of Generative AI that focuses only on **understanding and text generation**. LLM is designed to process and generate human-like text.
These models are built using deep learning techniques, particularly transformers, and are trained on massive datasets of text from books, websites, and other sources.
LLMs are trained on large text datasets and used for tasks like:
•	Chatbots (e.g., ChatGPT)
•	Text summarization
•	Code generation
•	Language translation
________________________________________________________________________________________________________________________________________________________________
## Embeddings:
Embeddings are numerical representations of data (such as text, images, audio, or code) in a high-dimensional vector space.
They convert words, sentences, images, or other types of data into high-dimensional vectors, capturing their meanings, relationships, or features.
These vectors capture semantic meaning and allow for efficient similarity searches.

## vector database:
A vector database is designed to store, index, and search high-dimensional vector embeddings. 
While their primary use case is similarity search, they offer many powerful capabilities beyond just searching for similar items.
Ex: 
ChromaDB (pip install chromadb) ,
FAISS (Facebook AI Similarity Search, pip install faiss-cpu)
milvus,
Pinecone

__________________________________________________________________________________________________________________________________________________________________
## RAG (Retrieval augmented generation)
A technique used in natural language processing (NLP) to enhance the performance of generative AI models.
Retrieval – retrieves relevant documents from large external sources (like DB, search index, external knowledge base, etc)
Generation – retrieved information will be fed into Generative model to produce a coherent and contextually appropriate response.
Benefits:
•  **Enhanced Accuracy:** By incorporating external knowledge, RAG can provide more accurate and up-to-date responses, especially for domain-specific or rapidly changing information. RAG reduces the risk of generating incorrect or hallucinated information.
•  **Scalability:** It allows AI systems to scale their knowledge without retraining, as the external knowledge base can be updated independently.
•  **Explainability:** The retrieval step provides transparency into the source of information, making the model's output more interpretable.
•  **Flexibility:** It can be adapted to various tasks, such as open-domain question answering, chatbots, or summarization.

__________________________________________________________________________________________________________________________________________________________________

## LangChain:
LangChain is an open-source framework designed to help developers build applications using large language models (LLMs) more effectively. It simplifies the integration of LLMs like OpenAI's GPT with external data sources, tools, APIs, and workflows.

#### Key Features of LangChain
#### Retrieval-Augmented Generation (RAG):
Combine LLMs with your own data (PDFs, databases, web pages, etc.) using vector stores and embeddings. This allows the LLM to answer questions based on custom content.

#### Chains:
You can create sequences (chains) of steps where each step is a prompt or a tool (like a search or API call). This is useful for multi-step tasks.

#### Agents:
Agents use an LLM to decide which tool to use and when. It dynamically plans the steps based on input.

#### Memory:
Adds context/history to conversations, making interactions more intelligent and natural.

#### Tool Integration:
Connects to vector databases (like Pinecone, Chroma, FAISS), APIs, document loaders, and more.

Example Stack : A basic LangChain app might use:
OpenAI GPT-4 (or other LLM)
ChromaDB or FAISS (for vector storage)
LangChain (to tie it all together)
Streamlit or Gradio (for UI)
__________________________________________________________________________________________________________________________________________________________________

#### Hugging Face:
Supports thousands of models across NLP, vision, audio, and multimodal AI (GPT, BERT, Stable Diffusion, etc.).

#### Ollama:
Primarily focused on running LLMs (Mistral, LLaMA, Gemma, etc.) with optimized performance.


Training --> inference















Aertifical Intelligance:
Machine learning:
Deep learning
Generative AI















