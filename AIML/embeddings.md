In Machine Learning, an embedding is a vector (an array of numbers) that represents real-world objects such as words, sentences, images or videos. 

The interesting property that these embeddings have is that two embeddings that represent similar or related real-world entities will share some similarities as well

embeddings can be compared, and a distance between them can be calculated.

### Install SentenceTransformers:
pip install sentence-transformers
pip freeze > requirements.txt


### Selecting a Model:
SentenceTransformers is a very popular framework. There are many pretrained compatible models available.
you can check the SentenceTransformers tag on HuggingFace.
all-MiniLM-L6-v2 model is a good choice that offers a good compromise between speed and quality

how many numbers or dimensions the resulting vectors will have. This is important because it directly affects the amount of storage you will need.  In the case of all-MiniLM-L6-v2, the generated vectors have 384 dimensions.


### Loading the Model:
from sentence_transformers import SentenceTransformer
model = SentenceTransformer('all-MiniLM-L6-v2')
The first time you do this, the model will be downloaded and installed in your virtual environment


### Generating Embeddings
embedding = model.encode('The quick brown fox jumps over the lazy dog')



## ElasticSearch:

## Retrieving Type Mappings
from app import es
es.es.indices.get_mapping(index='my_documents')