docker stop my-redis
docker rm my-redis
docker run --name my-redis -p 6379:6379 -d redis



Start-Job -ScriptBlock {
    . .\chess-model-env\Scripts\Activate.ps1
    uvicorn Chess-Model.src.api.main:app --host 127.0.0.1 --port 8001
}


Start-Job -ScriptBlock {
    . .\sveltekit-chess-env\Scripts\Activate.ps1
    uvicorn Sveltekit-Chess.backend.api.src.main:app --host 127.0.0.1 --port 8000
}


# Display running jobs
Get-Job

# Wait for user input before closing
Read-Host -Prompt "Press Enter to exit"
