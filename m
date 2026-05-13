Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C73E9C0A
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666982; cv=none; b=QV5ukkQlA0kKPICVxmEwfOpkcSKNfBRkKio/XV/WDyz1k9zkZIj75gkHAF3hJRblKaZIB2FKRaAK5oi2bkdN5NQoO6mwkjb7918DMW1t4RXTEo6aIiv3ja//7rdw3SBhTqigWoVdeL55H3hNu/kzRX3lHwT4BJKJ3YEODi9iIcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666982; c=relaxed/simple;
	bh=vYE0xt5ladoi1dJg8uPeJA+CI0rDe1yUCtJxngY5Y/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tUOjTUaTMdWytF980KgVBEI8aNJRmQmsRE4DwKcMPyyQdwfUjfMSaEp2U9kHHLYD8J/XgnXpywKDx4aQOydB2LIK6h5Pa0hQ0RbYg1XhYU0jIRLvtL131mAp1o9ZVw34i+xR81q4KIYGkRl718rGE6N1TbYBdy1L7S/n/UI8vcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=brQ6bArV; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="brQ6bArV"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-13354eb66baso2430890c88.1
        for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 03:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778666966; x=1779271766; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7geQ29k+vP3kqRpnkR89osFPesRjCTgee3KdQw1Yk8=;
        b=brQ6bArVfLf/m8YTCIy08EnRdpGkcxGwHGtVm4ouTgT6ZrdR6cBZAUoX0+QZB5sTUe
         vWwBn1Wp0pmOOxtWA1oxQJb+R4r7dimQLsSaDRx7LxZoHu6d0kbcWk77leeGt2/wOCAF
         hmhq+x8AYZHzPn3FP/B728wM7ZgRyqr646U3Fnza9Lqb63HB++IphEkmK3p0ekeS2QoN
         1X4xE2o5tj2XmZG9uoBIp2hyZjZWaBc1EwqstuzLAJijNDMrpDPGn3dlX2ZP2UzB/MIA
         bEM+ZW0MkjGkcjhHx8BuAYUZjaFaNC8AHLIc92VOSjtX7DPDvtUpnBXLPmDK7DeWE4ly
         2d4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778666966; x=1779271766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g7geQ29k+vP3kqRpnkR89osFPesRjCTgee3KdQw1Yk8=;
        b=q1quuNAn8Hqnj5AbRHAaj3eDjYucgPS1L5Uze4nC20i3O5wZ2WEQGreeKvZ7if/SpF
         iKzHYBELJm0SBNwjtYFhZTrsmf5bG5/EEOQvvs3GqigY9vL4QfqceWBbXMsw2kC5Hb+F
         6V2VnCVthv5069Xntg+L4R6pFcNJevhOvNS12Mo4m1CtWTWpxa1IHKopMyUKnbXvrSDG
         l+CCEY3YyiWep6uoZXcx68aN9wXaIP2fsFzkWFM80ydP5Bd1OUhnJLPjSrPTgkCx3Zp9
         2PjJcYNIGF9EfqTH2N16IvZMpzACkMVclYqrQdQg3M5sbh1FgGxLXlzxHhemXJSx0o6T
         KULQ==
X-Forwarded-Encrypted: i=1; AFNElJ+tuhPNNCRQCebWCywPdf2nxBvYDlz5CbiTd5AZUqKYLJoVNGVI7xpz0hj9NSdNy7BOJ4pgFht1rW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgh4dNeVJwuyw9rzmX7TJZPqHOHdsdd1IqEUFRX65ZXbcw1uT
	r8HOMtHtUJrzq994FhJh8DkwauV0Od8YI/cVFZNXz3M9ZvdzbPoCuSpzVhq9lYlGHhs=
