param(
  [Parameter(Mandatory=$true)][string]$Msg,
  [string]$Tag = ""
)

# 一键：暂存 -> 提交 -> 打标签 -> 推送（推送失败不阻塞答题）
# 无论在哪个目录调用，都先切到仓库根目录
$root = git rev-parse --show-toplevel 2>$null
if ($LASTEXITCODE -eq 0 -and $root) { Set-Location $root }

git add -A
git commit -m $Msg
if ($Tag -ne "") { git tag $Tag }

git push origin main --tags 2>$null

if ($LASTEXITCODE -ne 0) {
  Write-Host "推送失败：已本地提交并打标签，稍后补推（git push origin main --tags）" -ForegroundColor Yellow
} else {
  $suffix = ""
  if ($Tag -ne "") { $suffix = " (" + $Tag + ")" }
  Write-Host ("已提交并推送：" + $Msg + $suffix) -ForegroundColor Green
}
