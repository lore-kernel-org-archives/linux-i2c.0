Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9CC1E9B3D
	for <linux-i2c@vger.kernel.org>; Tue, 14 Apr 2026 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776187462; cv=none; b=lYWqZOez08zLS42onw6+ig4g5U6KgURiNwlwQj0VhwwIJymnYXYM2FFTU9GsSh2qZH7MTokUzCLw/gzxOQKE2P3Sx/c39XPVGQMo45Kw1KeL9eQUumH2QQPrnbk9X635zPPea6S6aR3Mq40SxhN4ElpyGGkx0UxcHWIDJK/dSdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776187462; c=relaxed/simple;
	bh=rXdExhuzmqjUhosf8Tul2Oo7GyTQzGMYQZgtXLhxzsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cnK9CpUFV4xnhgpFYj3mwRmdVgNruIpDAjjnfJqafeNH6++K4PI4b3kPKBk6AxqcEjoQRi1zT0DH1Qo0vQxOmL5Cko1fLPWQ7M9XpCnHe6O43CHQNiBAtQYD9TR/EuWe+cgX6KeIMSVF3+xkovNHRVIbxhsxqXSyJWLhP8DFaCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ5fLkQ+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ5fLkQ+"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad9516a653so29316205ad.0
        for <linux-i2c@vger.kernel.org>; Tue, 14 Apr 2026 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776187460; x=1776792260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OVMfubLs9rXzKVCrgJsmrbmGSp8TzTIvAiDj5WtSBp0=;
        b=cJ5fLkQ+aZazX0HyVYqtuC5kRvnIIIbrFbwI+/DKKzXWG7l8DSIN90MlqSmtiySXfK
         UlcenTur/efgMqXNWdJjWPw5Tl5QFQxz6/uKZ2me35ZPGvYq/f4XFn8EDxH9gEcHuxiE
         Bkml9CA6w+k1INfb2QeY//4xS3E9NOna5uP9KpBt3/RgDI56YqW+qvA0nIIzY7J3abdA
         bni8Fv9wp/hbkLOGu/8Yh5JHfA/9RhgusHaKfNK+238+/9LbRsV8WnweHmjeg3783qxz
         aNW9/3bt8Xgj61COcQTua6261KQmlLj8pYOOGpWy/v7mpSGpwyqN2M2qNLsSwlzJUIn4
         8rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776187460; x=1776792260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVMfubLs9rXzKVCrgJsmrbmGSp8TzTIvAiDj5WtSBp0=;
        b=O2/rgX2sxyUP6q4f6lIZomHGLmgoLY603wgfV1vHdNbpOnlV7sab4ZMy1AfkETN8sU
         JLd5Cm1knk1upOr9k8wDTtMP6KLxFf+w1/qJaqcpHLlKVW5Jaux25tMPUSpdu33XAUqF
         n4tVtz5D8nRsyv8M0qJi2/0K1OxiAfc63qtdIMQVhpRger39nIq0lYwQtov35rVAOhXf
         peS9ucVO6xOqyF8ZqrNo1MjjEQt21L4Xb4u2FV9yoIISfmP1u0rI6Fq72qQ4kQMmgMc4
         tdahCM+1fWHexY5L/DKU9zKmeed7F0vqVme6P72X3ufpatV5wdUv8b3L+cwgFnwjMdT2
         jnHA==
X-Gm-Message-State: AOJu0YwHUV4URLxkoKCxswcO9zGcctAWVZYlws3tj8PxSDr8BJwoFHhz
	sdmQ4Uigj5o+1S69JFgPa/ub5x05bhS+FyZlzgx2fOCUE1aGbIzKmba5
X-Gm-Gg: AeBDievwpSnHIwzC06ZjO+TK2z2pL1C8a8koP2ISfVNtlAg1AVPW+Ml1cgORZuD8gC9
	lpq7YPRjadhX8eoqrnSo6xc/y9FIJWwbYtGwJQFURmoXFZsKk5LWHwwWFByLrQG1ThRuyIyYRId
	7nATv9cl+HVG2scgl60iDkHmWsoR8xo+v99P+ypMscVaObdcm1AZlNf6BmqJ0Az4+vBIa4tepQV
	cXRlZOYIFEDN+fRkhfEI9wXdU2q83cVLSfeMapHmi7TqSSaQdkqFbGxRQoco1Tj3MJHu/4QQOm4
	Gt4GavKBWXzcGd8JE38V/WT4Yk9muaYPR5NjLbt4Nv2vnMqH6/Oo9BEx1gOYK4WS8Zpj0Hsl1Be
	TYn/IQTC3bg0wr6XgaMHXhsKpIzK6YcNToFwjYdGfnSyVvpOlxD5Qb/HxNT6tXVdYi8xpxwCNJk
	kH6SpMlWcDWdaviu/yauNJ/F1sfb9JZhys8ezpJ0D7taYz2bNTfM/APNjb9KUrH5fkNAIR2qgLX
	LdAQFFvnPhD
