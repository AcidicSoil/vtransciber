from moviepy.editor import AudioFileClip
from pathlib import Path

def extract_audio(video_path: Path):
    """Extract audio from a video file."""
    try:
        audio = AudioFileClip(str(video_path))
        audio_path = video_path.parent / f"{video_path.stem}_audio.wav"
        audio.write_audiofile(str(audio_path), verbose=False, logger=None)
        return audio_path
    except Exception as e:
        raise RuntimeError(f"Audio extraction failed: {e}")
