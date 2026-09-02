Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DFB3C345F
	for <linux-i2c@vger.kernel.org>; Wed,  2 Sep 2026 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384311; cv=none; b=plRNoXieFe11TDYBmj+3v8AG/fJ6iY16e3fxEVowN2XTVmc5TLLa7OiPLaKfBlURLyDFxCumtFS63Ok6NTZlEvPzQlWcm4XSF8zxs1CowWV1EXASLDU6tC9U7vP/o1oPSF5Uuxlexyuvim5GK1fjq6CPbkMBZopYypaznb9aslE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384311; c=relaxed/simple;
	bh=LHhpRWV64svn2PO2cWWQEY87EXmjPNDpiKNVs+iud0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NT9atd55hB0hp3mERtQGV0lnkI4hUYsSG8fkQgJ2qNuBWe+TP7UyMMC337ek6UjtSDyi17ZewEqBCqT2EBDbGfNKwVytCJRKezet+SmHDUMSX647QLqsUc5RKWz6RN5Z+55WXYAc881+h0BzKA53yHPfKcxi8V8zKRfqkk07+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+sA/duF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+sA/duF"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84eb992a881so1458392b3a.2
        for <linux-i2c@vger.kernel.org>; Wed, 02 Sep 2026 14:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788384303; x=1788989103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+/0STUVLZsyjAhQiRBiOnwe+jugMD4ztFWpPC89Ywfo=;
        b=l+sA/duF0T2zjwzPyElfx3MCquLfsCm0EzAlixgBgUDMzim60RT+4LCxp1Rfcjih2l
         A99b6dwyDMljOctKwGv9mZVApFXD6E1IxHMvALyFnbUU9NGJEx9cJ1ZkREkL04htSFxM
         9yvL8enAD7uKi2zvGKE0Psvd7LcgIxcA3KWNkcRwkQkDzuIzi1mJNNFR0yGui/DMVvuL
         tDznS40ksF41Q6/9mdlJ7jZzCCWNC+MZIFCY2TV/FtCSxfhYx6bh396YbdEB4YVhpo1D
         1oAJq90YUsfE99AhQX2IjGkl62sl4fH6zlLIQNOJIklHf3zNuTN4rlx5wzxuy+9scqrI
         5Rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788384303; x=1788989103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+/0STUVLZsyjAhQiRBiOnwe+jugMD4ztFWpPC89Ywfo=;
        b=GH1znKa2GqI1xQ1bSG4NhaRcH2pvLH9cochfv7Bf33kIBM9F1T/dkgu6L25AezMTPZ
         1u7GGpWT+h1fVJ2jklT31EK1NlM32nhxEoT0yB81YnUQ2M6GXrD9xCmIeatT0AOhhSfj
         lnXAxHGNpNFzn7/DrANi9pvow/AONKlYCTu8+/5HNUKD2gn6JgdQWuXqAxDNHz2G1fPD
         uhydfRjt6XLXuq4CREE0b1FmFDv4FUdu39sU0+rN9s+hMIG4v/Q8WsdQIssOTP3BKKqI
         smWOatJRnSavDZzztmOuvWcduG4dy73iT2krjiDtXzmsBCxi31x2nOMvlMz4Vh1VlO1W
         IkPQ==
X-Gm-Message-State: AFuF++mvon1bx9Iw8xKUOfukqzSplS5k98NNP6lajMdkuF9QpQDbhy/X
	pxo9W7xrZ0gUQGez7vecqivYdQob95Jg4YiEseJ1ejQD4sR7w9n/+kv5t+ybvA==
