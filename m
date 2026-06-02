Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C5E2045AD
	for <linux-i2c@vger.kernel.org>; Tue,  2 Jun 2026 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367725; cv=none; b=IpQplJAawyBa3TAzpOlSUjr+Ufc1P4Tj198ta3kxagW8+dRV8G4vSjhKQkUs+xLo6ZwLll4Xa8LKtaI1uUw4feNeks9qzLOsl9IcjClr59KHoOLOGdbo/dCoogFDCdngUBK41dMA3cEj8f4Z4j7p9EDWHYmWSxBMJoHBiFCCvuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367725; c=relaxed/simple;
	bh=2JDslwZlvwvheB4tbSz2/J4fSCpOMrlNTzhAqzkr1Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NfA4BbVDsxV06yqWuj33Bo+z+3ehfe4wapRuecTeM9ZSwMXDfLFg2VwFU3cD1G0oR9x70LVG48oGKN7tPq+inaFxacXYQmA+YTgCEw77Gl0dWPAQioVRb34zhduqg0mA/QmwUfrPm4ds6LtVhWaHs38RXL1reNEOa2sRF+ycXEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5oyKlq2; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5oyKlq2"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36bba9a1089so2224259a91.3
        for <linux-i2c@vger.kernel.org>; Mon, 01 Jun 2026 19:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780367723; x=1780972523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UOEoDKEucURarLOwbqZH2SbaBDc4QN1T1pXnFftQALE=;
        b=C5oyKlq2y/a+SIMdiVdvehdATXqYh9zk8qaqZtLPMaTMDXfR0OzpqQkUhytNDDvEvN
         NXxaXdcusI4DkfWYC12OWs9fQhWtGgvEfNvbu37YH9Gceelrs9xr914pOs13lSA7OTgK
         XQjJUE8b6mprOeQaBUT0Za+GA06TCY921Pm+SCaNOzjmLx9XSXxt4fkEhfKIqFlGsx6E
         +s0DCzsp4EWf2loqKul/fHqt8w8xzrMOKOaRjcjCFgV8d5CjhsSjVXhArnPpR+qNX3oD
         mxUYH8GIoINrL0KPiZwKTwpT3ATZmNggSinjnBck9UTXFp898Re7mNY0T9itm6XPJKkJ
         DNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780367723; x=1780972523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOEoDKEucURarLOwbqZH2SbaBDc4QN1T1pXnFftQALE=;
        b=pV+2geygJ7Ufk6yDM2rxlEFPwrim/KCw1QAzg0U67qQzZve3SHjNsavmCMCZYbnuxS
         9QWqX0hXDCY+SQqO3bynY79uCiUNfOBQXUjOFjkNu3odP5aJKTVaLEDkL5vAooS7WPIL
         G50uXx9nHXmjUsUF9D3GNPP2mM1St6D9adbyltGOQ4VglLLRu1zqSngc9dIQYRy56inz
         TrJvTPtCx0Cdtqmgq6K3qkAfr12sleg6t/Kv3VsZoSpJ2B4sIGJMv15dL0f1bAgESWG6
         JyZyz10qzQ2+1PqeCbhYTg50/awYtmCch5v4CTfqsAIvnQfJGHFvwu01ePahIrCRyE0G
         B8Gw==
X-Gm-Message-State: AOJu0YwQljziJ/I5beh73hM3vFSTG0IyiulJEI12HwoG2oHKLhMV5ut+
	PSKeYUl7M/3XEdtbWhlPDCVsIcFI2Ws0fgvWlz9W9z27sSEpD7E5jrl6qh0hsw==
