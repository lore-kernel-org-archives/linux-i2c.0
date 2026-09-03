Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A043E4C96;
	Thu,  3 Sep 2026 06:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788416981; cv=none; b=LunKjtYEB7/wKiGgg4yuHouDUOPB2sYZdpaaNPRqWJcs1YpYOGLMDl4FHauGCEa5MyNK6Jz62pUu/0ys7oMJnbaqNmgPjbQ2XsvsfdN3KirHqjb1Tnqq2MYEbBVY/R1jZJWGA+rVrB1psSXCq4KbzwHscGNdBnZ7ZMiTvDzVPp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788416981; c=relaxed/simple;
	bh=ee4ofXZqSNwy9f90hRIbdTrXM36N0JGgkb1HtRIRj6I=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=F62as6UiHV6BShhRKAq7a/3biT7PUlYAl0pxN5uiyTqBMFMzY9CXvMnT08Wp5gq2l+9kGXVxhzj5Q361CFNvgKwc8Nqh6JFrs91IlDZ9kVOhll9xAGLtwBfVcfLZTWQ9UtlE5LXYHXUa2vRiOO3hhKTElC9pFo/6r3TNcY97+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=YnYqaIej; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="YnYqaIej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1788416967;
	bh=iXWuAHhao+JQKfP/uWUlIG0PaXD5vB/r6zkEtM44/P8=;
	h=From:To:Cc:Subject:Date;
	b=YnYqaIejaJV2K4OXcvWMJyUBmRfqlCJ75981k8B0sEWyruvKOoAGQDgF+inZONHX4
	 ZJ3+OHRp/+Vgp8o5ELp/XnVpEA6HAy8bbi56pJR2jp1VYkXkuqINBYnqh0sspbUXuk
	 iG+OUfJvqzNt9JEAyd4XZANigyyGDCdsGbJQJOpE=
Received: from LAPTOP-TKBJAGN4.localdomain ([2408:8256:2d01:e2b1:6136:e6c:8ed6:40aa])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 7531182B; Thu, 03 Sep 2026 14:29:19 +0800
X-QQ-mid: xmsmtpt1788416959th7icnmcj
Message-ID: <tencent_E6A52FBBB25132C90B8E296FEB96E2C8CA07@qq.com>
X-QQ-XMAILINFO: N6IfSeM/PG+tdFPro0Mxsj7JJPO19r/CGZbFDiWlPqiRTwHSIuI8IwAoIZ6yLx
	 shYWmAjecjCTMXxsdmfz4aTo1VuqOgUVm78jzLOa0yIZd0sbfNRSiA8+m/Fh/1MFBPzjGrtDqCyL
	 48gNIGMnb5GvWOdTmjg5I4BdpjjBYsaVTKPXNhlCDO0MhYcv78MoHoniMk6KX3cVqxPOKBmII+Qd
	 yh9ecYWJq6NKwHokAw/5Z4Evk96VjaSmVyS8oL9oFp46xgjoY2Sjw3hsodmUHtFc7mARlEWTJ0gH
	 bvwj3/w08zAtGWBUoI2NfdzZFnYLbpcoLGFNWzXHc2X0+uUAwUIc/+4t5Z3PnoTnVtJJbskfld2i
	 yZm/KJ+BU95DxJxMzO7k1e6+OWHmnw1xM8LgWBq2u2BuIWb6gSc9fFZosCrMi1bDiYttPGkGvbfi
	 zxUMAMNZKIg2pzEyEbwNnZnSgD7iFbqZa8vK64L1mA6eXwdKJ2/e3IzczuEMUUolDPN1xk7bEP32
	 m4YTIJysKcGYeZugxgskKUMajuYfsd295bcgWjl3nsC4tFBckhRFIv7xzC9SLIjP4uWpApHs2uuE
	 yulofoC5hHkgQO9i5NGDdxdnle+TASM5KEx6mTx7TJmSYNCKYCa6ZUtbjDtxjnECLrah4C9N9Y+G
	 itcL9eiOY+J3iHFDlznWYoQ2VIemhROBxQFUMJ/uaBPqB6j9szHEaCw4z1Pnaj9e8GT8L8KGscUT
	 XMdrqtc+LgdoLRRCg06l9kRX4bmyg12bZTvIos4ntPcoyxKVydcKlUotkn/9EkXcy9nqkYVVU49i
	 vwdzu42NNrLg5ELdXw50/pkpjuxJ34GOoN9cOjW9JlgYaKHSj+PUgAOzJdZBf9BhtTDSfyBRFX5e
	 Q4SxUOxt/oiPKdZVikagAp7PnPeJ0zYKcvPVuRMMtYffVTgX/6rY1vwkNHz6BWFU/xyAmkLJd+Vb
	 aRdBO2eKM1UXXP9PczvwmLdgi/i3FY9DUE6OyE4c919lpf5GBkV6tkPiI10NnVRr7IDuJLUYG925
	 /r1XN2crsQ1EBXjbo1B1BxSDnPTllHfnV6OL603dPtUc1JbSlhw2stq1aw4chp6BAfKgT6brcoFt
	 fjLHDeLQnMImnvMGFm3I1uVX54pNOork/3sy4ns3Zgy3vrnYFKhmlLWMPL1d191deI/pB/Bu6IgG
	 WQox6RSzpRHw6nrySr5vLO4CJREOFtGPfHjbz+3xb8ANTE2Q==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Haobin Jiang <lemonoutput@foxmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Haobin Jiang <lemonoutput@foxmail.com>
