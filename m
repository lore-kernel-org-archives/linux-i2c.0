Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7D43D3337
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 06:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778652868; cv=none; b=Jo1vS9vXV8MgVSkK/MinrvmqauG86bdkgOrj8xmO5y5LPXHwCiCuWdbi3PQBfkoCbxOyHS16geZrRbGm0kWpEEaS2WrEB761nsl43fqjmXbT/0xMnArvOJ4zkFpWS2YMAJcHy0c1vbOqWjgawAqErQJmRBJpx5B+QRAC6L9MWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778652868; c=relaxed/simple;
	bh=WXpOlephWbdONJJApjAJQhKnhGSv2ntb8lLbb12ioZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiI6HA4pqzAm5gXy09necWDHD3PCTuAxKmEgWJWd3Hdu77GkuEo2fs2XJ09tpJtIEERVXn8fhLLGG6/hjaEv1vqAWTrfBrKYmIPZ8A4VhIz57CoUqsc43SeVwVBdUVNQmar/Ybqg78iR41yNed23aVt/aY26dLznEcSan1tONQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrmFiv3G; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrmFiv3G"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c796163fac5so4579204a12.1
        for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 23:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778652866; x=1779257666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyjHk1Sfn2/DlBLKAWJUgj9QQZN9N3eP8M75DdhK7S0=;
        b=CrmFiv3GEaBGWa20h61zur0kq907TbF7Xh6h8W7WjXF3uWI3rxyb9UzoTAXdjMPuQd
         N1P/1VRAUvqgyTqCAG9e7jpikFeOaBJFlctwzVVd7q7MK6JpDVKvAtOCnkmGbqg0BcO0
         BT133nLoKRF+zVCCauhpMsYa2zcBLEukEd2B5Lwttr6QD2Unvq8k8b4eHMnhI5gTOYj5
         LCjDBdaGsM1JoNMWJMlEPhrJGZYlvpM35UCM9edeLy+2pGgZ7IuC2FRM7AtlYkwDci16
         ISxWNR9Yk4aTwTuDdxGRqOqoz2GUPdZ6w3w05s9JtAr7I+5xAXkVosMCSOazEDE/VOnb
         30pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778652866; x=1779257666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MyjHk1Sfn2/DlBLKAWJUgj9QQZN9N3eP8M75DdhK7S0=;
        b=gvPyUV2VUo0s+qTxS/vqQVwVKkOpu/9caRmX6wNVeFDIiu+OgmWAWexJredHWIgp3+
         cheeEiehNvzTH87EThMpt6qrwIelajnZHh76fm+nfIkd4dSHIJIeb1VnSzvxXqJGnT2S
         O786MVRSu0DuM0NodCR7Uye7YeL/KgX32wiIgAGzWtW79fVpcuMhiv8dx4eXhLbdoQ6a
         MN/xGrjT0E+ODg6HoWIhtU5TpXERNVo1DFGwyLDTDga/fLJXYZxdFGhKxanr0afg5Ugf
         UdajWhucWdCNygEp6/vKovzlwl35pb2GHQuQHpPGwycA6PxR2t844pq3eyL7m8CE3vYd
         XRog==
X-Forwarded-Encrypted: i=1; AFNElJ+chdoX7EB3MlnwSFYMGqM7dZz5QnCcFtFf6jRYbBEvcrVg0oRtecc6D6XUGjXppkL2P64boPwU1oY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHah6BP6uJaypA2kUiUSE7jxapLUSV2Mz1QVlytuJJypZxYmYy
	ZN7ydLnpmNRJ/0/uQSsbULQ4/96uWTArI0Zki6C2DLwbtGKqVrnJ4Sb3
X-Gm-Gg: Acq92OGvy/JeFI4gQBQmGGRCPnx3OXU5IYafPkg3plpy77V5W2kR6HMm55fF8Ksg7Me
	xJcaE5OMcLjOqWu8p55VGu7/Mjz0qdeiU+/SWl1Q+Wpo5lI8Dhdow270kDTqYGtYN9c7rKHOz3Z
	abwLTqrZD0QRtSkRDonqSRfJNoJCLW8MLJicls84AMtFoanOF9a7eMDh8Gst09VekTE6FacOQwy
	RXdMayJDlAm4SOga9FR5IEtTSsFIU1tsbCQG2MOYqITkHJX5zmN7QxGRsn6gyUUUZwi7zyoNZ5T
	knleGnK0xD5HvhVKGDjnd9dXtDkc9KJUzSf+SyMooc6Vhlevb5A2lJNNjbN1TLRYONLKDABG24c
	3sBRtCbaFCdjjQ/2QnwxUHF8TVHlL1Z826JOpktRxKfdOz6a33p2CZvD7jjNWytK/qzzLbHcEiH
	nFcJxquqI7WxQFoJrh0HZxrnHXjUb70WLuMVy2WXFkMxSjKm41xj+IeJGkRXBvg8PIdMDbGzNwQ
	ALJzx1DRrCElwwiVyEYfENs0a8/zxYKlb5gEgyHCNtsSwow9mt8OIJXXQkhLNAo