X-Gm-Gg: Acq92OHnPAYmfYeVza+9Lz04L0UJm5rCCimTxQ+HvepQ8V8UoRTBkpJ/+gH5IcaYhHn
	asKm3q6kmWl7GzSu54O/NGifGreuliMvjNJU2X2JQ1L5l1GwJorcoaRYzIG9otPYj7zyA9FbTF3
	FT319R4ng/xEQ4SzGafoNdl4zV8sBakwnsLn6ikqx6hx68qKB4sMU/2eKaKGbblml46MnAm6NRX
	IcoX4gvNBAGSFBQixnw+RUZyyXRAM1UqXzigNHyq0hG/9JjD9wBViJBl+vzMetCKEypVREyn47d
	qAEizsAz8eGf9SkhuXfUWL1zcPdqhtf3QSDYaScjhieGNnz3vT6zox5F2Md27CS5HcaBf49Tuzq
	6e/I1mQL3PpjBq8/dkbFrKF6rlmdg3umr9froByrWfecWN97Nv3o/45jilaymILe/CqBTD1GZwN
	flMTz11z5OZTaM4Ws8ekrO0Gog4U8cTJPKzPxj
X-Received: by 2002:a05:7022:608b:b0:132:5d42:55ba with SMTP id a92af1059eb24-1343677c602mr1602360c88.16.1778666965951;
        Wed, 13 May 2026 03:09:25 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm29430265c88.15.2026.05.13.03.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:09:25 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Wed, 13 May 2026 03:09:22 -0700
Subject: [PATCH v3 1/3] i2c: xiic: preserve PEC byte length in SMBus block
 read setup
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-i2c-xiic-v3-1-ccb3cf70ba03@nexthop.ai>
References: <20260513-i2c-xiic-v3-0-ccb3cf70ba03@nexthop.ai>
In-Reply-To: <20260513-i2c-xiic-v3-0-ccb3cf70ba03@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778666964; l=5594;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=vYE0xt5ladoi1dJg8uPeJA+CI0rDe1yUCtJxngY5Y/M=;
 b=InRJ8GC47z6CGZfH6AUaiklz7fCO/eo9JoqVc/9hW/iT/SqSQac4WrJ16eBgP9B7Gq7DtEIT6
 FVP2FJkUSV8DCTcrfX2MkSjTwNbTA9FOQxwRQ9xmYcaa16VTtjzz9fg
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

xiic_smbus_block_read_setup() recalculates i2c->rx_msg->len based on the
length byte returned by the device, but historically clobbered the PEC
byte expectation the SMBus core had baked into msg->len. That dropped
the PEC byte from the caller's buffer on the normal and chunked
receive-fifo branches.

