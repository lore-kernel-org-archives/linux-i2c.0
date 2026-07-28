Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754843998B4
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258937; cv=none; b=ZSy+pQ4dJgdf9K5xkqyk0cdq1gUYiBHpQ+AHYKmiV6E0OxuSwsH7HDQqt3k1X9k38DudwmGEGzv56fCyp6q+Wtg0r0ZZ8ETzlkxiRrHY5VgmvUGCXtqcbazaj0Ty3+NYcsZxwE3N9Jv5bWAsl+kFQ4POsVFbizk4FJnMmUY+XqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258937; c=relaxed/simple;
	bh=q8w1cjiyi3fDD815Skn6IVMXnxAr33vK4QwsZzCK9+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJC+NSQoTkrkxwNw0xlEcTfS1QqWd7Ho9QiZT73wwhiq8J2UHJ15+7ratBpRIh9rK3TM2Wyrb5Ucq5AFiTZGuEOBx1HRcXFZgnWtr5/Q5aLCvbYWKCcUBxWmlXendMrOTZ+sKlWYmOvpT2goR137iADkVgmsm9icR7WDMEg4uv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgQo3S3r; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgQo3S3r"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso67081a91.1
        for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 10:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785258936; x=1785863736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U3AEn2faIvWQU4bHNGW5bAFp90KH6oE1JBVI6F9Tu/c=;
        b=WgQo3S3r6Z6ue6iqPBQY6sqnUUJbUYDWCdps1gVM1vHHIRYYRO7oQadKoKmUjKo/Fa
         gBUmunE0A/eK+Bf4AOBdZpghVaQv6/ynx+YZvTO7Q7w8ubVmOVSnTO/7U70ykcHt6Bn7
         V1+o064Tlbjh6NSMuyiLP87lG4omvDgSU/oTenv6+3V/Ze30b2ClbGbPFjcZcpqeyRRL
         FgSYmMnauK2bqgQdgrUhqvWD8nlwYmca8iZG+FUosX7f8nogz5hW4YNOILe1fwraymfF
         CwPj4QK+nq1NC8WovNSUDGNA6Iz6Bg753U2XkjqzDyEDTaI/3+PyMltTBez8C452wS4N
         b4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785258936; x=1785863736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U3AEn2faIvWQU4bHNGW5bAFp90KH6oE1JBVI6F9Tu/c=;
        b=mHrUJBL3x199JtIqfZ1+unHyEfvPm7fJMas7Ejr6VZz+Sam5Y9PP6M/HL4Q744fh8+
         dIT/ZmN/6PNfCN8Cte8JE030haBpyNRxZiTMIDk/urjSK4Hhxn0bxkjxakxee//jISAL
         3DYlb0r+2T3owRw40nZ0XjXmTVt7UI9Bfda+D+btHWDoPRj/PecxLaKgmvZJ7boSpl5Q
         8CE7ShHz2v3k/sPRQmN33WzDR/TuuhPngQWYDaO9xUEPwzxvewuNwxboe7y5fLFLccep
         Dx7w7M1yYF/0/9ymJ8v8+s2njO19kWV8YHJHBCgtZRmUyu4iv2tjWmAy5eoMLZuveDhU
         GPyw==
X-Gm-Message-State: AOJu0YwwSE81+zCNUvYbAd7lS/FZGO7miLgtivJdJ4UfjDSAL9ibfjAX
	+4drfRIlOld7PnJMpHMzWiFdbIHmzod93prgGk/5/aBLHMWPeVdE1Dz0/0dh
X-Gm-Gg: AR+sD11sIbR40B+Tdoc+5EWeL3xAWXWXpum9k7Nryw14urAba18FpkQgFlBN4PdPUKT
	urCIKZZ+KaZIg84m93xGJIpTg53hOSUzM9BO26e/agCHU9Hs60+B2zXaiu2zPcgZP/OFAODV01d
	1GLtvgPfzLEFO1tKAfZ0P9qGi5oh6Qj1QVcyTF8Nr9ioqQg3oR5QK3IISC3ZNUSIFCVRKQmpJRp
	3amh10Plyt3ht62J/jnxRbY+NlPAg3wyWGICNLh94CfrpZCaonlRV+cdH4oWZcix/wHhI8E9m2i
	DLCcPv7rgdaCRdMWIvubj9s4FKCQoHbaxh5P/IR6Ept5CG4GVtRU0gyWjdJzR4c23v9yfQ+i/86
	nF71aRhpaIyXncbppu8TmIJz01CUBGBTWuGQQ+2k4VZf2Ja9r56MSVuaqVMAhJlw6LKq+aqp0TL
	XrVagloKyHLVNu2QAXsvrKcd+0IHocig3VoIYJQiwKmFHVgVyEkxgh6EI0BF7Gm6+LGbWkXB6Fs
	f+1DhuD8rECMXE9S8UCvOZsqQ==
