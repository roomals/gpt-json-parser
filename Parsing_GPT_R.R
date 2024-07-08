library(jsonlite)
library(stringr)

# Define the JSON file path and parsing the JSON
json_file <- '/home/roomal/Downloads/2024-07-07-13-36-32/conversations.json'

# Read the JSON file as a string
json_str <- readLines(json_file, warn = FALSE)

# Collapse the lines into a single string
json_str <- paste(json_str, collapse = "")

# Remove the first and last brackets if they exist
if (str_starts(json_str, '\\[') & str_ends(json_str, '\\]')) {
  json_str <- str_sub(json_str, 2, -2)
}

# Fix possible trailing commas that might cause issues after bracket removal
json_str <- str_replace_all(json_str, ',\\s*$', '')

# Ensure the modified string is properly formatted by wrapping it in square brackets again
json_str <- paste0('[', json_str, ']')

# Parse the modified JSON string
json_data <- tryCatch({
  fromJSON(json_str, simplifyVector = FALSE)
}, error = function(e) {
  cat(paste0("Error parsing JSON: ", e$message, "\n"))
  quit(status = 1)
})

# Print the structure of json_data for debugging
print(str(json_data))

# Define a function to extract and write messages from a mapping
extract_and_write_messages <- function(mapping, file_conn) {
  for (id in names(mapping)) {
    # Check if the ID matches the desired format
    if (grepl("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", id)) {
      message_info <- mapping[[id]]$message
      if (!is.null(message_info)) {
        content <- message_info$content
        if (!is.null(content) && !is.null(content$parts)) {
          parts <- content$parts
          if (length(parts) > 0 && !is.null(parts[[1]])) {
            writeLines(c(paste0("## Message ID: ", id), "", parts[[1]], "", "---", ""), file_conn)
          }
        }
      }
    }
  }
}

# Access the 'mapping' dictionary within the JSON data
mappings <- list()  # Initialize as an empty list

# Loop through the list and collect all mappings
for (item in json_data) {
  if (is.list(item) && !is.null(item$mapping)) {
    mappings <- c(mappings, item$mapping)
  }
}

# Create a Markdown file for the output
output_file <- "/home/roomal/Documents/Test1.md"
timestamp <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
writeLines(c(paste0("## Conversation Log - ", timestamp), "", "# Extracted Messages", ""), output_file)
file_conn <- file(output_file, "a")
extract_and_write_messages(mappings, file_conn)
close(file_conn)
