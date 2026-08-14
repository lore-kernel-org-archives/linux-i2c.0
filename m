Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8761D43CE65
	for <linux-i2c@vger.kernel.org>; Fri, 14 Aug 2026 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702073; cv=none; b=H2piTrAOMcMpjlvKhGfLLi2vsp9oQa+r3kqMoTAeXEZrzbPqOilThUT9vMg+9/LMDXjMd4BJdlFyFk7ba+Cu0zDTwLbzfq54H7T56PVYdoBeOxr4KFdx57vgptJ7J2JwvBSolHKsaIezGB+9ws3snQnGzjjW2YBLe9UAQvjDCJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702073; c=relaxed/simple;
	bh=fHvEGpLk2MRNJYnz+NoIq8PHpNOU4Mz9S3vE9ZvlegQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCIhtSHVuAkIopM47hZGzOYP05B/QViZHY61Z4KF/UhbGoHA8hR78NpSyBYc4Z22YfraqTQxH4C2oqQeKw4YXQug6wOVPf4TD3pRoHxzQtMAriN5BSzFrcf+IrUYHhyDJ4mE4wETAk5FMGhI4xWaPQeRgQ6yvDNs57PRI7G43qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezhUJP/D; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezhUJP/D"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso10832875ad.1
        for <linux-i2c@vger.kernel.org>; Fri, 14 Aug 2026 03:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786702063; x=1787306863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=17GpjZ9iDTHmCeh6FQtMXZ5sjTZjc7sv++Y5IXPlka4=;
        b=ezhUJP/D09wATb11dOOsFk/Gd6yI0E5nWUi3r982OE5oaPSa9VTT5tstZW2oV5HI2U
         fyPHOx/anOZGdpbz9RE92meoZOTo14DqPkfNDNQaJVA66VJXKhHZxOV5HH9CuFwKM+8K
         08s83z+sFWrEY9gvhUKERaeWVL9vV83+iZu9/JnFlD8KJso7wLQaiRn2TyONtKzXdFMX
         /G3dVFKpz2K+JlOY6KK6mJcVAeKXBG82/XpezyLFRrb5wXDm6dqVLuBR9JUDJKjKmF7N
         pHs7yYvjcWagsf1HBHNaebQROJMf3EqQFs5+TmglwqYY55fS+MgEQHht2+Skly0Rr948
         r8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786702063; x=1787306863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=17GpjZ9iDTHmCeh6FQtMXZ5sjTZjc7sv++Y5IXPlka4=;
        b=rFGJh+/NL+Ouu4NIdv/Me0ejSLL0ZQn9vs3Blz9mqPB8lNQQ/0eLEgWDvcJpfDJ9UH
         4Rbv53fbWN0M/eDaz5dPZjrqTgVhfF1NuslzIU6tKoa0d8snWCXiLfG+EUp3m5YHjhvf
         qYL7gTgyAnEZnPLt3GtukbYMIgElhiBiSZfs+l0+eNTYU4QBOnZ3j9PZDOd48bWnt/RN
         DSamamNAjvdWuqgmcxe45IHIkc+yHw2zboB2qyLNPOUd86I6QN++sf6KxTKvdta9pPru
         qw55Ovq8ZTpZjqZB4PBjV789dU1089Y9UjDZC23yA+yhqJyWjvmBPLRfN9o6GYL9rSnG
         vpXg==
X-Gm-Message-State: AOJu0Yyo+S6fyGUSw7umbRIKB9BaXHHaHcCD5TzHdcTUFIRGeC7yn6XI
	O4LJ2VwTm2tIvmutK/UDb4hNShNlOKOrCp3BaDxET7BbsCr26cHaeMS7p6F8fYHU
X-Gm-Gg: AR+sD12hfpD4yIJjwbB1aWpJKyE4gwjvdKV7IJVNJ/zvMIDz5YZsm6UtwzAUGah/tkf
	vAEVY1eskkhv5arZ5koFdwVJzmn+3bGdJpNShlDkoao8nsVVRAt47ptY95MMGD7BosyUbauO0rw
	gomFzPFlyOnSWtPhvBCsAg5HGRaAFWVsVxSH21uXvYfKqj5qVOiUG5jlhLgjNgyM0rnJhcLKG6F
	5IbMOZAX6UBNtRMjiFdcgGZM/mQgfGWLWozSGcPYdjU5/WWL8le5oZdAHjSbb6DDOUTbFQGney2
	SbpqXpKJmU44DGO0do0SEG5ZT18XqNkY4BIkgViUHYbBNueUVz71YGEvK0YLJCMA8Ptj51F4yfe
	Mdvv96IzOUpzwgTixUFLOl807+4sJ7u1ddfguTtnnqDKiejR/nY5mW5BgeZ0xYUvrv98xSLNvi3
	vgat7uLoBNCSQSyNCcOzb7sbzgMqcuhvwcrSlgzuK29lu3Buyah05yHosddwrjQ2andhW1IHdvz
	Ib1wacGK9uVLAOSZrxQDj9+BOCJfp1rHjR4Ts0Ew4h0KJLMC6nBIpx5+y2Tc3rgajmt5yfx9YEn
	3etz23tkzrUaUbml+honC7P3YleA+SXyyYA5BG5NhBE2dKXE
