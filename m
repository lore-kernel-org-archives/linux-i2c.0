Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792765227;
	b=CKwlN+xk4mt6iCWuiH68qT7ShsvOAPYfDKYTTF2gCDWT6QB59I3/gXf0bLUe6mCH4hci
	 R/ZVMxpBrAy4M1xvf43ZcyiN0KNnlfmx53GNKNvDBRGUH1ZDoRNXZILq8I5SmpEXilyvn
	 u0uTQaurP6uEI1jG1xOBT4xEP/GYWwRXTrzudLjJb7kLmiLs0ac3Ehr+oatPAulRevqKx
	 6azl0/vevhuT00Wq1pKQN2A70hDLn2iTT3orWrZ7qfPfSom5sqWmx6q0X9uNSNyz+vh0C
	 3FSdnK5qHiyxEPSLnV6O2AR1Knq4p9vVclVvmsXu7OqfeDNOL+LqHVEXCAtxuNi9HCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765227;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dtJsbMDToX25UaJkQ9Vjt0xJWTfjICbAooiSfipFqtI=;
	b=ougf9/oNnR1ztQ35ecSyxyNyZ4ZHijsl4/xrDcTwUezIsCQ5bKkBUgw+k5cOVz4nShFd
	 l9NKEEOT/rzATn7pMk0LOMw5tfr3evu8E6j+bjwEucBFT6jLM2W33s2JsZ7+SBDbtbUxO
	 +hy/lLws6juLkTl35HhiEYtmczgQpYi/bU4tE/lj3kih/39FlenUan6K5iTqEutWq8ZLO
	 qu6tiIg6IyPNOgAlhYaaH00dj9jPwA9u3jZwjMTf3o2+RifYBqRS0wmDFBCj88/8a5hvK
	 JXp1VdP2Ay9VfqOgubhmKMXZ9hIvILXZu1S2BGFbLU3srTAxc92oxbLsoU7STAqhHMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1EZiU9s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4E2606A31D;
	Fri, 23 Oct 2026 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1EZiU9s
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792765226;
	b=OhuvNphG5QU84UrWdVp4hyrMJxMZWlTcczqjtP/q083Zgbc0gLEKM4rLUUpI4ii3t+SA
	 e1ANP2+4dz23yzilUSUYIPNfZJi5IG8Z7MBaQQZR/agKyw/Czjv2Ko0YwP5nuRpPI7cCO
	 crBrSD4GCtL06av7zIK0FWcF7ooCoh+AHZJmSCnNDMeGRIyhsKjeGYT/L0pBCLqrsOETp
	 ncXbXJ56DPveuAg51Zum68/YhuSdDAaeaOhomhVoNOaMowdTCraIlrdYWtFpszvZdvQDD
	 FZjv6GwrEfe6mE+W6VXYgJaRiY/b9gMeo6B3wspXSUdjKbld8Fhc/Mb6GENzhpLPgMg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792765226;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=dtJsbMDToX25UaJkQ9Vjt0xJWTfjICbAooiSfipFqtI=;
	b=iiyvnYjxRScfk56YP4iiW848QLiQqU00wLuB3QABfYCBDA4Vbf8DC0AqAaboKWSetKe9
	 B1dRzWhwnadUeWEQf1Z29UlNSRc6QCqBwos5D29PUDatJwcvTs4G+l7oMTOMIW7C522/x
	 zxWYKqJdxf/0cJwLkeVrZ2tFt9s8QHyIE2xp5+cx8sa8E2+Ik79Oa0Y4YGf74AeFU2b+j
	 Xf4cGpKlcTpIWwGTVNBDZtfExJZ60DBZ860MuRamGw4UIc2wZMU0lUZmcCrERI4mwcWW7
	 OUwslXI0uz41e8aAubuAxT+Hu928BPV/NN2PwwTdbSb7ANjYY1JbH65GtjhrJnISspw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 837891F01828;
	Fri, 23 Oct 2026 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792765226;
	bh=dtJsbMDToX25UaJkQ9Vjt0xJWTfjICbAooiSfipFqtI=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=M1EZiU9sjV7lFgoaBhOi4N55VCRCZZs8gaWH61qU7L7U+9P6XhupROzxL2eaCv+FB
	 c1JbRTtoViiUqh8ZqoP/pqnqVab6MHydUknqo59AfmASMYQ/flLcXncEYr8n7wUM9X
	 7a7IHfY3Vt1v1S8VEW7RfgDE9jHvhBowUppDMo7KfUhFxdfFp82QqVEorMHZ2BRzup
	 IE6mILFNi7BzeQPUEjxCBOQR1MTubombSzESoGgNQdxupRZ7D4iWl4jm0Jv1K+M/4j
	 tZ1DDCnpHqGp5DAChQfpVw/7KP61Mr5Icbtj/Is2YkUlXiH0TeZiVxmZzIObUPDGTH
	 6LsAWncZvOR2w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D6EBD4454F;
	Fri, 23 Oct 2026 14:20:24 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Fri, 23 Oct 2026 16:20:19 +0200
