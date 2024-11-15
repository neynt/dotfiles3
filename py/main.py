import click

@click.command()
@click.argument('input_file', type=click.Path(exists=True))
@click.argument('output_file', type=click.Path())
def extract_text(input_file, output_file):
    """Extracts only the text content from an SRT file and saves it to an output file."""
    with open(input_file, 'r', encoding='utf-8') as infile, open(output_file, 'w', encoding='utf-8') as outfile:
        lines = infile.readlines()
        for line in lines:
            # Skip lines that are numbers or timestamps
            if line.strip().isdigit() or '-->' in line:
                continue
            # Write non-empty text lines
            if line.strip():
                outfile.write(line)

if __name__ == '__main__':
    extract_text()
