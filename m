Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB847400DE8
	for <linux-i2c@vger.kernel.org>; Wed,  1 Jul 2026 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900773; cv=none; b=qcKk8AhyJxcrnBoEyYDMHiShrfl8KCnnnQ13cQWfjoHDtrc+hWBz2WoPexwXRYEztTsZGeZMae2GI1l1/kaUVqk5odfO/lM52kby9d5296a2w9lq1Wajv3wWVYZBlipebX0w00K3JkJz9+M63fa7FlzNORO4DV3xvqrs/JdBzSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900773; c=relaxed/simple;
	bh=hKZQkFUlZRkJ4dkfQ7XCvFwhZ/U5i9bJe+6uKHcZVlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LhDCm5Yd5KfHE7enzSocpw/u1BAQclxRB4ZYqeWb1RJ8FUlrTPc6+x4LX0wiljZsJFIDVOe2x3m+zTFwOREgyKBikI4xiHXgQvP9/L27ByxgbImlWr5wYw0X240LwuCmlmTM8DInnQzMS37NWSLKKHTLLu2WZISGNLReodpTJds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMS/3Yc2; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMS/3Yc2"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30edbb0dc5fso290880eec.0
        for <linux-i2c@vger.kernel.org>; Wed, 01 Jul 2026 03:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782900771; x=1783505571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JnbZMh/VMIPXgvmmZVZQ54fXfz7U5FC3rNj6e+Tek2E=;
        b=FMS/3Yc2w99bwtsZgOxGzsPAVqk/zQNswzr4xoibdQl+OFkpVklhCoUecr675aPjiv
         ofVfRZUZS8lutO5uS7+xvcnmejhO/WR/FrndluyHHWCKdMe32R4eRUWoWp25uYAC2Z2f
         1xSHxgLZ+HCOpkD56gCfufDecyj4y1YsiPX7QJfGd5ZZAUYVp0mormsQ8jFhmtTyee3h
         ZvW4E1Ox5zXjsSSZfzeDf02i7giukTCWYxiE0uZrQCBTWy1D8yaE5goM5pjGEIpCGXZ5
         kWC92hY+NKPW7fUywCnlGqdpOS8U2Sp+rCM9zLB7L1VNlGr/BOIPnUei+UlXRgcdhkFC
         TPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782900771; x=1783505571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnbZMh/VMIPXgvmmZVZQ54fXfz7U5FC3rNj6e+Tek2E=;
        b=qsHXuxiefWHYUogXWb+33KHd/J6dQSfwLDncE5cMyPu6UhCTe3nYFzg7Tl00euzk10
         /zHFH3MsIBAAYoUGWZvfhk7pS3ZtUUY9OHY69PUAHrFpemgmXxJl8uq3zagtM7MpAdLF
         dxPK6GklZaZEtdP5aZ4oolg/0rsob0mXwoNIk1CoDq601XVryA+8aqH3jlraJ4/DktAs
         xPZcAOjTCiSnh6JLfFujRKWn441oziUXuVCoBzKP1T4n9rhdIWiAI8OtQA0fPpvkVIjs
         Pm3zF2KYbrzA5Pv4PtsPd3MT8D7CQxX56fFv33XfoouVQ7lJeI20pjtY0vXyQJv4JOG7
         21ng==
X-Gm-Message-State: AOJu0Yz5J+wHHY1zuq6oowG9LDJfOWmV0tAawrJPmGevaYb0KcNdNoYR
	mIJVYdrZX4rngqus2U3H9jX/YFiKjQLujFnFE2JPzDKucKJK1DSMeTYWnOCXxZqK
X-Gm-Gg: AfdE7cl05yZK9/O3NDPwuHrp7PZQREYk+lNBzD30jOX5UWpou075zscqcAXVHJTb9um
	aZXvpYD/3Lq1Q1Nq6cEltrSe0yyst1Um9PZIN6QkRNKWu6SOCqKR1U+SZpuDtG2aBQ5IUnIdSs+
	nBgXweGczcT8/XXmc4Lkw4GjVYwSubQ/yLwq2KtH/soPAQJw1glM9owu7AP+Wz0Avw4TZ5OUlPA
	1dr4ktVAjSfoRfA91tVw2JXUFs8QAaYM88nEOEth4yVMqpR81v9aLevdnGbQbl9unHTyq5os5Au
	cMrICtsMYt6UHuYSL3RnYxujGbmyQCRRY4ORigqDYwItH0BmPWji3TEewItxIgm6Dgn5ZLyFJE7
	nrLqOc5DJHyUrY7nb+yjlsuwN/aqPkJSw8L5NG70qcNyzrId8l70nF2S5DXBMOl0vxkt9WnOWmD
	liCv2UuAMlF2AaPtHwgq+HV4uKkZvkReim8XZAk7UarQJE9s2QRXHkRPqR6XcZFCENYrG5CoRzJ
	ObREMjs9jdewSle0BDFy+C73fushOO7oWeb4PVzCPPqf5F3Qvec6xQImlb4Q3UpimFzfV0+3a/0
	NA==
X-Received: by 2002:a05:7300:7312:b0:304:e865:f7d1 with SMTP id 5a478bee46e88-30f053f3845mr122579eec.25.1782900770320;
        Wed, 01 Jul 2026 03:12:50 -0700 (PDT)