Subject: [PATCH v3] i2c: imx: add I2C_M_REV_DIR_ADDR and I2C_M_NOSTART
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261023-for-upstream-i2c-imx-lx2160-reverse-v3-1-a07b249df381@free.fr>
X-B4-Tracking: v=1; b=H4sIACJt22oC/5XPQY7CMAwF0KugrDGKnTZJZzX3GLEIwYFIQJHDV
 EWod5+UkYAlLL8X73/fVGHJXNTX4qaEh1xyf6rBLBcq7sNpx5C3NSvSZLXXDlIv8HsuF+FwhEw
 R8nGEw0hoNVSApTC40DWbrrWI3qsqnYVTHu8tP+ua97lcerneSwecr5/5AwJCImcj+7ixVn8nY
 V4lUbM+0IuI9J5Is4imMQ6b2IbuIS7/f0dN5n1Jm5ACu7bx3j63TdP0B2282+xwAQAA
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Carlos Song <carlos.song@nxp.com>, Haobin Jiang <lemonoutput@foxmail.com>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792765224; l=11530;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=5U+7si5KHQfRi+kyZkNw1CyRUTDh9ShUhHfMbHzoPK8=;
 b=wz5WTmYFk1M5LAaVWF9wi6Sd7J2GLYLZ8358iWYiarw1BE3sVxhZHuICTfMdLtav9VsbDPf8o
 uI003nDXD/1BWlOugHBKPSXVkJM8/rzCUkNCk5XANK2TVXqz8nzyPSY
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr
Content-Transfer-Encoding: 7bit

From: Vincent Jardin <vjardin@free.fr>

The Realtek RTL8366SE SMI read frame per:

  S Addr Rd [A] reg[7:0] [A] reg[15:8] [A] [data[7:0]] A [data[15:8]] NA P

Linux support it using I2C_M_REV_DIR_ADDR on a write message
that inverts the transmitted R/W bit, and I2C_M_NOSTART on the following
read message that continues the frame without re-addressing.

This NXP i2c-imx is missing such support, so on an LX2160A the Realtek switch
could not be used.

Acked-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
Follow the logics from i2c-algo-bit and i2c-s3c2410 (addr ^= 1).

Documentation/i2c/i2c-protocol.rst says I2C_M_NOSTART "may also be used
between direction changes by some rare devices"; the RTL8366SE is one of
such device !

- The NOSTART read turns the bus around without waiting for a completion,
  because the controller stretches SCL after the previous byte and the
  frame is therefore still open. That is what lets i2c_imx_read() enter
  the state the ISR would otherwise have moved to.

- I2C_FUNC_PROTOCOL_MANGLING also covers I2C_M_IGNORE_NAK,
  I2C_M_NO_RD_ACK and I2C_M_STOP, which this driver does not implement.
  They are rejected with -EOPNOTSUPP rather than advertised and silently
  ignored. I2C_M_NOSTART on the first message is rejected as well, and
  so is a NOSTART read after a read.
---
Changes in v3:
- i2c_imx_check_msgs(): reject a NOSTART read that follows a read. The
  controller NACKs the last byte of a read, the target then stops
  transmitting and the continuation would only clock in 0xff.
  From Sashiko on the v2 resend: no known user sends such a sequence,
  and i2c-algo-bit has the same limitation. No other changes.
  I did not want to spend time arguing, it is a safety Sashiko helps with.
- Link to v2: https://lore.kernel.org/r/20261023-for-upstream-i2c-imx-lx2160-reverse-v2-1-03afae754886@free.fr

Changes in v2:
- message validation with i2c_imx_check_msgs() (Carlos Song)
  No functional change
- Link to v1: https://lore.kernel.org/r/20260807-for-upstream-i2c-imx-lx2160-reverse-v1-1-f276ce8cb660@free.fr
---
 drivers/i2c/busses/i2c-imx.c | 157 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 117 insertions(+), 40 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 9477d814fde9..37fd14222b9e 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1000,16 +1000,10 @@ static inline int i2c_imx_isr_write(struct imx_i2c_struct *i2c_imx)
 	return 1;
 }
 
