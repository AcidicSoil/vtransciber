from pathlib import Path

def validate_environment(obs_path: Path):
    """Validate environment and prerequisites."""
    errors = []
    if not obs_path.exists():
        errors.append(f"OBS directory not found: {obs_path}")
    return errors
