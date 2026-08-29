Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C89F3976A0;
	Sat, 29 Aug 2026 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013368; cv=none; b=RDO+RqWY68jX6TN5o1VlawlzexVQx9TIR3rQWHZ1OGWiBClBfNQ6FPpAF9ZpeAz1whq8XY6Famf80w4o44kIwdJjHEkc5fciPe0YhaOs0s+XME64g5IIRRp8K/I8ud5QIKCs6fX7QKYg1mHvutWYKtU0KBiPLPirbB8ADH8pnKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013368; c=relaxed/simple;
	bh=eUH24XL3kXGSsh1qex2KxF4rPrPjz7TsITT9Zr3pdVk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=HJv3CQhVp/YdD/EAM7ZellS7CW2tqOF2qtMoNO7CH/MUE45RLR/zpcsgGg0MO5sO1w1ojCfWXhBsmK2RQYqIA5TkwkvXcql58zt+vWlGnXZF2AyfHaTvlcSpvBjaNRa2xNnzr9u9iJTJGzcspeqq67pY7NAWdkNenBrPuoGI09Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=XTemuDCf; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="XTemuDCf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1788013353;
	bh=uYj84NhaPDAXnupwTsU9+MQjHNukFHUbiUCsF3C8eWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XTemuDCfbTRvoGhjP2pSZCKAeE8Q4LALgEhM8EIcgGtXIFDV8y2CfdYb+tkQ8BRVx
	 1y46qh8cByau01fAn2RNMsb2QHxTvp6uEcYQ6QA8awOTDZdsLhU2R8Wk2vVLnLGBRS
	 0Pn4fozlpSJpCMiyxT0uWnvidjBmIEDbp0/jtzDM=
Received: from LAPTOP-TKBJAGN4.localdomain ([2408:8256:2d02:da31:a433:ae59:7369:ddb4])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 57B20AC8; Sat, 29 Aug 2026 22:21:59 +0800
X-QQ-mid: xmsmtpt1788013338trzeggnjv
Message-ID: <tencent_0D2E46A782AC418BC52A1BBF04CA1AC98E09@qq.com>
X-QQ-XMAILINFO: OYTBn1rNHH7tToiJ3K4w4Y3qO98LLhKkxkirT+ZbZwUEKf4CB0WGqIV1U8v+p6
	 XsMXCmHyijb0yht1y10z3/MjEiSwgHbS5PO7d9wxlQhR2K0o/JEYZbWqRf5TlnDQ60l69YSppwWN
	 x9/2gVVIAFn+VECay0hNgx0lUXqtc/9j9E7o8Exy2RQTC2OX4kerv/g0GzfBdj/v5ctqvkxIrCqm
	 ELaHsOu8YlqArlTPws9Vd8XkTLHbCf2n2YabYFEAEdaCHIwzaTCFHN5IqS/wLTUzMIBVR55+SvpI
	 l0aQ/KUWtwsS2s4WHT1VhDI/RT2KZhGEIE1AbmHZqImK6aXgR+rPaABBFeriRvovq0WcOFaW/3pV
	 /vn33/Bize3OkunbX1XMD9Krz2nKJBGlh/AhP6/oX+eUTg7W0e/vlOyGv+QEhNv0WGB87ULK9DBw
	 6BjN5G1HPOPLjZM3TVgaW4IKEg+R0TnzHRgVrbw6Z0QsGkWAdw8Ge6WJnYf80psxXrYV9WiByu7t
	 FZk4KOgCjJI8FX/Acw7Ui+pXYeGkORcv0/4V3taKHdJSUbHcewlS+U7JrdB+GP9ycaD09atQW4as
	 rb53Mw2S8YAL17RmGCuKM8VNuEAGG3ZfGsIKels8SpFQY/BGQOawx7ECQshZkgWGFOgB0IsD8oBl
	 aVDZ2xEreciP0Rn5AxI2flPC4GFfPwA5bexbyo0swCJhOya3exvaMlrYhtr6Vkv40q1PnQ8ral+e
	 suJU3qRJwOA5jBwaM6jMknaZL3Ez8tQsuXF93nt2OCbMDD7STZey8opP6u9BV5f+mMPpRrEGW3SR
	 7iKpB3QRgabZwVKUHjmXgRTmTS71gfJqYoR0yLZdD8FFTMhiei5sAFzoWzYjgC+txsxYWtEVJfPa
	 T1oTfy4LWSoVima5V99LXav67mF2n1vGjMufKiQioB3n8stJfvBPqzXrsirHLezJm0CU01NZtbAW
	 tCX2NNLti1Q+q0TqdIoGD+OTZKMiIeC8UBNxahuEmVz28I0kxT+Os6mYeqdobyEiOwZSm8sGTx+M
	 uz3ACTvcUzHf+9qI6Hf2nCcXZ9DDZ1RQVMUEM52bC5DjmOlBLTDo1crwbVlaeLPT23H0Er+wCeiM
	 FPv/6HNSe2lUGzCoAZenSU3JmzSw==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Haobin Jiang <lemonoutput@foxmail.com>
To: andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haobin Jiang <lemonoutput@foxmail.com>
Subject: [PATCH 1/1] i2c: imx: honour I2C_M_IGNORE_NAK for write messages
Date: Sat, 29 Aug 2026 22:21:48 +0800
X-OQ-MSGID: <20260829142148.10536-2-lemonoutput@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260829142148.10536-1-lemonoutput@foxmail.com>
References: <20260829142148.10536-1-lemonoutput@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i.MX controller has no hardware "ignore NAK" enable bit and checks
each byte in software after transmitting it: i2c_imx_acked() on the
atomic and DMA paths, i2c_imx_isr_acked() on the non-DMA ISR path.  Any
NAK is treated as a fatal error and aborts the transfer with -ENXIO.