-static inline int i2c_imx_isr_read(struct imx_i2c_struct *i2c_imx)
+static inline void i2c_imx_setup_read(struct imx_i2c_struct *i2c_imx)
 {
-	int result;
 	unsigned int temp;
 
-	result = i2c_imx_isr_acked(i2c_imx);
-	if (result)
-		return result;
-
-	/* setup bus to read data */
 	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
 	temp &= ~I2CR_MTX;
 	if ((i2c_imx->msg->len - 1) || (i2c_imx->msg->flags & I2C_M_RECV_LEN))
@@ -1017,6 +1011,18 @@ static inline int i2c_imx_isr_read(struct imx_i2c_struct *i2c_imx)
 
 	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 	imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR); /* dummy read */
+}
+
+static inline int i2c_imx_isr_read(struct imx_i2c_struct *i2c_imx)
+{
+	int result;
+
+	result = i2c_imx_isr_acked(i2c_imx);
+	if (result)
+		return result;
+
+	/* setup bus to read data */
+	i2c_imx_setup_read(i2c_imx);
 
 	return 0;
 }
@@ -1172,6 +1178,16 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
 	return i2c_imx_master_isr(i2c_imx, status);
 }
 
+static u8 i2c_imx_addr_byte(struct i2c_msg *msg)
+{
+	u8 addr = i2c_8bit_addr_from_msg(msg);
+
+	if (msg->flags & I2C_M_REV_DIR_ADDR)
+		addr ^= 1;
+
+	return addr;
+}
+
 static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 					struct i2c_msg *msgs)
 {
@@ -1200,7 +1216,7 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 	 * Write slave address.
 	 * The first byte must be transmitted by the CPU.
 	 */
-	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
+	imx_i2c_write_reg(i2c_imx_addr_byte(msgs), i2c_imx, IMX_I2C_I2DR);
 	time_left = wait_for_completion_timeout(
 				&i2c_imx->dma->cmd_complete,
 				msecs_to_jiffies(DMA_TIMEOUT));
@@ -1242,14 +1258,20 @@ static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
 	int result;
 	unsigned int temp = 0;
 
-	/* write slave address */
-	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
-	result = i2c_imx_trx_complete(i2c_imx, !use_dma);
-	if (result)
-		return result;
-	result = i2c_imx_acked(i2c_imx);
-	if (result)
-		return result;
+	/*
+	 * I2C_M_NOSTART continues a frame that is already open, so there is
+	 * no address phase: go straight to turning the bus around.
+	 */
+	if (!(msgs->flags & I2C_M_NOSTART)) {
+		/* write slave address */
+		imx_i2c_write_reg(i2c_imx_addr_byte(msgs), i2c_imx, IMX_I2C_I2DR);
+		result = i2c_imx_trx_complete(i2c_imx, !use_dma);
+		if (result)
+			return result;
+		result = i2c_imx_acked(i2c_imx);
+		if (result)
+			return result;
+	}
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> setup bus\n", __func__);
 
@@ -1371,16 +1393,18 @@ static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx,
 	int i, result;
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> write slave address: addr=0x%x\n",
-		__func__, i2c_8bit_addr_from_msg(msgs));
+		__func__, i2c_imx_addr_byte(msgs));
 
-	/* write slave address */
-	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
-	result = i2c_imx_trx_complete(i2c_imx, true);
-	if (result)
-		return result;
-	result = i2c_imx_acked(i2c_imx);
-	if (result)
-		return result;
+	if (!(msgs->flags & I2C_M_NOSTART)) {
+		/* write slave address */
+		imx_i2c_write_reg(i2c_imx_addr_byte(msgs), i2c_imx, IMX_I2C_I2DR);
+		result = i2c_imx_trx_complete(i2c_imx, true);
+		if (result)
+			return result;
+		result = i2c_imx_acked(i2c_imx);
+		if (result)
+			return result;
+	}
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> write data\n", __func__);
 
 	/* write data */
@@ -1402,7 +1426,7 @@ static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx,
 static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
 {
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> write slave address: addr=0x%x\n",
-		__func__, i2c_8bit_addr_from_msg(msgs));
+		__func__, i2c_imx_addr_byte(msgs));
 
 	i2c_imx->state = IMX_I2C_STATE_WRITE;
 	i2c_imx->msg = msgs;
@@ -1411,8 +1435,16 @@ static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
 	/*
 	 * By writing the device address we start the state machine in the ISR.
 	 * The ISR will report when it is done or when it fails.
+	 *
+	 * I2C_M_NOSTART continues a frame that is already open and so has no
+	 * address byte: push the first data byte instead. That raises the same
+	 * interrupt and the ISR carries on from the second byte.
 	 */
