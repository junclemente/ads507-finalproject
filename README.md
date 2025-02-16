# ADS 507 - Practical Data Engineering

# Installation

For development, part of the code in this project is run using Jupyter Notebooks. Conda is used to manage the Python environment. A YAML file is available for this project.

## Development

### Jupyter Notebook and Environment

To setup and run this project, please follow these steps:

Using conda, install the environment:

`conda env create -f environment/ads507.yml`

If changes were made to the YAML file, you can update the environment by running:

`conda env update -f environment/ads507.yml --prune`

### MySQL Database and Workbench

Access to a MySQL database is also necessary for this project. The database can be created using the provide schema file and MySQL Workbench.

### APIs

Washington State Department of Transportion Traffic APIs are used as the datasource for this project. The API sources used are:

- Travel Times
- Highway Alerts
- Weather Information

More information for this APIs can be found at the [Washington State Department of Transportation https://wsdot.wa.gov/traffic/api/](https://wsdot.wa.gov/traffic/api/) website.

### Credentials

Access code to retrieve data from the APIs is required. To ensure privacy and prevent abuse, the credentials for this project have been stored in a `.env` file. To use the code provided in this project, a `.env` file must be created in the root folder of the project. The `.env` variables must then be uploaded into the environment. This can be done using the `dotenv` Python library.

## Production

For production, the notebook that runs the extract, load, and transform script was exported to a python script.

A CRON job can be used to run the script on a schedule.

# Project Intro / Objective

The objective of this project is to use highway and travel information from the state of Washington to create a dashboard of highway alerts, weather information and travel times. This dashboard will connect to a mysql database. The mysql database connects to the Department of Transportation’s information via rest API and can be used to help end users make travel plans in Washington State.

# Contributors

- [Amayrani Balbuena](https://github.com/amayranib)
- [Jun Clemente](https://github.com/junclemente)
- [Sasha Libolt](https://github.com/slibolt)

# Methods Used

- MySQL
- MySQL Functions
- Pandas / Python

# Technologies

- Github
- Jupyter Notebooks
- Microsoft Azure
- MySQL
- VS Code
  = Washington State DOT APIs

# Project Description

Our objective is to create a dashboard for the highway and travel information for the state of Washington. This will include highway alerts, weather information and travel times. This dashboard will connect via rest API and can be used to help consumers make travel plans in Washington state.

## Data Dictionary

# License

MIT License

Copyright (c) 2025 Amayrani Balbuena, Jun Clemente, Sasha Libolt

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Acknowledgements

[Microsoft Azure: Cloud Computing Services](https://azure.microsoft.com)
[Washington State Dept of Transportation](https://wsdot.wa.gov/traffic/api/)
