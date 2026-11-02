Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611972;
	b=QwbrR7dPk3L60VyKseLRRWImaZNPjhp9ycFi72pw14Xcuvx/9RrE2+XQnylny28Hc/Sq
	 eQ+LNRt8iCRHSjgvEJ8Ocm+gtWG9I/rypNz95+Ra/EXMbxSlkI5GfxwpbQ/cIRf3LzBw/
	 SeWzQN27yptIKFMVgypQJ/35y6T4xSQBCsJ7WQhin3535EKz8XPQGne73eKUduaXxJUbW
	 u+X8P0MQPACNdLKIJTIJ7OkWP3p3XO6yRug3HvalCspOShFTCFdFh/iLh16DzwyOQ8DzK
	 BN5Z6KLUrHUzAtkrfWvVAembqf+yaes7Q4jJdBnunLC92w6FQYuZwY5d08H+M7/6D+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kA+vTZ/Eeoad9jIjZ1JZy2rB2AcKRzVxwNFQY1s/X5o=;
	b=dLADCWSEQ8UUtSgKtqHekfxvN0EtsmXYBBqraKk6Emq8B2GGSAqqCLzhkWuVbMKWXL7K
	 b36jK4OKJj7KQotKD+GRYXB2IIrUazlSiUstCFW1Bo7pD+KrB/NxUigKmIJxfxOEXSGs4
	 0frbwxGA5f7CNUxlnv8RF0ulxgnfhCOKBybRDC7DpP6mLeqjAM/ARGqTg8crZcOPGvhw4
	 /QaelWe1GybWxXkYwhtP5hE57Wn/9vYMBDnuwBgzDx20bnovrYoGYFWbls8UOTHtIH/Q0
	 DgqeuaV0oDeJVC8An/UynyEc+tJihqsgi1dagvuZo0mTja7eHx44uJE1udy8GgC4w2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cn10GkQr;
	arc=none smtp.remote-ip=74.125.228.71
