function Reset-Names {
    param (
        [string] $Path
        )

    if (-not $Path) {
        $Path = $pwd
        Write-Verbose "No path provided. Using current path: $Path"
    }

    $ResolvedPath = Resolve-Path -Path $Path
    $files = Get-ChildItem -Path $ResolvedPath | sort creationtime

    $i = 1
    foreach ($file in $files) {
        $newName = -join($i, $file.Extension)
        $newPath = Join-Path $ResolvedPath $newName
        Rename-Item -Path $file.FullName -NewName $newPath
        Write-Verbose -Message "Renamed $($file.Name) to $($newName)"
        $i = $i + 1
    }
}


<#
.SYNOPSIS
   Renames all files in a directory with a sequential index.

.DESCRIPTION
   The Reset-Names function renames all files in the specified directory using a sequential index 
   and maintains the original file extension. Files are numbered based on creation time, 
   with the oldest files having the smalest numbers

.PARAMETER Path
   Specifies the path of the directory containing the files to be renamed. If not provided, the 
   function uses the current location.

.EXAMPLE
   Reset-Names -Path "C:\Path\To\Your\Directory"
   Renames all files in the specified directory with a sequential index.

.EXAMPLE
   Reset-Names
   Renames all files in the current directory with a sequential index.

.NOTES
   File names will be replaced with a combination of a sequential index and the original file 
   extension (e.g., 1.jpg, 2.txt).
#>


