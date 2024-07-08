import json
import re
from datetime import datetime

# Define the JSON file path and parsing the JSON
json_file = '/home/roomal/Downloads/2024-07-07-13-36-32/conversations.json'

# Read the JSON file as a string
with open(json_file, 'r') as f:
    json_str = f.read()

# Remove the first and last brackets if they exist
if json_str.startswith('[') and json_str.endswith(']'):
    json_str = json_str[1:-1]

# Fix possible trailing commas that might cause issues after bracket removal
json_str = re.sub(r',\s*$', '', json_str)

# Ensure the modified string is properly formatted by wrapping it in square brackets again
json_str = f'[{json_str}]'

# Parse the modified JSON string
try:
    json_data = json.loads(json_str)
except json.JSONDecodeError as e:
    print(f"Error parsing JSON: {e}")
    exit(1)

# Define a function to extract and write messages from a mapping
def extract_and_write_messages(mapping, file_conn):
    for id in mapping.keys():
        # Check if the ID matches the desired format
        if re.match("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", id):
            message_info = mapping[id].get("message")
            if message_info is not None:
                content = message_info.get("content")
                if content is not None and content.get("parts") is not None:
                    parts = content["parts"]
                    if len(parts) > 0 and parts[0] is not None:
                        file_conn.write(f"## Message ID: {id}\n\n")  # Added extra newline here
                        file_conn.write(parts[0] + "\n\n---\n\n")  # Added extra newline here

# Access the 'mapping' dictionary within the JSON data
if isinstance(json_data, list):
    json_data = json_data[0]

if "mapping" in json_data:
    mappings = json_data["mapping"]
else:
    mappings = {}  # If 'mapping' key is not found, initialize as an empty dictionary

# Create a Markdown file for the output
output_file = "/home/roomal/Documents/Test1.md"
with open(output_file, "w") as file_conn:
    # Add a date timestamp at the top of the document for record-keeping
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    file_conn.write(f"## Conversation Log - {timestamp}\n\n")
    file_conn.write("# Extracted Messages\n\n")
    # Extract and write messages for IDs with the desired format
    extract_and_write_messages(mappings, file_conn)
