Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020AF26FDAC
	for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 23:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787443026; cv=none; b=pvwEBiW8jCw7YjWBI9W8YQ/iafX7ICLJxriQTm5N0puS7R7qcfdJnXhmC6WMxwvwP8urHQCaUnSFNz5k7FlAtP3cp783ACe7qO0L4+K7dy3CvI9gpODssytW/PDzkKFSidBzYHzDMRgTQtb76WpjLOhvTQHhYjF9a1OhPUAAWXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787443026; c=relaxed/simple;
	bh=nuGzTpsmrcvKaTiym6Bj/mHc/vKiEIWhpwGUB46rduQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mwmVRYeD0vv3EnGcAoUM+FI3cplSHpJtjHNLNyxzBuCuawrEslyq6SyWd7cTaxpK4CmiwbfZeCZcJtu5FsSkSqC1n8hyV7Pz38u7erxZRaVpk5Mjb+2QCaa5YDigpDu8X868KS03co/7YC20s9GgyZ0tCB9Uz838j9eT3cF1Rwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b325074c26so612902b6e.2
        for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 16:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787443023; x=1788047823;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :in-reply-to:date:mime-version:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c1dyqaX2JE4LACE39h07aH97KUpyPlPmzNiv2kRsibU=;
        b=ikvdAUXk82xKR0GVuipEZJnMsUwqOHLUA+pnRzGh82qoUikQqQzR0IOV0e+VDwnvFH
         XmgWkNn1BxBoedVUFbOGkzZsNIsOKzvGBLwI1Q+8YekTqUbMaGYASoRUTXz5La9QXdOm
         WQ6EnvMYatGJzYjWh7/5/68A20Pk3dmGzWYeuwX2bybP5N5IE7m9jBMWw1Slg2oSvA3j
         JrCL/Juq0zzokeMGKnAEgcx47VqqkQvA//qAPcHY3m9wYv7gga07nlFwyUxijERIyds6
         6XgTiMFgsOa6rpCgYFXcRv6POh8njP/HABE5ueYCIh1f0sDkmzdRPGvU4U5vgj589UkN
         a3iQ==
X-Forwarded-Encrypted: i=1; AHgh+RpsSpJR08w/ypTrDd3Jxlv3wuRcvIKlbH7rjqusJ51Qt5FBRTZucUMTAb3CuOL99fkcslPbDKkNiyg=@vger.kernel.org
X-Gm-Message-State: AFuF++mWqymhEGBdDOE+Ia18JdSK7kccyn340ygQUvXvWwL/wd2ydtme
	yYjQN3bt9kuWB0ZSz2lojqwER2VuZRCGJOSZ0WGuh0B23KF3V+9QHmXgWkv3i59rFGOJyCUoLZd
	ys5v5376UucHMRZugXwDSlHcDQPgVcLb5CXtBNmncx1+7DrA3M5/BmQEGkW4=
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3096:b0:4a4:da68:9434 with SMTP id
 5614622812f47-4b309b5ba40mr10187626b6e.14.1787443022980; Sat, 22 Aug 2026
 16:57:02 -0700 (PDT)
Date: Sat, 22 Aug 2026 16:57:02 -0700
In-Reply-To: <CALp66yHXAF8M2YmFi_czHWOU_EgsEEog__Ga13m_=TZmL0ctsA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8a374e.91706f20.16b6e3.02be.GAE@google.com>
Subject: Re: [syzbot] [fs?] [usb?] KASAN: slab-use-after-free Read in
 lockref_get (2)
From: syzbot <syzbot+227dbc9afd022922d624@syzkaller.appspotmail.com>
To: andi.shyti@kernel.org, hdanton@sina.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafad900@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

m: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.244305][    T1] NET: Registered PF_INET protocol family
[    3.247499][    T1] IP idents hash table entries: 131072 (order: 8, 1048=
576 bytes, vmalloc)
[    3.259218][    T1] tcp_listen_portaddr_hash hash table entries: 4096 (o=
rder: 7, 294912 bytes, vmalloc)
[    3.261261][    T1] Table-perturb hash table entries: 65536 (order: 6, 2=
62144 bytes, vmalloc)
[    3.263274][    T1] TCP established hash table entries: 65536 (order: 7,=
 524288 bytes, vmalloc)
