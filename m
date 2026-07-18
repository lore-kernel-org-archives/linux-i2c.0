Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6EC261B91
	for <linux-i2c@vger.kernel.org>; Sat, 18 Jul 2026 05:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784353599; cv=none; b=Pu1Y1+gziqHu2LvTERZUZd1F1TbJALfG7Vcj1SWiy7p7JFkvjBbNx1MEwP8bOTTSEYwmh9jvtdxHw56ME12gincnSq6WYzmrfXtBgxFuLAFwgiDf6SDisTHz7OGCh3LnWm+18pX3nMjx6N0vwzpXhjX3YWjUEo7mHQPxIz/A2vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784353599; c=relaxed/simple;
	bh=uUKvdVuw5u8PPz5ZSlCVtOEoqKVdYy6pRvGVbTZ8pgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q+RdMs8ll5EezebjIUY/HfJ/DUUjEhb+aKolN0nHKUiAIQyo9fov1xc3TSfV2JEY4LV+BeJK09ZJFOPEMghfcrmG79a93HoQLjoCLe912pChxuiEsJP6WsP7GXWMhlq88ganQ6wVsICz8ksxbTLhgGyCPE1NXtV4u1Jzg7UFqho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZA8PSAW; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZA8PSAW"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-848d21bbaffso8456116b3a.0
        for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 22:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784353597; x=1784958397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AzjmWUbHMsLucqNwv6zpk+CDzSMxPFowNwCFtEwRn2o=;
        b=CZA8PSAWr5eSIVX4kmj1GFG3J/jKbBO0RJPzsZW+dpKAwkeSMO4Kkr2DbFgTmAhkku
         BQdw0GzjgijIa0ogOXAaghfxLE/9a87VDq4B6F8Lq3wZUYq6k2S/KgOP2v2lIWYs1Y8X
         IwpMoJ8L0gm6XyEs5dDrIgLVMlIa1me0C267x3qWggNt8oHXNc/aJoMAS2mvnu1UnE+m
         dc0Y0pc/isdDg8WsBJzq8x220qXsMzeP5H6Aig/Pnx8ausG0Gel400FIjNzolhduf9YL
         0SeVbeIv44YezfgNHusqf/jA/nSce7Iyz4uRbSSBFWDtU82T+9oZ0dSB3Wayj0KDGeFv
         XW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784353597; x=1784958397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AzjmWUbHMsLucqNwv6zpk+CDzSMxPFowNwCFtEwRn2o=;
        b=jYYHej7R0+b4vMqeHJ+nbcvVsiIeKRL57u5dJyjFyd91rgH6UIBE0gSY2UGc5ajwje
         l0GeOcHZ26E6pTbsosaUE8oeEfFHV9/6siarWWFkDYjnhKLOsj5R4sEBOt2BNSxEem3M
         Pqh7EqFAiO+ONq8+23XwvSceUUbqWNeeMiLKUT305EueygNwkTlhDRgTsJFIWMVrRvUI
         hDKcept4Gb8tefHqhxPCdypDoVxL7svuaq29jQ1oqowXdduC6J7g/ELNID6bOhIacPm6
         d2ryCf6LwiaHFykqVHjh7gw5RY+FyfysyVsGQVwlnmQO94aKAuaOS9tKOSJDKtdMmINU
         sfvg==
X-Gm-Message-State: AOJu0YzjB5k+sVGkowqcDcLCuD71EyvDWmaN51I3fG4DnPZWFv89VYRU
	Gfz0+vShMnYBBhTfbacDuhBT9zge7yDK9Ty3aFpUI9uCzDvQez2wvonhCJRq2c5V