Received: from mail-ed2-f7.google.com (mail-ed2-f7.google.com [74.125.228.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD5B606A324
	for <linux-i2c@vger.kernel.org>; Mon,  2 Nov 2026 09:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BD5B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cn10GkQr
Received: by mail-ed2-f7.google.com with SMTP id 4fb4d7f45d1cf-6aa912db07bso2283016a12.0
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 01:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793611971; x=1794216771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kA+vTZ/Eeoad9jIjZ1JZy2rB2AcKRzVxwNFQY1s/X5o=;
        b=cn10GkQrQYu6kATy/dwSMsSIU8LXgit6pXqybm2MjT0SGERLcAft/h0umvgGAS0k2q
         rOB1wp/bTPqRe4B8GnhLKIKEgph7WW3a8+3PAG+DS5vAo4jzqbs5MIS4rwwasRIT0xuv
         it7E2n27OrI2UOqOPcHGKBIGJUTxYEw8GuO3IKJ8/0bBlvrjAz9jzPhQ2/vpEeEMqfZp
         9F9N2OqDi2+xgeRoCNol3bqt0KFbTSfUSSC42A6E47GSwGsxDsCT1TBbAa3vpWEEu4Kp
         O+N7mO7EWxLdjt2eU4Y7d/B1Q0faWeZxEnejJMlH3v4mCWqVR5jqOWezSSpZyGvZxHRn
         nMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793611971; x=1794216771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kA+vTZ/Eeoad9jIjZ1JZy2rB2AcKRzVxwNFQY1s/X5o=;
        b=Hr+mxryq7yE6by3ip7GN6YBgu6AWkMVuZmWZSWA6eHXOJtHnRHVfNnri5q8iHdtuzv
         btAFEYj2Pcb9mrtN16gyPJJX7mEW8fL1UaYmW3S2mah+aKqwHHkiFuzwQDtilVo82B5f
         PqxnrA5ziydQgrbG5HaRmGtqNfMYDzObvVxb4PHBMIu63EemqRD28h+MTIagMQmLz+iG
         Uer5XtDLyhXLf5e+ruMNhGa26DB0wDOuzQOZdWs29naEau+hVlk1tVT9mKCFMwhUumDn
         bLoWeHLcDUeEK8KgX71F0f7+4Lw71csPuOKa8XYcR9kc3GVCb0B5wdgKccRTJHruDOx7
         5DYg==
X-Forwarded-Encrypted: i=1; AKwUvBwxkGd9IrS7W5X07C2Ndzflv3i8h2YMFGnCbZpuU326vOwIHdSrkXLS2/W/D/H6GJCN13mwOTQIqig=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HiMV/o7mTIY5DAIBr5RM4Y/NnjwSuIJBOWZgaxWFAr73c6eMq
	HovEuFpC3+0c5fK+5VcriNH63sZSqYecVFvZVQ2oQdOtgXlLNcd865Sbr/nS28hS
X-Gm-Gg: AYBFou2TwDlmE3B6yTUeyCKIw4wysT/6HJI14HC0lJDluAtXbOI9XIlwy79geglV3g3
	3WF1p0Q3ek+LmbdN0XG1kI+k2Gmz8zEMzWSPf0QGEwkTu2pDe+3ScqEEzue9/UA9gikDqO11JmV
	0HMUXzVT3bqhu60XlUCp3I9LIx2EM1s34Oj05yfklPLF5BJH+ieVS91qlhPrszMYCN9u8MFGE6c
	kTD/9D0G8G67lx8S3v52fnsNQbsrdCExyr9iWMQBXceSDNTSXzRE842Vgydo8dGknp789Ijo0oY
	eDSG4+BqnTjBognFgcRar+yuISpeNLP+XVADd3Rzz1oUJD98leKgYAA3oCXjmSVUHxGLOu4JjMc
	H5RBTTw+TL8ftAlMENUJ7LxzG2kmTjKwfCo4w7g/RsYZC+lAsEiwqJNtPIky278Uska4IwwkCeu
	kxLFHlPWrJyXlZopcShSqw8HY9KtYI/TGeheKzOOEzLYj4NP8CErxu3HGaOM4NMBemHlhEIoQ/c
	Ll0gLJIbHLtOQgmDL4l/QeI9UqcrZwEgSpW7QHzfYH5GZw2bPeeXg1RGPSRfJ0PB2yS972QDsRS
	UtlDAvQq6zoFfqQ56sG448sGsc+I0VdIsNWF8gCMa1JglWW4xoahzNzfNqChJj9PNoraKHQ7yvM
	EDP3p/K+TR74M9SUO2wgyjfPN1gG7WL/LbxKEQSbl6RR/V8PIULYom5iZ
X-Received: by 2002:aa7:c618:0:b0:6b1:c6fa:c45c with SMTP id 4fb4d7f45d1cf-6b4d60d6045mr5299690a12.38.1793611970629;
        Mon, 02 Nov 2026 01:32:50 -0800 (PST)
Received: from thi-server.fritz.box (dslb-092-076-089-226.092.076.pools.vodafone-ip.de. [92.76.89.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4eca0f2a0sm3214273a12.25.2026.11.02.01.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:32:49 -0800 (PST)
From: Thilo Zirnstein <thi.zirnstein@gmail.com>
To: michal.simek@amd.com,
	andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thilo Zirnstein <thi.zirnstein@gmail.com>
Subject: [PATCH v4 1/2] i2c: i2c-xiic: fix clearing of bnb irq
Date: Mon,  2 Nov 2026 10:32:27 +0100
Message-ID: <20261102093228.2751576-2-thi.zirnstein@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102093228.2751576-1-thi.zirnstein@gmail.com>
References: <20261102093228.2751576-1-thi.zirnstein@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function for clearing the bnb bit,
It waits for all preconditions before clearing the bnb bit or times out.

Signed-off-by: Thilo Zirnstein <thi.zirnstein@gmail.com>
---
 drivers/i2c/busses/i2c-xiic.c | 40 ++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index ba560462d451..e68e17bdf0ba 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -233,6 +233,8 @@ static const struct timing_regs timing_reg_values[] = {
 #define XIIC_RESET_MASK             0xAUL
 
 #define XIIC_PM_TIMEOUT		1000	/* ms */
+/* timeout waiting for bus busy */
+#define XIIC_BB_TIMEOUT_US	1000
 /* timeout waiting for the controller to respond */
 #define XIIC_I2C_TIMEOUT	(msecs_to_jiffies(1000))
 /* timeout waiting for the controller finish transfers */
@@ -394,6 +396,30 @@ static int xiic_wait_tx_empty(struct xiic_i2c *i2c)
 	return 0;
 }
 
+static void xiic_clear_en_bnb(struct xiic_i2c *i2c)
+{
+	u8 sr = 0, isr = 0;
+	int ret;
+
+	isr = xiic_getreg8(i2c, XIIC_IISR_OFFSET);
+	if (!(isr & XIIC_INTR_BNB_MASK)) {
+		xiic_irq_en(i2c, XIIC_INTR_BNB_MASK);
+		return;
+	}
+
+	ret = read_poll_timeout_atomic(xiic_getreg8, sr,
+			sr & XIIC_SR_BUS_BUSY_MASK, 0, XIIC_BB_TIMEOUT_US, 0,
+			i2c, XIIC_SR_REG_OFFSET);
+
+	if (ret) {
+		dev_err(i2c->dev, "Failed to clear bnb\n");
+		return;
+	}
+
+	xiic_setreg8(i2c, XIIC_IISR_OFFSET, XIIC_INTR_BNB_MASK);
+	xiic_irq_en(i2c, XIIC_INTR_BNB_MASK);
+}
+
 /**
  * xiic_setclk - Sets the configured clock rate
  * @i2c: Pointer to the xiic device structure
@@ -883,9 +909,6 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 	}
 
 	if (pend & XIIC_INTR_BNB_MASK) {
-		/* IIC bus has transitioned to not busy */
-		clr |= XIIC_INTR_BNB_MASK;
-
 		/* The bus is not busy, disable BusNotBusy interrupt */
 		xiic_irq_dis(i2c, XIIC_INTR_BNB_MASK);
 
@@ -1030,7 +1053,7 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 
 		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET, val);
 
-		xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
+		xiic_clear_en_bnb(i2c);
 	} else {
 		/*
 		 * If previous message is Tx, make sure that Tx FIFO is empty
@@ -1097,7 +1120,7 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 
 	if (i2c->nmsgs == 1)
 		/* very last, enable bus not busy as well */
-		xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
+		xiic_clear_en_bnb(i2c);
 
 	/* the message is tx:ed */
 	i2c->tx_pos = msg->len;
@@ -1181,11 +1204,11 @@ static void xiic_start_send(struct xiic_i2c *i2c)
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
@@ -1227,8 +1250,9 @@ static void xiic_start_send(struct xiic_i2c *i2c)
 
 		/* Clear any pending Tx empty, Tx Error and then enable them */
 		xiic_irq_clr_en(i2c, XIIC_INTR_TX_EMPTY_MASK |
-				XIIC_INTR_TX_ERROR_MASK |
-				XIIC_INTR_BNB_MASK);
+				XIIC_INTR_TX_ERROR_MASK);
+
+		xiic_clear_en_bnb(i2c);
 	}
 
 	i2c->prev_msg_tx = true;
-- 
2.43.0

