$disks = Get-Disk | Where partitionstyle -eq 'raw' | sort number

    $count = 1
    $label = $args[0]

if($disks.Count -eq 1)
{
          $disk | 
          Initialize-Disk -PartitionStyle MBR -PassThru |
          New-Partition -UseMaximumSize -AssignDriveLetter |
          Format-Volume -FileSystem NTFS -NewFileSystemLabel "$label" -Confirm:$false -Force
          $count++

}
else
{
          foreach ($disk in $disks) 
          {
                $disk | 
                Initialize-Disk -PartitionStyle MBR -PassThru |
                New-Partition -UseMaximumSize -AssignDriveLetter |
                Format-Volume -FileSystem NTFS -NewFileSystemLabel "$label$count" -Confirm:$false -Force
                $count++
          }

}
