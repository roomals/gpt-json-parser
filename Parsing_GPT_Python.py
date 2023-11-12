import json
import re
from datetime import datetime

# Define the JSON file path and parsing the JSON
json_file = '/home/user/Documents/Convos_With_GPT/conversations.json'

with open(json_file, 'r') as f:
    json_data = json.load(f)

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
                        file_conn.write(f"## Message ID: {id}\n")
                        file_conn.write(parts[0] + "\n---\n")

# Access the 'mapping' dictionary within the JSON data
if "mapping" in json_data:
    mappings = json_data["mapping"]
else:
    mappings = {}  # If 'mapping' key is not found, initialize as an empty dictionary

# Create a Markdown file for the output
output_file = "/home/user/Documents/Convos_With_GPT/Test1.md"
with open(output_file, "w") as file_conn:
    # Add a date timestamp at the top of the document for record-keeping
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    file_conn.write(f"## Conversation Log - {timestamp}\n\n")
    file_conn.write("# Extracted Messages\n")
    # Extract and write messages for IDs with the desired format
    extract_and_write_messages(mappings, file_conn)
