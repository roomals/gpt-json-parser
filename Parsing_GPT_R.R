# Load necessary libraries
library(jsonlite)

# Define the JSON file path and parsing the JSON
json_file <- '/home/user/Documents/Convos_With_GPT/conversations.json'
json_data <- fromJSON(json_file)

# Define a function to extract and write messages from a mapping
extractAndWriteMessages <- function(mapping, fileConn) {
  for (id in names(mapping)) {
    # Check if the ID matches the desired format
    if (grepl("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", id)) {
      message_content <- mapping[[id]][["message"]][["content"]]
      if (!is.null(message_content)) {
        parts <- message_content[["parts"]]
        if (!is.null(parts) && length(parts) > 0 && !is.null(parts[[1]])) {
          writeLines(sprintf("## Message ID: %s\n", id), fileConn)
          writeLines(parts[[1]], fileConn)
          writeLines("\n---\n", fileConn)
        }
      }
    }
  }
}

# Access the 'mapping' list within the JSON data
if ("mapping" %in% names(json_data)) {
  mappings <- json_data[["mapping"]]
} else {
  mappings <- list()  # If 'mapping' key is not found, initialize as an empty list
}

# Create a Markdown file for the output
fileConn <- file("/home/user/Documents/Convos_With_GPT/Test.md", "w")

# Add a date timestamp at the top of the document for record-keeping
timestamp <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
writeLines(paste("## Conversation Log -", timestamp), fileConn)
writeLines("", fileConn)
writeLines("# Extracted Messages", fileConn)

# Extract and write messages for IDs with the desired format
extractAndWriteMessages(mappings, fileConn)

# Close the Markdown file
close(fileConn)
