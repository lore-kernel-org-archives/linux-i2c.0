Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792742728;
	b=XmOT+h37yDazs09v6iIPEhfORqYB31FYLDoGf/cSFSEY2zhb6opbdOP2r4IRvW8dLF5E
	 0FbhFOdO+zFnhZ3GgfjM0Bsmo1ldEnkhQYM4yoRJXlrT67HV8LnSQT+0vL0lz+CjiCt2y
	 z9LGRV6og1bStS5wb5sejbhVaoDfwG+2MF0r/fqqvijfD5nNn8Lyn1PPWzM7IAf+Bdyw9
	 XClyTTkRi5ij2L2ho89KPb/avG0eqiqaPXg5X8hfd9fqWEyCiguUwSPIg/Gq/+cbn+YZ5
	 oSW0/pYdy0+ak1OEwQ9R9dposQWWpBxDh23saGIeM0ov4Jua0N1xhkJUfN9sLNQUJng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742728;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=We23a8YmV1MydTQVOVcqW5epbVH/tjYZRWEjKwty+fM=;
	b=MPf3rhoW4IAblylMxvZd2vQO2qsk9LKet3lR7LwQa7VrKhlwOLQxuhnvaj1ydFtDVMFd
	 W+Io7Vji+QhDzC7F9F6914CKCRvSED2vO68Fb8q+bV1SuxvaqRFhbTr9B4321tNKQN7KF
	 kReZ55zNl9vohOAW7pvqh8K9fhuHHd9HjEEbOuVo0lKdJjOc7EAzYfdljUZaCmWcxLyoJ
	 bnvhaKrYti0LQDe/9YtWc3x1/CCUmIkkC3qwSZIDxa0dEZV0wWBcOOiG65NsYXWZ9Ix7h
	 Dc18Bl91B48z1xlqJl10weF1GopIxTA6vptKeIAD4e5dvE0QmUiaydoPSBCccyOMq+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGB6SWuA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718AC606A329;
	Fri, 23 Oct 2026 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGB6SWuA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792742728;
	b=gMXJA8mkimIiyQlQeTVw0ROx5LVm+XKrMmmefdGxSn7QkruadJUME6p2s/BzkQy7V/jJ
	 nYyGkBXl5kEVh//8rTYc6XEuPdU91+u2NSKqZaACQ5U2UYvDftF/xX8Gzd+/+m8dQBkw2
	 uO96w+Hni/8aZlBd2IFy8dmvpdu83k7RiT54w56mp47HfT8+SqnreGH/9kX0hR72AWvhN
	 Qb1onsN9YEyLHTJ/GdEwtr6gLtuU/4jGNFlyfHYcTvHa+csh73h5CZbty3Zb2XyNo3I6V
	 6qcoES95gwSLBNr3t2SX6qIRc8NfA93EWWMon6kWh6dsVXLTzUFqy9RVqGaUE/3u8HA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792742728;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=We23a8YmV1MydTQVOVcqW5epbVH/tjYZRWEjKwty+fM=;
	b=V/GeItG80FoTyn+xXvb2SZCwxvM02v6jVogLvRCKZmA8pPr6s1ByGMYmwGR7dbQIThd0
	 9G0k1cvRWxj/tMGYDYpTgs5SVs0UwroAyH3Sjil/wkx1N4Vhdrp1ZAbMt1xC+Cl07zklU
	 n4N5AsVXLUX1o2E7loxsakm4Q1FVf+C58x7uNja0jgUW5DgKkdMclue0YrgvslES/WMVC
	 +0TgZabe08hcvkcpxS3M8K3BTQAbr5cTcwIlzrx3fGhHH8pSeadH34/d0iyoXDq9sPJO7
	 Sy2CCaa7ng96Xzg6JHh2wH1rL7tXBkN0g5QsATytMODDyEfpv2Tmb8pdUc/CFoktsXg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 892AC1F01829;
	Fri, 23 Oct 2026 08:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792742728;
	bh=We23a8YmV1MydTQVOVcqW5epbVH/tjYZRWEjKwty+fM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=QGB6SWuA+f/m7Aa9vJN4SrijDRuss5lLsUXtl7iR7KlESLa1CDandkgh1/HA6D6MQ
	 e9NTZJIfBgyuu1ejFLCnKi2LRwTP3l+TIN+u62q1V6d4MgKZreqTADCiQOZxdSL0M7
	 ORmSaf/4RXSycmd0MfGwDr2NpfQe4ySp5HPqwJekCO1G1H9mUCZ4eeGHSqEkBMjDVH
	 UudBVuSPpmkmkjQczZCH1yiSFOtmtxWtWGX+i5dRCxV1VxtcnWLnGPdqzuszJsDvpu
	 MxNBcZcs9os/sVMVOORwmRsu8oJcAmRAMrnrRERfREQ8VYZu7HjEhfZ5vyz6UJswC8
	 h9HLHJMvvXmSQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 182F04440C;
	Fri, 23 Oct 2026 08:05:27 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Fri, 23 Oct 2026 10:05:15 +0200
