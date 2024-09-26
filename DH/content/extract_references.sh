#!/bin/bash

# Output file
output_file="extracted_references.html"

# Write HTML5 boilerplate header
cat <<EOL > $output_file
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Extracted References</title>
</head>
<body>
EOL

# Extract references and titles
grep -l '<h2 class="normal">References for Further Reading</h2>' *chapter*.html | while read file; do
    echo "<article>" >> $output_file
    echo "<!-- From the file: $file -->" >> $output_file

    # Extract the title
    title=$(sed -n 's/.*<h2 class="normal">\([^<]*\)<\/h2>.*/\1/p' "$file" | head -n 1)
    echo "<h1>$title</h1>" >> $output_file

    # Extract the references section, excluding the <h2> tag
    sed -n '/<h2 class="normal">References for Further Reading<\/h2>/,/<\/div>/p' "$file" | sed '1d' >> $output_file
    echo -e "\n\n" >> $output_file
    echo "</article>" >> $output_file
done

# Write HTML5 boilerplate footer
cat <<EOL >> $output_file
</body>
</html>
EOL
