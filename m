Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D0F35E957
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049353; cv=none; b=r/50MH+jSJCJPTiTvJ2xULjiF8pO39/hSxWbUcXCAl3lqsqjh8TASm+B/YwaCqUxifkbSOt4fx+KvzgCmbYonnuWlrpyBhqvSk2/UMENI8wDX2bUElhuRl1yzHH+/WVr6jrtydTxw0W//SiaSMGz7It1UefhN1Fw+5tucd34DQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049353; c=relaxed/simple;
	bh=a/OpJMsrZEY9OEjNsUXOYseMRjwbQc2doP8rUzmGenU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xmx4Mx7XcOGlmNl5D7R/LBanZeV4hmUutnR5WB7ap0/y896Bf+FiVG6Ybnldu+8bm8Nz3tvBsHOxpdVmdYXb3Jqur6jMvNc3AHSbUiCjzDP9r/KA49jkoZ2tFpu8HY9/eIiwTSw9Zffzd0nfyTMK9X/KNJCHhqBfz2reVgDLR8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoVnyX70; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoVnyX70"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2baca4df358so87947865ad.2
        for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 03:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780049348; x=1780654148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHr0wZ9EwQa/c6Vk+G+u2Owq7gK2jir1dXtjVgyxJ90=;
        b=QoVnyX70wunVLUcfFiNvbgPnfhz/81+P6xQlY+cSuwqjzt+9EGA5k2W/i9Cd3Yp6e8
         +AL3AiU0vbDlzBPq3QV25w9Vht7+GnVAsOqOAmTNWJ5v94jdmNmQWwNNTZHshHtEf22Y
         roJXZJp8sgfUg/Iw3tox02n43Cg7vpiI45eT12DeyKaz44v44zVUziK62xUo1lK77axH
         jD6EbP45Ht86HNbpB7UgXyQXP3feDbSrMrM1aY3zlNboO90bloxeyfBkaFjZ1X1pHwbN
         dOM//HghgK9EhC80p9YUV+ECOWnMa+V6vUFRrp4S9sw2Lq3kwQyVNNXk3JPfS8bnD4Y7
         7COA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049348; x=1780654148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DHr0wZ9EwQa/c6Vk+G+u2Owq7gK2jir1dXtjVgyxJ90=;
        b=nJ6y5IRaPHRYf92F0RsYJ03FMPdqfwLwg1+j2qXaoYcF76pikFubcmM3buz2rAWiR6
         gW2AgX+0eo/1WcU0+4YVspsnInQx/0NK1swqHnSBCdNG1cr/fMEfggYKsO6Y4puQitFs
         eXdT3CzuEqC/buyJQ3b2W0pQUcWW3yleihVwLpjOjh7nFIwFHTrlADPKz58Zam++szN/
         BKKF/1+deNkwaAWpZMK0isBlES3JRV9H1H4SDe+ThacdA4Xo3T2TF28kFXnEn+NBGrYz
         ZBT4wcZPgZEraavU0n483Kc9AbhyVnpABt3U3VZ61ZdQQUHlTcKwmT2rSJFlQJkG436I
         j9nw==
X-Gm-Message-State: AOJu0YwYy8htCGxoPIu85BYE/zTgArsYlenkmDRyW3XfJgamjv4Zp4w6
	3D+9LWqow791xlHz8VPjKubvosHV3NkUxf7/nMKpwgZnaCMAgcObS0D6BHorrAH4
X-Gm-Gg: Acq92OH2MOlH7F+nlCoXJUA4qtNTl03RpK81fvwXLiGn69pDKP/xJG0TGVsmlnApjJn
	XWoXxtDnZ9/yAMCs7RFoGo3qjBLArvhghtt2VJEJg3mme2FxRMfwOYKjmgNl4tajgDMn4bNQRkG
	apKe6ffETcm9VZlfXKt5tJOdhVSECMlPY9WAFOyqB4459B1MyiY0kdTS5gvJQ876TDBfwiWcy1d
	8NLrW3S4Ojt2FANbGLY+6YBxtu0YwFNv27DKZIorA1nDqHJeIc8TaVO36KCIlhJLw+0IzSw0cCC
	nNfd2N2hZoYk3lB1OCckvUPnSgig8yOgAr1qcTzKod1rP98J5a5rGq9AczlzNlu6+1pVGNSmkhe
	n6cuHRUxq335Trw6R7LJoVtetfZ521HSda6cI7st3GqMQQPX8eFcaiqpiwI1aUXI3uXPqfalVnD
	HLb6S1zRbhsTd38inut1H0waCnvel54+KgR96+zlPCkHmWVNLxRgMwf+qGCMI8o5gfPfxyAbpLY
	AugBMvLgAAY9awh2quIO4uX4JAhArcsv2KayiankAWWnYyLTKSEFl2LKQJGtrgOh60bW1a3qGE8
	P+Bft6qgwczNErTxZfsoLgE=
