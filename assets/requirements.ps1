Clear-Host

#pull script file from github
if(Test-Path -Path assets){
    Set-Location assets
} else {
    mkdir assets
    Set-Location assets
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest "https://raw.githubusercontent.com/CoriumCake/youtube-bat/main/assets/ytb.ps1" -OutFile ( New-Item -Path "scripts\ytb.ps1" -Force)
}

Clear-Host

#install ffmpeg
if(Test-Path -Path ffmpeg){
    Write-Host "ffmpeg" -NoNewline; Write-Host " pass. " -ForegroundColor Green;
} else {
    Write-Host "downloading ffmpeg"
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest "https://github.com/GyanD/codexffmpeg/releases/download/5.1.2/ffmpeg-5.1.2-essentials_build.zip" -OutFile ( New-Item -Path "ffmpeg\ffmpeg.zip" -Force)
    Expand-Archive -Force ffmpeg\ffmpeg.zip ffmpeg 
    Remove-Item ffmpeg\ffmpeg.zip
    Write-Host "ffmpeg installed`n"
}

#install ytdlp
if(Test-Path -Path ytdlp){
    Write-Host "yt-dlp" -NoNewline; Write-Host " pass. " -ForegroundColor Green;
} else {
    Write-Host "downloading yt-dlp"
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe" -OutFile ( New-Item -Path "ytdlp\ytdlp.exe" -Force)
    Write-Host "yt-dlp installed"
}

Set-Location ..
Set-Content main.bat "powershell.exe -ExecutionPolicy Bypass -File assets\scripts\ytb.ps1"

Write-Host ""
Write-Host "Done!"

Remove-Item $script:MyInvocation.MyCommand.Path -Force
