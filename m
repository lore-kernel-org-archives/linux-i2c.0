Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1DC38E8C9
	for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787390705; cv=none; b=GrxNQ4D0PHV7m2yQ+vzegCIGHVJBbue2EAq79KA42pzC3XELkZNgFD6Xq6qOmFPPHbXpL+5FJEl45OZD1iDZFzvImj0StkfANQB9WPYKYSrvGZY1OcmJ7smhERAazEGqZh/unm4aXqaX7/ULH7IVGr82skPVpNBbSFbC0FgNRKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787390705; c=relaxed/simple;
	bh=hfVCp/X+hF8vQmhFSgpBbu29VV9DOKRQwRoHRQeBIHE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DF6I3SkhlP2csjJfoZEQbF1jLzcOn4j08r0g3+6dJa2hQ3p9U8trKMjYVKcqIlef2fSfSDrPIci+uaMRMTouKXV+nL4NkVdJeTQBNLV1bN95akwv8KqC0mEGsne9Ja7d9ljXwBN2VJcCzrGGBY0Jj3RSVFy77TMUEGZChBxohcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7ee1e335245so2255843a34.1
        for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 02:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787390702; x=1787995502;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :in-reply-to:date:mime-version:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4z29aGdyxcXibmU6LoQc7foMs4uBavDd1VxAuNV6NA4=;
        b=TBdG2yH6weftY8sEWJSwjqjhXV5h4p4LXxA4tgel6OOaEyFpt2zM+uhGszfUDkM1AR
         GksLGyZO1mLT7+uCVsvKsfPlPxtzEl5hj+HVhkJN9ao0sh0lIPRDvPA5GsRfY9uEu1to
         DTf+dl9/gNizKviPYBEtqZtIbgTC1uBlGgHPKhGe7SjjNepIfptYSVLlF09H//9eXwrj
         ILTfmDt3ujZalKbjZy3FpbD7gvhi9CZgQ7Mlisutv3LMnn/yU6LbAnguv92JkGAT3i9F
         50DokGKCVwRK2YrOABBZ1l6mn7O/oCAKzKt6Kz2looP48xi4Pa3eo22qM8peTdgz8IPA
         aNKQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDevldVVLgrjz0VQYxYUbTI0Z8NesGSfxL6dAD0/X4KqEtxUcnu7O0wYXUMak7a5iPRnR4HCsuVcY=@vger.kernel.org
X-Gm-Message-State: AFuF++mMU7vUDnoscDK0CR4w9JATne4f+m9CB6LTL8K2cIZ3cCJWlpfM
	j8j4oRouqprx2gLa7JUgcBstz6VAsT+khW+02b11gl38HhPfmNeie82CC9kWhtY6+UFoQ3mz2OU
	3GqBM8jGlif8NXeeOYpwF7ogjgJLJcEGzcqGCvz6GQSc6TkPNG6oGLyJuQJA=
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8687:b0:6ac:98de:f087 with SMTP id
 006d021491bc7-6b16b26bb26mr3973981eaf.12.1787390702402; Sat, 22 Aug 2026
 02:25:02 -0700 (PDT)
Date: Sat, 22 Aug 2026 02:25:02 -0700
In-Reply-To: <20260822085155.1409-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a896aee.ae6ddae5.3da009.0056.GAE@google.com>
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

pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.320347][    T1] NET: Registered PF_INET protocol family
[    3.322856][    T1] IP idents hash table entries: 131072 (order: 8, 1048=
576 bytes, vmalloc)
[    3.336708][    T1] tcp_listen_portaddr_hash hash table entries: 4096 (o=
rder: 7, 294912 bytes, vmalloc)
[    3.339060][    T1] Table-perturb hash table entries: 65536 (order: 6, 2=
62144 bytes, vmalloc)
[    3.341172][    T1] TCP established hash table entries: 65536 (order: 7,=
 524288 bytes, vmalloc)
