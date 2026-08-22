Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F62230E0D5
	for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787425865; cv=none; b=dv6hLitvFnHoQT2zumWpD0DIlTgBZIesa70jGeLQWJ3Mc/5QBDxDACen6npv4QyEgFaR1Ixvl81qpO55B7XzD1TuV+pGJgu0rDnp9OgmQa1+tFw0A5ypDrZHOBMozg8TuWNj4TMkYzZ/vymw8T4TFTWBD00Buh2j3yj4OmEGLTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787425865; c=relaxed/simple;
	bh=UaSjt459zWMzbovl41+wulH+t2eVFE7zY25pavxl/1w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ni62/aAWSA0AOhvQTidzZFTkUNoglV/tVBABYhMdHkPhbPKrI4bBOr1FjQ6zobsHJLwPQzoSa0Yh4ixfHDYr7m4QTCmAH9YgHa86ajBuF3kA2cdZXzPnvE5JsaVNO6BJhm/Tu6Qy+6KxUBKFZ8mxfrhc6sJnrgi3JWcmHlnenTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4a7de733fa9so3937499b6e.3
        for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 12:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787425862; x=1788030662;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6i9kN6RYLS9h9uJ5b6k6MC7voerw/F6HyoMcnZLGYbA=;
        b=ilWBr4VqcWZTMdLm/i4mHWrhp5UFNSa5bqTF+bSdZXrdRTaZRdLYdpYBGBzbIuH/bq
         +YzJBJuH+w19i5sYUO4nxFJUooNn8ZZAdyUh7Kie+e2iiooh5vrZKZeb7Oi5O7Eim+Ty
         qFS5yB2X6Eb5G3i4qwCeBWEmWEWrD/talCPEwM/de04RlK5BN5tvwLIlILDN3O4OcGAC
         Wq8SybgDhU5ky8CjXHieOsMjBDqKPhyJ1tTdsC92Us1BFscWDlo1L4SlqYUnpyjgbnKX
         9RhVL98ysIkBht17Wx2C9Iq/WhfKSNXWqCij+lLdWK5qTCBb1/8kjNfjuNVQodEfaDfl
         Dekg==
X-Forwarded-Encrypted: i=1; AHgh+Ro0Zk6bPRosytcQEjafSa6/R5TmMaekOyVgB8Pe/b5LDzeRJpRnHg6+dNAfDDX4QPTUrVeswsDDB7c=@vger.kernel.org
X-Gm-Message-State: AFuF++nZaFcqbJyA8n96Y/SlvdUi900lmLut4s92mDTC3mmKS3RHyRLQ
	sbOT8AH+87NzCjYhAl1gppWz6fwIziaakhSNF+Fk9MfIm8ofuVvutX/iyeuxNE4VPlTKi1blm9c
	igik2ZqeLSBEKFPwRPDBFCdJNM2iJGUph+T3aiA0uFGcKXfJGLODGJPj1V1k=
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:d50:b0:4a4:ed9a:e7ac with SMTP id
 5614622812f47-4b3099d1303mr8243753b6e.1.1787425862123; Sat, 22 Aug 2026
 12:11:02 -0700 (PDT)
Date: Sat, 22 Aug 2026 12:11:02 -0700
In-Reply-To: <CALp66yFrutQ2h8SNyBZn04+LMPMnSEtWxW_Dr0vzfoHvEahSsQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a89f446.91706f20.16b6e3.02b8.GAE@google.com>
Subject: Re: [syzbot] [fs?] [usb?] KASAN: slab-use-after-free Read in
 lockref_get (2)
From: syzbot <syzbot+227dbc9afd022922d624@syzkaller.appspotmail.com>
To: andi.shyti@kernel.org, hdanton@sina.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafad900@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in start_dirop

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000028: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000140-0x0000000000000147]
CPU: 0 UID: 0 PID: 6528 Comm: syz.3.20 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
RIP: 0010:kasan_byte_accessible+0x15/0x30 mm/kasan/generic.c:210
Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03 48 01 c7 <0f> b6 07 3c 07 0f 96 c0 e9 0e 33 43 09 66 66 2e 0f 1f 84 00 00 00
RSP: 0018:ffffc90003abf4b0 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81e53a84 RDI: dffffc0000000028
RBP: 0000000000000140 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff81e53a84
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f2d04fb66c0(0000) GS:ffff888123dde000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2fa63fff CR3: 000000005762d000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __kasan_check_byte+0x13/0x50 mm/kasan/common.c:573
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire kernel/locking/lockdep.c:5842 [inline]
 lock_acquire+0x132/0x370 kernel/locking/lockdep.c:5825
 down_write_nested+0x94/0x200 kernel/locking/rwsem.c:1757
 inode_lock_nested include/linux/fs.h:1069 [inline]
 __start_dirop fs/namei.c:2918 [inline]
 start_dirop+0x4b/0xb0 fs/namei.c:2942
 simple_start_creating+0xf9/0x110 fs/libfs.c:2305
 debugfs_start_creating.part.0+0x82/0x170 fs/debugfs/inode.c:394
 debugfs_start_creating fs/debugfs/inode.c:371 [inline]
 debugfs_create_dir+0x72/0x440 fs/debugfs/inode.c:572
 i2c_device_probe+0x5f5/0xd10 drivers/i2c/i2c-core-base.c:588
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 i2c_new_client_device+0x660/0xd30 drivers/i2c/i2c-core-base.c:1019
 new_device_store+0x20f/0x420 drivers/i2c/i2c-core-base.c:1307
 dev_attr_store+0x58/0x80 drivers/base/core.c:2505
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2d0419de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2d04fb6028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f2d04425fa0 RCX: 00007f2d0419de99
RDX: 000000000000000f RSI: 0000200000000700 RDI: 0000000000000004
RBP: 00007f2d04233eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2d04426038 R14: 00007f2d04425fa0 R15: 00007fff6712ff78
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_byte_accessible+0x15/0x30 mm/kasan/generic.c:210
Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03 48 01 c7 <0f> b6 07 3c 07 0f 96 c0 e9 0e 33 43 09 66 66 2e 0f 1f 84 00 00 00
RSP: 0018:ffffc90003abf4b0 EFLAGS: 00010286

RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81e53a84 RDI: dffffc0000000028
RBP: 0000000000000140 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff81e53a84
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f2d04fb66c0(0000) GS:ffff888123ede000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f28e453f1d7 CR3: 000000005762d000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	0f 1f 00             	nopl   (%rax)
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	0f 1f 40 d6          	nopl   -0x2a(%rax)
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 c1 ef 03          	shr    $0x3,%rdi
  27:	48 01 c7             	add    %rax,%rdi
* 2a:	0f b6 07             	movzbl (%rdi),%eax <-- trapping instruction
  2d:	3c 07                	cmp    $0x7,%al
  2f:	0f 96 c0             	setbe  %al
  32:	e9 0e 33 43 09       	jmp    0x9433345
  37:	66                   	data16
  38:	66                   	data16
  39:	2e                   	cs
  3a:	0f                   	.byte 0xf
  3b:	1f                   	(bad)
  3c:	84 00                	test   %al,(%rax)


Tested on:

commit:         48a5a7ab Merge tag 'v7.2-rc4-smb3-client-fixes' of git..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17679549580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=227dbc9afd022922d624
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Note: no patches were applied.