X-Received: by 2002:a17:902:7b94:b0:2b2:9f9f:fe6b with SMTP id d9443c01a7336-2b2d5a5f92fmr117805295ad.40.1776187460089;
        Tue, 14 Apr 2026 10:24:20 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f3b299sm189034725ad.73.2026.04.14.10.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:24:19 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH v2] i2c: stub: Reject I2C block transfers with invalid length
Date: Wed, 15 Apr 2026 01:23:39 +0800
Message-ID: <20260414172338.110830-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The I2C_SMBUS_I2C_BLOCK_DATA case in stub_xfer() uses data->block[0]
as the transfer length. The existing check only clamps it to avoid
overrunning the chip->words[256] register array, but does not validate
it against I2C_SMBUS_BLOCK_MAX (32), which is the limit of the union
i2c_smbus_data.block buffer (34 bytes total). The driver is a
development/test tool (CONFIG_I2C_STUB=m, not built by default)
that must be loaded with a chip_addr= parameter.

A local user with access to /dev/i2c-* can issue an I2C_SMBUS ioctl
with I2C_SMBUS_I2C_BLOCK_DATA and data->block[0] > 32, causing
stub_xfer() to read or write past the end of the union
i2c_smbus_data.block buffer:

 BUG: KASAN: stack-out-of-bounds in stub_xfer (drivers/i2c/i2c-stub.c:223)
 Read of size 1 at addr ffff88800abcfd92 by task exploit/81
 Call Trace:
  <TASK>
  stub_xfer (drivers/i2c/i2c-stub.c:223)
  __i2c_smbus_xfer (drivers/i2c/i2c-core-smbus.c:593)
  i2c_smbus_xfer (drivers/i2c/i2c-core-smbus.c:536)
  i2cdev_ioctl_smbus (drivers/i2c/i2c-dev.c:391)
  i2cdev_ioctl (drivers/i2c/i2c-dev.c:478)
  __x64_sys_ioctl (fs/ioctl.c:583)
  do_syscall_64 (arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
  </TASK>

The bug exists because i2c-stub implements .smbus_xfer directly,
bypassing the I2C_SMBUS_BLOCK_MAX validation in
i2c_smbus_xfer_emulated(). The I2C_SMBUS_BLOCK_DATA case in the same
function correctly validates against I2C_SMBUS_BLOCK_MAX, but the
I2C_SMBUS_I2C_BLOCK_DATA case does not.

Fix by rejecting transfers with data->block[0] == 0 or
data->block[0] > I2C_SMBUS_BLOCK_MAX with -EINVAL, consistent with
both the I2C_SMBUS_BLOCK_DATA case in the same function and the
I2C_SMBUS_I2C_BLOCK_DATA validation in i2c_smbus_xfer_emulated().

Fixes: 4710317891e4 ("i2c-stub: Implement I2C block support")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2:
 - Also reject data->block[0] == 0 (suggested by Jean Delvare).

 drivers/i2c/i2c-stub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/i2c-stub.c b/drivers/i2c/i2c-stub.c
index fbb0db41b10e1..04314e3ed24c9 100644
--- a/drivers/i2c/i2c-stub.c
+++ b/drivers/i2c/i2c-stub.c
@@ -214,6 +214,11 @@ static s32 stub_xfer(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 		 * We ignore banks here, because banked chips don't use I2C
 		 * block transfers
 		 */
+		if (data->block[0] == 0 ||
+		    data->block[0] > I2C_SMBUS_BLOCK_MAX) {
+			ret = -EINVAL;
+			break;
+		}
 		if (data->block[0] > 256 - command)	/* Avoid overrun */
 			data->block[0] = 256 - command;
 		len = data->block[0];
-- 
2.43.0