X-Received: by 2002:a17:903:2986:b0:2bd:b585:55f5 with SMTP id d9443c01a7336-2bf204d973dmr28431175ad.8.1780049347629;
        Fri, 29 May 2026 03:09:07 -0700 (PDT)
Received: from hardik-yoga.oryx-cobra.ts.net ([2401:4900:1c22:2195:3f68:8568:1e68:2087])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b0122asm16051225ad.46.2026.05.29.03.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:09:07 -0700 (PDT)
From: Hardik Prakash <hardikprakash.official@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	wsa@kernel.org,
	andriy.shevchenko@intel.com,
	mario.limonciello@amd.com,
	brgl@bgdev.pl,
	basavaraj.natikar@amd.com,
	linusw@kernel.org,
	Hardik Prakash <hardikprakash.official@gmail.com>
Subject: [PATCH v8 1/2] Revert "pinctrl-amd: enable IRQ for WACF2200 touchscreen on Lenovo Yoga 7 14AGP11"
Date: Fri, 29 May 2026 15:38:36 +0530
Message-ID: <20260529100838.8896-2-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529100838.8896-1-hardikprakash.official@gmail.com>
References: <20260529100838.8896-1-hardikprakash.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 3812a9e84265a5cdd90d29fe8d97a023e91fb945.

The probe ordering fix in the following patch ensures amd_gpio_probe()
completes before i2c-designware probes AMDI0010:02, allowing the
existing amd_gpio_irq_enable() flow to work correctly. The manual IRQ
restoration added by this patch is therefore no longer needed.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221494
Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
---
 drivers/pinctrl/pinctrl-amd.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 64315b0edf2a..e3128b0045d2 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -26,7 +26,6 @@
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
 #include <linux/pinctrl/pinconf.h>
-#include <linux/dmi.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/string_choices.h>
@@ -40,39 +39,6 @@
 static struct amd_gpio *pinctrl_dev;
 #endif
 
-static const struct dmi_system_id amd_gpio_quirk_yoga7_14agp11[] = {
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "83TD"),
-			DMI_MATCH(DMI_BOARD_NAME, "LNVNB161216"),
-		},
-	},
-	{ }
-};
-
-static void amd_gpio_apply_quirks(struct amd_gpio *gpio_dev)
-{
-	const unsigned int pin = 157; /* WACF2200 GpioInt per ACPI _CRS */
-	unsigned long flags;
-	u32 reg;
-
-	if (!dmi_check_system(amd_gpio_quirk_yoga7_14agp11))
-		return;
-	if (pin >= gpio_dev->gc.ngpio)
-		return;
-
-	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
-	reg = readl(gpio_dev->base + pin * 4);
-	reg |= BIT(INTERRUPT_ENABLE_OFF) | BIT(INTERRUPT_MASK_OFF);
-	writel(reg, gpio_dev->base + pin * 4);
-	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
-
-	dev_info(&gpio_dev->pdev->dev,
-		 "Enabled IRQ for GPIO %u (Yoga 7 14AGP11 touchscreen)\n",
-		 pin);
-}
-
 static int amd_gpio_get_direction(struct gpio_chip *gc, unsigned offset)
 {
 	unsigned long flags;
@@ -1253,7 +1219,6 @@ static int amd_gpio_probe(struct platform_device *pdev)
 
 	/* Disable and mask interrupts */
 	amd_gpio_irq_init(gpio_dev);
-	amd_gpio_apply_quirks(gpio_dev);
 
 	girq = &gpio_dev->gc.irq;
 	gpio_irq_chip_set_chip(girq, &amd_gpio_irqchip);
-- 
2.54.0

