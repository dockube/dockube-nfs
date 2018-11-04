## **HOST (172.212.0.11)**
------
### Installation Libraries
```
sudo apt-get update
sudo apt-get -y install nfs-kernel-server
```

### Create NFS Folder
```
sudo mkdir -p /data
```

### Mounting
```
nano /etc/fstab
-----
LABEL=cloudimg-rootfs                         /                 ext4   defaults   0 0
LABEL=UEFI                                    /boot/efi         vfat   defaults   0 0
UUID="ce8b1e59-b692-482a-9df8-09032090c529"   /data             ext4   defaults   0 0
```

### Check Folder Owner
ls -la /data
```
drwxr-xr-x 2 nobody nogroup 4096 Oct 20 10:11 .
drwxr-xr-x 3 root   root    4096 Oct 20 10:02 ..
```

### Change Owner
```
sudo chown nobody:nogroup /data -R
-----
drwxr-xr-x 2 nobody nogroup 4096 Oct 20 10:11 .
drwxr-xr-x 3 nobody nogroup 4096 Oct 20 10:02 ..
```

### Export NFS (Mounting Point)
```
sudo nano /etc/exports
-----
/data 172.212.0.0/255.255.0.0(rw,sync,no_subtree_check,no_root_squash)
```

### Restart Services
```
sudo systemctl restart nfs-kernel-server
```

### Setup Firewall
* Enable Firewall & Allow Whitelist IP's
  ```
  sudo ufw enable
  sudo ufw allow "OpenSSH"
  ------
  sudo ufw allow from 172.212.0.6 to any port nfs     # master-1
  sudo ufw allow from 172.212.0.7 to any port nfs     # master-2
  sudo ufw allow from 172.212.0.8 to any port nfs     # node-1
  sudo ufw allow from 172.212.0.9 to any port nfs     # node-2
  sudo ufw allow from 172.212.0.10 to any port nfs    # node-3
  ```

* Check Status
  ```
  sudo ufw status
  ------
  Status: active

  To                         Action      From
  --                         ------      ----
  OpenSSH                    ALLOW       Anywhere
  OpenSSH (v6)               ALLOW       Anywhere (v6)
  2049                       ALLOW       172.212.0.6
  2049                       ALLOW       172.212.0.7
  2049                       ALLOW       172.212.0.8
  2049                       ALLOW       172.212.0.9
  2049                       ALLOW       172.212.0.10
  ```

## **NODE (172.212.0.6/7/8/9/10)**
------
### Installation Libraries
```
sudo apt-get update
sudo apt-get -y install nfs-common
```

### Setup Firewall
* Enable Firewall & Allow Whitelist IP's
  ```
  sudo ufw enable
  sudo ufw allow "OpenSSH"
  ```

### Setup NFS
* Create Folder
  ```
  mkdir -p /data-node
  ```

* Check Mounting Point NFS
  ```
  sudo mount 172.212.0.11:/data /data-node
  ```

### Mounting Point NFS
* Configuration FSTAB
  ```
  sudo nano /etc/fstab
  ------
  172.212.0.11:/data   /data-node   nfs   auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0
  ```
* Remounting All
  ```
  mount -a
  ```

## **NOTES !!!**
-----
**DISABLE** Firewall if you want to deploy kubernetes cluster (via Kubespray)
```
sudo ufw disable
```

Re-enable after finish deploy
```
sudo ufw enable
```