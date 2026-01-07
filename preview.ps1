<#
Simple local static file server for Windows PowerShell.
Usage:
  .\preview.ps1                  # serve current folder on port 8000
  .\preview.ps1 -Port 9000      # choose port
  .\preview.ps1 -Root site -Port 8080
Stop the server with Ctrl+C in the terminal.
#>
param(
  [int]$Port = 8000,
  [string]$Root = '.'
)

$Root = (Resolve-Path $Root).ProviderPath
Add-Type -AssemblyName System.Net.HttpListener
$listener = New-Object System.Net.HttpListener
$prefix = "http://+:$Port/"
$listener.Prefixes.Add($prefix)
try {
  $listener.Start()
} catch {
  Write-Error "Failed to start listener on port $Port. Try a different port or run as Administrator."
  exit 1
}
Write-Output "Serving '$Root' at http://localhost:$Port/"
Write-Output "Press Ctrl+C to stop."

try {
  while ($listener.IsListening) {
    $context = $listener.GetContext()
    try {
      $req = $context.Request
      $res = $context.Response
      $path = $req.Url.AbsolutePath.TrimStart('/') -replace '%20',' '
      if ([string]::IsNullOrEmpty($path)) { $path = 'index.html' }
      $file = Join-Path $Root $path
      if (-not (Test-Path $file)) {
        $res.StatusCode = 404
        $buf = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
        $res.OutputStream.Write($buf,0,$buf.Length)
        $res.Close()
        continue
      }
      $bytes = [System.IO.File]::ReadAllBytes($file)
      switch -regex ($file) {
        '\.html$' { $res.ContentType = 'text/html; charset=utf-8' }
        '\.css$'  { $res.ContentType = 'text/css; charset=utf-8' }
        '\.js$'   { $res.ContentType = 'application/javascript; charset=utf-8' }
        '\.png$'  { $res.ContentType = 'image/png' }
        '\.jpe?g$' { $res.ContentType = 'image/jpeg' }
        '\.svg$'  { $res.ContentType = 'image/svg+xml' }
        '\.json$' { $res.ContentType = 'application/json' }
        default   { $res.ContentType = 'application/octet-stream' }
      }
      $res.ContentLength64 = $bytes.Length
      $res.OutputStream.Write($bytes,0,$bytes.Length)
      $res.Close()
    } catch {
      # ignore per-request errors
    }
  }
} finally {
  if ($listener -and $listener.IsListening) { $listener.Stop(); $listener.Close() }
}
