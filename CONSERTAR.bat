@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo.
echo === Arrumando o perfil do GitHub ===
echo.

if exist "_github" (
  if exist ".github" rmdir /s /q ".github"
  ren "_github" ".github"
  echo [ok] _github renomeada para .github
)
if exist "snake.yml" del /q "snake.yml" & echo [ok] snake.yml antigo da raiz apagado

for %%f in (assets\header-dark.svg assets\header-light.svg assets\stack-dark.svg assets\stack-light.svg assets\footer.svg assets\projetos\lead-capture-api.svg assets\projetos\safe-upload.svg) do (
  if exist "%%f" del /q "%%f"
)
echo [ok] arquivos das versoes antigas apagados
echo.

where git >nul 2>nul
if errorlevel 1 (
  echo Git nao encontrado. Instale em https://git-scm.com e rode este arquivo de novo.
  pause
  exit /b 1
)

if not exist ".git" (
  git init -b main >nul
  git remote add origin https://github.com/KaioNacamura/KaioNacamura.git
)
git add -A
git commit -m "Perfil novo e cobrinha no lugar certo" >nul
echo Enviando para o GitHub (pode abrir o navegador pedindo login)...
git push -u origin main --force
if errorlevel 1 (
  echo.
  echo O envio falhou. Copie a mensagem acima e mande para o Claude.
  pause
  exit /b 1
)

echo.
echo === Pronto. Falta so no site do GitHub: ===
echo 1. Settings ^> Actions ^> General ^> Workflow permissions ^> Read and write ^> Save
echo 2. Actions ^> GitHub Snake Game ^> Run workflow
echo.
start "" "https://github.com/KaioNacamura/KaioNacamura/settings/actions"
pause