There are legitimate use cases where a target NAKs a write on purpose,
and when it does, the transfer needs to continue rather than abort.  The
standard way to express this is the I2C_M_IGNORE_NAK flag, which the
core honours through i2c_transfer_buffer_flags() only when the adapter
advertises I2C_FUNC_PROTOCOL_MANGLING.  The i.MX driver never advertised
it, so callers using the flag are rejected by the core before any byte
is sent.  One such caller is the in-tree crypto driver atmel-i2c.c,
whose wake sequence for the ATECC508A/608A requires exactly this: the
still-asleep device NAKs every byte of the wake token, and the write
must complete anyway.

Advertise I2C_FUNC_PROTOCOL_MANGLING and honour I2C_M_IGNORE_NAK on the
write path by passing it through to both ACK checks.  With the flag set a
NAK no longer aborts the transfer and the byte loop continues so the
remaining bytes are still transmitted.  The read path always passes
false, and every transfer without the flag keeps the previous behaviour
bit-for-bit unchanged.

No retry is introduced: the meaning of a NAK is device-specific [1], so
it stays a device-driver decision.  I2C_M_IGNORE_NAK is only honoured
when the device driver explicitly sets it, which is exactly how the flag
is meant to be used.

Link: https://patchwork.ozlabs.org/project/linux-i2c/patch/1467900229-5262-1-git-send-email-tharvey@gateworks.com/ # [1]
Link: https://lore.kernel.org/linux-i2c/4D46D571.5010907@armadeus.com/ # [2]
Link: https://patchwork.ozlabs.org/project/linux-i2c/patch/1378857490-30968-1-git-send-email-luka@openwrt.org/ # [3]
Signed-off-by: Haobin Jiang <lemonoutput@foxmail.com>
---
 drivers/i2c/busses/i2c-imx.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 28313d0fad37..737c19688ecc 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -612,9 +612,12 @@ static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx, bool atomic)
 	return 0;
 }
 
-static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
+static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx, bool ignore_nak)
 {
 	if (imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR) & I2SR_RXAK) {
+		if (ignore_nak)
+			return 0;
+
 		dev_dbg(&i2c_imx->adapter.dev, "<%s> No ACK\n", __func__);
 		return -ENXIO;  /* No ACK */
 	}
@@ -968,11 +971,15 @@ static int i2c_imx_unreg_slave(struct i2c_client *client)
 	return ret;
 }
 
-static inline int i2c_imx_isr_acked(struct imx_i2c_struct *i2c_imx)
+static inline int i2c_imx_isr_acked(struct imx_i2c_struct *i2c_imx,
+				    bool ignore_nak)
 {
 	i2c_imx->isr_result = 0;
 
 	if (imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR) & I2SR_RXAK) {
+		if (ignore_nak)
+			return 0;
+
 		i2c_imx->state = IMX_I2C_STATE_FAILED;
 		i2c_imx->isr_result = -ENXIO;
 		wake_up(&i2c_imx->queue);
@@ -985,7 +992,7 @@ static inline int i2c_imx_isr_write(struct imx_i2c_struct *i2c_imx)
 {
 	int result;
 
-	result = i2c_imx_isr_acked(i2c_imx);
+	result = i2c_imx_isr_acked(i2c_imx, i2c_imx->msg->flags & I2C_M_IGNORE_NAK);
 	if (result)
 		return result;
 
@@ -1002,7 +1009,8 @@ static inline int i2c_imx_isr_read(struct imx_i2c_struct *i2c_imx)
 	int result;
 	unsigned int temp;
 
-	result = i2c_imx_isr_acked(i2c_imx);
+	/* Read path always checks NAK; I2C_M_IGNORE_NAK is write-only. */
+	result = i2c_imx_isr_acked(i2c_imx, false);
 	if (result)
 		return result;
 
@@ -1213,7 +1221,7 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 	if (result)
 		return result;
 
-	return i2c_imx_acked(i2c_imx);
+	return i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
 }
 
 static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
@@ -1227,7 +1235,8 @@ static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
 	result = i2c_imx_trx_complete(i2c_imx, !use_dma);
 	if (result)
 		return result;
-	result = i2c_imx_acked(i2c_imx);
+	/* Read address NAK must always be reported; I2C_M_IGNORE_NAK is write-only. */
+	result = i2c_imx_acked(i2c_imx, false);
 	if (result)
 		return result;
 
@@ -1358,7 +1367,7 @@ static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx,
 	result = i2c_imx_trx_complete(i2c_imx, true);
 	if (result)
 		return result;
-	result = i2c_imx_acked(i2c_imx);
+	result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
 	if (result)
 		return result;
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> write data\n", __func__);
@@ -1372,7 +1381,7 @@ static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx,
 		result = i2c_imx_trx_complete(i2c_imx, true);
 		if (result)
 			return result;
-		result = i2c_imx_acked(i2c_imx);
+		result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
 		if (result)
 			return result;
 	}
@@ -1697,7 +1706,7 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
 static u32 i2c_imx_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
-		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
+		| I2C_FUNC_SMBUS_READ_BLOCK_DATA | I2C_FUNC_PROTOCOL_MANGLING;
 }
 
 static const struct i2c_algorithm i2c_imx_algo = {
-- 
2.34.1

