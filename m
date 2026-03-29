Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22F53806D7
	for <linux-i2c@vger.kernel.org>; Sun, 29 Mar 2026 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774802534; cv=none; b=seBd8LMlwcoZlWuZGfryCHZN15oVQxRZQKe23b2RAbgToQEx8RIOTkycnPKArrQuvMfUdHcz8BhnlUsK5p5nSder+8jzTuIGJ6rDf4PnOEDeI+DkaqnljBIhYy/frX26TZGv6CMM78ky/Cd+F8T28d94QUhqDHdt7ip0oeBgHKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774802534; c=relaxed/simple;
	bh=2dXv0nAmkiJYZS9eDr+LvkacZkKKtj06sR29apGbOlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LyORl7vLEp+ZKmg4IzdwbRRamU7Rhn6org+cAT6AOc7ZplmNGqt3JCmWowokOfPSig6YVbZ2ZgJ/vM6gr50z3ZnwTtbtWXJM7A4y3/kmawE1LAYWaHvntzMN6fN+UemWCy2cUA9L+sjZxV/MXWft132GKX8l55FO6GnZ9HbZfrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4RciwCj; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4RciwCj"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c70bfef17a4so2731635a12.2
        for <linux-i2c@vger.kernel.org>; Sun, 29 Mar 2026 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774802533; x=1775407333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/VkDaEIdx6Ux33QpjDJoUSEWWsuae4zX/E6ZQCjaiTQ=;
        b=F4RciwCjvn/pHxGD62ig0g0o86nHs95fXMGst5NFVwggi4MpTufD5MoqeaWirlzDPn
         IpzfjxMQn7BL+6ZfrzUE/69g4E/7YMGmlr/GBFbU3CGKAAWWVFfstPAj+a/efgkbwzMR
         shzSK2/bDDF/x1yPG+fv9Ntw35y9DiCapUHtiQG3Sy3m1uHGtDKquwjP+G0sjmr4PxEu
         viWfvwaWud+3FwT4FdlYGw4hjprjrZ+t3+j9px9DahIwzEspzlypY7vyS036cUYyFaEn
         VjH40wuTHuC4O4kC5kBetHd9HrLcpfrNCd/gL0IozAGd5j5VKSRKfZDfGOQSZi68iRGa
         KLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774802533; x=1775407333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VkDaEIdx6Ux33QpjDJoUSEWWsuae4zX/E6ZQCjaiTQ=;
        b=gvxgcd0ZyWTg8ZR662KnVnFjp+eB9K1EsIBQUT3A+NDISKbW+TXDdP58ld9tUPg25E
         8rN7J5KAWugWnQoBZ/KOQ+5inElWqplmJS2yqNc/1+VIMLGL8eeevj/0kWBrLkcaGNNa
         +SUmWRchpHwwt8aPjgnFkVGqlRF2Bp+fAQPAtQy7dsa3QiLAw3k+6h9dBfxRLojdbc2F
         KAhH2BxEhSp7cnvwdc3UoINwpE+5BedCu/97TDeZgc2IFiJWDECRrHtAFf5uBfi6cRUz
         Cp6/A1eB9fCh6h5z59qFyNAiRv/i+rMvZ7fJ+no5/D4UM3uqdmtD9yItpvfWLBNU7ZkE
         Iewg==
X-Gm-Message-State: AOJu0YwCPTbZxC2EtWVE8NkIorvsmmuKv9HNmc6tqABcKWBjtW42ttsZ
	RVxCi4qjn+Wjh6BX83+nYO9phnjldIXKKxngMDzkHhl7aK3UWpgGIIw5
X-Gm-Gg: ATEYQzwnQoqAd2OghMuqbveZq6zSLmjyMa12kitZo7pD7J49iNp8Y1V+bIXLIojRc+W
	xc4etdBfzi0ub0+/ORXZ1cGAIGdeB5a76vBQ4dxi9HtAANqWjNi6VgjUMOyWKRuEH2FBvixrk+2
	usLumhUqFGhasJfXtFerLKUeydsRIlMNv4vf9Y6vW9P/PU+JNDfvPHwHN5AOjPr0EERDVWBxeMA
	CaT6F3ymQ1s+1zp1rnwV1e0R8RaAxeOy3XuMsrAfaLPjCl3ngXXy3mX/3559ug4+tylLBT5IVz5
	G2Bw4VGgWLpV2SNEgmckB4L5jlLfOCZBnJ4F3XHfPUJgnCjQUosV+t1APhbiYh9Qotz4eTsRmBn
	rgsX92gYOYbHDiGiT4iVvb9SxtxuA7R1bQbiIlA/d92+b/SAbQ5+joCl6UfFkcx5Arr0eBw7AqV
	d25dibaga1C2yxurkStsSILMq240R4NHOHSuwkDVQ7TolJfKByyN5O5K0g1t4re7cCiHnYjDMp0
	oy3ocPMxmwB
X-Received: by 2002:a05:6a20:7d9b:b0:39b:e321:784e with SMTP id adf61e73a8af0-39c87c40488mr9199781637.60.1774802532982;
        Sun, 29 Mar 2026 09:42:12 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917db770sm4015782a12.32.2026.03.29.09.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:42:12 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: stub: Reject I2C block transfers exceeding I2C_SMBUS_BLOCK_MAX
Date: Mon, 30 Mar 2026 00:41:27 +0800
Message-ID: <20260329164126.820797-2-bestswngs@gmail.com>
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

Fix by rejecting oversized transfers with -EINVAL when
data->block[0] exceeds I2C_SMBUS_BLOCK_MAX, consistent with both
the I2C_SMBUS_BLOCK_DATA case in the same function and the
I2C_SMBUS_I2C_BLOCK_DATA validation in i2c_smbus_xfer_emulated().

Fixes: 4710317891e4 ("i2c-stub: Implement I2C block support")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/i2c/i2c-stub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/i2c-stub.c b/drivers/i2c/i2c-stub.c
index fbb0db41b10e1..349ef9fb2fdbc 100644
--- a/drivers/i2c/i2c-stub.c
+++ b/drivers/i2c/i2c-stub.c
@@ -214,6 +214,10 @@ static s32 stub_xfer(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 		 * We ignore banks here, because banked chips don't use I2C
 		 * block transfers
 		 */
+		if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
+			ret = -EINVAL;
+			break;
+		}
 		if (data->block[0] > 256 - command)	/* Avoid overrun */
 			data->block[0] = 256 - command;
 		len = data->block[0];
-- 
2.43.0