X-Gm-Gg: AfdE7cl9RawN42KH3NPl1h2nqY1MnbyXSQE9lipG17lXwgDP3bkCuAVU4noZo3aDij7
	CVXsk+hhAJyvfJI+P8XmXK3yyV6rIcdZpo3nyRAd6+OwBNnGXU/YC3JIJ7BCUn9sLDOI8B7f9kp
	H05pizdQ3PCijs3QYS2u0VzE1v0oPRAzkHe7G1c1E0s9pM5zhXs9CtA3r37+cZd9gnVc5UAGtoB
	/FvccfkPCLR6M6mbiDhPpVmEjDXNiOZvGHG9D3yRtI45Iu8OHVOQkop4+HE82wzdsMgUeC4+ZaV
	fKnXktAIKbwFWnMeghLwUPafcO4MjdOIwYfP4LTTbqOJR1iwy910LPFtScVXtRo9Q6NtLPCZEud
	FsMt6+UEKg2BfBbXKhUrhlIM0EIkJ7BJKVUtjhaWH0Djyf+41Z97KU0E2x09/qsGpzeYWxUlUWm
	y6u6CW52Gor3hyrD69HjNdBpkdo4O+ii5zrXrTcosvVs8bPPOZqcyhgeIXFDZGrCLF488Wb/Kiy
	Xd9qGIPg0VbGrRY8wuseBeRPrgmdAg+809u4m0kmcBZ4qhsGepOio9cuSQQMWUI/Q==
X-Received: by 2002:a05:6300:2289:b0:3c3:a546:12a2 with SMTP id adf61e73a8af0-3c3ad975d93mr5895431637.52.1784353596504;
        Fri, 17 Jul 2026 22:46:36 -0700 (PDT)