X-Gm-Gg: Acq92OHv+r6Raca11vB0BbUBvKEIRktPljRrroaakmkcCi8IHHmc7Nn2FC1zr0BqKHw
	Dsp5PWzMff1Yd992/1+4Z+Jo1D2Mdqcr8Aup/NdQ4uLrWPBO1YQiLAR4BfR/q4ib22N2DjcKdiu
	iqEzda96jOM9bBSmSx376p0LICT0mNMNXeo5nOlm0xxB7OerN7mipfHFJo1rKJjUXHpTyq2Jx18
	1HkF9v2i53A83BlwqzCF0/amA9ca0AinHJ+oGSB/vbdB5k13qFHfhmykQQDgPuqA4mHIPMgHQ1E
	dO0Jbqfb+wUsuYczHK90dGkuvzjZz5/fvPss0JpJ7EdoUfM/SXqsGP9hO8pMi/7f4wG0yjVZ70u
	FGoMeRZusIdes4KIuqTzkG4j9OganAnQ0e8ITdtuCqo5pVM9f2yZ0XQfv1hU6YLbhtzt5vruyT5
	5YW4fDI00CvuJCk65vA1ySfa36xPycNvL3/kZ5lw1BeQj8ySUzrXiXbGf6W57/8+5RKNT6V/y60
	dZzTUSvx2VT3LgWOWHF5yzMKlEre4PEe2ZbmaZoWEumKQ==
X-Received: by 2002:a17:90b:354c:b0:369:7f25:cec0 with SMTP id 98e67ed59e1d1-36c2eba615emr8721105a91.0.1780367722526;
        Mon, 01 Jun 2026 19:35:22 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbe0d89d8sm6854480a91.3.2026.06.01.19.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 19:35:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	chleroy@kernel.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] i2c: ibm_iic: replace in_8/out_8 with ioread8/iowrite8
Date: Mon,  1 Jun 2026 19:35:05 -0700
Message-ID: <20260602023505.551007-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mechanical conversion of the ppc4xx-specific in_8/out_8 accessors to
the generic ioread8/iowrite8 helpers for portability.

This allows COMPILE_TEST to be enabled for greater compile coverage.

Also replace 4xx with 44x as the latter is a deprecated symbol.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/busses/Kconfig       |   2 +-
 drivers/i2c/busses/i2c-ibm_iic.c | 150 +++++++++++++++----------------
 2 files changed, 73 insertions(+), 79 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d59a4d0b402c..0669daf83c6d 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -731,7 +731,7 @@ config I2C_HISI
 
 config I2C_IBM_IIC
 	tristate "IBM PPC 4xx on-chip I2C interface"
-	depends on 4xx || (PPC && COMPILE_TEST)
+	depends on 44x || COMPILE_TEST
 	help
 	  Say Y here if you want to use IIC peripheral found on
 	  embedded IBM PPC 4xx based systems.
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 7c70e8bda24e..ec856443a539 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -82,14 +82,13 @@ static void dump_iic_regs(const char* header, struct ibm_iic_private* dev)
 {
 	volatile struct iic_regs __iomem *iic = dev->vaddr;
 	printk(KERN_DEBUG "ibm-iic%d: %s\n", dev->idx, header);
-	printk(KERN_DEBUG
-	       "  cntl     = 0x%02x, mdcntl = 0x%02x\n"
-	       "  sts      = 0x%02x, extsts = 0x%02x\n"
-	       "  clkdiv   = 0x%02x, xfrcnt = 0x%02x\n"
-	       "  xtcntlss = 0x%02x, directcntl = 0x%02x\n",
-		in_8(&iic->cntl), in_8(&iic->mdcntl), in_8(&iic->sts),
-		in_8(&iic->extsts), in_8(&iic->clkdiv), in_8(&iic->xfrcnt),
-		in_8(&iic->xtcntlss), in_8(&iic->directcntl));
+	printk(KERN_DEBUG "  cntl     = 0x%02x, mdcntl = 0x%02x\n"
+			  "  sts      = 0x%02x, extsts = 0x%02x\n"
+			  "  clkdiv   = 0x%02x, xfrcnt = 0x%02x\n"
+			  "  xtcntlss = 0x%02x, directcntl = 0x%02x\n",
+	       ioread8(&iic->cntl), ioread8(&iic->mdcntl), ioread8(&iic->sts),
+	       ioread8(&iic->extsts), ioread8(&iic->clkdiv), ioread8(&iic->xfrcnt),
+	       ioread8(&iic->xtcntlss), ioread8(&iic->directcntl));
 }
 #  define DUMP_REGS(h,dev)	dump_iic_regs((h),(dev))
 #else
