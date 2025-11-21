# sem_three_eligify

## Overview
ELIGIFY is a simple Flask-backed app with a frontend for exam eligibility checks. The backend exposes an endpoint to parse PDF files. PDF parsing now uses OCR via PyTesseract.

## OCR Setup (Windows)
To use the OCR-based PDF parser, install these prerequisites:

- Install Tesseract OCR: https://github.com/UB-Mannheim/tesseract/wiki
  - Default install path: `C:\Program Files\Tesseract-OCR\tesseract.exe`
  - Optionally set env var `TESSERACT_CMD` to the full path of `tesseract.exe`.

- Install Poppler for Windows (required by `pdf2image`):
  - Download from: https://github.com/oschwartz10612/poppler-windows/releases/
  - Add the `bin` folder to your system `PATH`, or set env var `POPPLER_PATH` to that `bin` directory.

## Python Dependencies
Install Python packages:

```
pip install -r requirements.txt
```

`requirements.txt` includes: `flask`, `pytesseract`, `pdf2image`, `Pillow`.

## Run the App
Start the Flask server:

```
python app.py
```

Visit `http://localhost:3000/` in a browser.

## PDF Parsing API
- Endpoint: `POST /api/parse-pdf`
- Form field: `file` (PDF)
- Response:

```
{
  "text": "...extracted OCR text..."
}
```

## Collaborator C & E Notes
- Core module: `lib/pdf_parser.py`
- Functions:
  - `parse_pdf(...)` with `method='auto'|'text'|'ocr'` returns text or a diagnostic string.
  - `extract_text_with_info(...)` returns diagnostics (`decided_method`, `text_layer_found`, `ocr_available`, `rasterize_ok`, `ocr_ok`, `warnings`).
  - `extract_headings_and_bullets(...)` returns headings and bullet items.
  - `extract_modification_items(...)` normalizes bullet items.
  - `extract_marksheet_fields(...)` extracts common marksheet fields or returns `{ "error": <reason> }`.

### Environment variables
- `TESSERACT_CMD`: full path to `tesseract.exe` (if not in PATH).
- `POPPLER_PATH`: path to Poppler `bin` directory (Windows).

### Usage examples
```python
from lib.pdf_parser import (
    parse_pdf,
    extract_text_with_info,
    extract_headings_and_bullets,
    extract_modification_items,
    extract_marksheet_fields,
)

# Auto: prefer embedded text, fallback to OCR
text = parse_pdf("sample.pdf", dpi=300, ocr_lang="eng", method="auto")

# Diagnostics
info = extract_text_with_info("sample.pdf", method="auto")
print(info["decided_method"], info["text_layer_found"], info["warnings"]) 

# Headings/Bullets
hb = extract_headings_and_bullets("sample.pdf")

# Normalized modification items
mods = extract_modification_items("project_modification.pdf")

# Marksheet fields
fields = extract_marksheet_fields("marksheet.pdf")
```

### Branches
- OCR improvements: `feature/ocr-extraction`
- Parsing utilities and diagnostics: `feature/pdf-parsing`

### Notes for integration
- Return diagnostic strings or `extract_text_with_info` in the API for easier debugging.
- Ensure `POPPLER_PATH`/`TESSERACT_CMD` are set in deployment environments on Windows.
