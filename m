Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526FC3672AA
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571272; cv=none; b=sE0IJDw9eEQhR0WFj6Mo815Tm18Z/gHrZ/T+k1sGWU8s38aMu0MFPhac/JrR5QvQqnQmYifc6Tqn6INk9uT5/L7dZTPV9h1MhixgEgH6zg9xu/aGDO1mNJ+EiB++ZWxB2oI10VcPOYeMQshbhHHnBOrdH5S/vSqoLf7pSo46dB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571272; c=relaxed/simple;
	bh=t1XG/Pl14YN/6UQXaghjEzoaUjADDTxVxBV/J7INaiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WItm7GmOq+Gsq0osG+QGmls+evgd37g0BLlIxzaohZXqmoDpnA3XCCMFKVFW2OTUV9f71vt0uK8GOG5KxmUy2JT7Fz95LzeNzuHHjD3s8ZsVEFNsuhZBa9o15+J4ZMaF/6luRBKG6BmRUQdtgoPrGzvYrqBAIG2GzH7Iby9cBY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKFpCSRH; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKFpCSRH"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-367cbac9cb1so3093370a91.3
        for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 00:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778571263; x=1779176063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etg83PviE/w1g4Vyc9uQdtlXTJeI/QHOPu5afMb3oNY=;
        b=LKFpCSRHn1KiDKpELsS5o4vYvnlOdEP4K5iNs2J8qAYF1FfTV/KAD97Oy3jR6RBRT+
         jCqiW0wkr7uQPBBBeZIZM8HJBhkkt8d8RANbaSc/OrhKKoH+SSCohfqrcwAF/cC6k3ZC
         jDew989B2HF5Kn8bFRw1D7Il1AmCU9rJ1T/bifjBi/Rf1anBbaJTsMklV2UWP8mIQp2A
         6HteVXT+R5Y0tApcAK29+nrNmOculpTukgHbx5wy+HgstOecjahWZZuNNnns+jUCpdau
         BF7Tg7lIwPtzAWhBQa38j0tHlmT6x9bdryzbJ9nFevPLDK5Hyb4+qQUdw3PqmuEH3Vug
         4gUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571263; x=1779176063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=etg83PviE/w1g4Vyc9uQdtlXTJeI/QHOPu5afMb3oNY=;
        b=TXA5lGXnuwUdk+XwboQNcMHtvoo2+TgkLJTWZRBdknmK6bou7vhU14ooGu8lcYPQgj
         6RZOrQZDhqRriCRYJpFkQP1ZpgDpKr0M8Bt1RpgZrdZII6qEIS5covRSt2zsAL636oHO
         9dXV+SFUy4DL/l91ejolmHBYaJuMJr7prVUbExVajSL04R3I7BUyzDNfbaPCseNzr9ZF
         AfA+o5P1dxrBbIeU/Qit5XrJsuwDBVGJEyZNUBRLXRwIhStEIfhpt5usYSJS+wf9YTnx
         7AjOO2G83ahV2t2Qy0MtKIvIj6Igz17eMgmDGgVlhBkPnox4wVlnddRXR7H2I7Dc6jsu
         U3pg==
X-Forwarded-Encrypted: i=1; AFNElJ8Z/qwLpF3seElo2SFYy7L/gTjGjA5p529j2jWhoY7hQ8j3dJf53YStUqPh6101+l67zadtHtKxjFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS2Y2RZtEdr80TC5df6/vGZ/X/3e7xXIgWoVuBKvnI3KmGhTZ1
	QB5eLskrvlWgOma86lhg0DM7vyaLSrK8NH77etYwl9EzNSbXNX1V4Mpx+BeJI27WyD4=
X-Gm-Gg: Acq92OHfO+batIGFiqqjDxoA/6H2J6zFKoSCoYvOPl2YOfVMWulcErvFGWQd6qXkjne
	rwSqAg/LkRhio7YQgqzCsg+IxEA3zyENk6Whv6VKwTlN4g7/PAX3ey2yjPjLx5+tgmxqQBunWAm
	4g3Ek6/2WAxWJZKoYSsMp53gKx1xOjmwReZmxNWfgkj8Lzh3+jAs3E8gZ2sGgBgkOl031lem2Kd
	mMIB9bF2kM5xnAmPkqAwwMhV34Uk8/Vrn6xdYL4U6Ttkus4vpoROjuRu669iBWfqOPo/aBkosM5
	XtOs4jvNEdXUg1tBR+eEtAY+p4FKYAgQbqqYVU7BMcXegaibP/XrY3XjkaG8pTQ+bX4UF/9fN8j
	ej23+Qn9AuHCu5fK2DQ/ip8jbViAK/Dk0sbXZSPOs3rgdW35sOowisq/jK5XSDJ58Sgr1lkjy+F
	VoF/x3UGeEGszEisnmqw7d39w116ggOUQr/JG/bxxwbnSvaxq4uSVS+E104YFOGwQ682lp3gV2H
	048GWj7A1Ly1WccTq+G1z6QLThJrlezhID2rs23JEabTT13/Ut8ewRxBspfQ0Q=