@@ -124,7 +123,7 @@ static struct ibm_iic_timings {
 /* Enable/disable interrupt generation */
 static inline void iic_interrupt_mode(struct ibm_iic_private* dev, int enable)
 {
-	out_8(&dev->vaddr->intmsk, enable ? INTRMSK_EIMTC : 0);
+	iowrite8(enable ? INTRMSK_EIMTC : 0, &dev->vaddr->intmsk);
 }
 
 /*
@@ -137,37 +136,35 @@ static void iic_dev_init(struct ibm_iic_private* dev)
 	DBG("%d: init\n", dev->idx);
 
 	/* Clear remote target address */
-	out_8(&iic->lmadr, 0);
-	out_8(&iic->hmadr, 0);
+	iowrite8(0, &iic->lmadr);
+	iowrite8(0, &iic->hmadr);
 
 	/* Clear local target address */
-	out_8(&iic->lsadr, 0);
-	out_8(&iic->hsadr, 0);
+	iowrite8(0, &iic->lsadr);
+	iowrite8(0, &iic->hsadr);
 
 	/* Clear status & extended status */
-	out_8(&iic->sts, STS_SCMP | STS_IRQA);
-	out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD | EXTSTS_LA
-			    | EXTSTS_ICT | EXTSTS_XFRA);
+	iowrite8(STS_SCMP | STS_IRQA, &iic->sts);
+	iowrite8(EXTSTS_IRQP | EXTSTS_IRQD | EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA, &iic->extsts);
 
 	/* Set clock divider */
-	out_8(&iic->clkdiv, dev->clckdiv);
+	iowrite8(dev->clckdiv, &iic->clkdiv);
 
 	/* Clear transfer count */
-	out_8(&iic->xfrcnt, 0);
+	iowrite8(0, &iic->xfrcnt);
 
 	/* Clear extended control and status */
-	out_8(&iic->xtcntlss, XTCNTLSS_SRC | XTCNTLSS_SRS | XTCNTLSS_SWC
-			    | XTCNTLSS_SWS);
+	iowrite8(XTCNTLSS_SRC | XTCNTLSS_SRS | XTCNTLSS_SWC | XTCNTLSS_SWS, &iic->xtcntlss);
 
 	/* Clear control register */
-	out_8(&iic->cntl, 0);
+	iowrite8(0, &iic->cntl);
 
 	/* Enable interrupts if possible */
 	iic_interrupt_mode(dev, dev->irq >= 0);
 
 	/* Set mode control */
-	out_8(&iic->mdcntl, MDCNTL_FMDB | MDCNTL_EINT | MDCNTL_EUBS
-			    | (dev->fast_mode ? MDCNTL_FSM : 0));
+	iowrite8(MDCNTL_FMDB | MDCNTL_EINT | MDCNTL_EUBS | (dev->fast_mode ? MDCNTL_FSM : 0),
+		 &iic->mdcntl);
 
 	DUMP_REGS("iic_init", dev);
 }
@@ -185,28 +182,28 @@ static void iic_dev_reset(struct ibm_iic_private* dev)
 	DUMP_REGS("reset", dev);
 
     	/* Place chip in the reset state */
-	out_8(&iic->xtcntlss, XTCNTLSS_SRST);
+	iowrite8(XTCNTLSS_SRST, &iic->xtcntlss);
 
 	/* Check if bus is free */
-	dc = in_8(&iic->directcntl);
+	dc = ioread8(&iic->directcntl);
 	if (!DIRCTNL_FREE(dc)){
 		DBG("%d: trying to regain bus control\n", dev->idx);
 
 		/* Try to set bus free state */
-		out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);
+		iowrite8(DIRCNTL_SDAC | DIRCNTL_SCC, &iic->directcntl);
 
 		/* Wait until we regain bus control */
 		for (i = 0; i < 100; ++i){
-			dc = in_8(&iic->directcntl);
+			dc = ioread8(&iic->directcntl);
 			if (DIRCTNL_FREE(dc))
 				break;
 
 			/* Toggle SCL line */
 			dc ^= DIRCNTL_SCC;
-			out_8(&iic->directcntl, dc);
+			iowrite8(dc, &iic->directcntl);
 			udelay(10);
 			dc ^= DIRCNTL_SCC;
-			out_8(&iic->directcntl, dc);
+			iowrite8(dc, &iic->directcntl);
 
 			/* be nice */
 			cond_resched();
@@ -214,7 +211,7 @@ static void iic_dev_reset(struct ibm_iic_private* dev)
 	}
 
 	/* Remove reset */
