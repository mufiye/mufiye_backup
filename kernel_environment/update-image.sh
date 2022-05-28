# make olddefconfig -j8 && make bzImage -j8 && make modules -j8 && make modules_install INSTALL_MOD_PATH=mod -j8
# -append "quiet console=ttyS0 IP=192.168.122.2 root=/dev/vda1 rw kmemleak=on" \ # quiet: 不打印信息
kernel_version=linux-kernel

qemu-system-x86_64 \
-enable-kvm \
-smp 16 \
-m 2G \
-kernel /home/mufiye/mufiye_kernel/${kernel_version}/arch/x86/boot/bzImage \
-virtfs local,id=kmod_dev,path=/home/mufiye/mufiye_kernel/${kernel_version}/mod,readonly=on,mount_tag=9p,security_model=none \
-vga none \
-nographic \
-append "console=ttyS0 root=/dev/vda rw kmemleak=on" \
-device virtio-scsi-pci \
-drive file=bullseye.qcow2,if=none,format=qcow2,cache=writeback,file.locking=off,id=root \
-device virtio-blk,drive=root,id=d_root \
-net nic,model=virtio,macaddr=00:11:22:33:44:55 \
-net bridge,br=virbr0 \
-gdb tcp::5550 \
