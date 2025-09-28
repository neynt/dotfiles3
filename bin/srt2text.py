#!/usr/bin/env python3
import re
import click

def extract_text_from_srt(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.read()

    # Remove subtitle numbers and timecodes
    pattern = r'\d+\n\d{2}:\d{2}:\d{2},\d{3} --> \d{2}:\d{2}:\d{2},\d{3}\n'
    cleaned_content = re.sub(pattern, '', content)

    # Remove empty lines
    lines = [line.strip() for line in cleaned_content.split('\n') if line.strip()]

    return ' '.join(lines)

@click.command()
@click.argument('input_file', type=click.Path(exists=True))
@click.option('--output', '-o', type=click.Path(), help='Output file path. If not provided, prints to console.')
@click.option('--preserve-lines', '-l', is_flag=True, help='Preserve line breaks in the output.')
def main(input_file, output, preserve_lines):
    """Extract text from an SRT file."""
    try:
        extracted_text = extract_text_from_srt(input_file)

        if preserve_lines:
            extracted_text = extracted_text.replace('. ', '.\n')

        if output:
            with open(output, 'w', encoding='utf-8') as f:
                f.write(extracted_text)
            click.echo(f"Extracted text has been written to {output}")
        else:
            click.echo(extracted_text)

    except Exception as e:
        click.echo(f"An error occurred: {e}", err=True)
        raise click.Abort()

if __name__ == "__main__":
    main()
