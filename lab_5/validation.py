import json
import sys
from jsonschema import validate
from jsonschema import exceptions

data_f = "load.json"
schema_f = "myschema.json"#"generated.json"
try:
    with open(data_f, "r") as read_file:
        data = json.load(read_file)
except Exception as err:
    print("Error loading ", data_f, " \n",err)

try:
    with open(schema_f, "r") as read_schema:
        schema = json.load(read_schema)
except Exception as err:
    print("Error loading ", schema_f, " \n",err)

try:
    validate(instance=data, schema=schema)
    print("Validation successful")
except exceptions.ValidationError as ve:
    print("Validation error!\n", ve)