-	out_8(&iic->xtcntlss, 0);
+	iowrite8(0, &iic->xtcntlss);
 
 	/* Reinitialize interface */
 	iic_dev_init(dev);
@@ -228,7 +225,7 @@ static void iic_dev_reset(struct ibm_iic_private* dev)
 static int iic_dc_wait(volatile struct iic_regs __iomem *iic, u8 mask)
 {
 	unsigned long x = jiffies + HZ / 28 + 2;
-	while ((in_8(&iic->directcntl) & mask) != mask){
+	while ((ioread8(&iic->directcntl) & mask) != mask) {
 		if (unlikely(time_after(jiffies, x)))
 			return -1;
 		cond_resched();
@@ -253,60 +250,60 @@ static int iic_smbus_quick(struct ibm_iic_private* dev, const struct i2c_msg* p)
 	DBG("%d: smbus_quick(0x%02x)\n", dev->idx, p->addr);
 
 	/* Reset IIC interface */
-	out_8(&iic->xtcntlss, XTCNTLSS_SRST);
+	iowrite8(XTCNTLSS_SRST, &iic->xtcntlss);
 
 	/* Wait for bus to become free */
-	out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);
+	iowrite8(DIRCNTL_SDAC | DIRCNTL_SCC, &iic->directcntl);
 	if (unlikely(iic_dc_wait(iic, DIRCNTL_MSDA | DIRCNTL_MSC)))
 		goto err;
 	ndelay(t->buf);
 
 	/* START */
-	out_8(&iic->directcntl, DIRCNTL_SCC);
+	iowrite8(DIRCNTL_SCC, &iic->directcntl);
 	sda = 0;
 	ndelay(t->hd_sta);
 
 	/* Send address */
 	v = i2c_8bit_addr_from_msg(p);
 	for (i = 0, mask = 0x80; i < 8; ++i, mask >>= 1){
-		out_8(&iic->directcntl, sda);
+		iowrite8(sda, &iic->directcntl);
 		ndelay(t->low / 2);
 		sda = (v & mask) ? DIRCNTL_SDAC : 0;
-		out_8(&iic->directcntl, sda);
+		iowrite8(sda, &iic->directcntl);
 		ndelay(t->low / 2);
 
-		out_8(&iic->directcntl, DIRCNTL_SCC | sda);
+		iowrite8(DIRCNTL_SCC | sda, &iic->directcntl);
 		if (unlikely(iic_dc_wait(iic, DIRCNTL_MSC)))
 			goto err;
 		ndelay(t->high);
 	}
 
 	/* ACK */
-	out_8(&iic->directcntl, sda);
+	iowrite8(sda, &iic->directcntl);
 	ndelay(t->low / 2);
-	out_8(&iic->directcntl, DIRCNTL_SDAC);
+	iowrite8(DIRCNTL_SDAC, &iic->directcntl);
 	ndelay(t->low / 2);
-	out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);
+	iowrite8(DIRCNTL_SDAC | DIRCNTL_SCC, &iic->directcntl);
 	if (unlikely(iic_dc_wait(iic, DIRCNTL_MSC)))
 		goto err;
-	res = (in_8(&iic->directcntl) & DIRCNTL_MSDA) ? -EREMOTEIO : 1;
+	res = (ioread8(&iic->directcntl) & DIRCNTL_MSDA) ? -EREMOTEIO : 1;
 	ndelay(t->high);
 
 	/* STOP */
-	out_8(&iic->directcntl, 0);
+	iowrite8(0, &iic->directcntl);
 	ndelay(t->low);
-	out_8(&iic->directcntl, DIRCNTL_SCC);
+	iowrite8(DIRCNTL_SCC, &iic->directcntl);
 	if (unlikely(iic_dc_wait(iic, DIRCNTL_MSC)))
 		goto err;
 	ndelay(t->su_sto);
-	out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);
+	iowrite8(DIRCNTL_SDAC | DIRCNTL_SCC, &iic->directcntl);
 
 	ndelay(t->buf);
 
 	DBG("%d: smbus_quick -> %s\n", dev->idx, res ? "NACK" : "ACK");
 out:
 	/* Remove reset */
