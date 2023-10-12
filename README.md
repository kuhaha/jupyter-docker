

# DockerのBuild Cacheの削除
1. 容量確認  
```$ docker system df```
2. キャッシュ削除  
```$ docker builder prune```

# イメージの削除
1. 現在使用されていないイメージの削除  
```$ docker image prune```
2. すべてのイメージを抹消  
```$ docker image prune -a```

# コンテナの削除
1. 現在使用されていないコンテナの削除  
```$ docker container prune -f```
2. すべてのコンテナを抹消  
```$ docker image prune -a```

# ボリュームの削除
1. ボリュームの確認  
```$ docker volume ls```
2. ボリュームを個別に削除  
```$ docker volume rm volume_name```
3. 使用していないものすべて  
```$ docker volume prune -f```

# 全て削除
```$ docker volume rm $(docker volume ls -qf dangling=true)```

# ネットワークの削除
```$ docker network prune -f```

# 全てを一括削除
これまでの奴らを一気に削除するコマンドになります。

1. イメージ、コンテナ、ネットワーク   
```$ docker system prune```
2. volumeも含める場合  
```$ docker system prune --volumes```

# docker起動後にjupyter のtoken 確認
1. ログを見て token 取得する。  
```$ docker logs <jupyter container>```
2. docker コンテナに入って token 確認  
   ```$ docker ps -a```
   
   ```$ docker exec -it <jupyter container> /bin/bash```  
   
   ```$ jupyter notebook list```
    Currently running servers:
    http://0.0.0.0:8888/?token=yyyy :: /home/jovyan
    jovyan@e22198a8202b:~$ exit