X-Gm-Gg: AYBFou2BKf1Wi9iybli3CzXMFCX3ctd3xi58E+IkZOMmrwC+XNzwJptsJzT0xmV4t4j
	/IvYqVSEOmM/tgZDc/wsZ/cRY9jgJfy/9p7tQ/DRSSz47h0TBvkVICTZKBewNdhrv/0yAiM5/y4
	4Xdl6yRxHsMFZl1lF4279PK2iThtxM8qv+GAJ5G5XH+Y0UmA0FMEA8paABzjswoDDF1Gb06DMi4
	VDH2R4et5iP9PZWz8XZEudQ9thD9xWZolLe62u+Tu8dpx91MM2DElhV8P3Dbg7ws5bDMyNIdjLc
	Jol6jGvHLVf4cEPK0bY40EuoFTgbanPyUGVsK/DIInAMfdUZvXt9JtLrQtyWbqMksNKaBFkiLRG
	tpUxa5jWomEpGdvODqnqYQFqc4OeAlkloKDNlnjf+nL9bitFHgR7H7rJ1a3ohRNsy19TOkvwYOF
	uInyeth+7LWDy26ix/vDE5QRM8SUJKrWLsZWui1EgakQKsmCH3SK5PdEE+/fgApYKU8X59ZpsAt
	SZ9NgWYSjTxHMDpR9bTVU13qM73TC/sb0PD/o0phorqOWgbic+4VnXbUrfyjvDIExvo8zy+Kx4d
	Qnd8/U/6eMWN9FST3QlMRuCZcascYw7TA0BhPQ==
X-Received: by 2002:a05:6a00:ad0b:b0:857:4dea:e1dd with SMTP id d2e1a72fcca58-85ed3c7d7b6mr11974426b3a.14.1788384302556;
        Wed, 02 Sep 2026 14:25:02 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc43d40c55fsm90890a12.19.2026.09.02.14.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 14:25:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 2/3] i2c: ibm_iic: get the irq early in probe
Date: Wed,  2 Sep 2026 14:24:55 -0700
Message-ID: <20260902212456.289608-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902212456.289608-1-rosenp@gmail.com>
References: <20260902212456.289608-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use platform_get_irq() which can return -EPROBE_DEFER, unlike
irq_of_map_and_parse().

Check for iic_force_poll before doing so to avoid pointless work.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 43 ++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 20421ebe73ab..8af666442952 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -648,31 +648,22 @@ static inline u8 iic_clckdiv(unsigned int opb)
 }
 
 static int iic_request_irq(struct platform_device *ofdev,
-				     struct ibm_iic_private *dev)
+			   struct ibm_iic_private *dev)
 {
-	struct device_node *np = ofdev->dev.of_node;
-	int irq;
-
-	if (iic_force_poll)
-		return 0;
-
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		dev_err(&ofdev->dev, "irq_of_parse_and_map failed\n");
-		return 0;
-	}
+	int ret;
 
 	/* Disable interrupts until we finish initialization, assumes
 	 *  level-sensitive IRQ setup...
 	 */
 	iic_interrupt_mode(dev, 0);
-	if (request_irq(irq, iic_handler, 0, "IBM IIC", dev)) {
-		dev_err(&ofdev->dev, "request_irq %d failed\n", irq);
+	ret = request_irq(dev->irq, iic_handler, 0, "IBM IIC", dev)
+	if (ret) {
+		dev_err(&ofdev->dev, "request_irq %d failed\n", dev->irq);
 		/* Fallback to the polling mode */
-		return 0;
+		return ret;
 	}
 
-	return irq;
+	return ret;
 }
 
 /*
@@ -685,12 +676,23 @@ static int iic_probe(struct platform_device *ofdev)
 	struct i2c_adapter *adap;
 	void __iomem *vaddr;
 	const u32 *freq;
+	int irq;
 	int ret;
 
 	vaddr = devm_platform_ioremap_resource(ofdev, 0);
 	if (IS_ERR(vaddr))
 		return PTR_ERR(vaddr);
 
+	if (iic_force_poll) {
+		irq = 0;
+	} else {
+		irq = platform_get_irq(ofdev, 0);
+		if (irq == -EPROBE_DEFER)
+			return irq;
+		if (irq < 0)
+			dev_warn(&ofdev->dev, "using polling mode\n");
+	}
+
 	dev = kzalloc_obj(*dev);
 	if (!dev)
 		return -ENOMEM;
@@ -701,9 +703,12 @@ static int iic_probe(struct platform_device *ofdev)
 
 	init_waitqueue_head(&dev->wq);
 
-	dev->irq = iic_request_irq(ofdev, dev);
-	if (!dev->irq)
-		dev_warn(&ofdev->dev, "using polling mode\n");
+	dev->irq = irq;
+	if (dev->irq > 0) {
+		ret = iic_request_irq(ofdev, dev, irq);
+		if (ret)
+			dev->irq = 0;
+	}
 
 	/* Board specific settings */
 	if (iic_force_fast || of_get_property(np, "fast-mode", NULL))
-- 
2.55.0

