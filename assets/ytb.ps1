$base = Get-Location
$key = "HKCU:\Software\yt-bat"

$env:path = "$base\assets\ffmpeg\ffmpeg-5.1.2-essentials_build\bin;$base\assets\ytdlp;C:\Windows\system32"

#reg =======================================================================================
if (!(Test-Path $key)) {
    New-Item -path "HKCU:\Software\" -name "yt-bat"
    Set-ItemProperty -path "HKCU:\Software\yt-bat" -name "path" -value "$base"
}

#home function =============================================================================
function home {
    Clear-Host

    Write-Host "::: " -ForegroundColor white -NoNewline; Write-Host "YOUTUBE BAT " -ForegroundColor Red -NoNewline; Write-Host ":::" -ForegroundColor white -NoNewline;

    Write-Host ""

    Write-Host "1 .webm " -ForegroundColor Yellow -NoNewline; Write-Host "(fastest)" -ForegroundColor white
    Write-Host "2 .mp4 " -ForegroundColor Yellow -NoNewline; Write-Host "(best quality)" -ForegroundColor white
    Write-Host "3 .mp3 " -ForegroundColor Yellow -NoNewline; Write-Host "(audio only)" -ForegroundColor white
    Write-Host "4 change directory" -ForegroundColor Cyan
    Write-Host "5 exit" -ForegroundColor Red

    Write-Host ""

    Write-Host "[1]" -NoNewline; Write-Host " webm " -ForegroundColor Yellow -NoNewline;
    Write-Host "[2]" -NoNewline; Write-Host " mp4 " -ForegroundColor Yellow -NoNewline;
    Write-Host "[3]" -NoNewline; Write-Host " mp3 " -ForegroundColor Yellow -NoNewline; 
    Write-Host "[4]" -NoNewline; Write-Host " cd " -ForegroundColor Cyan -NoNewline;
    Write-Host "[5]" -NoNewline; Write-Host " exit" -ForegroundColor Red -NoNewline;

    CHOICE /n /c:12345

    Switch ($LASTEXITCODE) {
        1 {webm}
        2 { mp4 }
        3 { mp3 }
        4 { changedir }
        5 { exit }
    }
}

#webm function =============================================================================
function webm {
    Clear-Host

    Write-Host ":::" -ForegroundColor white -NoNewline ; Write-Host ".webm" -ForegroundColor Yellow -NoNewline ; Write-Host ":::" -ForegroundColor white 

    Write-Host ""

    Write-Host "Current folder" -ForegroundColor Cyan -NoNewline; Write-Host " >> " -ForegroundColor Yellow -NoNewline; Write-Host((Get-ItemProperty -path $key).path) -ForegroundColor white;

    Write-Host ""
    $pathA = Read-Host "Youtube link"

    Write-Host ""

    if (($null -eq $pathA) -or ($pathA -eq "") -or ($pathA -eq " ")) {
        Write-Host "Your link is invalid" -ForegroundColor Red
    }
    else {
        $reg = (Get-ItemProperty -path $key).path
        ytdlp --format "bv*+ba/b" -o "$reg\output\webm\%(title)s" $pathA
    }

    Write-Host ""

    Write-Host "[1]" -NoNewline; Write-Host " continue " -ForegroundColor green -NoNewline; Write-Host "[2]" -NoNewline; Write-Host " exit " -ForegroundColor red -NoNewline;

    CHOICE /n /c:12

    Switch ($LASTEXITCODE) {
        1 { webm }
        2 { home }
    }
}

#mp4 function =============================================================================
function mp4 {
    Clear-Host

    Write-Host ":::" -ForegroundColor white -NoNewline ; Write-Host ".mp4 (best quality)" -ForegroundColor Yellow -NoNewline ; Write-Host ":::" -ForegroundColor white 

    Write-Host ""

    Write-Host "Current folder" -ForegroundColor Cyan -NoNewline; Write-Host " >> " -ForegroundColor Yellow -NoNewline; Write-Host((Get-ItemProperty -path $key).path) -ForegroundColor white;

    Write-Host ""
    $pathA = Read-Host "Youtube link"

    Write-Host ""

    if (($null -eq $pathA) -or ($pathA -eq "") -or ($pathA -eq " ")) {
        Write-Host "Your link is invalid" -ForegroundColor Red
    }
    else {
        $reg = (Get-ItemProperty -path $key).path
        ytdlp --format "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]" -o "$reg\output\mp4\%(title)s" $pathA
    }

    Write-Host ""

    Write-Host "[1]" -NoNewline; Write-Host " continue " -ForegroundColor green -NoNewline; Write-Host "[2]" -NoNewline; Write-Host " exit " -ForegroundColor red -NoNewline;

    CHOICE /n /c:12

    Switch ($LASTEXITCODE) {
        1 { mp4 }
        2 { home }
    }
}

