Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129343B7763
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088754; cv=none; b=mX1dhUu30MIKXI2DZ3nPnQdMZfGTJ7qaBOn3eRyXx+LlLENmdJxssto2nyXEGJIGppPOC90mrqpljWcXwLY+Yrg8VGKN2/Fpt6BVSPdiXSbNaDZRSjUmP841Gz//dEj/m0CZ9qMCR0gAZnrWyrskAzPEjlQFZGlrUoe1JZWXfOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088754; c=relaxed/simple;
	bh=egpSBSiiVF81IZfyLqS6u/B6Mtzw5dC3K/sD5zzWGsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYNjfDNwtWktmrcN/WikFQ5k0MrVUQ9A1TAviQS/O6XgWD9AdBjnzyM3xfFxCdbMuh8MbC5q+56WqLDwuVwTrqOgluQl7iEYe+f1/IWiXFjAVPKk0zEfsMvS/CwgPi68ZH4LDUpw3yG6pbwAcOvswEQ8sIz+ToKCiC9xipQUi5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9fvI+Om; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9fvI+Om"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bd2c147abaso11305495ad.3
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 00:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779088752; x=1779693552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9Ygl8nWXtwJ478R08EPxLQYgb2RjIx4YLds39Mkiug=;
        b=j9fvI+OmSRkQNLX+EGixpJ5QuXjyDuVdEMWQEnV+e8SllBTuqQNPFR691tbjWVjKfn
         ysr9Z3gzqP/QaVCFK9rcWIwsrZpI0yrUQxf1X+RkdARN+lKAv8y1g3TuMjsbE9PyWDPq
         4XmvxrHZPY/XuO5wFJzyMvh7JA4jdtZQBj/ydAiQ2NqhsNW8JeU3vmIioMkVFRqr15IE
         a3sXSNpgxpp4k3gIhPrsfc2I2wday9C9OQrtFssBiJIArLzQ4B3IfdOs6TZpRF2EjeRj
         C9NCx1S4dDuxNOMAeQayDcNu/ZfC2kLEiXV/CHS/LP9w3s4OxbW8uG9ued8IBCCb4V7M
         nsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779088752; x=1779693552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K9Ygl8nWXtwJ478R08EPxLQYgb2RjIx4YLds39Mkiug=;
        b=X6oyA6/bdL6XQcbaYFM6TwePIsTR/RI9tVSnC3zo/1G54OhIgjmq6RiXZMJ3SNn6AY
         YRQOEx3u8IcuiXdLB2zYA+evxjtY5UDFgyocXFlgnZJZFCvi4h1imlX8Ftjl3EbRek+t
         OnmVDteFVWRzhkMobnikLjRreWwCxgmJ9ARbyYzrSbZLu4u4BbxiZBfH9/hM/sAjCzem
         /2oozgU+REQqdoB++uLpKNKvmPAip6kywLxD5Hxp6bL3OIClnIn8aUB3bWcFr6A8caGT
         5mL1v7zoEmmmNpgPlWkR26gyp6iw5UjXknBUiAZJWhv1J0ztd7ACEmLOLBXT7F0sS+wo
         Pqog==
X-Gm-Message-State: AOJu0Yxo2DFseVZJui6/4DOddFeD5BfIr708GNPJLlizqcDy0BVGPKsg
	xH65L/fh+WBzbeRBz+WyMqiaLgsvxMQiu+OW6kSt7mgvVyGgPwlTGN6W0LhnmLDa
X-Gm-Gg: Acq92OFayUEwyr1olsiqWhAlNppa30wf3nurznRk00W5NXVMGIGoYdZPaKYYtB16TLJ
	J0RGiYim/H450YXD1aXpqOv/boEUjuSWfWjd9Hhbqc7TcQpFNY0wckw8uyh278eT56D8C2mA3lK
	nhOJuKtWHWTmIcTLBsF1/S4MkYsG+SVlK3Hk8jtJiNGKTNeC+1ePbrj7lJvW4+0ZiTRxvBYR1D/
	cFUKB30XQvB3dK2JIBuDQrxp1OyDQdK5rh9KrnevOfyL+0Q9ZfWzTY6Ef8DKiiTHnX2ppkSLPL+
	wCvVyhLVRBx8B63QxYbZatLAC4ebCsaS9dGMoGmiQMwY2NDC2b5tIVfjupSbKZdHnc4v+DLR9nw
	ty5avu0w6s8orK80WyywbXPZMjLArjGQRZJJEPaFnO5MzA6s+FLXomGgLyLBIqWjTvHWjROo8l9
	IFbRZy/5v2L9Fc4XMgDcZH3GFstqtcwLxsWpx2YzC6JNk31U0pdig50oeSTN00OESV6zjPvhUZW
	QPb1eMKianz7lr++t1CWG3n1RSfmfE227LcvfYg+OJB2gx7a2CvBFnFouSaIFRb
X-Received: by 2002:a17:903:11c4:b0:2bd:9766:bd2b with SMTP id d9443c01a7336-2bd9766be37mr109767385ad.19.1779088751915;
        Mon, 18 May 2026 00:19:11 -0700 (PDT)
Received: from hardik-yoga ([2401:4900:1c65:166e:af67:d4b8:e4e0:1695])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bdc4c2cd64sm62276215ad.78.2026.05.18.00.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:19:11 -0700 (PDT)
From: Hardik Prakash <hardikprakash.official@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	wsa@kernel.org,
	andriy.shevchenko@intel.com,
	mario.limonciello@amd.com,
	brgl@bgdev.pl,
	basavaraj.natikar@amd.com,
	linus.walleij@linaro.org,
	Hardik Prakash <hardikprakash.official@gmail.com>
Subject: [PATCH v4 1/1] i2c: designware: fix probe ordering for AMD GPIO on Lenovo Yoga 7 14AGP11
Date: Mon, 18 May 2026 12:47:57 +0530
Message-ID: <20260518071816.26629-2-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518071816.26629-1-hardikprakash.official@gmail.com>
References: <20260518071816.26629-1-hardikprakash.official@gmail.com>
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
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=221494
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 77 +++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 3351c4a9ef118..3ffc3d757fbd1 100644
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
@@ -86,6 +87,78 @@ static const struct dmi_system_id dw_i2c_hwmon_class_dmi[] = {
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
+	struct acpi_device *adev;
+
+	if (!dmi_check_system(dw_i2c_amd_gpio_defer_dmi))
+		return false;
+
+	adev = ACPI_COMPANION(device);
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
@@ -138,6 +211,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
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