Subject: [PATCH v2] i2c: imx: honour I2C_M_IGNORE_NAK
Date: Thu,  3 Sep 2026 14:29:15 +0800
X-OQ-MSGID: <20260903062915.7875-1-lemonoutput@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i.MX controller has no hardware "ignore NAK" enable bit and checks
each byte in software after transmitting it: i2c_imx_acked() on the
atomic paths, i2c_imx_isr_acked() on the ISR path.  Any NAK is
therefore treated as a fatal error and aborts the transfer with -ENXIO.

There are legitimate cases where a target NAKs on purpose and the
transfer must continue anyway.  The standard way to express this is
I2C_M_IGNORE_NAK, which the core passes through to the bus driver
unchanged: i2c_transfer_buffer_flags() performs no validation of the
message flags, and the i.MX driver has never advertised
I2C_FUNC_PROTOCOL_MANGLING.  Today such a transfer transmits bytes
until the first NAK and then fails with -ENXIO, silently dropping the
flag.  One in-tree caller that hits this on i.MX buses is the wake
sequence of the Atmel crypto drivers (drivers/crypto/atmel-i2c.c, used
by atmel-ecc.c for the ATECC508A/608A): the sleeping device NAKs the
wake token and the write must complete anyway; the ATECC508A is wired
to an i.MX I2C controller e.g. on the Gateworks GW5904.

Advertise I2C_FUNC_PROTOCOL_MANGLING and honour I2C_M_IGNORE_NAK at
every software ACK check: on the PIO write paths, which check the ACK
of the address and of every data byte, and on the PIO read paths, which
check the target's ACK of the address byte, mirroring i2c-img-scb.
With the flag set a NAK no longer aborts the transfer and the byte loop
continues so the remaining bytes are still transmitted.  Every transfer
without the flag keeps the previous behaviour unchanged.

A NAK'd byte does not generate a further DMA request, so a DMA write to
a deliberately-NAKing target would stall until DMA_TIMEOUT instead of
completing.  Force the PIO path for every message carrying
I2C_M_IGNORE_NAK, again mirroring i2c-img-scb, which implements the
flag in atomic mode only.  The DMA write path therefore never sees the
flag, but it passes the flag through at the final ACK check like the
other paths.

I2C_FUNC_PROTOCOL_MANGLING is a blanket capability bit, so advertising
it while implementing only I2C_M_IGNORE_NAK would silently ignore the
other mangling flags.  Reject I2C_M_NO_RD_ACK and I2C_M_REV_DIR_ADDR in
xfer_common() instead; no in-tree user of these flags transfers through
i2c-imx.  I2C_M_NO_RD_ACK is not implementable at all on this
controller: it always clocks the ninth acknowledge bit and I2CR[TXAK]
only selects ACK versus NAK.  I2C_M_STOP is deliberately not rejected:
the controller already terminates every transfer with a STOP and
separates messages with repeated STARTs, so leaving the flag unhandled
changes nothing on the bus, while rejecting it would break the ov2659
camera on imx6qdl-ds: I2C_CLIENT_SCCB is I2C_M_STOP | I2C_M_IGNORE_NAK
and the driver stamps client->flags on every message, including the
chip-ID reads done at probe time.

No retry is introduced: the meaning of a NAK is device-specific [1], so
it stays a device-driver decision.  I2C_M_IGNORE_NAK is only honoured
when the device driver explicitly sets it, which is exactly how the
flag is meant to be used.

Link: https://patchwork.ozlabs.org/project/linux-i2c/patch/1467900229-5262-1-git-send-email-tharvey@gateworks.com/ # [1]
Link: https://lore.kernel.org/linux-i2c/4D46D571.5010907@armadeus.com/ # [2]
Link: https://patchwork.ozlabs.org/project/linux-i2c/patch/1378857490-30968-1-git-send-email-luka@openwrt.org/ # [3]
Signed-off-by: Haobin Jiang <lemonoutput@foxmail.com>

