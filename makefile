##@meta {desc: 'build and deployment for python projects', date: '2024-03-04'}


## Build system
#
PROJ_TYPE =		python
PROJ_MODULES =		git python-resources python-cli python-doc \
			python-doc-deploy markdown
CLEAN_ALL_DEPS +=	cleanalldep
ADD_CLEAN +=		$(MODEL_STAGE_DIR)
ADD_CLEAN_ALL +=	result-summary.csv


## Project
#
DIST_APP =		./dist
MODEL_STAGE_DIR =	stage


## Includes
#
include ./zenbuild/main.mk


## Tests and reporting
#
# train/test the word vector model
.PHONY:			traintestwordvec
traintestwordvec:
			$(DIST_APP) traintest -c models/wordvec.yml

# train/test the base transformer model
.PHONY:			traintransbase
traintransbase:
			$(DIST_APP) traintest -c models/transformer.yml \
				--override esid_default.model_id=xlm-roberta-base

# train/test the large transformer model
.PHONY:			traintranslarge
traintranslarge:
			$(DIST_APP) traintest -c models/transformer.yml \
				--override esid_default.model_id=xlm-roberta-large

# rerun tests
.PHONY:			testmodels
testmodels:		cleanall traintransbase traintranslarge
			$(DIST_APP) summary
			src/bin/markdown-results.py


## Distribution
#
# create production transformer models
.PHONY:			trantrainsprodbase
trantrainsprodbase:
			$(DIST_APP) trainprod -c models/transformer.yml \
				--override esid_default.model_id=xlm-roberta-base

.PHONY:			trantrainsprodlarge
trantrainsprodlarge:
			$(DIST_APP) trainprod -c models/transformer.yml \
				--override esid_default.model_id=xlm-roberta-large

# create a distribution of all trained models
.PHONY:			dist
dist:			cleanall trantrainsprodbase trantrainsprodlarge
			echo rm -r $(MODEL_STAGE_DIR)
			@echo "creating distribution files..."
			mkdir -p $(MODEL_STAGE_DIR)
			@for i in `$(DIST_APP) resids` ; do \
				echo "packaging $$i" ; \
				$(DIST_APP) pack \
					--resid $$i \
					--modeldir $(MODEL_STAGE_DIR) ; \
			done


## Clean
#
.PHONY:			cleanalldep
cleanalldep:
			$(DIST_APP) clean --clevel 2

.PHONY:			vaporize
vaporize:		cleanall
			$(DIST_APP) clean --clevel 3
