MASTER1=
WORKER1=
WORKER2=
WORKER3=


JOIN_CMD=$(ssh root@${MASTER1} "kubeadm token create --print-join-command")
ssh root@${WORKER1} "sudo $JOIN_CMD"
ssh root@${WORKER2} "sudo $JOIN_CMD"
ssh root@${WORKER3} "sudo $JOIN_CMD"
