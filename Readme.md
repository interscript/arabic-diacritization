# قيثارة KITHARA 
### Arabic Diacritization Library
Arabic diacritization is useful for several practical business cases like text to speech or romanization of arabic texts or scripts.

## Purpose

This repository contains everything to train a diacritization model in python and run it in python and Ruby.

This library was built for the [Interscript project](https://www.interscript.com) ([at GitHub](https://github.com/secryst/secryst)).

Diacritization strategy is following several steps with at heart a deep learning model:
	
1. text preprocessing
2. neural networks model prediction
3. text postprocessing
 
This repository contains: 

- [lib](https://github.com/interscript/arabic-diacritization/tree/master/lib) is the ruby library using nnet model in onnx format.
- [docs](https://github.com/interscript/arabic-diacritization/tree/master/docs) contains an application focused summary of latest (06.2021) relevant papers and solutions.
- [python](https://github.com/interscript/arabic-diacritization/tree/master/python)  
	- A **neural network solution** for automatised diacritization based on the work of [almodhfer](https://github.com/almodhfer/Arabic_Diacritization), from which we overtook the baseline and more advanced and efficient CBHG models only. 
This very recent solution allows for efficient predictions on CPU's with a reasonable sized model.
	* **Pytorch to ONNX** conversion of pytorch to ONNX format
	* **Strings Pre-/Post-processing**, also from [almodhfer](https://github.com/almodhfer/Arabic_Diacritization)
- [tests and benchmarking utilities](https://github.com/interscript/arabic-diacritization/tree/master/tests-benchmarks), allowing to compare with other implementations. 
	* tests are are taken from [diacritization benchmarking](https://github.com/AliOsm/arabic-text-diacritization)
	* we have added own, realistic datasets for the problem of diacritization
- **models-data** directory to store models and embeddings in various formats
