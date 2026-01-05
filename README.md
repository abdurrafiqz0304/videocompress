# VIDEO COMPRESSOR // TITANIUM EDITION
### The Set Up may take several minutes to complete

## 🚀 Quick Start (No Manual Setup)
## 📦 Installation (Automatic)

This tool comes with an auto-installer that sets up the environment and creates shortcuts.

1. **Clone the repository**:

```bash
git clone [https://github.com/abdurrafiqz0304/videocompress.git](https://github.com/abdurrafiqz0304/videocompress.git) && cd videocompress && install.bat
```
2. **CMD**:
```bash
curl -k -L -o titanium.zip https://github.com/abdurrafiqz0304/videocompress/archive/refs/heads/main.zip && tar -xf titanium.zip && cd videocompress-main && install.bat
```

3. **PowerShell**:
```bash
Invoke-WebRequest -Uri "https://github.com/abdurrafiqz0304/videocompress/archive/refs/heads/main.zip" -OutFile "titanium.zip"; Expand-Archive -Path "titanium.zip" -DestinationPath "."; cd videocompress-main; .\install.bat
```

4. **Termux**:
```bash
pkg update -y && pkg upgrade -y && pkg install python ffmpeg -y && termux-setup-storage && echo "import os,subprocess;I='/sdcard/Download/Video_Raw';O='/sdcard/Download/Video_Compressed';os.makedirs(I,exist_ok=True);os.makedirs(O,exist_ok=True);print('\n--- TITANIUM MOBILE ---');print(f'Put videos in: {I}');input('Press Enter to Start...');files=[f for f in os.listdir(I) if f.endswith(('.mp4','.mkv','.mov'))];print(f'Found {len(files)} videos.');[subprocess.run(f'ffmpeg -i \"{I}/{f}\" -v error -stats -c:v libx264 -crf 23 -preset ultrafast \"{O}/small_{f}\"',shell=True) for f in files];print('Done!')" > mobile_compress.py && python mobile_compress.py
```

## ✨ Key Features

* **📂 Batch Processing:** Drag and drop hundreds of videos; the tool processes them sequentially automatically.
* **🧠 Smart Skip Logic:** Automatically detects if a file is already optimized and skips it to save time.
* **🎛️ 3 Compression Modes:**
    * **Lossless:** Retains original quality (CRF 18).
    * **Balanced:** The sweet spot between size and quality (CRF 23).
    * **Aggressive:** Maximum compression for WhatsApp/Discord sharing (CRF 28).
* **🎨 Cyberpunk CLI:** A modern, colored terminal interface with real-time status updates.
* **🔈 Audio Preservation:** Maintains audio clarity using standard AAC encoding.
* **📱 Cross-Platform:** Works on Windows, macOS, Linux, and Android (Termux).

## 🚀 How to Use (Workflow)

This tool does not use a "File Picker" window. It works by scanning a specific folder.

### Step 1: Initialization
Run the tool for the first time by double-clicking **`install.bat`** (or `vidcomp.bat`).
* This will automatically generate two necessary folders in your directory:
    * `📁 videos_raw` (Input Zone)
    * `📁 videos_compressed` (Output Zone)

### Step 2: "Upload" Your Videos
**This is the most important step.**
Move or Copy your heavy video files (`.mp4`, `.mov`, `.mkv`, etc.) into the **`videos_raw`** folder.
* *You can put 1 video or 100 videos here. The tool will handle them all.*

### Step 3: Launch Protocol
Double-click the **Desktop Shortcut** or **`vidcomp.bat`**.
The system will detect the files in `videos_raw` and ask you to select a mode:

| Input | Mode | Description | Best For |
| :--- | :--- | :--- | :--- |
| **1** | **LOSSLESS** | Low compression, high bitrate. | Archiving / Editing |
| **2** | **BALANCED** | Standard H.264 compression. | YouTube / General Use |
| **3** | **AGGRESSIVE** | High compression, lower bitrate. | WhatsApp / Discord |

### Step 4: Processing
Sit back. The terminal will show the progress:
* **[DONE]:** Successful compression.
* **[SKIP]:** File was ignored (already small enough).
* **[FAIL]:** Error processing file.

### Step 5: Completion
Once finished, the **`videos_compressed`** folder will open automatically containing your new, smaller files.