X-Received: by 2002:a17:90b:52:b0:366:52fe:e749 with SMTP id 98e67ed59e1d1-36652feecdamr18593148a91.5.1778571262728;
        Tue, 12 May 2026 00:34:22 -0700 (PDT)
Received: from hardik-yoga ([2401:4900:1c23:32d:3989:a15e:2491:59ba])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d63bad27sm12420410a91.10.2026.05.12.00.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:34:22 -0700 (PDT)
From: Hardik Prakash <hardikprakash.official@gmail.com>
To: linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: linus.walleij@linaro.org,
	wsa@kernel.org,
	Hardik Prakash <hardikprakash.official@gmail.com>
Subject: [PATCH 2/2] i2c: designware: fix probe ordering for AMD GPIO on Lenovo Yoga 7 14AGP11
Date: Tue, 12 May 2026 13:01:39 +0530
Message-ID: <20260512073139.16343-3-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512073139.16343-1-hardikprakash.official@gmail.com>
References: <20260512073139.16343-1-hardikprakash.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing dw_i2c_amd_gpio_defer_dmi quirk for Lenovo 83TD checks
gpio_dev->driver to determine if the GPIO controller is ready, but
this pointer is set before pinctrl-amd's probe completes, causing
i2c_designware to probe AMDI0010:02 before the GPIO IRQ quirk runs.

Switch to device_is_bound() under device_lock() to correctly defer
until GPIO probe has fully completed. Also replace the string-based
device lookup with ACPI HID/UID matching for robustness, and add
DMI_BOARD_NAME to the DMI match to reduce false positives.

Fixes: the lost arbitration on AMDI0010:02 at boot on Lenovo 83TD.

Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 81 +++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 3351c4a9ef118..ccf4433a1d4fa 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2007 MontaVista Software Inc.
  * Copyright (C) 2009 Provigent Ltd.
  */
+#include <linux/acpi.h>
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -86,6 +87,82 @@ static const struct dmi_system_id dw_i2c_hwmon_class_dmi[] = {
 	{ } /* terminate list */
 };
 
+static const struct dmi_system_id dw_i2c_amd_gpio_defer_dmi[] = {
+	{
+		.ident = "Lenovo Yoga 7 14AGP11",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83TD"),
+			DMI_MATCH(DMI_BOARD_NAME, "LNVNB161216"),
+		},
+	},
+	{ } /* terminate list */
+};
+
+struct dw_i2c_hid_uid {
+	const char *hid;
+	u64 uid;
+};
+
+static int dw_i2c_match_hid_uid(struct device *dev, const void *data)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	const struct dw_i2c_hid_uid *id = data;
+
+	if (!adev)
+		return 0;
+
+	return acpi_dev_hid_uid_match(adev, id->hid, id->uid);
+}
+
+static struct device *dw_i2c_find_platform_hid_uid(const char *hid, u64 uid)
+{
+	struct dw_i2c_hid_uid data = {
+		.hid = hid,
+		.uid = uid,
+	};
+
+	return bus_find_device(&platform_bus_type, NULL, &data, dw_i2c_match_hid_uid);
+}
+
+static bool dw_i2c_needs_amd_gpio_dep(struct device *device)
+{
+	struct acpi_device *adev = ACPI_COMPANION(device);
+
+	if (!dmi_check_system(dw_i2c_amd_gpio_defer_dmi))
+		return false;
+	if (!adev)
+		return false;
+
+	return acpi_dev_hid_uid_match(adev, "AMDI0010", 2);
+}
+
+static int dw_i2c_defer_for_amd_gpio(struct device *device)
+{
+	struct device *gpio_dev;
+
+	if (!dw_i2c_needs_amd_gpio_dep(device))
+		return 0;
+
+	gpio_dev = dw_i2c_find_platform_hid_uid("AMDI0030", 0);
+	if (!gpio_dev)
+		return -EPROBE_DEFER;
+
+	device_lock(gpio_dev);
+	if (!device_is_bound(gpio_dev)) {
+		device_unlock(gpio_dev);
+		put_device(gpio_dev);
+		return -EPROBE_DEFER;
+	}
+	device_unlock(gpio_dev);
+
+	if (!device_link_add(device, gpio_dev, DL_FLAG_AUTOREMOVE_CONSUMER))
+		dev_warn(device, "failed to add device link to AMDI0030:00\n");
+
+	put_device(gpio_dev);
+	return 0;
+}
+
 static const struct i2c_dw_semaphore_callbacks i2c_dw_semaphore_cb_table[] = {
 #ifdef CONFIG_I2C_DESIGNWARE_BAYTRAIL
 	{
@@ -138,6 +215,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	struct dw_i2c_dev *dev;
 	int irq, ret;
 
+	ret = dw_i2c_defer_for_amd_gpio(device);
+	if (ret)
+		return ret;
+
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq == -ENXIO)
 		flags |= ACCESS_POLLING;
-- 
2.54.0

