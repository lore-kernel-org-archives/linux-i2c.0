Received: from mail-ed2-f4.google.com (mail-ed2-f4.google.com [74.125.228.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870FE37B40E
	for <linux-i2c@vger.kernel.org>; Mon, 12 Oct 2026 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813897; cv=none; b=hjqYI2/3QWzNUhlkPaFdSnoJSbWjQ5w0ZdVQe5xAiBr++/j64lJ452FAS57F0esu8Uj7+iKfBzxZTdNTq7DIJHy00KyHmPKmHEYnuUC1yQCsWs5nw2zgeqK0f4ahlNtB1R7sstoMx85m1JSWMsY2bDcTPm6GY28adQuuaWFdoC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813897; c=relaxed/simple;
	bh=YGwGd3X0wSlJYpWucqcz7XGqmn7cqVxfCQw20hQUoTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jYitwziygVA3sh26Zv0RMu7CHLtfTgkl9uqcPk/INOOuCQmLe1xB3HUFGxePbubBwwyZqYT3lDnHEjZJfC5CqXWAlQY/sbTXFlAJrRcDaEVVdlI5esrG90WbXI9VdJrlt+b3sg1hO+yp9jmoYt8bDYQH6eg63rwnlPG+Ue5RW+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b91hVPw5; arc=none smtp.client-ip=74.125.228.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b91hVPw5"
Received: by mail-ed2-f4.google.com with SMTP id 4fb4d7f45d1cf-6afe183a704so1174340a12.1
        for <linux-i2c@vger.kernel.org>; Mon, 12 Oct 2026 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791813894; x=1792418694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pDbDDRw5NqCQFjKs4W4BF9IGnUoJVxd/s6rpPe+Ky2M=;
        b=b91hVPw5wbjT3eqAnV5A6QTayLzc/zDSFwfJXilQnSFbJIeqjguBrDr/EqiNdqwGEE
         lbyRZXJX3nQY0xd1DfMAuwq/esMulnuA8nx+GUBsjWz3a/J+QHuothbJ6/oHEu/MUcNU
         cHjnvUq0xJMdALKd5/fDnkVR8HcxOWil6ixJjzq9iflo/gwIhE3dB8XCxBs1Z6fS2Jzs
         HrSjsyEo8/UPxBNJ7MnTfgeLTL5Rgq4LMQAb8uiYmshJWjefBZbEgVW5+JK+4zHMA6Z6
         SlwMDD0W1TXUOvLt4c02ITQE569kKIWcwat19Qt2KPwY4lZcTcmY17RDoMqEB1V+SYQc
         NKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791813894; x=1792418694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pDbDDRw5NqCQFjKs4W4BF9IGnUoJVxd/s6rpPe+Ky2M=;
        b=TT760ymZOKF32/79dtgpZIK42OBhOROxlhqiQ7H1EinFtmm82lQ/w6gfvStndY1jYY
         AMZpl9wdZpJyoG5SxUAzmz4FlDyTnNhEs2XfKe5G/nPdh6glPxVsZF8pyFRK6eOP5iQn
         jzHmv/5791cVYw1BWOQ7N3rEmrFPhE09oZmiZ43VOxxrcx5fbjCiieaCkmHv4h0iihJY
         pKBBzsVVGnwT3UaFZoLzGXLC2BBDQ4O3VKbPHbzSXs5jgyiVY+TbuQ+dvQj5UtoOpDWM
         OwPo4GnuSwwL2o5V9dHxNlw6FCpTklQ6jqKuy10kgwG4NPEscce1/mSKI4q1GHqw2ukc
         DcYw==
X-Forwarded-Encrypted: i=1; AKwUvBz04NBD4Fh/gDibGxHc+d6mvWzpO1F7O9/dq0OQawe9H33dHjnKQ70XUEpdQJFv5g8mk6Q1Fb6H3/Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUPLBAtB02KwbYmLtD6qbfGr//yC/0ljU207IvqBExLySDGaYf
	8pa5msnERn6RQRbbAykf07SuXkU63cj5J0vcMNnAr6ey4DWSAPzCJvmD
X-Gm-Gg: AYBFou0N7XHfvG9tJb96YxeBxIi/c4kD9qV/Q5xwqD28jkD9YmlvBZfZoSRzpmuhMZT
	u0dN3C0KJ29YOGDn7upMTAIEjYg/Cel+glIqYLvv7rDZ7RC5QrBxSjm/boT1GZSX4S16yiIOR4f
	3jUK/sD04vQj11HZrLa0FaMxreIFaTvojWedMfw5Ao3ISVdP9UJAeXILVKOnj/yOpLrAT7osIX1
	rgmOMNo8Hodq5ztB0Xbpyo+pXQ9fQxpbuGcG2jPOkhHVgzW+v3BmVBKa8DjUpC+BqT2J0z+Urp7
	hT5KDdkvmHDrhoQns/zmKy/UJ85XOgQzP7Lrwt7UUHfKALDhKgsmNjGL4dm2qS+MLGvJbbUpuMW
	8ODJTtpVwXIttIzACNFdMAvuBL/EVpfgfyWMyWcPmWNmWkpq1oJE94cb5QwA27ttkmWoCJ0eyqG
	RWp1U/8TthKe/c8FYMFSUHOPW5q97AfyyO0miBWZGTg4Pi/5bft65Xknsv/BOl2PgIi2jKkLGyy
	rwk+DzmVo0q11wglsw+fubXTp9b9Fzr+8a3nSbd0u6kxbZatzt5S0V/UzMMGOQoKZy7NDp3B0/L
	vm4+sy/WUeKOrFkqB/R2kdWxFg==
X-Received: by 2002:a05:6402:2347:b0:6b1:b75e:e0ba with SMTP id 4fb4d7f45d1cf-6b1b75ee465mr3517228a12.28.1791813892505;
        Mon, 12 Oct 2026 07:04:52 -0700 (PDT)
Received: from thi-server.fritz.box (dslb-092-076-089-226.092.076.pools.vodafone-ip.de. [92.76.89.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b1c1d9fc0esm1477287a12.4.2026.10.12.07.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:04:51 -0700 (PDT)
From: Thilo Zirnstein <thi.zirnstein@gmail.com>
To: michal.simek@amd.com,
	andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thilo Zirnstein <thi.zirnstein@gmail.com>
Subject: [PATCH 1/1] i2c: i2c-xiic: fix clearing of bnb irq
Date: Mon, 12 Oct 2026 16:04:44 +0200
Message-ID: <20261012140444.1195207-1-thi.zirnstein@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes the clearing routine for the bus not busy (bnb) irq.

The bnb is used to indicate that the current transfer is done.

A high level view of the software flow for tx:

* init i2c controller
* prepare all registers ( fill fifo, enable irqs, ... )
* start i2c txfer
* clear and enable bnb
* wait for completion
* ( serve interrupts )
* ( bnb interrupt ): complete completion

The datasheet ( pg090-axi-iic, Interrupt-Status-Register ISR)
states that the bnb bit can only be cleared if
the bus busy bit in the status register is set.

So the iic controller must have recognized that their is some activity
on the bus. ( Start condition )

Currently the bnb bit is cleared without checking or waiting for this
condition. This can lead to spurious bnb interrupts.

This commit introduces a function for clearing the bnb bit,
which waits for all preconditions and clears the bnb bit or times out.

Tested on Zynqmp dev board with some custom logic.

Tested-by: Thilo Zirnstein <thi.zirnstein@gmail.com>

Signed-off-by: Thilo Zirnstein <thi.zirnstein@gmail.com>
---
 drivers/i2c/busses/i2c-xiic.c | 103 ++++++++++++++++------------------
 1 file changed, 48 insertions(+), 55 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 5e397a7e63f6..de463d356bff 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -73,9 +73,6 @@ enum i2c_scl_freq {
  * @prev_msg_tx: Previous message is Tx
  * @quirks: To hold platform specific bug info
  * @smbus_block_read: Flag to handle block read
- * @smbus_actual_len: Valid byte count (length + payload + optional PEC) of a
- *	padded SMBus block read. msg->len is trimmed to this on completion.
- *	Zero when no trimming is needed.
  * @input_clk: Input clock to I2C controller
  * @i2c_clk: I2C SCL frequency
  * @atomic: Mode of transfer
@@ -101,7 +98,6 @@ struct xiic_i2c {
 	bool prev_msg_tx;
 	u32 quirks;
 	bool smbus_block_read;
-	unsigned int smbus_actual_len;
 	unsigned long input_clk;
 	unsigned int i2c_clk;
 	bool atomic;
@@ -230,7 +226,9 @@ static const struct timing_regs timing_reg_values[] = {
 
 #define XIIC_RESET_MASK             0xAUL
 
-#define XIIC_PM_TIMEOUT		1000	/* ms */
+#define XIIC_PM_TIMEOUT 1000 /* ms */
+/* timeout waiting for bus busy */
+#define XIIC_BB_TIMEOUT		(msecs_to_jiffies(1))
 /* timeout waiting for the controller to respond */
 #define XIIC_I2C_TIMEOUT	(msecs_to_jiffies(1000))
 /* timeout waiting for the controller finish transfers */
@@ -392,6 +390,30 @@ static int xiic_wait_tx_empty(struct xiic_i2c *i2c)
 	return 0;
 }
 
+static int xiic_clear_en_bnb(struct xiic_i2c *i2c)
+{
+	u8 sr = 0, isr = 0;
+	unsigned long timeout;
+
+	timeout = jiffies + XIIC_BB_TIMEOUT;
+	for (isr = xiic_getreg8(i2c, XIIC_IISR_OFFSET);
+		(isr & XIIC_INTR_BNB_MASK);
+		isr = xiic_getreg8(i2c, XIIC_IISR_OFFSET)) {
+
+		sr = xiic_getreg8(i2c, XIIC_SR_REG_OFFSET);
+		if (sr & XIIC_SR_BUS_BUSY_MASK)
+			xiic_setreg8(i2c, XIIC_IISR_OFFSET, XIIC_INTR_BNB_MASK);
+
+		if (time_after(jiffies, timeout)) {
+			dev_err(i2c->dev, "Failed to clear bnb\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	xiic_irq_en(i2c, XIIC_INTR_BNB_MASK);
+	return 0;
+}
+
 /**
  * xiic_setclk - Sets the configured clock rate
  * @i2c: Pointer to the xiic device structure
@@ -543,38 +565,30 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 
 	/* Check if received length is valid */
 	if (rxmsg_len <= I2C_SMBUS_BLOCK_MAX) {
-		unsigned int pec_len = i2c->rx_msg->len - 1;
-
 		/* Set Receive fifo depth */
-		if (rxmsg_len + pec_len > IIC_RX_FIFO_DEPTH) {
+		if (rxmsg_len > IIC_RX_FIFO_DEPTH) {
 			/*
-			 * Trailing bytes (payload plus any PEC) exceed Rx FIFO
-			 * capacity, so drain in chunks. This also keeps the
-			 * else branch below from pushing rfd_set past the
-			 * 4-bit XIIC_RFD_REG_OFFSET field.
+			 * When Rx msg len greater than or equal to Rx fifo capacity
+			 * Receive fifo depth should set to Rx fifo capacity minus 1
 			 */
 			rfd_set = IIC_RX_FIFO_DEPTH - 1;
-			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
-		} else if (1 + rxmsg_len + pec_len < SMBUS_BLOCK_READ_MIN_LEN) {
+			i2c->rx_msg->len = rxmsg_len + 1;
+		} else if ((rxmsg_len == 1) ||
+			(rxmsg_len == 0)) {
 			/*
-			 * The HW needs SMBUS_BLOCK_READ_MIN_LEN bytes on the
-			 * bus to exit cleanly: by the time the ISR reads the
-			 * length byte the second byte is already being clocked
-			 * in, too late to NACK. Pad the drain target and record
-			 * the real length, trimmed back on completion so the
-			 * PEC check sees the right byte.
+			 * Minimum of 3 bytes required to exit cleanly. 1 byte
+			 * already received, Second byte is being received. Have
+			 * to set NACK in read_rx before receiving the last byte
 			 */
 			rfd_set = 0;
 			i2c->rx_msg->len = SMBUS_BLOCK_READ_MIN_LEN;
-			i2c->smbus_actual_len = 1 + rxmsg_len + pec_len;
 		} else {
 			/*
-			 * All trailing bytes fit in the Rx FIFO. Defer RX_FULL
-			 * until every one of them is buffered, so the drain
-			 * takes xiic_read_rx()'s bytes_rem == 0 path.
+			 * When Rx msg len less than Rx fifo capacity
+			 * Receive fifo depth should set to Rx msg len minus 2
 			 */
-			rfd_set = rxmsg_len + pec_len - 1;
-			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
+			rfd_set = rxmsg_len - 2;
+			i2c->rx_msg->len = rxmsg_len + 1;
 		}
 		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);
 
@@ -587,16 +601,6 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 	dev_err(i2c->adap.dev.parent, "smbus_block_read Invalid msg length\n");
 }
 
-/*
- * Undo the setup-time padding of a short SMBus block read before rx_msg is
- * cleared, so the PEC check sees the right byte.
- */
-static void xiic_smbus_trim_len(struct xiic_i2c *i2c)
-{
-	if (i2c->rx_msg && i2c->smbus_actual_len)
-		i2c->rx_msg->len = i2c->smbus_actual_len;
-}
-
 static void xiic_read_rx(struct xiic_i2c *i2c)
 {
 	u8 bytes_in_fifo, cr = 0, bytes_to_read = 0;
@@ -819,8 +823,6 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 
 		xiic_read_rx(i2c);
 		if (xiic_rx_space(i2c) == 0) {
-			xiic_smbus_trim_len(i2c);
-
 			/* this is the last part of the message */
 			i2c->rx_msg = NULL;
 
@@ -881,19 +883,13 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 	}
 
 	if (pend & XIIC_INTR_BNB_MASK) {
-		/* IIC bus has transitioned to not busy */
-		clr |= XIIC_INTR_BNB_MASK;
-
 		/* The bus is not busy, disable BusNotBusy interrupt */
 		xiic_irq_dis(i2c, XIIC_INTR_BNB_MASK);
 
 		if (i2c->tx_msg && i2c->smbus_block_read) {
 			i2c->smbus_block_read = false;
-			/*
-			 * Drive xiic_tx_space() to 0 to signal STATE_DONE
-			 * without truncating the rx_msg length.
-			 */
-			i2c->tx_pos = i2c->tx_msg->len;
+			/* Set requested message len=1 to indicate STATE_DONE */
+			i2c->tx_msg->len = 1;
 		}
 
 		if (!i2c->tx_msg)
@@ -965,7 +961,6 @@ static void xiic_recv_atomic(struct xiic_i2c *i2c)
 			return;
 	}
 
-	xiic_smbus_trim_len(i2c);
 	i2c->rx_msg = NULL;
 	xiic_irq_clr_en(i2c, XIIC_INTR_TX_ERROR_MASK);
 
@@ -983,9 +978,6 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 	u8 cr = 0, rfd_set = 0;
 	struct i2c_msg *msg = i2c->rx_msg = i2c->tx_msg;
 
-	/* A stale value from an aborted block read would truncate this msg. */
-	i2c->smbus_actual_len = 0;
-
 	if (!i2c->atomic)
 		dev_dbg(i2c->adap.dev.parent, "%s entry, ISR: 0x%x, CR: 0x%x\n",
 			__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
@@ -1028,7 +1020,7 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 
 		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET, val);
 
-		xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
+		xiic_clear_en_bnb(i2c);
 	} else {
 		/*
 		 * If previous message is Tx, make sure that Tx FIFO is empty
@@ -1095,7 +1087,7 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 
 	if (i2c->nmsgs == 1)
 		/* very last, enable bus not busy as well */
-		xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
+		xiic_clear_en_bnb(i2c);
 
 	/* the message is tx:ed */
 	i2c->tx_pos = msg->len;
@@ -1179,11 +1171,11 @@ static void xiic_start_send(struct xiic_i2c *i2c)
 		/* Clear any pending Tx empty, Tx Error and then enable them */
 		xiic_irq_clr_en(i2c, XIIC_INTR_TX_EMPTY_MASK |
 				XIIC_INTR_TX_ERROR_MASK |
-				XIIC_INTR_BNB_MASK |
 				((i2c->nmsgs > 1 || xiic_tx_space(i2c)) ?
 				XIIC_INTR_TX_HALF_MASK : 0));
 
 		xiic_fill_tx_fifo(i2c);
+		xiic_clear_en_bnb(i2c);
 	} else {
 		/*
 		 * If previous message is Tx, make sure that Tx FIFO is empty
@@ -1225,8 +1217,9 @@ static void xiic_start_send(struct xiic_i2c *i2c)
 
 		/* Clear any pending Tx empty, Tx Error and then enable them */
 		xiic_irq_clr_en(i2c, XIIC_INTR_TX_EMPTY_MASK |
-				XIIC_INTR_TX_ERROR_MASK |
-				XIIC_INTR_BNB_MASK);
+						XIIC_INTR_TX_ERROR_MASK);
+
+		xiic_clear_en_bnb(i2c);
 	}
 
 	i2c->prev_msg_tx = true;
-- 
2.43.0