X-Received: by 2002:a17:90b:3945:b0:37f:e326:6557 with SMTP id 98e67ed59e1d1-38f6a33d8cemr3736659a91.4.1785258935722;
        Tue, 28 Jul 2026 10:15:35 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f2b9e35sm226215a91.14.2026.07.28.10.15.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 10:15:34 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] i2c: iop3xx: fix adapter and IRQ teardown
Date: Wed, 29 Jul 2026 02:15:27 +0900
Message-ID: <20260728171527.48275-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The probe path enables the controller and requests its IRQ before
registering the I2C adapter, but ignores an adapter registration
failure. The remove path also frees the IRQ data and unmaps its
registers without first unregistering the adapter or IRQ handler.

Check the adapter registration result and unwind the IRQ on failure.
On removal, unregister the adapter first, then quiesce the controller
and synchronize and release the IRQ before freeing its backing
resources.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/i2c/busses/i2c-iop3xx.c | 31 ++++++++++++++++++++++---------
 drivers/i2c/busses/i2c-iop3xx.h |  1 +
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
index 4c67c5d18f..c375509c93 100644
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -89,6 +89,16 @@ iop3xx_i2c_enable(struct i2c_algo_iop3xx_data *iop3xx_adap)
 	__raw_writel(cr, iop3xx_adap->ioaddr + CR_OFFSET);
 }
 
+static void
+iop3xx_i2c_disable(struct i2c_algo_iop3xx_data *iop3xx_adap)
+{
+	unsigned long cr = __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
+
+	cr &= ~(IOP3XX_ICR_ALD_IE | IOP3XX_ICR_BERR_IE |
+		IOP3XX_ICR_RXFULL_IE | IOP3XX_ICR_TXEMPTY_IE);
+	__raw_writel(cr, iop3xx_adap->ioaddr + CR_OFFSET);
+}
+
 static void
 iop3xx_i2c_transaction_cleanup(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
@@ -392,14 +402,10 @@ iop3xx_i2c_remove(struct platform_device *pdev)
 	struct i2c_algo_iop3xx_data *adapter_data =
 		(struct i2c_algo_iop3xx_data *)padapter->algo_data;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	unsigned long cr = __raw_readl(adapter_data->ioaddr + CR_OFFSET);
 
-	/*
-	 * Disable the actual HW unit
-	 */
-	cr &= ~(IOP3XX_ICR_ALD_IE | IOP3XX_ICR_BERR_IE |
-		IOP3XX_ICR_RXFULL_IE | IOP3XX_ICR_TXEMPTY_IE);
-	__raw_writel(cr, adapter_data->ioaddr + CR_OFFSET);
+	i2c_del_adapter(padapter);
+	iop3xx_i2c_disable(adapter_data);
+	free_irq(adapter_data->irq, adapter_data);
 
 	iounmap(adapter_data->ioaddr);
 	release_mem_region(res->start, IOP3XX_I2C_IO_SIZE);
@@ -467,6 +473,7 @@ iop3xx_i2c_probe(struct platform_device *pdev)
 		ret = irq;
 		goto unmap;
 	}
+	adapter_data->irq = irq;
 	ret = request_irq(irq, iop3xx_i2c_irq_handler, 0,
 				pdev->name, adapter_data);
 
@@ -492,13 +499,19 @@ iop3xx_i2c_probe(struct platform_device *pdev)
 	iop3xx_i2c_reset(adapter_data);
 	iop3xx_i2c_enable(adapter_data);
 
-	platform_set_drvdata(pdev, new_adapter);
 	new_adapter->algo_data = adapter_data;
 
-	i2c_add_numbered_adapter(new_adapter);
+	ret = i2c_add_numbered_adapter(new_adapter);
+	if (ret)
+		goto disable;
+	platform_set_drvdata(pdev, new_adapter);
 
 	return 0;
 
+disable:
+	iop3xx_i2c_disable(adapter_data);
+	free_irq(adapter_data->irq, adapter_data);
+
 unmap:
 	iounmap(adapter_data->ioaddr);
 
diff --git a/drivers/i2c/busses/i2c-iop3xx.h b/drivers/i2c/busses/i2c-iop3xx.h
index 1435483355..6c07ea16bf 100644
--- a/drivers/i2c/busses/i2c-iop3xx.h
+++ b/drivers/i2c/busses/i2c-iop3xx.h
@@ -92,6 +92,7 @@ struct i2c_algo_iop3xx_data {
 	spinlock_t lock;
 	u32 SR_enabled, SR_received;
 	int id;
+	int irq;
 	struct gpio_desc *gpio_scl;
 	struct gpio_desc *gpio_sda;
 };
-- 
2.47.1
