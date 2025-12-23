# path: install.sh
#!/bin/bash
set -euo pipefail

echo "==================================================="
echo " OBS Recording Transcriber - Unix Installation (uv)"
echo "==================================================="
echo

# Check for Python
if ! command -v python3 &> /dev/null; then
  echo "Python 3 not found! Please install Python 3.8 or higher."
  echo "For Ubuntu/Debian: sudo apt update && sudo apt install python3 python3-pip"
  echo "For macOS: brew install python3"
  exit 1
fi

# Ensure uv is installed
if ! command -v uv &> /dev/null; then
  echo "uv not found. Installing with pip (user install)..."
  python3 -m pip install --user -U uv
  export PATH="$HOME/.local/bin:$PATH"
fi

# Enter script dir (project root assumption)
cd "$(dirname "$0")"

# Make install.py executable if present
if [ -f "install.py" ]; then
  chmod +x install.py
fi

# Create/sync environment + install deps
if [ -f "pyproject.toml" ]; then
  uv sync
elif [ -f "requirements.txt" ]; then
  uv venv
  uv pip install -r requirements.txt
else
  uv venv
  uv pip install streamlit
fi

# Run the existing installer inside the uv environment (if present)
if [ -f "install.py" ]; then
  echo "Running installation script (uv run)..."
  uv run python3 ./install.py
fi

echo
echo "Run the application with:"
echo "uv run streamlit run app.py"
