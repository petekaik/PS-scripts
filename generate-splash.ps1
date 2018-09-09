param ([string] $origImg = 'srcimg.png')

# Hello!
if(Test-Path $origImg){
     echo "Generating iOS Splash Screen Images from $origImg"
}else{
     Write-Host 'You must specify a source file name (generate-splash imagefile.png) or save an "srcimg.png" in script folder'
     exit
}

# Array for parallel processing commands
$cmds = @()

####################################
# Generate image processing commands
####################################

# iPhone 6, 6s, 7, 8
$widht = 750
$height = 1334
# Portrait
$cmds += 'magick ' + $origImg + ' -resize ' + $height + ' -shave ' + ($height-$widht)/2 + 'x0 iPhone_' + $widht + 'x' + $height + '@2x.png'
# Landscape
$cmds += 'magick ' + $origImg + ' -resize ' + $height + ' -shave 0x' + ($height-$widht)/2 + ' iPhone_' + $height + 'x' + $widht + '@2x.png'

# iPhone 6+, 6s+, 7+, 8+
$widht = 1242
$height = 2208
# Portrait
$cmds += 'magick ' + $origImg + ' -resize ' + $height + ' -shave ' + ($height-$widht)/2 + 'x0 iPhonePlus_' + $widht + 'x' + $height + '@3x.png'
# Landscape
$cmds += 'magick ' + $origImg + ' -resize ' + $height + ' -shave 0x' + ($height-$widht)/2 + ' iPhonePlus_' + $height + 'x' + $widht + '@3x.png'

# iPhone X
$widht = 1125
$height = 2436
# Portrait
$cmds += 'magick ' + $origImg + ' -resize ' + $height + ' -shave ' + ($height-$widht)/2 + 'x0 iPhoneX_' + $widht + 'x' + $height + '@3x.png'
# Landscape
$cmds += 'magick ' + $origImg + ' -resize ' + $height + ' -shave 0x' + ($height-$widht)/2 + ' iPhoneX_' + $height + 'x' + $widht + '@3x.png'

# iPad Mini & Air
$widht = 1536
$height = 2048
# Portrait
$cmds += 'magick ' + $origImg + ' -resize ' + $height + ' -shave ' + ($height-$widht)/2 + 'x0 iPadAir_' + $widht + 'x' + $height + '@2x.png'
# Landscape
$cmds += 'magick ' + $origImg + ' -resize ' + $height + ' -shave 0x' + ($height-$widht)/2 + ' iPadAir_' + $height + 'x' + $widht + '@2x.png'

# iPad Pro 10,5"
$widht = 1668
$height = 2224
# Portrait
$cmds += 'magick ' + $origImg + ' -resize ' + $height + ' -shave ' + ($height-$widht)/2 + 'x0 iPadPro10_' + $widht + 'x' + $height + '@2x.png'
# Landscape
$cmds += 'magick ' + $origImg + ' -resize ' + $height + ' -shave 0x' + ($height-$widht)/2 + ' iPadPro10_' + $height + 'x' + $widht + '@2x.png'

# iPad Pro 12,9"
$widht = 2048
$height = 2732
# Portrait
$cmds += 'magick ' + $origImg + ' -resize ' + $height + ' -shave ' + ($height-$widht)/2 + 'x0 iPadPro12_' + $widht + 'x' + $height + '@2x.png'
# Landscape
$cmds += 'magick ' + $origImg + ' -resize ' + $height + ' -shave 0x' + ($height-$widht)/2 + ' iPadPro12_' + $height + 'x' + $widht + '@2x.png'

########################
# Do parallel processing
########################

workflow generate {
    param ([string[]]$cmds)

    ForEach -Parallel ($cmd in $cmds) {
        echo $cmd
        invoke-expression $cmd
    }
}

generate -cmds $cmds

# Bye!
echo "Done!"
sleep 5