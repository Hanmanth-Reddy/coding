ElasticSearch



keyword search
full text search 

ELSER Model (Elastic Learned Sparse Encoder of Representations)
ELSER is Elastic's own model, designed for semantic search in Elasticsearch.

semantic search — understanding meaning rather than just matching words.



## 🔍 Search Types – Visual Summary

| **Type**           | **Purpose**             | **Example**                              |
|--------------------|--------------------------|-------------------------------------------|
| **Lexical (BM25)** | Exact keyword match      | `"reset password"`                        |
| **Semantic**       | Understand meaning        | `"recover access"` ⇒ `"reset password"`   |
| **Fuzzy**          | Typo tolerance            | `"passwrod"` ⇒ `"password"`               |
| **Autocomplete**   | Suggest while typing      | `"res"` ⇒ `"reset"`                       |
| **Wildcard/Regex** | Pattern match             | `"pass*"` or regex `pa[s|z]{2}word`       |
| **Phonetic**       | Sound similarity          | `"Jon"` ⇒ `"John"`                        |
| **Faceted**        | Filtered drill-down       | Filter: Price range, brand, category      |
| **Geo Search**     | Location-aware            | Restaurants within 5 km of me             |
| **Hybrid**         | Combines BM25 + semantic  | Keyword match + semantic relevance        |
| **Multimodal**     | Image + text + etc.       | "Find similar dresses" (from image)       |
| **Boolean**        | Logical control           | `A AND B NOT C`                           |
| **Personalized**   | User-context-aware        | Results based on history or preferences   |
