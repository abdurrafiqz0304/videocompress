import os
import subprocess
import glob
import sys
import platform
import shutil
import time

# --- AESTHETICS ENGINE (Garunk Mode) ---
if os.name == 'nt': os.system('color') 

class Style:
    RED = '\033[91m'
    GREEN = '\033[92m'
    CYAN = '\033[96m'
    YELLOW = '\033[93m'
    BOLD = '\033[1m'
    RESET = '\033[0m'
    
    @staticmethod
    def header(text):
        print(f"\n{Style.BOLD}{Style.CYAN} :: {text} :: {Style.RESET}")

    @staticmethod
    def status(type, message):
        if type == "INFO": prefix = f"{Style.CYAN}[INFO]{Style.RESET}"
        elif type == "EXEC": prefix = f"{Style.YELLOW}[EXEC]{Style.RESET}"
        elif type == "DONE": prefix = f"{Style.GREEN}[DONE]{Style.RESET}"
        elif type == "FAIL": prefix = f"{Style.RED}[FAIL]{Style.RESET}"
        else: prefix = f"[{type}]"
        print(f" {prefix} {message}")

# --- CONFIGURATION ---
INPUT_DIR = "videos_raw"
OUTPUT_DIR = "videos_compressed"
EXTENSIONS = ('.mp4', '.mov', '.mkv', '.avi', '.ts', '.flv', '.webm')

def get_binary(tool):
    local = os.path.join(os.getcwd(), f"{tool}.exe")
    return local if os.path.exists(local) else shutil.which(tool)

FFMPEG = get_binary("ffmpeg")

def open_directory(path):
    try:
        if platform.system() == "Windows": os.startfile(path)
        elif platform.system() == "Darwin": subprocess.Popen(["open", path])
        else: subprocess.Popen(["xdg-open", path])
    except: pass

def compress_core(input_path, output_path, crf_val):
    filename = os.path.basename(input_path)
    cmd = [
        FFMPEG, '-y', '-v', 'error', '-stats',
        '-i', input_path, '-c:v', 'libx264', '-preset', 'medium',
        '-crf', str(crf_val), '-c:a', 'aac', '-b:a', '128k',
        output_path
    ]

    print(f"\n {Style.BOLD}>> PROCESSING TARGET: {Style.CYAN}{filename}{Style.RESET}")
    start = time.time()
    try:
        subprocess.run(cmd, check=True, stdin=subprocess.DEVNULL)
        size_in = os.path.getsize(input_path)
        size_out = os.path.getsize(output_path)
        reduction = ((size_in - size_out) / size_in) * 100
        elapsed = time.time() - start
        
        Style.status("DONE", f"Time: {elapsed:.1f}s | Delta: {Style.GREEN}-{reduction:.1f}%{Style.RESET}")
        Style.status("INFO", f"{size_in/(1024*1024):.1f}MB -> {Style.BOLD}{size_out/(1024*1024):.1f}MB{Style.RESET}")
    except:
        Style.status("FAIL", f"Corruption detected in {filename}")

def main():
    os.system('cls' if os.name == 'nt' else 'clear')
    print(f"{Style.BOLD}{Style.RED}")
    print(" ╔═══════════════════════════════════════════════╗")
    print(" ║    TITANIUM COMPRESSOR // CORE ACTIVE v4.0    ║")
    print(" ╚═══════════════════════════════════════════════╝")
    print(f"{Style.RESET}")

    if not FFMPEG:
        Style.status("FAIL", "CRITICAL: FFmpeg binaries missing.")
        return

    if not os.path.exists(INPUT_DIR):
        os.makedirs(INPUT_DIR)
        Style.status("INFO", f"Sector Initialized: {INPUT_DIR}")
        return
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    files = []
    for ext in EXTENSIONS:
        files.extend(glob.glob(os.path.join(INPUT_DIR, f"*{ext}")))

    if not files:
        Style.status("FAIL", f"No payloads in sector '{INPUT_DIR}'.")
        return

    Style.status("INFO", f"{len(files)} Targets Acquired.")
    Style.header("SELECT COMPRESSION PROTOCOL")
    print(f" {Style.BOLD}1.{Style.RESET} LOSSLESS (Minimal Compression)")
    print(f" {Style.BOLD}2.{Style.RESET} BALANCED (Recommended)")
    print(f" {Style.BOLD}3.{Style.RESET} AGGRESSIVE (Max Save)")
    
    try:
        choice = input(f"\n {Style.RED}>> INPUT COMMAND: {Style.RESET}")
        if choice == '1': crf = 18
        elif choice == '3': crf = 28
        else: crf = 23
    except: return

    Style.header("INITIATING SEQUENCE")
    for f in files:
        out = os.path.join(OUTPUT_DIR, f"compressed_{os.path.basename(f)}")
        compress_core(f, out, crf)
    
    Style.header("SEQUENCE COMPLETE")
    open_directory(OUTPUT_DIR)

if __name__ == "__main__":
    main()