# ADS 507 - Practical Data Engineering

# Project Overview

This project leverages highway and travel information from the Washington State Department of Transportation (WSDOT) to create an interactive dashboard that provides real-time highway alerts, weather updates, and travel times.

The dashboard connects to a MySQL database, which ingests data from WSDOT’s RESTful APIs. By integrating live traffic and weather data, this system helps end users make informed travel decisions in Washington State.

# Project Objective

The primary goal of this project is to:

- Develop a dashboard that displays real-time highway and travel information.
- Aggregate traffic alerts, weather conditions, and estimated travel times from WSDOT.
- Store and manage data efficiently using a MySQL database.
- Connect to WSDOT’s RESTful APIs to ensure continuous updates.
- Provide an intuitive and accessible tool for travelers in Washington State.

# Contributors

- [Amayrani Balbuena](https://github.com/amayranib)
- [Jun Clemente](https://github.com/junclemente)
- [Sasha Libolt](https://github.com/slibolt)


# Installation

This project uses Jupyter Notebooks, Python scripts, a MySQL database, and API integreation with the Washington State Department of Transportation APIs. 

## Install the Conda Environment

- Anaconda or Miniconda must be installed on your system. 
- Run the following command to create the environment:
```bash
conda env create -f environment/ads507.yml
```
- If the YAML file needs to be updated or modified, the environment can be updated with the following: 
```bash
conda env update -f environment/ads507.yml --prune
```
- Activate the environment:
```bash
conda activate ads507
```

## Database Setup

This project requires a MySQL database to store traffic data. 
- Ensure access to a MySQL Server. MySQL Workbench can also be used. 
- Use the provided schema file located in: 
```pgsql
sql/schema/
├── ads507_team2_schema.sql
└── sample_data.sql 
```
- Run the `ads507_team2_schema.sql` SQL script to create the database and tables. 
- `sample_data.sql` was included as example data but it is recommended to run the Jupyter Notebook or Python script to populate the database. 

### API Configuration

This project fetches real-time data provided by the Washington State Department of Transportation (WSDOT) APIs:
- Travel Times
- Highway Alerts
- Weather Information

#### Obtain API Access Credentials:
- Obtain an API key from [WSDOT API Portal](https://wsdot.wa.gov/traffic/api/). 
- This key is required to access the APIs. 

#### Create a `.env` File

In the root directory of the project, create a file named `.env` with the following variables: 

```ini
# WSDOT API Key
API_KEY=your_api_key_here

# MySQL Database Configuration
AZURE_URL=your_database_url
AZURE_PORT=your_database_port
AZURE_DB=your_database_name

AZURE_USERNAME=your_database_username
AZURE_PWD=your_database_password
```
- The `.env` file is automatically loaded by the project using the `dotenv` Python library. 
- API requests and datbase conmnections pull credentials from this file instead of hardcoding them into the file to ensure security and prevent abuse. 

#### Security
Do not commit the `.env` file to Git as it contains sensitive credentials. 
To prevent accidental commits, the `.gitignore` file should include `.env`. 

## Python Environment and CRON

To set up the project to run using a CRON job, the Jupyter Notebook was exported to a Python script. To create a compatible environment without Conda, a `requirements.txt` file was created with the following command: 

```
pip list --format=freeze > requirements.txt
```

A CRON job can be used to run the script on a schedule.





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
- Washington State DOT APIs



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
