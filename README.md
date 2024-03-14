# EduSenti: Education Review Sentiment in Albanian

[![PyPI][pypi-badge]][pypi-link]
[![Python 3.10][python3100-badge]][python3100-link]
[![Python 3.11][python311-badge]][python311-link]

Pretraining and sentiment student to instructor review corpora and analysis in
Albanian.  This repository contains the code base to be used for the paper
[RoBERTa Low Resource Fine Tuning for Sentiment Analysis in Albanian].  To
reproduce the results, see the paper [reproduction repository].  If you use our
model or API, please [cite](#citation) our paper.

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
## Table of Contents

- [Obtaining](#obtaining)
- [Usage](#usage)
- [API](#api)
- [Models](#models)
- [Differences from the Paper Repository](#differences-from-the-paper-repository)
- [Documentation](#documentation)
- [Changelog](#changelog)
- [Citation](#citation)
- [License](#license)

<!-- markdown-toc end -->



## Obtaining

The library can be installed with pip from the [pypi] repository:
```bash
pip3 install zensols.edusenti
```

The [models](#models) are downloaded on the first use of the command-line or
API.


## Usage

Command line:
```bash
$ edusenti predict sq.txt
(+): <Per shkak të gjendjes së krijuar si pasojë e pandemisë edhe ne sikur [...]>
(-): <Fillimisht isha e shqetësuar se si do ti mbanim kuizet, si do të [...]>
(+): <Kjo gjendje ka vazhduar edhe në kohën e provimeve>
...
```

Use the `csv` action to write all predictions to a comma-delimited file (use
`edusent --help`).


## API

```python
>>> from zensols.edusenti import (
>>>     ApplicationFactory, Application, SentimentFeatureDocument
>>> )
>>> app: Application = ApplicationFactory.get_application()
>>> doc: SentimentFeatureDocument
>>> for doc in app.predict(['Kjo gjendje ka vazhduar edhe në kohën e provimeve']):
>>>     print(f'sentence: {doc.text}')
>>>     print(f'prediction: {doc.pred}')
>>>     print(f'prediction: {doc.softmax_logit}')

sentence: Kjo gjendje ka vazhduar edhe në kohën e provimeve
prediction: +
logits: {'+': 0.70292175, '-': 0.17432323, 'n': 0.12275504}
```


## Models

The [models] are downloaded the first time the API is used.  To change the
model (by default `xlm-roberta-base` is used) on the command-line, use
`--override esi_default.model_namel=xlm-roberta-large`.  You can also create a
`~/.edusentirc` file with the following:

```ini
[esi_default]
model_namel = xlm-roberta-large
```

Performance of the models on the test set when trained and validated are below.

| Model               |   F1 | Precision | Recall |
|:--------------------|-----:|----------:|-------:|
| `xlm-roberta-base`  | 78.1 |      80.7 |   79.7 |
| `xlm-roberta-large` | 83.5 |      84.9 |   84.7 |

However, the distributed models were trained on the training and test sets
combined.  The validation metrics of those trained models are available on the
command line with `edusenti info`.


## Differences from the Paper Repository

The paper [reproduction repository] has quite a few differences, mostly around
reproducibility.  However, this repository is designed to be a package used for
research that applies the model.  To reproduce the results of the paper, please
refer to the [reproduction repository].  To use the best performing model
(XLM-RoBERTa Large) from that paper, then use this repository.

The primary difference is this repo has significantly better performance in
Albanian, which climbed from from F1 71.9 to 83.5 (see [models](#models)).
However, this repository has no English sentiment model since it was only used
for comparing methods.

Changes include:

* Python was upgraded from 3.9.9 to 3.11.6
* PyTorch was upgraded from 1.12.1 to 2.1.1
* HuggingFace transformers was upgraded from 4.19 to 4.35
* [zensols.deepnlp] was upgraded from 1.8 to 1.13
* The dataset was re-split and stratified.


## Documentation

See the [full documentation](https://plandes.github.io/edusenti/index.html).
The [API reference](https://plandes.github.io/edusenti/api.html) is also
available.


## Changelog

An extensive changelog is available [here](CHANGELOG.md).


## Citation

If you use this project in your research please use the following BibTeX entry:

```bibtex
@inproceedings{nuciRoBERTaLowResource2024,
  title = {{{RoBERTa Low Resource Fine Tuning}} for {{Sentiment Analysis}} in {{Albanian}}},
  booktitle = {The 2024 {{Joint International Conference}} on {{Computational Linguistics}}, {{Language Resources}} and {{Evaluation}}},
  author = {Nuci, Krenare and Landes, Paul and Di Eugenio, Barbara},
  date = {2024-05-20},
  publisher = {International Committee on Computational Linguistics},
  location = {Turin, Italy},
  eventtitle = {{{LREC-COLING}} 2024}
}
```


## License

[MIT License](LICENSE.md)

Copyright (c) 2023 - 2024 Paul Landes and Krenare Pireva Nuci


<!-- links -->
[pypi]: https://pypi.org/project/zensols.edusenti/
[pypi-link]: https://pypi.python.org/pypi/zensols.edusenti
[pypi-badge]: https://img.shields.io/pypi/v/zensols.edusenti.svg
[python3100-badge]: https://img.shields.io/badge/python-3.10-blue.svg
[python3100-link]: https://www.python.org/downloads/release/python-3100
[python311-badge]: https://img.shields.io/badge/python-3.11-blue.svg
[python311-link]: https://www.python.org/downloads/release/python-3110

[RoBERTa Low Resource Fine Tuning for Sentiment Analysis in Albanian]: https://example.com
[reproduction repository]: https://github.com/uic-nlp-lab/edusenti
[models]: https://zenodo.org/records/10795173
[zensols.deepnlp]: https://github.com/plandes/deepnlp
