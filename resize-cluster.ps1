$CLUSTER_COUNT = $args[0]
Write-Output $CLUSTER_COUNT
if ($args.Count -eq 0) {
    Write-Output  "Please specify the node number of hadoop cluster!"
    exit 1
}
Remove-Item .\config\slaves
New-Item .\config\slaves
for ($i = 1; $i -le $CLUSTER_COUNT; $i++) {
    "hadoop-slave$i" | Out-File -FilePath .\config\slaves -Append
}
Write-Output  "build docker hadoop image"
# rebuild kiwenlau/hadoop image
docker build -t joway/hadoop-cluster:latest .
