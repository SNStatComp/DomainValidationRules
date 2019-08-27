# DomainValidationRules
Domain-specific validation rules for the European Statistical System


Examples of data validation rules, described in handbooks for data transmission
between National Statistical Institutes and Eurostat. The rules are implemented
using R package [validate](https://cran.r-project.org/package=validate) and [GenericValidationRules](https://github.com/SNStatComp/GenericValidationRules).


### Implemented rules

- [Short term statistics](STS) rules:
   - STS01: "Correct series",
   - STS02: "No gaps",
   - STS03: "Prices positive",
   - STS04: "No negative observations",
   - STS05: "unique observations",
   - STS06: "all series types",
   - STS10: "base index is 100"

- [National Accounts](NA) rules:
   - NA_MAIN_VCO_Consistency_between_Prices: "Chain linked formula"


