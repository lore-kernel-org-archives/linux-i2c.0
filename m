Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99A826FA60
	for <linux-i2c@vger.kernel.org>; Mon, 30 Mar 2026 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774844795; cv=none; b=NJd40I6LqD3QoO1WG6D9kKdx79kvmrshJtH8MUQ8D3LosVkuDpNmnHLApg4kttJiTRIoBK2oYjcj2b/yohx0vi2DaHuZ0L4wRYdX0/GygmKIUxafBWbK2PjUi51j20znheFLNwvIITctifZPoZY+F1vmtzM9CeC+3Tv6Y34h+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774844795; c=relaxed/simple;
	bh=Q0lXIsGDXKvyVl1kKXYekFT1SW45OJBuDcA3uYRJOSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OM14sDmdsgeO3f5sfK+rd/EuioJBMYYZQRoLoPFUVoF/nWb2PmX/EPPCZiedSaaTbljH5/qecpa1Ifn07Zvvlpl8jKByTCRklWM6qKjd78OS6wo/70yogMJy+LfjqmD4IEkvYifIE1AM1jrAsTq/XPKhaGHbg6GztRp4j6EOgqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjmrFreO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjmrFreO"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35c206f0481so3689957a91.0
        for <linux-i2c@vger.kernel.org>; Sun, 29 Mar 2026 21:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774844793; x=1775449593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MEFziDjY8EELmDWMIHiwj21wEphahbqJkx5694Z88mI=;
        b=mjmrFreOzs/KKtXvpmv3SFAgzAueXOMYVtCbdwv1qCbBIvy0MP+kQvS5WZ7K3JzxMK
         6geErfuHk15M3KNVgf6qs8PfiPgezOBa+l2cq6p5h/08A7n6fsKcIEGkfy5PkZAj6qOZ
         fuZxhHgML35oYkYd8GTsvuw+bLS2c9r4/TCW0x5GcVFmpx/OxAABjDFZRsexjo3J0aoU
         Gkl5jqIycvh+OH3e9WlPFgCYwK22kMg2vugj8vGwSOBsYM7rwFhI1YToHLS5x5gIQoPU
         YCTX9BNdhSTxAmYtGqs5k77/R5ITUKWYkbYE0GJYjb5qtDWtnb+5H2Mi+NQvm/Qd/pTR
         nRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774844793; x=1775449593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEFziDjY8EELmDWMIHiwj21wEphahbqJkx5694Z88mI=;
        b=eiKpgFAlbx/rIG0sJVjwIH5SsO6HHufrhJ4qi1or0kQdYLGkxK2mEJnUe2oEYF13A8
         JH5UzMq5q66XQJe1aqDMjpmNWvm4j6XnfM/VNnY8tllDiytTpK3Jzttp+vbNVijHKnFW
         AbIy/nQYMlrnRHnMWhXIHKsn58dY9BrzBj2Vd1NCGIUOVUD6wkyqP0Si6uOnRsy/zHJV
         unwdIYu7jrNZNPpsTPCxq0V65E1NvS+lLFn7UaNghO5f/ZxNv7NxDqTORrDlXe18EVYs
         a/Cg5JFhOOzdEgaGtmSL4NQ8MaYlh+r0nsar4RE2yorpdi71jCyiw+t3e89Od1kYkPjO
         fnaw==
X-Forwarded-Encrypted: i=1; AJvYcCWmw/dOg/LbQmIctkAlrPKKKrEsJ37vdC+FAknsB6rgM4M8Utc782ORx6gxd5EqMr7KU3J4zrUJ8S8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf9hg/mdDSSaaU7KE3VfO8uVWtdMeqUies0xcboGvCArwC5nRM
	8XwgCLCbHJ+k5EV0wHkaUl3gL5AntyZKABAea9tVKF+yCtAlO7kBKulQGsxKJ8JXoTJHYg==
X-Gm-Gg: ATEYQzxyB5sKS7rV26UjmgPdHdWvGfyMWUSHaTfcJcbHXKxiyXG48ImLmRZV0rUtx+n
	/zSyQGg+xxhWGMm+E1VzbOzaCh4EAL6m2fqrIFZFV3eYnQeIasPmIEAhdeqq1zdMCclouYLJA44
	/3Gf2aKW3+Eu9roVXv2/5iWk1Rr3jUJCBrt13YDEkOb0d8mFV2lLos1gBEqZjHUyQeRsIuJzg/H
	U0W1UIo6VdFCm0WndvAdedqQdgwu3YMJSkympbvuJleKrKun1OrD1X2eVBqplQ5loYVehVpoTH6
	yGae6XK2rUml1Ef1eKHG6cthmH3on8UbilKa6T63SJaQImbfUoEB6CyeQnnpiUPlnjwOP3hR4Dv
	DYhizyQapNbYEDnQxsh9R2vTbjRbGqZWaVNsOycgowdTLoRdFCS9l2gNltWVZON8kt5Rd43GEZ3
	9O7SieIB5P/qNy33VRsTo7GDili6coOETuoy1rle+UyLxkh7kULQuaG37D0lkztft9aznjV8B4Y
	5pUoqNX8JYiffHUqBD0XBk=
