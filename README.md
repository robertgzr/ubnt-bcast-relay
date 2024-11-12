# UDP Broadcast Relay for Ubiquiti EdgeRouter-X

> [!NOTE]
> This is an adaptation of @britannic's [repo](https://github.com/britannic/ubnt-bcast-relay), the original README with how to configure the relay can be found [here](./README.original.md##configuration)

```sh
# compile udp-broadcast-relay for ER-X
make DEVICE=ER-X

# upload ubnt-bcast-relay_ER-X.tgz to your device
tar -xvzf ubnt-bcast-relay_ER-X.tgz
sudo bash ./ubnt-bcast-relay/setup.sh
```
