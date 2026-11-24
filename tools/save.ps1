param(
  [Parameter(Mandatory=$true)][string]$Msg,
  [string]$Tag = ""
)

# 让 git 输出按 UTF-8 解码（中文路径必需）
$prevOut = [Console]::OutputEncoding
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch {}

# 脚本在 tools/ 下，仓库根目录就是它的上一层（不解析 git 输出，避开中文路径乱码）
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

git add -A

# 提交信息走临时文件：PowerShell 5.1 传参会用系统 ANSI 编码，中文会存成乱码
$msgFile = [System.IO.Path]::GetTempFileName()
[System.IO.File]::WriteAllText($msgFile, $Msg, (New-Object System.Text.UTF8Encoding($false)))
git commit -F $msgFile
$commitCode = $LASTEXITCODE
Remove-Item $msgFile -Force

if ($commitCode -ne 0) {
  Write-Host "没有需要提交的改动" -ForegroundColor Yellow
} else {
  if ($Tag -ne "") { git tag $Tag }

  git push origin main --tags 2>$null
  if ($LASTEXITCODE -ne 0) {
    Write-Host "推送失败：已本地提交并打标签，稍后补推（git push origin main --tags）" -ForegroundColor Yellow
  } else {
    $suffix = ""
    if ($Tag -ne "") { $suffix = " (" + $Tag + ")" }
    Write-Host ("已提交并推送：" + $Msg + $suffix) -ForegroundColor Green
  }
}

try { [Console]::OutputEncoding = $prevOut } catch {}