X-Received: by 2002:a17:90a:d410:b0:356:1db4:8fe5 with SMTP id 98e67ed59e1d1-35c30115629mr10183939a91.29.1774844793246;
        Sun, 29 Mar 2026 21:26:33 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c2eacff20sm4257584a91.3.2026.03.29.21.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 21:26:32 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Xiang Mei <xmei5@asu.edu>,
	linux-i2c@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] i2c: smbus: reject oversized block transfers in the common path
Date: Mon, 30 Mar 2026 12:26:22 +0800
Message-ID: <20260330042622.2608889-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SMBus block transfer length data->block[0] is validated in
i2c_smbus_xfer_emulated() but that check runs too late for tracepoints
and is skipped entirely when the adapter provides a native smbus_xfer
implementation. This allows user-controlled oversized block lengths to
reach tracepoint memcpy calls and driver callbacks unchecked.

Add an early validation in __i2c_smbus_xfer() that rejects block
transfers with data->block[0] > I2C_SMBUS_BLOCK_MAX before any
tracepoint fires or driver callback runs. This is consistent with
the existing -EINVAL convention in the emulated path and protects all
downstream consumers at once: the smbus_write tracepoint, all native
smbus_xfer driver implementations, and the emulated path.

Two distinct bugs are fixed by this change:

Bug 1: smbus_write tracepoint OOB (include/trace/events/smbus.h)
  trace_smbus_write() fires before any validation and copies
  data->block[0]+1 bytes into a 34-byte event buffer. With
  block[0]=0xfe the tracepoint copies 255 bytes, overflowing by 221.

 BUG: KASAN: stack-out-of-bounds in trace_event_raw_event_smbus_write+0x27c/0x530
 Read of size 255 at addr ffff88800c8b7cd8 by task poc_smbus/86
 Call Trace:
  <TASK>
  trace_event_raw_event_smbus_write+0x27c/0x530 (include/trace/events/smbus.h:23)
  __i2c_smbus_xfer+0x43a/0xa40 (include/trace/events/smbus.h:91)
  i2c_smbus_xfer+0x19e/0x340 (include/linux/i2c.h:835)
  i2cdev_ioctl_smbus+0x38f/0x7f0 (drivers/i2c/i2c-dev.c:391)
  i2cdev_ioctl+0x35e/0x680 (drivers/i2c/i2c-dev.c:478)
  __x64_sys_ioctl+0x147/0x1e0 (fs/ioctl.c:52)
  do_syscall_64+0xcf/0x15d0 (arch/x86/entry/syscall_64.c:63)
  entry_SYSCALL_64_after_hwframe+0x76/0x7e (arch/x86/entry/entry_64.S:130)
  </TASK>

Bug 2: i2c-stub I2C_SMBUS_I2C_BLOCK_DATA OOB (drivers/i2c/i2c-stub.c)
  stub_xfer() implements .smbus_xfer directly and only clamps
  block[0] against 256-command, not I2C_SMBUS_BLOCK_MAX. With
  block[0]=0xff and command=0 the loop accesses block[1+i] for
  i up to 254, far past the 34-byte union.

 UBSAN: array-index-out-of-bounds in drivers/i2c/i2c-stub.c:223:44
 index 34 is out of range for type '__u8 [34]'
 Call Trace:
  <TASK>
  stub_xfer+0x1971/0x198f [i2c_stub] (drivers/i2c/i2c-stub.c:223)
  __i2c_smbus_xfer+0x306/0xa40 (drivers/i2c/i2c-core-smbus.c:607)
  i2c_smbus_xfer+0x19e/0x340 (include/linux/i2c.h:835)
  i2cdev_ioctl_smbus+0x38f/0x7f0 (drivers/i2c/i2c-dev.c:391)
  i2cdev_ioctl+0x35e/0x680 (drivers/i2c/i2c-dev.c:478)
  __x64_sys_ioctl+0x147/0x1e0 (fs/ioctl.c:52)
  do_syscall_64+0xcf/0x15d0 (arch/x86/entry/syscall_64.c:63)
  entry_SYSCALL_64_after_hwframe+0x76/0x7e (arch/x86/entry/entry_64.S:130)
  </TASK>

Fixes: 8a325997d95d ("i2c: Add message transfer tracepoints for SMBUS [ver #2]")
Fixes: 4710317891e4 ("i2c-stub: Implement I2C block support")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes since the initial submission:
- Moved the check from stub_xfer() into __i2c_smbus_xfer() so it
  covers all callers, not just i2c-stub. This also fixes a separate
  OOB in the smbus_write tracepoint that hits the same missing
  validation from a different angle.

 drivers/i2c/i2c-core-smbus.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 71eb1ef56f0c..edb093687a4c 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -566,6 +566,15 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 	if (res)
 		return res;
 
+	/* Reject invalid block lengths before they reach tracepoints
+	 * or native smbus_xfer implementations.
+	 */
+	if (data && (protocol == I2C_SMBUS_BLOCK_DATA ||
+		     protocol == I2C_SMBUS_BLOCK_PROC_CALL ||
+		     protocol == I2C_SMBUS_I2C_BLOCK_DATA) &&
+	    data->block[0] > I2C_SMBUS_BLOCK_MAX)
+		return -EINVAL;
+
 	/* If enabled, the following two tracepoints are conditional on
 	 * read_write and protocol.
 	 */
-- 
2.43.0