X-Received: by 2002:a05:6a20:4388:b0:3c1:fbf:1e2e with SMTP id adf61e73a8af0-3cc71abd254mr5461785637.10.1786702062996;
        Fri, 14 Aug 2026 03:07:42 -0700 (PDT)
Received: from hardik-yoga.oryx-cobra.ts.net ([2401:4900:1c63:eba:8431:2d12:e0ed:5dd0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d60ecdd0sm3323961eec.9.2026.08.14.03.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:07:42 -0700 (PDT)
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
	andi.shyti@kernel.org,
	linux@leemhuis.info,
	regressions@leemhuis.info,
	linux-kernel@vger.kernel.org,
	Hardik Prakash <hardikprakash.official@gmail.com>
Subject: [PATCH] Revert "i2c: designware: defer probe if child GpioInt controllers are not bound"
Date: Fri, 14 Aug 2026 15:37:19 +0530
Message-ID: <20260814100719.9548-1-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 0a4bb2abc3e56d7be6e69b050c88ba52c87e22bf.

The reverted commit causes a regression on ThinkPad T14s Gen 4 (AMD):
the touchpad's I2C controller fails with lost arbitration errors,
because it delays i2c-designware's probe by roughly 500ms, which
shifts the touchpad's first HID descriptor fetch into a window where
the platform's embedded controller is still acting as a secondary I2C
bus master. Debug tracing confirms the GpioInt dependency check itself
behaves correctly (it defers appropriately and confirms the GPIO
controller is bound); the arbitration failure happens roughly a
second after the check passes, when i2c_hid_acpi's own probe attempts
its first transaction.

The original fix is still needed for the Lenovo Yoga 7 14AGP11
touchscreen race the commit addressed, but a corrected version will
be resubmitted once the EC bus-mastering interaction is understood
and handled properly, rather than reintroducing a different
regression on more widely-used ThinkPad hardware in the meantime.

Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes: https://lore.kernel.org/all/b4a4eadb-282f-464c-843a-19d415a34d0c@leemhuis.info/
Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 80 ---------------------
 1 file changed, 80 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index c8a203fff4d1..6d6e81242f74 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -8,14 +8,12 @@
  * Copyright (C) 2007 MontaVista Software Inc.
  * Copyright (C) 2009 Provigent Ltd.
  */
-#include <linux/acpi.h>
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/gpio/driver.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -132,80 +130,6 @@ static int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
 	return 0;
 }
 
-#if defined(CONFIG_ACPI) && defined(CONFIG_GPIOLIB)
-/*
- * Check whether an ACPI GpioInt resource's referenced GPIO controller
- * has finished probing. Resources with no named controller (resource
- * source string) are skipped, since they can't be resolved to a
- * struct device.
- */
-static int check_gpioint_resource(struct acpi_resource *ares, void *data)
-{
-	struct acpi_resource_gpio *agpio;
-	struct acpi_device *gpio_adev;
-	struct device *gpio_dev;
-	acpi_handle handle;
-	acpi_status status;
-
-	if (!acpi_gpio_get_irq_resource(ares, &agpio))
-		return 1; /* not a GpioInt resource, skip */
-
-	if (!agpio->resource_source.string_length)
-		return 1; /* no named controller, skip */
-
-	status = acpi_get_handle(NULL, agpio->resource_source.string_ptr, &handle);
-	if (ACPI_FAILURE(status))
-		return 1;
-
-	gpio_adev = acpi_fetch_acpi_dev(handle);
-	if (!gpio_adev)
-		return 1;
-
-	struct gpio_device *gdev __free(gpio_device_put) =
-		gpio_device_find_by_fwnode(acpi_fwnode_handle(gpio_adev));
-	if (!gdev)
-		return -EPROBE_DEFER; /* controller not registered yet: abort walk */
-
-	gpio_dev = gpio_device_to_device(gdev)->parent;
-
-	guard(device)(gpio_dev);
-	if (!device_is_bound(gpio_dev))
-		return -EPROBE_DEFER; /* controller not bound yet: abort walk */
-
-	return 1; /* bound, skip adding to resource list, continue walk */
-}
-
-static int check_child_gpioint(struct acpi_device *adev, void *data)
-{
-	LIST_HEAD(res_list);
-	int ret;
-
-	ret = acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, NULL);
-	if (ret < 0)
-		return ret;
-
-	acpi_dev_free_resource_list(&res_list);
-
-	return 0;
-}
-
-static int i2c_dw_check_gpio_dependencies(struct device *dev)
-{
-	struct acpi_device *adev;
-
-	adev = ACPI_COMPANION(dev);
-	if (!adev)
-		return 0;
-
-	return acpi_dev_for_each_child(adev, check_child_gpioint, NULL);
-}
-#else
-static int i2c_dw_check_gpio_dependencies(struct device *dev)
-{
-	return 0;
-}
-#endif /* CONFIG_ACPI && CONFIG_GPIOLIB */
-
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
 	u32 flags = (uintptr_t)device_get_match_data(&pdev->dev);
@@ -214,10 +138,6 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	struct dw_i2c_dev *dev;
 	int irq, ret;
 
-	ret = i2c_dw_check_gpio_dependencies(device);
-	if (ret)
-		return ret;
-
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq == -ENXIO)
 		flags |= ACCESS_POLLING;

base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
-- 
2.55.0

