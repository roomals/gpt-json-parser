# Conversation JSON Parser

This repository contains Python and R scripts for parsing conversation data from JSON files.

## Core Components:

1.  Python Script (`Parsing_GPT_Python.py`): A versatile Python-based parser that efficiently converts JSON-formatted conversational data into a more accessible Markdown format. This script is essential for researchers who prefer Python for data manipulation and analysis.

2.   R Script (`Parsing_GPT_R.R`): Parallel to its Python counterpart, this R-based script offers similar functionalities, catering to those who are more inclined towards using R for statistical analysis and data visualization in psychological and philosophical research.

## Environment and Compatibility:

The project is tailored for a Kali Linux environment, ensuring robustness and security in data handling.
Compatibility with Python 3.x and R ensures accessibility to a broad range of users with varying technical backgrounds.

## Requirements
**requirements.txt:**

For the provided script, there are no additional dependencies beyond the standard library, so you will not need a `requirements.txt` file for gpt-json-parser. If you do end up needing to install additional libraries, consider using conda.

### Installation in a Kali Linux environment
sudo apt update
sudo apt -y upgrade
sudo apt -y install r-base
wget https://download1.rstudio.org/desktop/<distro_here>/x86_64/rstudio-<version>-<arch>.deb

example: wget https://download1.rstudio.org/desktop/debian9/x86_64/rstudio-1.2.5042-amd64.deb

sudo apt install ./rstudio-1.2.5042-amd64.deb


### Installing packages in R or R-Studio

install.packages(c("readr", "ggplot2", "tidyr" corrplot", "rstan", "stats", "GPArotation", "tidyverse", "GGally", "knitr", "psych", "dplyr", "conflicted"))

## Usage

### Python Script

To use the Python script, follow these steps (consider using conda):

1. Clone the repository:
   git clone https://github.com/roomals/gpt-json-parser.git
2. cd conversation-json-parser
3. pip install -r requirements.txt
4. Update path in script by pointing it to your json file. Make sure your file is formated to the sample json included in this git.
5. python3 Parsing_GPT_Python.py

### R Script

To use the R script, follow these steps:

1. Clone the repository:
   git clone https://github.com/roomals/gpt-json-parser.git
2. cd conversation-json-parser
3. install.packages(c("readr", "ggplot2", "tidyr" corrplot", "rstan", "stats", "GPArotation", "tidyverse", "GGally", "knitr", "psych", "dplyr", "conflicted"))
4. Update path in script by pointing it to your json file. Make sure your file is formated to the sample json included in this git.
5. Rscript Parsing_GPT_R.R

### License
See Liscence

### Acknowledgments
Thanks to R, python, and OpenAI's ChatGPT for inspiring this project.