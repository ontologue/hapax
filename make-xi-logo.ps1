Add-Type -AssemblyName System.Drawing

$width = 120
$height = 120
$bmp = New-Object System.Drawing.Bitmap($width, $height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::Transparent)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

$color = [System.Drawing.Color]::FromArgb(255, 26, 122, 122)
$brush = New-Object System.Drawing.SolidBrush($color)

# Essai avec Lithos Pro, fallback Georgia
$fontFamilies = @("Lithos Pro", "Lithos Pro Regular", "Georgia", "Times New Roman")
$font = $null
foreach ($name in $fontFamilies) {
    try {
        $f = New-Object System.Drawing.Font($name, 80, [System.Drawing.FontStyle]::Bold)
        if ($f.Name -eq $name) { $font = $f; break }
    } catch {}
}
if (-not $font) {
    $font = New-Object System.Drawing.Font("Arial", 80, [System.Drawing.FontStyle]::Bold)
}

$sf = New-Object System.Drawing.StringFormat
$sf.Alignment = [System.Drawing.StringAlignment]::Center
$sf.LineAlignment = [System.Drawing.StringAlignment]::Center

$rect = New-Object System.Drawing.RectangleF(0, 0, $width, $height)
$g.DrawString([char]0x039E, $font, $brush, $rect, $sf)

$g.Dispose()
$outPath = "$PSScriptRoot\images\xi-hapax.png"
$bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()

Write-Host "Police utilisee : $($font.Name)"
Write-Host "Fichier genere : $outPath"