Received: from hardik-yoga.oryx-cobra.ts.net ([2401:4900:1c65:6c8f:5cab:df22:e20:58c4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20c158sm14310101eec.29.2026.07.17.22.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 22:46:35 -0700 (PDT)
From: Hardik Prakash <hardikprakash.official@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	wsa@kernel.org,
	andriy.shevchenko@intel.com,
	mario.limonciello@amd.com,
	brgl@bgdev.pl,
	basavaraj.natikar@amd.com,
	linusw@kernel.org,
	nathan@kernel.org,
	chaitanya.kumar.borah@intel.com,
	Hardik Prakash <hardikprakash.official@gmail.com>
Subject: [PATCH v13] i2c: designware: defer probe if child GpioInt controllers are not bound
Date: Sat, 18 Jul 2026 11:13:31 +0530
Message-ID: <20260718054330.8975-2-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I2C controllers may have child devices with GpioInt resources that
depend on GPIO controllers being fully initialized. If the I2C
controller probes and enumerates children before the referenced GPIO
controller has completed probe, GPIO interrupts may not be properly
configured, leading to device failures.

On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
fail with lost arbitration errors:

  0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
  0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
  0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
  2.348157  lost arbitration

Add a dependency check that walks ACPI child devices and defers probe
until any referenced GPIO controller is bound.

Fixes: 3812a9e84265 ("pinctrl-amd: enable IRQ for WACF2200 touchscreen on Lenovo Yoga 7 14AGP11")
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
Assisted-by: Claude:claude-sonnet-5
Assisted-by: DeepSeek:deepseek-v4-pro
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221494
---
v12 -> v13:
- v12 was sent as an incomplete diff (generated against v11 rather than
  against current master due to a git format-patch invocation mistake on
  my end), not a real standalone patch (Andy Shevchenko)
- Not carrying forward Bartosz Golaszewski's v12 Acked-by, per Andy's
  request
- Add blank line before guard(device)(gpio_dev) for readability (Andy
  Shevchenko)
- No other functional code changes since v12

v11 -> v12:
- Move gdev declaration to point of use with gpio_device_find_by_fwnode()
  call (Andy Shevchenko)
- Extract acpi_get_handle() return into acpi_status variable rather than
  inline in ACPI_FAILURE() (Andy Shevchenko)
- Use guard(device)(...) instead of scoped_guard(device, ...) {} for a
  single following statement (Andy Shevchenko)
- Use LIST_HEAD(res_list) instead of separate declaration + INIT_LIST_HEAD()
  (Andy Shevchenko)
- Check acpi_dev_get_resources() error before freeing the resource list,
  restoring the check-then-free ordering that had regressed in v11
  (Andy Shevchenko)
- Split ACPI_COMPANION(dev) assignment onto its own line rather than at
  declaration (Andy Shevchenko)

v10 -> v11:
- Replaced custom gpio_controller_ref list and dedup logic with
  gpio_device_find_by_fwnode() (Suggested-by: Andy Shevchenko)
- Moved resource-skip explanation from commit message into a code comment
- Fixed device_is_bound() to check gpio_device_to_device(gdev)->parent
  rather than the gpio_device's own internal class device, which is
  registered on the synthetic "gpio" bus and never has a driver bound to it

v9 -> v10:
- Use acpi_gpio_get_irq_resource() instead of open-coding GPIO resource
  type checks, eliminating duplication with gpiolib-acpi (Andy Shevchenko)
- Simplify string_source guard to a single string_length check, confirmed
  sufficient via ACPICA parser in drivers/acpi/acpica/rsutils.c
  (Andy Shevchenko)
- acpi_dev_get_resources() on single line, free only on success path
  (Andy Shevchenko)
- Reversed xmas tree ordering for variable declarations (Andy Shevchenko)
- Removed useless int ret = 0 assignment (Andy Shevchenko)
- acpi_dev_for_each_child() on single line (Andy Shevchenko)
- Use guard(device)(gpio_dev) pattern to avoid uninitialized variable
  warning and deduplicate the !gpio_dev check (Andy Shevchenko)

v8 -> v9:
- Sent as a 2-patch series: revert of the broken v8 patch, plus a
  corrected resubmission
- Use acpi_gpio_get_irq_resource() instead of open-coding GPIO resource
  type checks, eliminating duplication with gpiolib-acpi (Andy Shevchenko)
- Remove gpio_dep_ctx wrapper struct, pass list_head * directly (Andy Shevchenko)
- Add const to gpio_controller_ref.path (Andy Shevchenko)
- Add NULL check for resource_source.string_ptr to fix a crash on hardware
  where GPIO resources have no named controller (Reported-by: Nathan
  Chancellor, Reported-by: Chaitanya Kumar Borah)
- Use acpi_dev_get_resources() return value properly (Andy Shevchenko)
- Fix all error paths to call free_gpio_controller_list() (Andy Shevchenko)
- Change guard to #if defined(CONFIG_ACPI) && defined(CONFIG_GPIOLIB)
- Remove erroneous put_device() calls -- acpi_get_first_physical_node()
  returns a borrowed pointer with no refcount increment
- Use LIST_HEAD() macro, split adev declaration and assignment (Andy Shevchenko)
- scoped_guard single statement without braces (Andy Shevchenko)
- Remove misused Reported-by/Closes tags (Andy Shevchenko)

v7 -> v8:
- Add revert of the earlier pinctrl-amd DMI quirk (patch 1 of the original
  v1-v7 series), confirmed unnecessary once probe ordering is fixed
  (Mario Limonciello)
- Collect Acked-by (Bartosz Golaszewski) and Reviewed-by (Mario Limonciello)

v6 -> v7:
- Fix unused 'ret' variable in check_child_gpioint() (kernel test robot)
- Replace BugLink: with Link: (Bartosz Golaszewski)
- Add Reported-by and Closes tags for kernel test robot warning

v5 -> v6:
- Replace DMI-specific deferral with a generic GpioInt dependency check
  walking ACPI child devices (Suggested-by: Mario Limonciello)

v4 -> v5:
- Add blank line before #include <linux/acpi.h> (Bartosz Golaszewski)
- Use scoped_guard(device, gpio_dev) (Bartosz Golaszewski)

v3 -> v4:
- Rebase onto Linus Walleij's tree (the original patch 1 already there)
- Use --base so series is correctly 1/1 (Andy Shevchenko)

v2 -> v3:
- Fix variable declaration style (Andy Shevchenko)
- Add BugLink tag (Andy Shevchenko)
- CC AMD engineers (Andy Shevchenko)

v1 -> v2:
- Replace custom HID/UID lookup with acpi_dev_get_first_match_dev()
- Use device_is_bound() under device_lock() with explanatory comments
- Add Assisted-by tags per coding-assistants.rst

Note: this patch was originally part of a 2-patch series (v1-v7) whose
first patch was a DMI-specific pinctrl-amd IRQ quirk; that patch was
merged separately into Linus Walleij's tree at v1 and later reverted at
v8 once this patch made the manual IRQ restoration unnecessary.

 drivers/i2c/busses/i2c-designware-platdrv.c | 80 +++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 6d6e81242f74..c8a203fff4d1 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -8,12 +8,14 @@
  * Copyright (C) 2007 MontaVista Software Inc.
  * Copyright (C) 2009 Provigent Ltd.
  */
+#include <linux/acpi.h>
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/gpio/driver.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -130,6 +132,80 @@ static int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
 	return 0;
 }
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_GPIOLIB)
+/*
+ * Check whether an ACPI GpioInt resource's referenced GPIO controller
+ * has finished probing. Resources with no named controller (resource
+ * source string) are skipped, since they can't be resolved to a
+ * struct device.
+ */
+static int check_gpioint_resource(struct acpi_resource *ares, void *data)
+{
+	struct acpi_resource_gpio *agpio;
+	struct acpi_device *gpio_adev;
+	struct device *gpio_dev;
+	acpi_handle handle;
+	acpi_status status;
+
+	if (!acpi_gpio_get_irq_resource(ares, &agpio))
+		return 1; /* not a GpioInt resource, skip */
+
+	if (!agpio->resource_source.string_length)
+		return 1; /* no named controller, skip */
+
+	status = acpi_get_handle(NULL, agpio->resource_source.string_ptr, &handle);
+	if (ACPI_FAILURE(status))
+		return 1;
+
+	gpio_adev = acpi_fetch_acpi_dev(handle);
+	if (!gpio_adev)
+		return 1;
+
+	struct gpio_device *gdev __free(gpio_device_put) =
+		gpio_device_find_by_fwnode(acpi_fwnode_handle(gpio_adev));
+	if (!gdev)
+		return -EPROBE_DEFER; /* controller not registered yet: abort walk */
+
+	gpio_dev = gpio_device_to_device(gdev)->parent;
+
+	guard(device)(gpio_dev);
+	if (!device_is_bound(gpio_dev))
+		return -EPROBE_DEFER; /* controller not bound yet: abort walk */
+
+	return 1; /* bound, skip adding to resource list, continue walk */
+}
+
+static int check_child_gpioint(struct acpi_device *adev, void *data)
+{
+	LIST_HEAD(res_list);
+	int ret;
+
+	ret = acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, NULL);
+	if (ret < 0)
+		return ret;
+
+	acpi_dev_free_resource_list(&res_list);
+
+	return 0;
+}
+
+static int i2c_dw_check_gpio_dependencies(struct device *dev)
+{
+	struct acpi_device *adev;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return 0;
+
+	return acpi_dev_for_each_child(adev, check_child_gpioint, NULL);
+}
+#else
+static int i2c_dw_check_gpio_dependencies(struct device *dev)
+{
+	return 0;
+}
+#endif /* CONFIG_ACPI && CONFIG_GPIOLIB */
+
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
 	u32 flags = (uintptr_t)device_get_match_data(&pdev->dev);
@@ -138,6 +214,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	struct dw_i2c_dev *dev;
 	int irq, ret;
 
+	ret = i2c_dw_check_gpio_dependencies(device);
+	if (ret)
+		return ret;
+
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq == -ENXIO)
 		flags |= ACCESS_POLLING;

base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
-- 
2.54.0

