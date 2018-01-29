$VOLUME = $HOME + "\src\"
$SLAVE_COUNT = 2

if (-not (Test-Path $VOLUME)) {
	mkdir $VOLUME
}
Write-Output "start hadoop-master container..."

	docker run -itd `
	--net=hadoop `
	-p 50070:50070 `
	-p 8088:8088 `
	-v "${VOLUME}:/root/src"`
	--name hadoop-master `
	--hostname hadoop-master `
	joway/hadoop-cluster > $null

for ($i = 1; $i -le $SLAVE_COUNT; $i++) {
    docker rm -f hadoop-slave$i  > $null
	Write-Output "start hadoop-slave$i container..."
	docker run -itd `
    --net=hadoop `
	--name hadoop-slave$i `
	--hostname hadoop-slave$i `
	joway/hadoop-cluster  > $null
}
Invoke-Item $VOLUME
docker exec -it hadoop-master bash