X-Received: by 2002:a05:6a20:3d90:b0:398:919a:ddf5 with SMTP id adf61e73a8af0-3af8137c3f6mr2143737637.24.1778652866100;
        Tue, 12 May 2026 23:14:26 -0700 (PDT)
Received: from hardik-yoga ([2401:4900:1c64:ff18:3fa8:7855:804e:9f49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826771a8a1sm13470874a12.24.2026.05.12.23.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 23:14:25 -0700 (PDT)
From: Hardik Prakash <hardikprakash.official@gmail.com>
To: linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: linus.walleij@linaro.org,
	wsa@kernel.org,
	andriy.shevchenko@intel.com,
	Hardik Prakash <hardikprakash.official@gmail.com>
Subject: [PATCH 2/2] i2c: designware: fix probe ordering for AMD GPIO on Lenovo Yoga 7 14AGP11
Date: Wed, 13 May 2026 11:43:38 +0530
Message-ID: <20260513061338.9348-3-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513061338.9348-1-hardikprakash.official@gmail.com>
References: <20260513061338.9348-1-hardikprakash.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Lenovo Yoga 7 14AGP11 (83TD), the WACF2200 touchscreen fails with
lost arbitration errors on AMDI0010:02 at boot. The root cause is a
probe ordering issue: i2c_designware probes AMDI0010:02 before
pinctrl-amd has finished initialising, so the GPIO 157 interrupt
needed by the touchscreen is not yet enabled.

Add a DMI-matched deferral in dw_i2c_plat_probe() that uses
device_is_bound() under device_lock() to correctly wait until
pinctrl-amd's probe has fully completed. Use acpi_dev_get_first_match_dev()
for robust HID/UID-based GPIO controller lookup instead of string
name matching.

Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
Assisted-by: Claude:claude-sonnet-4-6
Assisted-by: GPT-Codex:gpt-5.2-codex
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 75 +++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 3351c4a9ef118..35fa4bcafc7ad 100644
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
@@ -86,6 +87,76 @@ static const struct dmi_system_id dw_i2c_hwmon_class_dmi[] = {
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
+static bool dw_i2c_needs_amd_gpio_dep(struct device *device)
+{
+	struct acpi_device *adev = ACPI_COMPANION(device);
+
+	if (!dmi_check_system(dw_i2c_amd_gpio_defer_dmi))
+		return false;
+	if (!adev)
+		return false;
+
+	return acpi_dev_hid_uid_match(adev, "AMDI0010", "2");
+}
+
+static int dw_i2c_defer_for_amd_gpio(struct device *device)
+{
+	struct acpi_device *gpio_adev;
+	struct device *gpio_dev;
+
+	if (!dw_i2c_needs_amd_gpio_dep(device))
+		return 0;
+
+	/*
+	 * Find the AMD GPIO controller by HID/UID and get its physical
+	 * platform device. We need the platform device (not the ACPI device)
+	 * because that is what gets bound by the amd_gpio driver.
+	 */
+	gpio_adev = acpi_dev_get_first_match_dev("AMDI0030", "0", -1);
+	if (!gpio_adev)
+		return -EPROBE_DEFER;
+
+	gpio_dev = acpi_get_first_physical_node(gpio_adev);
+	acpi_dev_put(gpio_adev);
+	if (!gpio_dev)
+		return -EPROBE_DEFER;
+
+	/*
+	 * Check that amd_gpio probe has fully completed, not just that the
+	 * driver pointer is set. The driver pointer is assigned before probe
+	 * finishes, so checking it would allow i2c_designware to probe before
+	 * the GPIO IRQ quirk in amd_gpio_probe() has run.
+	 */
+	device_lock(gpio_dev);
+	if (!device_is_bound(gpio_dev)) {
+		device_unlock(gpio_dev);
+		return -EPROBE_DEFER;
+	}
+	device_unlock(gpio_dev);
+
+	/*
+	 * Create a device link so the driver core enforces probe/remove
+	 * ordering between this I2C controller and the GPIO controller.
+	 */
+	if (!device_link_add(device, gpio_dev, DL_FLAG_AUTOREMOVE_CONSUMER))
+		dev_warn(device, "failed to add device link to %s\n",
+			 dev_name(gpio_dev));
+
+	return 0;
+}
+
 static const struct i2c_dw_semaphore_callbacks i2c_dw_semaphore_cb_table[] = {
 #ifdef CONFIG_I2C_DESIGNWARE_BAYTRAIL
 	{
@@ -138,6 +209,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
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