Subject: [PATCH RESEND v2] i2c: imx: add I2C_M_REV_DIR_ADDR and
 I2C_M_NOSTART
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
Message-Id: <20261023-for-upstream-i2c-imx-lx2160-reverse-v2-1-03afae754886@free.fr>
X-B4-Tracking: v=1; b=H4sIADoV22oC/5XNMQ+CMBCG4b9iOnumd0IBJwddHXQ0DlCv2kTFX
 JFgCP/dyqKjjt9d8ry9Ciyeg1pMeiXc+uDrWxw0nSh7Lm8nBn+MW5Emo3OdgasFHvfQCJdX8GT
 BXzu4dIRGQwRYAkNWFklVpAYxz1WU7sLOd2Nlr7br3XqzUod4P/vQ1PIc4y2O3786LQKCo8xYz
 m1ljF46YZ45GfWWvkSk30R6izhP5hkmNi2LjzgMwwvyGOJULgEAAA==
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Carlos Song <carlos.song@nxp.com>, Haobin Jiang <lemonoutput@foxmail.com>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792742726; l=11255;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=WiWfwJ6/hA56r4jsG0++u+NW6uZ/JjT3AlfhiASLboY=;
 b=nG6AqkL29THn9RuOUVPetlCnVX8fKnK6GM6H+zBVQaCymdlXjyJ6u8b7hdh0QQs8YpBIxI7nv
 9V3/EuC2gW1CiPwSCWelc6PdFGVV4jCICRCKb5BBDkImDg8tIfn/5iS
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
  ignored. I2C_M_NOSTART on the first message is rejected as well.
---
RESEND:
- No change since v2 of 2026-08-12, only added:
  Acked-by from Carlos Song and Reviewed-by from Frank Li
- Resent as a new thread
- Haobin Jiang's "i2c: imx: honour I2C_M_IGNORE_NAK" v3 is built on top of it:
  https://lore.kernel.org/r/tencent_342A87BFCECA70C9982E68A79AAD878B6909@qq.com
- Link to v2: https://lore.kernel.org/r/20260812-for-upstream-i2c-imx-lx2160-reverse-v2-1-f1343714c5a9@free.fr

Changes in v2:
- message validation with i2c_imx_check_msgs() (Carlos Song)
  No functional change
- Link to v1: https://lore.kernel.org/r/20260807-for-upstream-i2c-imx-lx2160-reverse-v1-1-f276ce8cb660@free.fr
---
 drivers/i2c/busses/i2c-imx.c | 153 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 113 insertions(+), 40 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 9477d814fde9..7dc9c43673ee 100644
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
@@ -1574,6 +1613,33 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
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
+		}
+	}
+
+	return 0;
+}
+
 static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 			       struct i2c_msg *msgs, int num, bool atomic)
 {
@@ -1583,6 +1649,10 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(adapter);
 	int use_dma = 0;
 
+	result = i2c_imx_check_msgs(msgs, num);
+	if (result)
+		return result;
+
 	/* Start I2C transfer */
 	result = i2c_imx_start(i2c_imx, atomic);
 	if (result) {
@@ -1604,7 +1674,7 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 		if (i == num - 1)
 			is_lastmsg = true;
 
-		if (i) {
+		if (i && !(msgs[i].flags & I2C_M_NOSTART)) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> repeated start\n", __func__);
 			temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
@@ -1636,7 +1706,8 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 #endif
 
 		use_dma = i2c_imx->dma && msgs[i].len >= DMA_THRESHOLD &&
-			msgs[i].flags & I2C_M_DMA_SAFE;
+			msgs[i].flags & I2C_M_DMA_SAFE &&
+			!(msgs[i].flags & I2C_M_NOSTART);
 		if (msgs[i].flags & I2C_M_RD) {
 			int block_data = msgs->flags & I2C_M_RECV_LEN;
 
@@ -1730,7 +1801,9 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
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