---
v1 -> v2:
	- Honour I2C_M_IGNORE_NAK on the read path as well, at the checks
	  of the target's ACK of the address byte (i2c_imx_isr_read(),
	  i2c_imx_prepare_read()), mirroring i2c-img-scb, instead of
	  silently dropping the flag there.  Read requests carrying the
	  flag cannot be rejected, because in-tree SCCB sensors such as
	  ov2659 set I2C_CLIENT_SCCB, i.e. I2C_M_STOP |
	  I2C_M_IGNORE_NAK, on their read messages too.
	- Force the PIO path for every message with I2C_M_IGNORE_NAK: a
	  NAK'd byte does not generate a further DMA request, so a DMA
	  write to a deliberately-NAKing target would stall until
	  DMA_TIMEOUT (mirrors i2c-img-scb).  i2c_imx_dma_write() can
	  therefore never see the flag, though it still passes it
	  through at the final ACK check like the other paths.
	- Reject I2C_M_NO_RD_ACK and I2C_M_REV_DIR_ADDR in
	  xfer_common() instead of advertising blanket support and
	  silently ignoring them.  I2C_M_STOP is not rejected: the
	  controller already emits a STOP after the final message and
	  repeated STARTs between messages, and rejecting it would break
	  the ov2659 camera on imx6qdl-ds.
	- Correct the description of the status quo: the core does not
	  reject I2C_M_IGNORE_NAK; i2c_transfer_buffer_flags() passes the
	  message flags through unchanged, so the current driver sends
	  bytes until the first NAK and then fails with -ENXIO.
---
 drivers/i2c/busses/i2c-imx.c | 44 ++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 28313d0fad37..5b22a497a791 100644
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
 
@@ -1002,7 +1009,7 @@ static inline int i2c_imx_isr_read(struct imx_i2c_struct *i2c_imx)
 	int result;
 	unsigned int temp;
 
-	result = i2c_imx_isr_acked(i2c_imx);
+	result = i2c_imx_isr_acked(i2c_imx, i2c_imx->msg->flags & I2C_M_IGNORE_NAK);
 	if (result)
 		return result;
 
@@ -1213,7 +1220,8 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 	if (result)
 		return result;
 
-	return i2c_imx_acked(i2c_imx);
+	/* I2C_M_IGNORE_NAK messages always take the PIO path. */
+	return i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
 }
 
 static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
@@ -1227,7 +1235,7 @@ static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
 	result = i2c_imx_trx_complete(i2c_imx, !use_dma);
 	if (result)
 		return result;
-	result = i2c_imx_acked(i2c_imx);
+	result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
 	if (result)
 		return result;
 
@@ -1358,7 +1366,7 @@ static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx,
 	result = i2c_imx_trx_complete(i2c_imx, true);
 	if (result)
 		return result;
-	result = i2c_imx_acked(i2c_imx);
+	result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
 	if (result)
 		return result;
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> write data\n", __func__);
@@ -1372,7 +1380,7 @@ static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx,
 		result = i2c_imx_trx_complete(i2c_imx, true);
 		if (result)
 			return result;
-		result = i2c_imx_acked(i2c_imx);
+		result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
 		if (result)
 			return result;
 	}
@@ -1549,6 +1557,16 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 	bool is_lastmsg = false;
 	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(adapter);
 	int use_dma = 0;
+	u16 mangling = I2C_M_NO_RD_ACK | I2C_M_REV_DIR_ADDR;
+
+	/*
+	 * Only I2C_M_IGNORE_NAK is implemented; reject the unsupported
+	 * mangling flags.  I2C_M_STOP is the controller's native
+	 * behaviour and must not be rejected.
+	 */
+	for (i = 0; i < num; i++)
+		if (msgs[i].flags & mangling)
+			return -EOPNOTSUPP;
 
 	/* Start I2C transfer */
 	result = i2c_imx_start(i2c_imx, atomic);
@@ -1604,6 +1622,14 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 
 		use_dma = i2c_imx->dma && msgs[i].len >= DMA_THRESHOLD &&
 			msgs[i].flags & I2C_M_DMA_SAFE;
+
+		/*
+		 * I2C_M_IGNORE_NAK is honoured on the PIO paths only; a
+		 * NAK'd byte does not generate a further DMA request
+		 * (mirrors i2c-img-scb).
+		 */
+		if (msgs[i].flags & I2C_M_IGNORE_NAK)
+			use_dma = false;
 		if (msgs[i].flags & I2C_M_RD) {
 			int block_data = msgs->flags & I2C_M_RECV_LEN;
 
@@ -1697,7 +1723,7 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
 static u32 i2c_imx_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
-		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
+		| I2C_FUNC_SMBUS_READ_BLOCK_DATA | I2C_FUNC_PROTOCOL_MANGLING;
 }
 
 static const struct i2c_algorithm i2c_imx_algo = {

base-commit: 04e9bf1648f846976b543e91c1838a712433772a
-- 
2.34.1

