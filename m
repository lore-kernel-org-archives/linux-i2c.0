Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0572B3FBB52
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861766; cv=none; b=PiqrQm8nZSnj9OFhNhPdFOSI07GEa/9AlHS97u8Np94g7j0ZyO0Qc89/jkJ7nw9SXeLWiSfTG0iV+gI31WaOshuBVdBguYx2ZO4yVkzTBpyphhOGcqe5Zv2LX86/MqmoBiV0Mm3oiA+9pZ2ZW9aY64nmCe88OSCb6R3bCbJRVVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861766; c=relaxed/simple;
	bh=egpSBSiiVF81IZfyLqS6u/B6Mtzw5dC3K/sD5zzWGsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFV4eNRzKWoX3NBpAIagULv4mBKVv5Rc64FXI/wLV3lO1eq6Myl7+vsWHU67jNehHf1uzFIJwX9J/W8vGlaUvhmI1r/4IGVMsCXP2zwG3g1DEdHT3gD/Ce4+VPHoYq+RvS6pLYKZ7sgRwo2quvz7NmeS8ZUj+D7pD/lozX/wNDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPGtH9oI; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPGtH9oI"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c822652f82aso6992444a12.3
        for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 09:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861764; x=1779466564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9Ygl8nWXtwJ478R08EPxLQYgb2RjIx4YLds39Mkiug=;
        b=gPGtH9oIfAbLgkTaMwBrrbpeZh/EQ0zN7U1PwungUYTPwUTLkEI20sWVepTA4Crvox
         RRnEpEA1M2xuCKMMjtdIgNtG6d9/ChgaNVq348G5IPL6rl/j4/wY8VFdWyMOnAdu9QqJ
         d4nOSWzyP47LKuRVXTZ16jss/BzbPNBJpR4sBlQMPJsGbIHGOKb1RzU4UL29SKBb0mnM
         xe4E7MicIaKT77eW+6C+HYqR5icA8ux/in3HzrAe7JFV5+rCLklmMa+q7Re+dCBM1k/d
         sEH1HXkU8fjuMSPYh2QjihufUVWzST3gqskoeBcfM7h2U5zk9j5TVZzkUu6aHRMCzelm
         j6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861764; x=1779466564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K9Ygl8nWXtwJ478R08EPxLQYgb2RjIx4YLds39Mkiug=;
        b=aY37R12ucMZzsvyfdOcHcaEoVo1vN6ShRWfOBkDtKi7PYY41FgSKjBz0UYs1ozVRMw
         2GgVrfYCVmvTWHhFBuHjvBNl6BgVcNjCE9btRznJtQqLJlnYeCOrDALFmQimgSYi/qEJ
         P1qHk3SrUB6Sy95p731X+aNAs2yHdLq+kIvfquR6xVza3kekO8dav0LVzDTuYxWxX1qJ
         i0a5MVTJjSwqkw1Gyn46Lio03NlZuGCRI2EPg1FXDqUNbZG7/LhdnJZnbHPyiRw09GGJ
         sK3isfzKsGe7C9XmjwAd0qKE3odml5sbDTjzUslstpozlCN55Yt14WqtKChRpQY25zLC
         AWxg==
X-Gm-Message-State: AOJu0Yze3VBL9VDrA9nEq5czsl+J0jL+LtjMH+ayhyvcoz6977W52zh9
	3JHAqDt9IvKtK0US4daw0TMdMIUwjr7XOKxp6X1AXFpE7fzcJrxGKWBLhYvwBo93
X-Gm-Gg: Acq92OHLFE2dvBOBJtvNvNLhvVTZyZyADeWJMaPNW5YC9VsXr4+3MUCd1mxhUeYlw6z
	vX/F7e9SwGOgzIzVIVLV1KgtpPGmC6/Ntz1BeDWNeJepuLY7BmI01rU2sGgYmTumD0ukcG4KPxJ
	nz8gmxCQg2QLBB3RxYHCqpXZO1e1NLD3Qdi0Vs3IaKstLGjcCHV6Oba8/x33mQmZX5zrF/ZNk+o
	Kuye9vk2Ow+JcUaDcYJ9TaxfRT3HXrszE4IG3Fwym9F29KyTNBRhhQOCdKNSWbyw43ICyZyD1t9
	azmQJLvbTeaWF1JUIcfuHQMfN+ibOoyuaekMrcmDrQKKw1kvOa+s7IHzOgm93PexzlOdTOWbCzZ
	iaYVHa70vt2Xzh2kn1xMLauiQHeXrGsDiJCt/6xffacbzQxYiXMZwYdie8v2LRt6utv5BHWFmcx
	83tfOEqWd1TRm1S3NWcR4LeSRLyCL1YXws0hB2UfLr+8hLlwomRFLiy/7Yp2Ozy7lNCMWig0ffn
	rn/f/EAN/JyA6uHP2jtyj2jtk52Ug9i94gcEiH9QJE1zpaP+MYjNqdAo9ZMR1g0
X-Received: by 2002:a05:6a20:7d9f:b0:398:7792:3882 with SMTP id adf61e73a8af0-3b22e823125mr5509269637.16.1778861763631;
        Fri, 15 May 2026 09:16:03 -0700 (PDT)
Received: from hardik-yoga ([2401:4900:1c64:ff18:3fa8:7855:804e:9f49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb062a2bsm7699036a12.7.2026.05.15.09.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:16:03 -0700 (PDT)
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
Subject: [PATCH v3 2/2] i2c: designware: fix probe ordering for AMD GPIO on Lenovo Yoga 7 14AGP11
Date: Fri, 15 May 2026 21:45:16 +0530
Message-ID: <20260515161516.10474-2-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515161516.10474-1-hardikprakash.official@gmail.com>
References: <20260515161516.10474-1-hardikprakash.official@gmail.com>
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