-	out_8(&iic->xtcntlss, 0);
+	iowrite8(0, &iic->xtcntlss);
 
 	/* Reinitialize interface */
 	iic_dev_init(dev);
@@ -326,11 +323,11 @@ static irqreturn_t iic_handler(int irq, void *dev_id)
 	struct ibm_iic_private* dev = (struct ibm_iic_private*)dev_id;
 	volatile struct iic_regs __iomem *iic = dev->vaddr;
 
-	DBG2("%d: irq handler, STS = 0x%02x, EXTSTS = 0x%02x\n",
-	     dev->idx, in_8(&iic->sts), in_8(&iic->extsts));
+	DBG2("%d: irq handler, STS = 0x%02x, EXTSTS = 0x%02x\n", dev->idx, ioread8(&iic->sts),
+	     ioread8(&iic->extsts));
 
 	/* Acknowledge IRQ and wakeup iic_wait_for_tc */
-	out_8(&iic->sts, STS_IRQA | STS_SCMP);
+	iowrite8(STS_IRQA | STS_SCMP, &iic->sts);
 	wake_up_interruptible(&dev->wq);
 
 	return IRQ_HANDLED;
@@ -344,30 +341,28 @@ static int iic_xfer_result(struct ibm_iic_private* dev)
 {
 	volatile struct iic_regs __iomem *iic = dev->vaddr;
 
-	if (unlikely(in_8(&iic->sts) & STS_ERR)){
-		DBG("%d: xfer error, EXTSTS = 0x%02x\n", dev->idx,
-			in_8(&iic->extsts));
+	if (unlikely(ioread8(&iic->sts) & STS_ERR)) {
+		DBG("%d: xfer error, EXTSTS = 0x%02x\n", dev->idx, ioread8(&iic->extsts));
 
 		/* Clear errors and possible pending IRQs */
-		out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD |
-			EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA);
+		iowrite8(EXTSTS_IRQP | EXTSTS_IRQD | EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA,
+			 &iic->extsts);
 
 		/* Flush controller data buffer */
-		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
+		iowrite8(ioread8(&iic->mdcntl) | MDCNTL_FMDB, &iic->mdcntl);
 
 		/* Is bus free?
 		 * If error happened during combined xfer
 		 * IIC interface is usually stuck in some strange
 		 * state, the only way out - soft reset.
 		 */
-		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
+		if ((ioread8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE) {
 			DBG("%d: bus is stuck, resetting\n", dev->idx);
 			iic_dev_reset(dev);
 		}
 		return -EREMOTEIO;
-	}
-	else
-		return in_8(&iic->xfrcnt) & XFRCNT_MTC_MASK;
+	} else
+		return ioread8(&iic->xfrcnt) & XFRCNT_MTC_MASK;
 }
 
 /*
@@ -380,14 +375,14 @@ static void iic_abort_xfer(struct ibm_iic_private* dev)
 
 	DBG("%d: iic_abort_xfer\n", dev->idx);
 
-	out_8(&iic->cntl, CNTL_HMT);
+	iowrite8(CNTL_HMT, &iic->cntl);
 
 	/*
 	 * Wait for the abort command to complete.
 	 * It's not worth to be optimized, just poll (timeout >= 1 tick)
 	 */
 	x = jiffies + 2;