[    3.274524][    T1] TCP bind hash table entries: 65536 (order: 12, 94371=
84 bytes, vmalloc hugepage)
[    3.281391][    T1] TCP: Hash tables configured (established 65536 bind =
65536)
[    3.284940][    T1] MPTCP token hash table entries: 8192 (order: 8, 7208=
96 bytes, vmalloc)
[    3.288577][    T1] UDP hash table entries: 4096 (order: 8, 1048576 byte=
s, vmalloc)
[    3.291550][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    3.306684][    T1] RPC: Registered named UNIX socket transport module.
[    3.307718][    T1] RPC: Registered udp transport module.
[    3.308513][    T1] RPC: Registered tcp transport module.
[    3.309357][    T1] RPC: Registered tcp-with-tls transport module.
[    3.310392][    T1] RPC: Registered tcp NFSv4.1 backchannel transport mo=
dule.
[    3.316342][    T1] NET: Registered PF_XDP protocol family
[    3.317480][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 windo=
w]
[    3.318551][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0x0fff windo=
w]
[    3.319885][    T1] pci_bus 0000:00: resource 6 [io  0xc000-0xffff windo=
w]
[    3.321388][    T1] pci_bus 0000:00: resource 7 [io  0xa000-0xbfff windo=
w]
[    3.322459][    T1] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bff=
ff window]
[    3.323839][    T1] pci_bus 0000:00: resource 9 [mem 0xc0000000-0xfebfef=
ff window]
[    3.326592][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    3.328327][    T1] PCI: CLS 0 bytes, default 64
[    3.329389][    T1] PCI-DMA: Using software bounce buffering for IO (SWI=
OTLB)
[    3.330474][    T1] software IO TLB: mapped [mem 0x00000000b4400000-0x00=
000000b8400000] (64MB)
[    3.333143][    T1] ACPI: bus type thunderbolt registered
[    3.341226][    T1] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters=
, 10737418240 ms ovfl timer
[    3.346936][   T59] kworker/u8:1 (59) used greatest stack depth: 27864 b=
ytes left
[    3.364118][    T1] kvm_amd: CPU 1 isn't AMD or Hygon
[    3.365204][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycle=
s: 0x285d48fab19, max_idle_ns: 440795208084 ns
[    3.367725][    T1] clocksource: Switched to clocksource tsc
[    3.403452][    T1] Initialise system trusted keyrings
[    3.404162][   T84] kworker/u8:4 (84) used greatest stack depth: 27160 b=
ytes left
[    3.407742][    T1] workingset: timestamp_bits=3D40 (anon: 35) max_order=
=3D21 bucket_order=3D0 (anon: 0)
[    3.415933][    T1] DLM installed
[    3.421490][    T1] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    3.429626][    T1] NFS: Registering the id_resolver key type
[    3.430824][    T1] Key type id_resolver registered
[    3.431584][    T1] Key type id_legacy registered
[    3.432928][    T1] nfs4filelayout_init: NFSv4 File Layout Driver Regist=
ering...
[    3.434314][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Drive=
r Registering...
[    3.441599][    T1] smbdirect: subsystem loading...
[    3.448154][    T1] smbdirect: subsystem loaded
[    3.471719][    T1] Key type cifs.spnego registered
[    3.472760][    T1] Key type cifs.idmap registered
[    3.476921][    T1] ntfs3: Enabled Linux POSIX ACLs support
[    3.477738][    T1] ntfs3: Read-only LZX/Xpress compression included
[    3.478987][    T1] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-20=
06 Red Hat, Inc.
[    3.482637][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    3.483593][    T1] QNX4 filesystem 0.2.3 registered.
[    3.484738][    T1] qnx6: QNX6 filesystem 1.0.0 registered.
[    3.486442][    T1] fuse: init (API version 7.45)
[    3.489877][    T1] orangefs_debugfs_init: called with debug mask: :none=
: :0:
[    3.492401][    T1] orangefs_init: module version upstream loaded
[    3.494199][    T1] JFS: nTxBlock =3D 8192, nTxLock =3D 65536
[    3.507409][    T1] SGI XFS with ACLs, security attributes, realtime, sc=
rub, repair, quota, no debug enabled
[    3.514958][    T1] 9p: Installing v9fs 9p2000 file system support
[    3.516652][    T1] NILFS version 2 loaded
[    3.517609][    T1] befs: version: 0.9.3
[    3.519354][    T1] ocfs2: Registered cluster interface o2cb
[    3.521201][    T1] ocfs2: Registered cluster interface user
[    3.523024][    T1] OCFS2 User DLM kernel interface loaded
[    3.545147][    T1] gfs2: GFS2 installed
[    3.560183][    T1] ceph: loaded (mds proto 32)
[    3.573563][    T1] NET: Registered PF_ALG protocol family
[    3.574709][    T1] async_tx: api initialized (async)
[    3.575970][    T1] Key type asymmetric registered
[    3.576921][    T1] Asymmetric key parser 'x509' registered
[    3.577745][    T1] Asymmetric key parser 'pkcs8' registered
[    3.578604][    T1] Key type pkcs7_test registered
[    3.579842][    T1] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 239)
[    3.583698][    T1] io scheduler mq-deadline registered
[    3.584626][    T1] io scheduler kyber registered
[    3.586119][    T1] io scheduler bfq registered
[    3.601298][    T1] input: Power Button as /devices/platform/LNXPWRBN:00=
/input/input0
[    3.605629][    T1] ACPI: button: Power Button [PWRF]
[    3.609215][    T1] input: Sleep Button as /devices/platform/LNXSLPBN:00=
/input/input1
[    3.611991][    T1] ACPI: button: Sleep Button [SLPF]
[    3.635978][    T1] ioatdma: Intel(R) QuickData Technology Driver 5.00
[    3.662181][   T10] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    3.663176][   T10] virtio-pci 0000:00:03.0: virtio_pci: leaving for leg=
acy driver
[    3.694911][   T10] ACPI: \_SB_.LNKD: Enabled at IRQ 10
[    3.696705][   T10] virtio-pci 0000:00:04.0: virtio_pci: leaving for leg=
acy driver
[    3.724400][   T10] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[    3.725672][   T10] virtio-pci 0000:00:06.0: virtio_pci: leaving for leg=
acy driver
[    4.062323][  T524] kworker/u8:7 (524) used greatest stack depth: 26904 =
bytes left
[    4.258630][    T1] N_HDLC line discipline registered with maxframe=3D40=
96
[    4.261364][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enab=
led
[    4.275999][    T1] 00:02: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[    4.291450][    T1] 00:03: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D =
115200) is a 16550A
[    4.306966][    T1] 00:04: ttyS2 at I/O 0x3e8 (irq =3D 6, base_baud =3D =
115200) is a 16550A
[    4.321856][    T1] 00:05: ttyS3 at I/O 0x2e8 (irq =3D 7, base_baud =3D =
115200) is a 16550A
[    4.357497][    T1] Non-volatile memory driver v1.3
[    4.382848][    T1] usbcore: registered new interface driver xillyusb
[    4.391825][    T1] ACPI: bus type drm_connector registered
[    4.402882][    T1] [drm] Initialized vgem 1.0.0 for vgem on minor 0
[    4.408272][    T1] ------------[ cut here ]------------
[    4.409057][    T1] [PLANE:35:plane-0] pixel format with alpha exposed b=
ut blend mode not setup
[    4.409076][    T1] WARNING: drivers/gpu/drm/drm_mode_config.c:872 at dr=
m_mode_config_validate+0xfb4/0x1be0, CPU#0: swapper/0/1
[    4.412353][    T1] Modules linked in:
[    4.412951][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted syz=
kaller #0 PREEMPT(full)=20
[    4.414327][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 08/05/2026
[    4.415957][    T1] RIP: 0010:drm_mode_config_validate+0xfbb/0x1be0
[    4.416871][    T1] Code: 00 49 8b 57 18 48 89 f8 48 c1 e8 03 0f b6 04 2=
8 84 c0 74 08 3c 03 0f 8e 00 0b 00 00 48 8d 3d fc 1e 81 0b 41 8b b7 c8 00 0=
0 00 <67> 48 0f b9 3a e9 fa fd ff ff 48 8b 5c 24 20 e8 41 9b 3c fc 48 8d
[    4.420277][    T1] RSP: 0000:ffffc90000067c18 EFLAGS: 00010246
[    4.421416][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000=
0000000000000
[    4.422525][    T1] RDX: ffff8880270d17e0 RSI: 0000000000000023 RDI: fff=
fffff914f9750
[    4.423790][    T1] RBP: dffffc0000000000 R08: 0000000000000001 R09: 000=
0000000000000
[    4.424912][    T1] R10: 0000000000000001 R11: 0000000000000000 R12: fff=
fed1004db7023
[    4.426628][    T1] R13: ffffed1004db7024 R14: 0000000000000001 R15: fff=
f888026db8028
[    4.427965][    T1] FS:  0000000000000000(0000) GS:ffff888123b83000(0000=
) knlGS:0000000000000000
[    4.429922][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.431232][    T1] CR2: ffff88823ffff000 CR3: 000000000eb94000 CR4: 000=
00000003526f0
[    4.432829][    T1] Call Trace:
[    4.433578][    T1]  <TASK>
[    4.434377][    T1]  drm_dev_register+0x56e/0x7b0
[    4.435116][    T1]  vkms_create+0x491/0x5b0
[    4.436303][    T1]  ? __pfx_vkms_init+0x10/0x10
[    4.437097][    T1]  vkms_init+0x98/0xe0
[    4.437725][    T1]  do_one_initcall+0x11c/0x6f0
[    4.438689][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    4.439912][    T1]  ? kasan_unpoison+0x15/0x60
[    4.440799][    T1]  ? kernel_init_freeable+0x4ca/0x7b0
[    4.441810][    T1]  kernel_init_freeable+0x6ea/0x7b0
[    4.442739][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.443755][    T1]  kernel_init+0x21/0x1e0
[    4.444481][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.445296][    T1]  ret_from_fork+0x730/0xd60
[    4.446009][    T1]  ? __pfx_ret_from_fork+0x10/0x10
[    4.446941][    T1]  ? __switch_to+0x800/0x10f0
[    4.448149][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.448847][    T1]  ret_from_fork_asm+0x1a/0x30
[    4.449585][    T1]  </TASK>
[    4.450241][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    4.451670][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted syz=
kaller #0 PREEMPT(full)=20
[    4.453007][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 08/05/2026
[    4.454566][    T1] Call Trace:
[    4.455144][    T1]  <TASK>
[    4.455713][    T1]  dump_stack_lvl+0x100/0x190
[    4.455982][    T1]  vpanic+0x553/0x970
[    4.455982][    T1]  ? __pfx_vpanic+0x10/0x10
[    4.455982][    T1]  panic+0xd1/0xe0
[    4.455982][    T1]  ? __pfx_panic+0x10/0x10
[    4.455982][    T1]  check_panic_on_warn.cold+0x19/0x34
[    4.455982][    T1]  ? drm_mode_config_validate+0xfb4/0x1be0
[    4.455982][    T1]  __warn.cold+0x191/0x318
[    4.455982][    T1]  __report_bug+0x30f/0x440
[    4.455982][    T1]  ? drm_mode_config_validate+0xfb4/0x1be0
[    4.455982][    T1]  ? __pfx___report_bug+0x10/0x10
[    4.455982][    T1]  ? __lock_acquire+0x4c5/0x1ec0
[    4.455982][    T1]  report_bug_entry+0xe2/0x290
[    4.455982][    T1]  ? drm_mode_config_validate+0xfbb/0x1be0
[    4.455982][    T1]  handle_bug+0x1cd/0x2a0
[    4.455982][    T1]  exc_invalid_op+0x17/0x50
[    4.455982][    T1]  asm_exc_invalid_op+0x1a/0x20
[    4.455982][    T1] RIP: 0010:drm_mode_config_validate+0xfbb/0x1be0
[    4.455982][    T1] Code: 00 49 8b 57 18 48 89 f8 48 c1 e8 03 0f b6 04 2=
8 84 c0 74 08 3c 03 0f 8e 00 0b 00 00 48 8d 3d fc 1e 81 0b 41 8b b7 c8 00 0=
0 00 <67> 48 0f b9 3a e9 fa fd ff ff 48 8b 5c 24 20 e8 41 9b 3c fc 48 8d
[    4.455982][    T1] RSP: 0000:ffffc90000067c18 EFLAGS: 00010246
[    4.455982][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000=
0000000000000
[    4.455982][    T1] RDX: ffff8880270d17e0 RSI: 0000000000000023 RDI: fff=
fffff914f9750
[    4.455982][    T1] RBP: dffffc0000000000 R08: 0000000000000001 R09: 000=
0000000000000
[    4.455982][    T1] R10: 0000000000000001 R11: 0000000000000000 R12: fff=
fed1004db7023
[    4.455982][    T1] R13: ffffed1004db7024 R14: 0000000000000001 R15: fff=
f888026db8028
[    4.455982][    T1]  ? drm_mode_config_validate+0xf76/0x1be0
[    4.455982][    T1]  drm_dev_register+0x56e/0x7b0
[    4.455982][    T1]  vkms_create+0x491/0x5b0
[    4.455982][    T1]  ? __pfx_vkms_init+0x10/0x10
[    4.455982][    T1]  vkms_init+0x98/0xe0
[    4.455982][    T1]  do_one_initcall+0x11c/0x6f0
[    4.455982][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    4.455982][    T1]  ? kasan_unpoison+0x15/0x60
[    4.455982][    T1]  ? kernel_init_freeable+0x4ca/0x7b0
[    4.455982][    T1]  kernel_init_freeable+0x6ea/0x7b0
[    4.455982][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.455982][    T1]  kernel_init+0x21/0x1e0
[    4.455982][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.455982][    T1]  ret_from_fork+0x730/0xd60
[    4.455982][    T1]  ? __pfx_ret_from_fork+0x10/0x10
[    4.455982][    T1]  ? __switch_to+0x800/0x10f0
[    4.455982][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.455982][    T1]  ret_from_fork_asm+0x1a/0x30
[    4.455982][    T1]  </TASK>
[    4.455982][    T1] Kernel Offset: disabled
[    4.455982][    T1] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
AR=3D'ar'
CC=3D'gcc'
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_ENABLED=3D'1'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
CXX=3D'g++'
GCCGO=3D'gccgo'
GO111MODULE=3D'auto'
GOAMD64=3D'v1'
GOARCH=3D'amd64'
GOAUTH=3D'netrc'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOCACHEPROG=3D''
GODEBUG=3D''
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFIPS140=3D'off'
GOFLAGS=3D''
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build1331161525=3D/tmp/go-build -gno-record-gc=
c-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.26.0'
GOWORK=3D''
PKG_CONFIG=3D'pkg-config'

git status (err=3D<nil>)
HEAD detached at 05b26a281c0
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3D05b26a281c072cc34dcad83a283fd2aeeff18ad1 -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20260724-140511"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3D05b26a281c072cc34dcad83a283fd2aeeff18ad1 -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20260724-140511"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D05b26a281c072cc34dcad83a283fd2aeeff18ad1 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20260724-140511"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"05b26a281c072cc34dcad83a283fd2aeef=
f18ad1\"
/usr/bin/ld: /tmp/ccXjEkJ3.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x386): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D11d04625580000


Tested on:

commit:         66fb95a5 Merge tag 'caps-pr-20260820' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D49d6006e566a6d9=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3D227dbc9afd022922d=
624
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.44

Note: no patches were applied.
