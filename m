Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE722D73B9
	for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776889895; cv=none; b=rtuMuGGr3YMePVrMm42RvSBrEeQYfW72WAMlm4X2srKYZd3MMkjvFdONHN903g0CNljUk69/DpJuLhN8nMeEusxxCZdF+DEk6S/V/XNyBpCKCpOGxxmc4fnQHHOPDd2xjXUI9w9Eyj/1C0GWsuxqiHT0BHDU9q2GtJ3JP4Jb0aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776889895; c=relaxed/simple;
	bh=TMkocFJLWJm4Sroh7iQUBFb49UB/GkdQivU9pH4FNj0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h4R1o/OcgzGVfLM7/+uL2vCHPaCI3cHLloh7h4ruvB8dLOLQhCxdLAf7HIjcv0wJ+hpUyuEppCWeuh/HeH8UF6qTPTAEY6llXCe4GS9ztXfegB4tTw4SxPbCTw+pa4/HHyZsNdWA2mSCaZ2JYeVoqSFPHaeyADhUUcCGNhyGHFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7dcc59fe0d8so4320908a34.2
        for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 13:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776889892; x=1777494692;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEVE3nzbOZ9dSmZW3nzsp2ytFpj2hTepm3SE40jPxNY=;
        b=Gu43NeJ+o3qZ1WS0AFziXzc13YtajWWWRgYDuoIpGS5RjnrGnLsXr3uW60kpb9FOaW
         H9aYOrsxpVvfYfJ/8KkNUL9fmi97V+s6RaJQ10xAkLw6ThsU8dnCaatlBVFf4R6sXY5e
         +Bo+X6CMiwTVeZ6uYchTpP+rHXwMHR/HIlQXRCRO2Bwrj5PZS/JX+lSHLAGIFBiCFY70
         0NNDv/vclokWXzj3slcJwtPNUleVOQHdKcv0eMZe0q/Q8m3XZZYdM2C0VmzOHAaPSVgE
         76DInOBIU85Alq22Ogzyhm7sz9hXDt+IEQIAbKrZRzoyDmmGXUS9i44z9cLrerGnb37R
         2+Hw==
X-Gm-Message-State: AOJu0YxeWfsMt3DjdFwTOsQkTlFDdNbNvKOS9QEWd9MNN48rxsIIYhhF
	pgS5pnJTtdflHSRFqs53NXh/8U+dYumKB2N9K1zN1jIvzMIiafZv65IE6n8acgbAPcprJ8IEm6I
	zYhlQV9NUIWr2uG3BNh6RusoaoKqvZ1txlwQygWXe/DLyZPJWZCEMQ+IyK2A6cw==
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f010:b0:696:1882:dd04 with SMTP id
 006d021491bc7-6961882ddc3mr168743eaf.52.1776889892544; Wed, 22 Apr 2026
 13:31:32 -0700 (PDT)
Date: Wed, 22 Apr 2026 13:31:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e93024.a00a0220.17a17.0031.GAE@google.com>
Subject: [syzbot] [i2c?] WARNING: refcount bug in i2c_get_adapter (2)
From: syzbot <syzbot+c0291c8c9aaa473c7721@syzkaller.appspotmail.com>
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e753c16cb3dd Merge tag 'spi-fix-v7.0-rc7' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127f9106580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45cb3c58fd963c27
dashboard link: https://syzkaller.appspot.com/bug?extid=c0291c8c9aaa473c7721
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ae80002fa8a/disk-e753c16c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6ef912fb95e2/vmlinux-e753c16c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b5b121be2ebf/bzImage-e753c16c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c0291c8c9aaa473c7721@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25, CPU#0: syz.1.506/7352
Modules linked in:
CPU: 0 UID: 0 PID: 7352 Comm: syz.1.506 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
RIP: 0010:refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25
Code: eb 66 85 db 74 3e 83 fb 01 75 4c e8 bb d6 25 fd 48 8d 3d 84 01 d6 0a 67 48 0f b9 3a eb 4a e8 a8 d6 25 fd 48 8d 3d 81 01 d6 0a <67> 48 0f b9 3a eb 37 e8 95 d6 25 fd 48 8d 3d 7e 01 d6 0a 67 48 0f
RSP: 0018:ffffc9001ca9f6d8 EFLAGS: 00010283
RAX: ffffffff849eaa68 RBX: 0000000000000002 RCX: 0000000000080000
RDX: ffffc90006421000 RSI: 00000000000006c7 RDI: ffffffff8f74abf0
RBP: 0000000000000000 R08: ffff888020331e80 R09: 0000000000000005
R10: 0000000000000100 R11: 0000000000000004 R12: ffffffff8c04a688
R13: dffffc0000000000 R14: ffff88803b531188 R15: dffffc0000000000
FS:  00007f9769ca66c0(0000) GS:ffff888126332000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6df4ab1d80 CR3: 00000000348d0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:-1 [inline]
 __refcount_inc include/linux/refcount.h:366 [inline]
 refcount_inc include/linux/refcount.h:383 [inline]
 kref_get include/linux/kref.h:45 [inline]
 kobject_get+0xfa/0x120 lib/kobject.c:643
 i2c_get_adapter+0x6d/0xa0 drivers/i2c/i2c-core-base.c:2612
 i2cdev_open+0x48/0x190 drivers/i2c/i2c-dev.c:603
 chrdev_open+0x4d0/0x5f0 fs/char_dev.c:411
 do_dentry_open+0x83d/0x13e0 fs/open.c:949
 vfs_open+0x3b/0x350 fs/open.c:1081
 do_open fs/namei.c:4677 [inline]
 path_openat+0x2e43/0x38a0 fs/namei.c:4836
 do_file_open+0x23e/0x4a0 fs/namei.c:4865
 do_sys_openat2+0x113/0x200 fs/open.c:1366
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f976ba0d04e
Code: 08 0f 85 a5 a8 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
RSP: 002b:00007f9769ca5b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f9769ca66c0 RCX: 00007f976ba0d04e
RDX: 0000000000000402 RSI: 00007f9769ca5c00 RDI: ffffffffffffff9c
RBP: 00007f9769ca5c00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: cccccccccccccccd
R13: 00007f976bcc6038 R14: 00007f976bcc5fa0 R15: 00007fffc400e638
 </TASK>
----------------
Code disassembly (best guess):
   0:	eb 66                	jmp    0x68
   2:	85 db                	test   %ebx,%ebx
   4:	74 3e                	je     0x44
   6:	83 fb 01             	cmp    $0x1,%ebx
   9:	75 4c                	jne    0x57
   b:	e8 bb d6 25 fd       	call   0xfd25d6cb
  10:	48 8d 3d 84 01 d6 0a 	lea    0xad60184(%rip),%rdi        # 0xad6019b
  17:	67 48 0f b9 3a       	ud1    (%edx),%rdi
  1c:	eb 4a                	jmp    0x68
  1e:	e8 a8 d6 25 fd       	call   0xfd25d6cb
  23:	48 8d 3d 81 01 d6 0a 	lea    0xad60181(%rip),%rdi        # 0xad601ab
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	eb 37                	jmp    0x68
  31:	e8 95 d6 25 fd       	call   0xfd25d6cb
  36:	48 8d 3d 7e 01 d6 0a 	lea    0xad6017e(%rip),%rdi        # 0xad601bb
  3d:	67                   	addr32
  3e:	48                   	rex.W
  3f:	0f                   	.byte 0xf


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
