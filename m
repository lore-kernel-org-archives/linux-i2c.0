From: Johnny Bieren <jbieren@redhat.com>
Subject: amd756 driver error introduced with kernel-4.9.0-0.rc1.git0.2.fc26
Date: Tue, 8 Nov 2016 07:50:34 -0500
Message-ID: <5821CA1A.5020608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752883AbcKHMvu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 8 Nov 2016 07:51:50 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jdelvare@suse.com
Cc: linux-i2c@vger.kernel.org

Hello,
It appears that a driver_probe_device failure was introduced with 
kernel-4.9.0-0.rc1.git0.2.fc26.  When booting this kernel, or any newer 
kernel, I see the following:

[   15.675485] ------------[ cut here ]------------
[   15.680129] WARNING: CPU: 4 PID: 528 at drivers/base/dd.c:343 
driver_probe_device+0x353/0x430
[   15.688678] Modules linked in: i2c_amd756(+) pcc_cpufreq(-) k8temp 
fjes amd_rng acpi_cpufreq tpm_tis tpm_tis_core tpm nfsd auth_rpcgss 
nfs_acl lockd grace sunrpc xfs libcrc32c hpsa scsi_transport_sas 
ata_generic pata_acpi serio_raw cciss pata_amd
[   15.688681] CPU: 4 PID: 528 Comm: systemd-udevd Not tainted 
4.9.0-0.rc1.git0.2.fc26.x86_64 #1
[   15.688690] Hardware name: HP ProLiant DL385 G1, BIOS A05 03/01/2006
[   15.688693]  ffffb5ddc062bb00 ffffffff953e93fd 0000000000000000 
0000000000000000
[   15.688695]  ffffb5ddc062bb40 ffffffff950a181b 00000157bd43a0a0 
ffff8f70bd43a0a0
[   15.688697]  ffffffffc0440468 ffffffffc0440468 000000000000000b 
0000000000000001
[   15.688698] Call Trace:
[   15.688703]  [<ffffffff953e93fd>] dump_stack+0x63/0x86
[   15.688706]  [<ffffffff950a181b>] __warn+0xcb/0xf0
[   15.688708]  [<ffffffff950a194d>] warn_slowpath_null+0x1d/0x20
[   15.688709]  [<ffffffff955409a3>] driver_probe_device+0x353/0x430
[   15.688711]  [<ffffffff95540b5f>] __driver_attach+0xdf/0xf0
[   15.688713]  [<ffffffff95540a80>] ? driver_probe_device+0x430/0x430
[   15.688715]  [<ffffffff9553e25c>] bus_for_each_dev+0x6c/0xc0
[   15.688717]  [<ffffffff9553ffbe>] driver_attach+0x1e/0x20
[   15.688718]  [<ffffffff9553f9f0>] bus_add_driver+0x170/0x270
[   15.688720]  [<ffffffffc0407000>] ? 0xffffffffc0407000
[   15.688722]  [<ffffffff95541480>] driver_register+0x60/0xe0
[   15.688723]  [<ffffffffc0407000>] ? 0xffffffffc0407000
[   15.688725]  [<ffffffff9543e7dc>] __pci_register_driver+0x4c/0x50
[   15.688728]  [<ffffffffc040701e>] amd756_driver_init+0x1e/0x1000 
[i2c_amd756]
[   15.688731]  [<ffffffff95002190>] do_one_initcall+0x50/0x180
[   15.688734]  [<ffffffff9520ab81>] ? __vunmap+0x81/0xd0
[   15.688737]  [<ffffffff9522ad29>] ? kmem_cache_alloc_trace+0x99/0x1b0
[   15.688739]  [<ffffffff951bb9aa>] ? do_init_module+0x27/0x1ef
[   15.688741]  [<ffffffff951bb9e2>] do_init_module+0x5f/0x1ef
[   15.688744]  [<ffffffff9512f581>] load_module+0x25b1/0x2980
[   15.688746]  [<ffffffff9512be60>] ? __symbol_put+0x60/0x60
[   15.688749]  [<ffffffff9512fac3>] SYSC_init_module+0x173/0x190
[   15.688751]  [<ffffffff9512fbfe>] SyS_init_module+0xe/0x10
[   15.688753]  [<ffffffff95003c17>] do_syscall_64+0x67/0x180
[   15.688757]  [<ffffffff958112ab>] entry_SYSCALL64_slow_path+0x25/0x25
[   15.688758] ---[ end trace 9920abb49d6753e2 ]---

The problem does not appear in kernel-4.9.0-0.rc0.git9.1.fc26, but it 
does appear in kernel-4.9.0-0.rc1.git0.2.fc26.  It reproduces 100% of 
the time for me.  Can you please look into this issue?

Thanks,
Johnny Bieren
