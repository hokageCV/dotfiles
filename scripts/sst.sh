#!/usr/bin/env python3
import os, json, subprocess
import sounddevice as sd
import vosk

model_path = os.path.expanduser("~/.local/share/vosk/model")
model = vosk.Model(model_path)
rec = vosk.KaldiRecognizer(model, 16000)

# Notify start
subprocess.run(["notify-send", "-t", "1000", "🎤 Voice Typing", "Listening..."])

with sd.RawInputStream(samplerate=16000, blocksize=8000,
                       dtype='int16', channels=1) as stream:

    while True:
        data, _ = stream.read(4000)
        data = bytes(data)

        if rec.AcceptWaveform(data):
            result = json.loads(rec.Result()).get("text", "").strip()

            if result:
                # 🚧 AUTO-SPACE: add a space after the recognized phrase
                result = result + " "

                # Type into the active window
                subprocess.run(["wtype", result])

                # Popup
                subprocess.run([
                    "notify-send", "-t", "1200",
                    "⌨️ Typed", result
                ])
            else:
                subprocess.run(["notify-send", "-t", "1200", "No speech detected"])

            break