Received: from hardik-yoga.oryx-cobra.ts.net ([2401:4900:a137:d795:30b1:c22:58a1:6ebc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2ffdbfesm18720743eec.11.2026.07.01.03.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 03:12:49 -0700 (PDT)
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
Subject: [PATCH v10] i2c: designware: defer probe if child GpioInt controllers are not bound
Date: Wed,  1 Jul 2026 15:42:18 +0530
Message-ID: <20260701101218.42529-1-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I2C controllers may have child devices with GpioInt resources that
depend on GPIO controllers to be fully initialized. If the I2C
controller probes and enumerates children before the referenced GPIO
controller has completed probe, GPIO interrupts may not be properly
configured, leading to device failures.

On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
fail with lost arbitration errors.

Add a generic dependency check in i2c-designware that walks ACPI child
devices, identifies any GpioInt resources, resolves the referenced GPIO
controllers, and defers probe if those controllers are not yet bound.
Uses acpi_gpio_get_irq_resource() to avoid duplicating GPIO resource
parsing logic from gpiolib-acpi. Skips resources with no resource
source string (string_length == 0 or string_ptr == NULL) to avoid
crashes on hardware where GPIO resources have no named controller.

The probe ordering race was confirmed via dynamic debug tracing:

  0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
  0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
  0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
  2.348157  lost arbitration

Fixes: 3812a9e84265 ("pinctrl-amd: enable IRQ for WACF2200 touchscreen on Lenovo Yoga 7 14AGP11")
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
Assisted-by: Claude:claude-sonnet-4-6
Assisted-by: GPT:gpt-5.4-mini
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221494
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 132 ++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 6d6e81242f74..d8331d1dead8 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -8,6 +8,8 @@
  * Copyright (C) 2007 MontaVista Software Inc.
  * Copyright (C) 2009 Provigent Ltd.
  */
+
+#include <linux/acpi.h>
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -130,6 +132,132 @@ static int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
 	return 0;
 }
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_GPIOLIB)
+struct gpio_controller_ref {
+	struct list_head node;
+	const char *path;
+};
+
+static void free_gpio_controller_list(struct list_head *gpio_controllers)
+{
+	struct gpio_controller_ref *ref, *tmp;
+
+	list_for_each_entry_safe(ref, tmp, gpio_controllers, node) {
+		list_del(&ref->node);
+		kfree(ref->path);
+		kfree(ref);
+	}
+}
+
+static int check_gpioint_resource(struct acpi_resource *ares, void *data)
+{
+	struct list_head *gpio_controllers = data;
+	struct acpi_resource_gpio *agpio;
+	struct gpio_controller_ref *ref;
+
+	if (!acpi_gpio_get_irq_resource(ares, &agpio))
+		return 1;
+
+	if (!agpio->resource_source.string_length)
+		return 1;
+
+	/* Skip if we've already tracked this GPIO controller */
+	list_for_each_entry(ref, gpio_controllers, node) {
+		if (!strncmp(ref->path, agpio->resource_source.string_ptr,
+			     agpio->resource_source.string_length))
+			return 1;
+	}
+
+	ref = kzalloc(sizeof(*ref), GFP_KERNEL);
+	if (!ref)
+		return -ENOMEM;
+
+	ref->path = kstrdup(agpio->resource_source.string_ptr, GFP_KERNEL);
+	if (!ref->path) {
+		kfree(ref);
+		return -ENOMEM;
+	}
+
+	list_add_tail(&ref->node, gpio_controllers);
+	return 1;
+}
+
+static int check_child_gpioint(struct acpi_device *adev, void *data)
+{
+	struct list_head res_list;
+	int ret;
+
+	INIT_LIST_HEAD(&res_list);
+	ret = acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, data);
+	if (ret < 0)
+		return ret;
+
+	acpi_dev_free_resource_list(&res_list);
+	return 0;
+}
+
+static int i2c_dw_check_gpio_dependencies(struct device *dev)
+{
+	struct gpio_controller_ref *ref;
+	LIST_HEAD(gpio_controllers);
+	struct acpi_device *adev;
+	int ret;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return 0;
+
+	/* Walk all child devices and collect GpioInt controller references */
+	ret = acpi_dev_for_each_child(adev, check_child_gpioint, &gpio_controllers);
+	if (ret < 0)
+		goto cleanup;
+
+	/* For each GPIO controller, check if its platform device is bound */
+	list_for_each_entry(ref, &gpio_controllers, node) {
+		struct acpi_device *gpio_adev;
+		struct device *gpio_dev;
+		acpi_status status;
+		acpi_handle handle;
+		bool bound;
+
+		status = acpi_get_handle(NULL, ref->path, &handle);
+		if (ACPI_FAILURE(status))
+			continue;
+
+		gpio_adev = acpi_fetch_acpi_dev(handle);
+		if (!gpio_adev)
+			continue;
+
+		gpio_dev = acpi_get_first_physical_node(gpio_adev);
+		acpi_dev_put(gpio_adev);
+		if (gpio_dev) {
+			guard(device)(gpio_dev);
+			bound = device_is_bound(gpio_dev);
+		} else {
+			bound = false;
+		}
+		/*
+		 * Defer probe until the GPIO controller is fully bound,
+		 * ensuring its IRQ setup is complete before we enumerate
+		 * I2C child devices.
+		 */
+		if (!bound) {
+			ret = -EPROBE_DEFER;
+			goto cleanup;
+		}
+	}
+
+cleanup:
+	free_gpio_controller_list(&gpio_controllers);
+	return ret;
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
@@ -138,6 +266,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	struct dw_i2c_dev *dev;
 	int irq, ret;
 
+	ret = i2c_dw_check_gpio_dependencies(device);
+	if (ret)
+		return ret;
+
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq == -ENXIO)
 		flags |= ACCESS_POLLING;

base-commit: 5a66900afbd6b2a063eebad35294038a654de2b0
-- 
2.54.0