Compute pec_len up-front as (i2c->rx_msg->len - 1) and add it to the
new length in every branch:

  - chunked (rxmsg_len + pec_len > IIC_RX_FIFO_DEPTH): set the drain
    target to rxmsg_len + 1 + pec_len.

  - deferred (small enough to drain in one fill but >= MIN_LEN total):
    same.

  - padded (1 + rxmsg_len + pec_len < SMBUS_BLOCK_READ_MIN_LEN): the
    hardware needs at least 3 bytes on the bus to exit the read
    cleanly (the second byte is already being clocked in by the time
    the ISR reads the length byte and is too late to NACK), so we
    still pad rx_msg->len up to SMBUS_BLOCK_READ_MIN_LEN. The dummy
    trailing byte that gets drained must then be trimmed off before
    handing the message back to the SMBus core; otherwise
    i2c_smbus_check_pec() reads buf[len-1] (= dummy) instead of the
    real PEC byte at buf[1] and rejects every clean zero-length block
    read with -EBADMSG.

    Record the true valid byte count in a new field
    i2c->smbus_actual_len and have xiic_process()'s RX_FULL completion
    site trim rx_msg->len down to it before clearing rx_msg.

    Widen the branch condition from the old "(rxmsg_len == 1) ||
    (rxmsg_len == 0)" to "(1 + rxmsg_len + pec_len) < MIN_LEN" so that
    user requests with multi-byte trailing bytes (e.g. pec_len == 2 on
    a zero-length block) flow through the deferred branch instead of
    getting truncated to MIN_LEN here.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 3e7735e1dae0..d4308716d461 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -73,6 +73,11 @@ enum i2c_scl_freq {
  * @prev_msg_tx: Previous message is Tx
  * @quirks: To hold platform specific bug info
  * @smbus_block_read: Flag to handle block read
+ * @smbus_actual_len: For SMBus block reads padded to SMBUS_BLOCK_READ_MIN_LEN,
+ *	the number of bytes that are actually valid (length byte + payload +
+ *	optional PEC). msg->len gets trimmed to this on transfer completion so
+ *	the SMBus core sees the real PEC byte and not the trailing dummy.
+ *	Zero when no trimming is needed.
  * @input_clk: Input clock to I2C controller
  * @i2c_clk: I2C SCL frequency
  * @atomic: Mode of transfer
@@ -98,6 +103,7 @@ struct xiic_i2c {
 	bool prev_msg_tx;
 	u32 quirks;
 	bool smbus_block_read;
+	unsigned int smbus_actual_len;
 	unsigned long input_clk;
 	unsigned int i2c_clk;
 	bool atomic;
@@ -539,6 +545,8 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 
 	/* Check if received length is valid */
 	if (rxmsg_len <= I2C_SMBUS_BLOCK_MAX) {
+		unsigned int pec_len = i2c->rx_msg->len - 1;
+
 		/* Set Receive fifo depth */
 		if (rxmsg_len > IIC_RX_FIFO_DEPTH) {
 			/*
@@ -546,23 +554,30 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 			 * Receive fifo depth should set to Rx fifo capacity minus 1
 			 */
 			rfd_set = IIC_RX_FIFO_DEPTH - 1;
-			i2c->rx_msg->len = rxmsg_len + 1;
-		} else if ((rxmsg_len == 1) ||
-			(rxmsg_len == 0)) {
+			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
+		} else if (1 + rxmsg_len + pec_len < SMBUS_BLOCK_READ_MIN_LEN) {
 			/*
-			 * Minimum of 3 bytes required to exit cleanly. 1 byte
-			 * already received, Second byte is being received. Have
-			 * to set NACK in read_rx before receiving the last byte
+			 * Hardware requires at least SMBUS_BLOCK_READ_MIN_LEN
+			 * bytes on the bus to exit the read cleanly: by the
+			 * time the ISR pulls the length byte from the FIFO,
+			 * the second byte is already being clocked in and
+			 * cannot be NACKed in time. Pad the drain target so
+			 * the HW reaches the minimum, but remember the true
+			 * valid byte count and trim msg->len back on transfer
+			 * completion -- otherwise the SMBus core's PEC check
+			 * reads the trailing dummy byte instead of the real
+			 * PEC byte and rejects clean transfers with -EBADMSG.
 			 */
 			rfd_set = 0;
 			i2c->rx_msg->len = SMBUS_BLOCK_READ_MIN_LEN;
+			i2c->smbus_actual_len = 1 + rxmsg_len + pec_len;
 		} else {
 			/*
 			 * When Rx msg len less than Rx fifo capacity
 			 * Receive fifo depth should set to Rx msg len minus 2
 			 */
 			rfd_set = rxmsg_len - 2;
-			i2c->rx_msg->len = rxmsg_len + 1;
+			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
 		}
 		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);
 
@@ -797,6 +812,17 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 
 		xiic_read_rx(i2c);
 		if (xiic_rx_space(i2c) == 0) {
+			/*
+			 * If the setup path padded a short SMBus block read up
+			 * to SMBUS_BLOCK_READ_MIN_LEN for the HW exit
+			 * workaround, trim rx_msg->len back to the number of
+			 * bytes that are actually valid so the SMBus core's
+			 * PEC check reads the right index. Must happen before
+			 * the rx_msg = NULL below.
+			 */
+			if (i2c->rx_msg && i2c->smbus_actual_len)
+				i2c->rx_msg->len = i2c->smbus_actual_len;
+
 			/* this is the last part of the message */
 			i2c->rx_msg = NULL;
 

-- 
2.53.0