# mp3 function =============================================================================
function mp3 {
    Clear-Host

    Write-Host ":::" -ForegroundColor white -NoNewline ; Write-Host ".mp3 (best quality)" -ForegroundColor Yellow -NoNewline ; Write-Host ":::" -ForegroundColor white

    Write-Host ""

    Write-Host "Current folder" -ForegroundColor Cyan -NoNewline; Write-Host " >> " -ForegroundColor Yellow -NoNewline; Write-Host((Get-ItemProperty -path $key).path) -ForegroundColor white;

    Write-Host ""

    $pathA = Read-Host "Youtube link"

    Write-Host ""

    if (($null -eq $pathA) -or ($pathA -eq "") -or ($pathA -eq " ")) {
        Write-Host "Your link is invalid" -ForegroundColor Red
    }
    else {
        $reg = (Get-ItemProperty -path $key).path
        ytdlp --extract-audio --audio-format mp3 --audio-quality 0 -o "$reg\output\mp3\%(title)s.%(ext)s" $pathA
    }

    Write-Host ""

    Write-Host "[1]" -NoNewline; Write-Host " continue " -ForegroundColor green -NoNewline; Write-Host "[2]" -NoNewline; Write-Host " exit " -ForegroundColor red -NoNewline;

    CHOICE /n /c:12

    Switch ($LASTEXITCODE) {
        1 { mp3 }
        2 { home }
    }
}

# change dir function ====================================================================
function changedir {
    Clear-Host

    Write-Host ":::" -ForegroundColor white -NoNewline; Write-Host " Change Directory " -ForegroundColor Red -NoNewline; Write-Host ":::" -ForegroundColor white

    Write-Host ""

    Write-Host "Current Path" -ForegroundColor Cyan -NoNewline; Write-Host " >> " -ForegroundColor Yellow -NoNewline; Write-Host((Get-ItemProperty -path $key).path) -ForegroundColor white;

    Write-Host ""

    Write-Host "[1]" -NoNewline; Write-Host " edit " -ForegroundColor green -NoNewline; Write-Host "[2]" -NoNewline; Write-Host " exit " -ForegroundColor red -NoNewline;

    CHOICE /n /c:12

    Switch ($LASTEXITCODE) {
        1 { editdir } 
        2 { home }
    }
}

#edit dir function ========================================================================
function editdir {
    Clear-Host

    Write-Host ":::" -ForegroundColor white -NoNewline; Write-Host " Change Directory " -ForegroundColor Red -NoNewline; Write-Host ":::" -ForegroundColor white

    Write-Host ""

    Write-Host "Current Path" -ForegroundColor Cyan -NoNewline; Write-Host " >> " -ForegroundColor Yellow -NoNewline; Write-Host((Get-ItemProperty -path $key).path) -ForegroundColor white;

    Write-Host ""

    Write-Host "new path "-ForegroundColor blue -NoNewline; Write-Host ">> " -ForegroundColor Yellow -NoNewline

    $pathA = Read-Host
    
    if (($null -eq $pathA) -or ($pathA -eq "") -or ($pathA -eq " ")) {
        changedir
    }
    else {
        if (Test-Path $pathA) {
            Write-Host ""

            Write-Host "new directory is" -ForegroundColor DarkBlue -NoNewline; Write-Host " >> " -ForegroundColor Yellow -NoNewline; Write-Host("$pathA") -ForegroundColor white;
            
            Write-Host ""

            Write-Host "[1]" -NoNewline; Write-Host " save " -ForegroundColor green -NoNewline; Write-Host "[2]" -NoNewline; Write-Host " exit " -ForegroundColor red -NoNewline;
    
            CHOICE /n /c:12

            Switch ($LASTEXITCODE) {
                1 { Set-ItemProperty -path $key -name "path" -value "$pathA" }
                1 { changedir } 
                2 { editdir }
            }
        }
        else {
            Write-Host ""

            Write-Host "your path is invalid" -ForegroundColor red

            Write-Host ""

            Write-Host "[1]" -NoNewline; Write-Host " retry " -ForegroundColor green -NoNewline; Write-Host "[2]" -NoNewline; Write-Host " exit " -ForegroundColor red -NoNewline;
    
            CHOICE /n /c:12

            Switch ($LASTEXITCODE) {
                1 { changedir }
                2 { home }
            }
        }
    }
}

home