-	while ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
+	while ((ioread8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE) {
 		if (time_after(jiffies, x)){
 			DBG("%d: abort timeout, resetting...\n", dev->idx);
 			iic_dev_reset(dev);
@@ -412,12 +407,12 @@ static int iic_wait_for_tc(struct ibm_iic_private* dev){
 
 	if (dev->irq >= 0){
 		/* Interrupt mode */
-		ret = wait_event_interruptible_timeout(dev->wq,
-			!(in_8(&iic->sts) & STS_PT), dev->adap.timeout);
+		ret = wait_event_interruptible_timeout(dev->wq, !(ioread8(&iic->sts) & STS_PT),
+						       dev->adap.timeout);
 
 		if (unlikely(ret < 0))
 			DBG("%d: wait interrupted\n", dev->idx);
-		else if (unlikely(in_8(&iic->sts) & STS_PT)){
+		else if (unlikely(ioread8(&iic->sts) & STS_PT)) {
 			DBG("%d: wait timeout\n", dev->idx);
 			ret = -ETIMEDOUT;
 		}
@@ -426,7 +421,7 @@ static int iic_wait_for_tc(struct ibm_iic_private* dev){
 		/* Polling mode */
 		unsigned long x = jiffies + dev->adap.timeout;
 
-		while (in_8(&iic->sts) & STS_PT){
+		while (ioread8(&iic->sts) & STS_PT) {
 			if (unlikely(time_after(jiffies, x))){
 				DBG("%d: poll timeout\n", dev->idx);
 				ret = -ETIMEDOUT;
@@ -460,7 +455,7 @@ static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm,
 	int i, j, loops, ret = 0;
 	int len = pm->len;
 
-	u8 cntl = (in_8(&iic->cntl) & CNTL_AMD) | CNTL_PT;
+	u8 cntl = (ioread8(&iic->cntl) & CNTL_AMD) | CNTL_PT;
 	if (pm->flags & I2C_M_RD)
 		cntl |= CNTL_RW;
 
@@ -471,7 +466,7 @@ static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm,
 
 		if (!(cntl & CNTL_RW))
 			for (j = 0; j < count; ++j)
-				out_8((void __iomem *)&iic->mdbuf, *buf++);
+				iowrite8(*buf++, (void __iomem *)&iic->mdbuf);
 
 		if (i < loops - 1)
 			cmd |= CNTL_CHT;
@@ -481,7 +476,7 @@ static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm,
 		DBG2("%d: xfer_bytes, %d, CNTL = 0x%02x\n", dev->idx, count, cmd);
 
 		/* Start transfer */
-		out_8(&iic->cntl, cmd);
+		iowrite8(cmd, &iic->cntl);
 
 		/* Wait for completion */
 		ret = iic_wait_for_tc(dev);
@@ -502,7 +497,7 @@ static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm,
 
 		if (cntl & CNTL_RW)
 			for (j = 0; j < count; ++j)
-				*buf++ = in_8((void __iomem *)&iic->mdbuf);
+				*buf++ = ioread8((void __iomem *)&iic->mdbuf);
 	}
 
 	return ret > 0 ? 0 : ret;
@@ -517,12 +512,12 @@ static inline void iic_address(struct ibm_iic_private* dev, struct i2c_msg* msg)
 		msg->addr, msg->flags & I2C_M_TEN ? 10 : 7);
 
 	if (msg->flags & I2C_M_TEN) {
-	    out_8(&iic->cntl, CNTL_AMD);
-	    out_8(&iic->lmadr, i2c_10bit_addr_lo_from_msg(msg));
-	    out_8(&iic->hmadr, i2c_10bit_addr_hi_from_msg(msg) & ~I2C_M_RD);
+		iowrite8(CNTL_AMD, &iic->cntl);
+		iowrite8(i2c_10bit_addr_lo_from_msg(msg), &iic->lmadr);
+		iowrite8(i2c_10bit_addr_hi_from_msg(msg) & ~I2C_M_RD, &iic->hmadr);
 	} else {
-	    out_8(&iic->cntl, 0);
-	    out_8(&iic->lmadr, i2c_8bit_addr_from_msg(msg) & ~I2C_M_RD);
+		iowrite8(0, &iic->cntl);
+		iowrite8(i2c_8bit_addr_from_msg(msg) & ~I2C_M_RD, &iic->lmadr);
 	}
 }
 
@@ -578,7 +573,7 @@ static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	}
 
 	/* Check bus state */
-	if (unlikely((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE)){
+	if (unlikely((ioread8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE)) {
 		DBG("%d: iic_xfer, bus is not free\n", dev->idx);
 
 		/* Usually it means something serious has happened.
@@ -591,14 +586,13 @@ static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		 */
 		iic_dev_reset(dev);
 
-		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
+		if ((ioread8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE) {
 			DBG("%d: iic_xfer, bus is still not free\n", dev->idx);
 			return -EREMOTEIO;
 		}
-	}
-	else {
+	} else {
 		/* Flush controller data buffer (just in case) */
-		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
+		iowrite8(ioread8(&iic->mdcntl) | MDCNTL_FMDB, &iic->mdcntl);
 	}
 
 	/* Load target address */
-- 
2.54.0

