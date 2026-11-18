Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996736;
	b=a/JN2W/xLfMECZqdtPTknpc5VFCWYUtP5A/JcnKnD9BuB0sjdtQfytmC/i8h3y52fT7L
	 ZyB7yBqaxs2N30yh56vAmDNiVEmTdFZ77oE/yvKnM2UcWkSHPNlXKpCiUxFoijHxIDJZ9
	 pmCe5ZOxUYPQecm5botqcnYlzFSvunVjGCuXSFbtUN/cZRnzCr8eZW5OdiO6BtWfVx7e4
	 MLbqGIMeQeHQzokMz4DPSdNKCaEre75bD3O9Ng1bDjoizMsSZUizcAmcDL6IPG4cmUlgR
	 bMHWuOlBJ8/OnFWnVaCzC8bU9XO+rBXo4zELoZobA0bGZBP4FMNDEh9ARbwk3a1cPDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=urL0eMB5iRPIEjTLq6WXSe5g/qGCtlbh75jFBqhB950=;
	b=yvsRcQibrymp25qyuW034n+zFPjZsTBhYi2kK68Qx6RGjmV41VLFpgMNFSK9t0ezgNoR
	 f6wSPSB7IyEqCS8Xzk7x8HtqbmiIvCmvcCyukN+zAAlz/IzFp7QdYwQh8f3ZXAMgG6yH4
	 AdaPrRI6vKs7n84QAezRPs9p4I52S1oPXu8xCwCTJmjCItO7JYKBL5ouzVc/8+P0l//14
	 nMGhuMxHpkHpldLu986QyTkSIOuDt0kI2ULaia/NwsiWm6ELBEqkggHmGAVSqZOIeQSZI
	 eBz0pbMLjVsOcEAZQ4fyC85kGnvCkw/xohKlzx6Nxi1mhO1hUjKcEokIWORyS5t6V/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BciwCkhS;
	arc=none smtp.remote-ip=74.125.228.139
Received: from mail-ej2-f11.google.com (mail-ej2-f11.google.com [74.125.228.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675F9606A32C
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 10:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 675F9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BciwCkhS
Received: by mail-ej2-f11.google.com with SMTP id a640c23a62f3a-c504c069dcaso61205966b.1
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 02:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794996735; x=1795601535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=urL0eMB5iRPIEjTLq6WXSe5g/qGCtlbh75jFBqhB950=;
        b=BciwCkhSMyiRE+I4OF/eTaeL7vyBLZoZK0MsO+mlhfi/IxkFtlNzGb1PjmUaptrbgZ
         xDwiM0wl4qQa7v9JbAULa8NUltz0LBJ8scuqR4iFW6MxhOfQbwPADs14pXBCAlxaN4LE
         qaRRRnksWymDLbv0KL4Go47Vro69sX4FaJ6Gn5IIxc4dmcmkdj7nwNsIvZlpMG8/G241
         ohPdJWoME0yEJO7ZQiNnt2DR1q2J+R/EqA6tnWYyXAwJPSShPRAK2FNAG6FO1zsY1ADt
         voVS2vxyBda7Ck0UenxC248bpmgy9EHu0z6CWEjIPRhKFTbqL8uxXp/HgxfJhEEL/tLg
         85bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794996735; x=1795601535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=urL0eMB5iRPIEjTLq6WXSe5g/qGCtlbh75jFBqhB950=;
        b=ved8vu9vuE93XzjY2Y8oKT4/c6R6rohZWsRnsJdgXEXsJ0FTWVAq6gFO8Dfpu8NilA
         guzcj3l47tA0vfB0ZLlGv+4HPVkGyPw07Asa2mni8+1+Clks5WI8ivNZvfOzXDnuh5R+
         /2wPNloqsMhR/ZDuerKP0Z1t/bxzAUJiMq6qH3cIYgU7GSUhHC3mhgjP1sy5T84BTYjM
         knfKiUqfB4+qkU+tkl7JHNM7g0HwoRJSMlZ8tNgjkB8VO7n0wD+99M4Xb/kGM89CjSGA
         eJbqJg/9tRtYphqHVTXq28q6eaPEvfLc2Ta7OKbGXfwi9QPTLKtNgBOK3XEhOoyfjPck
         dRWQ==
X-Forwarded-Encrypted: i=1; AL+hErEH+3ST/cmnS7vf0tKg0bWUMmqk0XKdPqFm1Do8hVystqKJ1NdkpFLoY43PqJYBpswnScbfiT4DX/c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LzbscCdk2DhnRj1JqRkqMgg6wEyG+dIJ7aF5xH5/rINFfiiqV
	Hr3ZwRBkGxL+Z/iU427hQVQ41+mAGhXKRksdmwuUvLgRUTyM+wZ4wOju
X-Gm-Gg: AYBFou0VzKmwEaC1uM5Y2I1MYyH7uHiSXwjiBJ93Nf1DmqdpT/EpffbHoRKtC56sbzG
	dgiLyiJES7crjG4L2e19aRrI43G/M/G5Bv1PMpdfz7sNUF6QOsHGDoPH7C3YZUwYoy4qtUJvvAU
	EYUohEbTFVVfByElSMOOcMfvQdCEGdBukfcNKmUrv0WMB7N+YqCeHH42H5k4FBp4E1SzFG2AZU5
	rRC/sy70dqZUI7GpWHSYRjwgIXkLDvsZPUJR3GSJLNgcp57Hrkpw9/61/9FWtNrtFoFmUh4NYnk
	L50wl4jBIWO2Gx9McxfeFY1PVbgsHcMWQmLLECQTRgGeIDm8z7+DnQYxOuycyiY7WcAhi9Ma+YB
	3NUtKW/WwSts8SCXizqphYTGXi/qauiq4cm2f9cSe0au/71RxYUCtbAPvA+l1mxCajPv+LLPQiu
	ExCDPdN2+iEtxc1US1ZFR9V416s5oSdLTCZ55VF7cBrAkwp9e9Uk76IJHXSOh3aRf6YofeE/OW/
	p2QFTrbPRdW2OdqISR8c+O17O6uNYTSGEuPvkfRiTprwUaWYeS7IAryET5Jvwe/+g8bb/hYV9lP
	JEwSrLLZzLFkR0tBxXjYsRb/Q93/f6aZAX7LkAFx3QG1uOpeXuCz4WobbOE2uWRSecEvnd80lvr
	NNlk7xlcM479RAkMOP9BOx7iY4xCPYfhGqXRRG4T/i39NQw3lWhPHWkFB
X-Received: by 2002:a17:907:d406:b0:c49:cfcf:8d7f with SMTP id a640c23a62f3a-c510e3bd593mr169522666b.46.1794996734526;
        Wed, 18 Nov 2026 02:12:14 -0800 (PST)
Received: from thi-server.fritz.box (dslb-092-076-089-226.092.076.pools.vodafone-ip.de. [92.76.89.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510c83f332sm78436366b.7.2026.11.18.02.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:12:14 -0800 (PST)
From: Thilo Zirnstein <thi.zirnstein@gmail.com>
To: michal.simek@amd.com,
	andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thilo Zirnstein <thi.zirnstein@gmail.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH v4 1/2] i2c: i2c-xiic: fix clearing of bnb irq
Date: Wed, 18 Nov 2026 11:11:46 +0100
Message-ID: <20261118101147.3350796-2-thi.zirnstein@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118101147.3350796-1-thi.zirnstein@gmail.com>
References: <20261118101147.3350796-1-thi.zirnstein@gmail.com>
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

Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
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