-	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
+	if (msgs->flags & I2C_M_NOSTART)
+		imx_i2c_write_reg(msgs->buf[i2c_imx->msg_buf_idx++], i2c_imx,
+				  IMX_I2C_I2DR);
+	else
+		imx_i2c_write_reg(i2c_imx_addr_byte(msgs), i2c_imx, IMX_I2C_I2DR);
 	wait_event_timeout(i2c_imx->queue,
 			   i2c_imx->state == IMX_I2C_STATE_DONE ||
 			   i2c_imx->state == IMX_I2C_STATE_FAILED,
@@ -1529,22 +1561,29 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 
 	dev_dbg(&i2c_imx->adapter.dev,
 		"<%s> write slave address: addr=0x%x\n",
-		__func__, i2c_8bit_addr_from_msg(msgs));
+		__func__, i2c_imx_addr_byte(msgs));
 
 	i2c_imx->is_lastmsg = is_lastmsg;
 
-	if (block_data)
-		i2c_imx->state = IMX_I2C_STATE_READ_BLOCK_DATA;
-	else
-		i2c_imx->state = IMX_I2C_STATE_READ;
 	i2c_imx->msg = msgs;
 	i2c_imx->msg_buf_idx = 0;
 
-	/*
-	 * By writing the device address we start the state machine in the ISR.
-	 * The ISR will report when it is done or when it fails.
-	 */
-	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
+	if (msgs->flags & I2C_M_NOSTART) {
+		i2c_imx->state = block_data ? IMX_I2C_STATE_READ_BLOCK_DATA_LEN
+					    : IMX_I2C_STATE_READ_CONTINUE;
+		i2c_imx_setup_read(i2c_imx);
+	} else {
+		if (block_data)
+			i2c_imx->state = IMX_I2C_STATE_READ_BLOCK_DATA;
+		else
+			i2c_imx->state = IMX_I2C_STATE_READ;
+
+		/*
+		 * By writing the device address we start the state machine in the ISR.
+		 * The ISR will report when it is done or when it fails.
+		 */
+		imx_i2c_write_reg(i2c_imx_addr_byte(msgs), i2c_imx, IMX_I2C_I2DR);
+	}
 	wait_event_timeout(i2c_imx->queue,
 			   i2c_imx->state == IMX_I2C_STATE_DONE ||
 			   i2c_imx->state == IMX_I2C_STATE_FAILED,
@@ -1574,6 +1613,37 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 	return ret;
 }
 
+#define I2C_IMX_UNSUPPORTED_PROTOCOL_MANGLING_FLAGS \
+	(I2C_M_IGNORE_NAK | I2C_M_NO_RD_ACK | I2C_M_STOP)
+
+static int i2c_imx_check_msgs(struct i2c_msg *msgs, int num)
+{
+	int i;
+
+	for (i = 0; i < num; i++) {
+		/* Reject rather than silently transfer */
+		if (msgs[i].flags & I2C_IMX_UNSUPPORTED_PROTOCOL_MANGLING_FLAGS)
+			return -EOPNOTSUPP;
+
+		if (msgs[i].flags & I2C_M_NOSTART) {
+			/*
+			 * NOSTART continues an already open frame. The first
+			 * message has nothing to continue from,
+			 * a 0 length continuation leaves the controller with
+			 * no byte to clock.
+			 */
+			if (i == 0 || msgs[i].len == 0)
+				return -EOPNOTSUPP;
+
+			if ((msgs[i].flags & I2C_M_RD) &&
+			    (msgs[i - 1].flags & I2C_M_RD))
+				return -EOPNOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
 static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 			       struct i2c_msg *msgs, int num, bool atomic)
 {
@@ -1583,6 +1653,10 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(adapter);
 	int use_dma = 0;
 
+	result = i2c_imx_check_msgs(msgs, num);
+	if (result)
+		return result;
+
 	/* Start I2C transfer */
 	result = i2c_imx_start(i2c_imx, atomic);
 	if (result) {
@@ -1604,7 +1678,7 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 		if (i == num - 1)
 			is_lastmsg = true;
 
-		if (i) {
+		if (i && !(msgs[i].flags & I2C_M_NOSTART)) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> repeated start\n", __func__);
 			temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
@@ -1636,7 +1710,8 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 #endif
 
 		use_dma = i2c_imx->dma && msgs[i].len >= DMA_THRESHOLD &&
-			msgs[i].flags & I2C_M_DMA_SAFE;
+			msgs[i].flags & I2C_M_DMA_SAFE &&
+			!(msgs[i].flags & I2C_M_NOSTART);
 		if (msgs[i].flags & I2C_M_RD) {
 			int block_data = msgs->flags & I2C_M_RECV_LEN;
 
@@ -1730,7 +1805,9 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
 static u32 i2c_imx_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
-		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
+		| I2C_FUNC_SMBUS_READ_BLOCK_DATA
+		| I2C_FUNC_NOSTART
+		| I2C_FUNC_PROTOCOL_MANGLING;
 }
 
 static const struct i2c_algorithm i2c_imx_algo = {

---
base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
change-id: 20260807-for-upstream-i2c-imx-lx2160-reverse-7a94b9561188

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>