[    3.352671][    T1] TCP bind hash table entries: 65536 (order: 12, 94371=
84 bytes, vmalloc hugepage)
[    3.359566][    T1] TCP: Hash tables configured (established 65536 bind =
65536)
[    3.362810][    T1] MPTCP token hash table entries: 8192 (order: 8, 7208=
96 bytes, vmalloc)
[    3.365711][    T1] UDP hash table entries: 4096 (order: 8, 1048576 byte=
s, vmalloc)
[    3.368753][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    3.393847][    T1] RPC: Registered named UNIX socket transport module.
[    3.395099][    T1] RPC: Registered udp transport module.
[    3.395874][    T1] RPC: Registered tcp transport module.
[    3.396658][    T1] RPC: Registered tcp-with-tls transport module.
[    3.397537][    T1] RPC: Registered tcp NFSv4.1 backchannel transport mo=
dule.
[    3.413324][    T1] NET: Registered PF_XDP protocol family
[    3.414554][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 windo=
w]
[    3.415698][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0x0fff windo=
w]
[    3.416687][    T1] pci_bus 0000:00: resource 6 [io  0xc000-0xffff windo=
w]
[    3.417767][    T1] pci_bus 0000:00: resource 7 [io  0xa000-0xbfff windo=
w]
[    3.418871][    T1] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bff=
ff window]
[    3.419953][    T1] pci_bus 0000:00: resource 9 [mem 0xc0000000-0xfebfef=
ff window]
[    3.422539][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    3.423826][    T1] PCI: CLS 0 bytes, default 64
[    3.426230][    T1] PCI-DMA: Using software bounce buffering for IO (SWI=
OTLB)
[    3.427263][    T1] software IO TLB: mapped [mem 0x00000000b4400000-0x00=
000000b8400000] (64MB)
[    3.435273][    T1] ACPI: bus type thunderbolt registered
[    3.443694][    T1] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters=
, 10737418240 ms ovfl timer
[    3.447762][   T59] kworker/u8:1 (59) used greatest stack depth: 29032 b=
ytes left
[    3.450226][   T58] kworker/u8:1 (58) used greatest stack depth: 27864 b=
ytes left
[    3.469069][    T1] kvm_amd: CPU 1 isn't AMD or Hygon
[    3.469872][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycle=
s: 0x285cff649df, max_idle_ns: 440795263193 ns
[    3.471672][    T1] clocksource: Switched to clocksource tsc
[    3.481565][   T66] kworker/u8:3 (66) used greatest stack depth: 25768 b=
ytes left
[    3.500131][    T1] Initialise system trusted keyrings
[    3.502858][    T1] workingset: timestamp_bits=3D40 (anon: 35) max_order=
=3D21 bucket_order=3D0 (anon: 0)
[    3.512501][    T1] DLM installed
[    3.517800][    T1] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    3.536175][    T1] NFS: Registering the id_resolver key type
[    3.537128][    T1] Key type id_resolver registered
[    3.538012][    T1] Key type id_legacy registered
[    3.539140][    T1] nfs4filelayout_init: NFSv4 File Layout Driver Regist=
ering...
[    3.540371][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Drive=
r Registering...
[    3.547553][    T1] smbdirect: subsystem loading...
[    3.564900][    T1] smbdirect: subsystem loaded
[    3.598084][    T1] Key type cifs.spnego registered
[    3.599281][    T1] Key type cifs.idmap registered
[    3.603336][    T1] ntfs3: Enabled Linux POSIX ACLs support
[    3.604159][    T1] ntfs3: Read-only LZX/Xpress compression included
[    3.605869][    T1] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-20=
06 Red Hat, Inc.
[    3.609511][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    3.610587][    T1] QNX4 filesystem 0.2.3 registered.
[    3.611550][    T1] qnx6: QNX6 filesystem 1.0.0 registered.
[    3.613253][    T1] fuse: init (API version 7.45)
[    3.616782][    T1] orangefs_debugfs_init: called with debug mask: :none=
: :0:
[    3.619251][    T1] orangefs_init: module version upstream loaded
[    3.621005][    T1] JFS: nTxBlock =3D 8192, nTxLock =3D 65536
[    3.633589][    T1] SGI XFS with ACLs, security attributes, realtime, sc=
rub, repair, quota, no debug enabled
[    3.643027][    T1] 9p: Installing v9fs 9p2000 file system support
[    3.645565][    T1] NILFS version 2 loaded
[    3.646261][    T1] befs: version: 0.9.3
[    3.647689][    T1] ocfs2: Registered cluster interface o2cb
[    3.650626][    T1] ocfs2: Registered cluster interface user
[    3.652098][    T1] OCFS2 User DLM kernel interface loaded
[    3.674039][    T1] gfs2: GFS2 installed
[    3.688972][    T1] ceph: loaded (mds proto 32)
[    3.702507][    T1] NET: Registered PF_ALG protocol family
[    3.703631][    T1] async_tx: api initialized (async)
[    3.704425][    T1] Key type asymmetric registered
[    3.705357][    T1] Asymmetric key parser 'x509' registered
[    3.706303][    T1] Asymmetric key parser 'pkcs8' registered
[    3.707095][    T1] Key type pkcs7_test registered
[    3.708694][    T1] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 239)
[    3.711217][    T1] io scheduler mq-deadline registered
[    3.712022][    T1] io scheduler kyber registered
[    3.713500][    T1] io scheduler bfq registered
[    3.733250][    T1] input: Power Button as /devices/platform/LNXPWRBN:00=
/input/input0
[    3.737243][    T1] ACPI: button: Power Button [PWRF]
[    3.740294][    T1] input: Sleep Button as /devices/platform/LNXSLPBN:00=
/input/input1
[    3.743488][    T1] ACPI: button: Sleep Button [SLPF]
[    3.760851][    T1] ioatdma: Intel(R) QuickData Technology Driver 5.00
[    3.795590][  T122] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    3.796719][  T122] virtio-pci 0000:00:03.0: virtio_pci: leaving for leg=
acy driver
[    3.828286][  T122] ACPI: \_SB_.LNKD: Enabled at IRQ 10
[    3.829202][  T122] virtio-pci 0000:00:04.0: virtio_pci: leaving for leg=
acy driver
[    3.859623][  T122] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[    3.860539][  T122] virtio-pci 0000:00:06.0: virtio_pci: leaving for leg=
acy driver
[    4.463278][    T1] N_HDLC line discipline registered with maxframe=3D40=
96
[    4.467787][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enab=
led
[    4.476224][    T1] 00:02: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[    4.493361][    T1] 00:03: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D =
115200) is a 16550A
[    4.509251][    T1] 00:04: ttyS2 at I/O 0x3e8 (irq =3D 6, base_baud =3D =
115200) is a 16550A
[    4.526430][    T1] 00:05: ttyS3 at I/O 0x2e8 (irq =3D 7, base_baud =3D =
115200) is a 16550A
[    4.559677][    T1] Non-volatile memory driver v1.3
[    4.580110][    T1] usbcore: registered new interface driver xillyusb
[    4.585483][    T1] ACPI: bus type drm_connector registered
[    4.594378][    T1] [drm] Initialized vgem 1.0.0 for vgem on minor 0
[    4.603925][    T1] ------------[ cut here ]------------
[    4.605301][    T1] [PLANE:35:plane-0] pixel format with alpha exposed b=
ut blend mode not setup
[    4.605324][    T1] WARNING: drivers/gpu/drm/drm_mode_config.c:872 at dr=
m_mode_config_validate+0xfb4/0x1be0, CPU#1: swapper/0/1
[    4.608698][    T1] Modules linked in:
[    4.609287][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted syz=
kaller #0 PREEMPT(full)=20
[    4.610609][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 08/05/2026
[    4.612083][    T1] RIP: 0010:drm_mode_config_validate+0xfbb/0x1be0
[    4.613020][    T1] Code: 00 49 8b 57 18 48 89 f8 48 c1 e8 03 0f b6 04 2=
8 84 c0 74 08 3c 03 0f 8e 00 0b 00 00 48 8d 3d bc 2b 81 0b 41 8b b7 c8 00 0=
0 00 <67> 48 0f b9 3a e9 fa fd ff ff 48 8b 5c 24 20 e8 c1 ab 3c fc 48 8d
[    4.616410][    T1] RSP: 0000:ffffc90000067c18 EFLAGS: 00010246
[    4.617338][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000=
0000000000000
[    4.618540][    T1] RDX: ffff88801dffdb00 RSI: 0000000000000023 RDI: fff=
fffff914f9390
[    4.619686][    T1] RBP: dffffc0000000000 R08: 0000000000000001 R09: 000=
0000000000000
[    4.620824][    T1] R10: 0000000000000001 R11: 0000000000000000 R12: fff=
fed1004f76023
[    4.621960][    T1] R13: ffffed1004f76024 R14: 0000000000000001 R15: fff=
f888027bb0028
[    4.623049][    T1] FS:  0000000000000000(0000) GS:ffff888123c83000(0000=
) knlGS:0000000000000000
[    4.624304][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.625982][    T1] CR2: 0000000000000000 CR3: 000000000eb94000 CR4: 000=
00000003526f0
[    4.627366][    T1] Call Trace:
[    4.628060][    T1]  <TASK>
[    4.628536][    T1]  drm_dev_register+0x56e/0x7b0
[    4.629278][    T1]  vkms_create+0x491/0x5b0
[    4.630003][    T1]  ? __pfx_vkms_init+0x10/0x10
[    4.630947][    T1]  vkms_init+0x98/0xe0
[    4.631562][    T1]  do_one_initcall+0x11c/0x6f0
[    4.632307][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    4.633099][    T1]  ? kasan_unpoison+0x27/0x60
[    4.633765][    T1]  ? kernel_init_freeable+0x4ca/0x7b0
[    4.634537][    T1]  kernel_init_freeable+0x6ea/0x7b0
[    4.635547][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.636310][    T1]  kernel_init+0x21/0x1e0
[    4.637019][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.637931][    T1]  ret_from_fork+0x730/0xd60
[    4.638635][    T1]  ? __pfx_ret_from_fork+0x10/0x10
[    4.639447][    T1]  ? __switch_to+0x800/0x10f0
[    4.640129][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.640843][    T1]  ret_from_fork_asm+0x1a/0x30
[    4.641540][    T1]  </TASK>
[    4.641984][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    4.642965][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted syz=
kaller #0 PREEMPT(full)=20
[    4.644186][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 08/05/2026
[    4.645282][    T1] Call Trace:
[    4.645282][    T1]  <TASK>
[    4.645282][    T1]  dump_stack_lvl+0x100/0x190
[    4.645282][    T1]  vpanic+0x553/0x970
[    4.645282][    T1]  ? __pfx_vpanic+0x10/0x10
[    4.645282][    T1]  panic+0xd1/0xe0
[    4.645282][    T1]  ? __pfx_panic+0x10/0x10
[    4.645282][    T1]  check_panic_on_warn.cold+0x19/0x34
[    4.645282][    T1]  ? drm_mode_config_validate+0xfb4/0x1be0
[    4.645282][    T1]  __warn.cold+0x191/0x318
[    4.645282][    T1]  __report_bug+0x30f/0x440
[    4.645282][    T1]  ? drm_mode_config_validate+0xfb4/0x1be0
[    4.645282][    T1]  ? __pfx___report_bug+0x10/0x10
[    4.645282][    T1]  ? __lock_acquire+0x4c5/0x1ec0
[    4.654883][    T1]  report_bug_entry+0xe2/0x290
[    4.654883][    T1]  ? drm_mode_config_validate+0xfbb/0x1be0
[    4.654883][    T1]  handle_bug+0x1cd/0x2a0
[    4.654883][    T1]  exc_invalid_op+0x17/0x50
[    4.654883][    T1]  asm_exc_invalid_op+0x1a/0x20
[    4.654883][    T1] RIP: 0010:drm_mode_config_validate+0xfbb/0x1be0
[    4.654883][    T1] Code: 00 49 8b 57 18 48 89 f8 48 c1 e8 03 0f b6 04 2=
8 84 c0 74 08 3c 03 0f 8e 00 0b 00 00 48 8d 3d bc 2b 81 0b 41 8b b7 c8 00 0=
0 00 <67> 48 0f b9 3a e9 fa fd ff ff 48 8b 5c 24 20 e8 c1 ab 3c fc 48 8d
[    4.654883][    T1] RSP: 0000:ffffc90000067c18 EFLAGS: 00010246
[    4.654883][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000=
0000000000000
[    4.654883][    T1] RDX: ffff88801dffdb00 RSI: 0000000000000023 RDI: fff=
fffff914f9390
[    4.654883][    T1] RBP: dffffc0000000000 R08: 0000000000000001 R09: 000=
0000000000000
[    4.654883][    T1] R10: 0000000000000001 R11: 0000000000000000 R12: fff=
fed1004f76023
[    4.654883][    T1] R13: ffffed1004f76024 R14: 0000000000000001 R15: fff=
f888027bb0028
[    4.654883][    T1]  ? drm_mode_config_validate+0xf76/0x1be0
[    4.654883][    T1]  drm_dev_register+0x56e/0x7b0
[    4.654883][    T1]  vkms_create+0x491/0x5b0
[    4.654883][    T1]  ? __pfx_vkms_init+0x10/0x10
[    4.654883][    T1]  vkms_init+0x98/0xe0
[    4.654883][    T1]  do_one_initcall+0x11c/0x6f0
[    4.654883][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    4.654883][    T1]  ? kasan_unpoison+0x27/0x60
[    4.654883][    T1]  ? kernel_init_freeable+0x4ca/0x7b0
[    4.654883][    T1]  kernel_init_freeable+0x6ea/0x7b0
[    4.654883][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.654883][    T1]  kernel_init+0x21/0x1e0
[    4.654883][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.654883][    T1]  ret_from_fork+0x730/0xd60
[    4.654883][    T1]  ? __pfx_ret_from_fork+0x10/0x10
[    4.654883][    T1]  ? __switch_to+0x800/0x10f0
[    4.654883][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.654883][    T1]  ret_from_fork_asm+0x1a/0x30
[    4.654883][    T1]  </TASK>
[    4.654883][    T1] Kernel Offset: disabled
[    4.654883][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3894593634=3D/tmp/go-build -gno-record-gc=
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
/usr/bin/ld: /tmp/cchHMbJf.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x386): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D11570625580000


Tested on:

commit:         26260251 Merge tag 'livepatching-for-7.3' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D49d6006e566a6d9=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3D227dbc9afd022922d=
624
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D147895495800=
00

