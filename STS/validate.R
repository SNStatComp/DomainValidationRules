# Load a function to read the transmission file format.
source("STS/stsfun.R")

# Validate package (version >= 0.2.7)
library(validate)
# GenericValidationRules (version >= 0.5.0)
library(GenericValidationRules)

# load the data
sts <- read_sts("STS/data/STSIND_TOVT_Q_2018_0002_V0001.csv")

# load the rules
rls <- validator(.file="STS/rules/sts_rules.yaml")

# confront data with rules
out <- confront(sts$data, rls, ref=list(meta=sts$meta))

# study result
summary(out)

# turn result into regular dataset
validation_data <- as.data.frame(out)



