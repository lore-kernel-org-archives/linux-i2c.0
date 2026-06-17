Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630AD3BB12E
	for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679617; cv=none; b=K77FzIropxxQUhm8EZHJbE9e92fv9tB7SmrL6rqqWT42qmCgGJH5+w4TPNjqIQ5s1E6QhY8S7MqNyWSfIPmjahJ+F+ozY6k6F6oxP3uXTI6iirlh24WnlbpdwFDqTHu7rjG8sjRV+yQL6qUcEduIEgoEkzarkgD9Eoew/WYl3w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679617; c=relaxed/simple;
	bh=aBrYT4DVJx6FYZ1EOU4w1/KBdIVmZ7ko2jVTs3nEJj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNb4TlrWhHKVSBX2HmJ7HmiSOyZvJeUhUJR5BBYdqEVEJAOnS/oV2zw9ii/IKDXTqH3tP0fJAuTStXnRNxQffDG1zZAnf4f4zYUZBKK/ebVSNuBViLtd2j9iydQImZgR93I67Su6OerOgrGp8TT5vsKDImq27obazoe+piqV+MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoKICBh/; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoKICBh/"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1390f75d8bbso938146c88.0
        for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 00:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781679612; x=1782284412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgUZ5MdWHk1It7dPuCiGJcxyI3aHoyg6M40ZkX/AvJU=;
        b=YoKICBh/FTXUBkMSdD21Scu3YpWjO9FixLcEK+2S6uObfd52iFHSaaebeUa/FBw6u4
         1RgWAHOkQxsm1yeqOgghz9Z3CVZvTrXyUNx/72C0nYh0XT8MSbXYl4/6flP3nxTCbtvc
         JAeUaSe7qun0irXCT88NsWVv9nPwkzVMO2aKpF+ZbBT7ne5neCgcN3xaLZZu/+8hfQxz
         0XpYnXU3ySC51RCZnEDIZ98/1jqMQ95hvDUOUWZrUkdgCNcfOyE7kUho0JO/5CgPkSSO
         Rznrh4rcrdaYj9PznqUOr7xS69f0mK6H1UlWku0t2EK+5FD6irz7hNOTvb0vpd/u3HKf
         CoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781679612; x=1782284412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fgUZ5MdWHk1It7dPuCiGJcxyI3aHoyg6M40ZkX/AvJU=;
        b=fkDzA5JII9U2ukpDk+WaHKUqVHYXM+nlYBYwS8LG6Da8h7gRetyRpRp1n6uSrfmmID
         HMgKtDv7cly2DBL4IFWV/ZWgkJf2Xv2qPGW3oxeXxSPAyip7A0jJDJ3NMsp3Olt/X32u
         Ls7tdQmIkG7HsYQXCyIFnV2Mo1yrdwFsCkJkpFmWPkXT9YJRr5tWB1wNKMjHVbMXCNeN
         rYfXp1M/eAiL6xdI+4upD8/Ka51UOJTnXunvBudYYrUQxtu03FTld6orhBan7T0IHjUO
         aLREY5YXALcQZqwWAzfij5QJA2xrCsb7dkJQa9ErHiDcPZgsnhJI4AtRwzqfn65+Bv/F
         Invw==
X-Gm-Message-State: AOJu0YxJdpf2eI+kM2Yae/k1I9Sc5dHfIinv3P6+SPcc3U+3CrGGJKJF
	SfBLnkuxC//lDpww1k9YmSBB+MDMqQWOhstirUbkddMHAKUkXHBr/9F7th/7iocv
X-Gm-Gg: Acq92OEbdGtrvamMVbrjIh8bsmabTACGsP4eKkcWn4HXQKOedP8KATvBfozhltAx1Al
	HizHzWxPlAWQpQXRSWnJJOC3piN5tOdMWZXw6buTa/l/g95emRwOfEni6eizcYA1TvoMZhibTW2
	Hwf5qa0ULmv8KAnfLMvJ11a8xBbixR7zODfUbrA1kHEGRoS4nv+MLv+MO57kkHFeMOv7wPCb588
	oro23YV1SuVpUvcinCtxphVq+48uPh0PqvfFy+NWJPQrPqEqZHQqmEk7lTR/DC6UGCY/gnpn18g
	kD0dcW//FEFVEhCxS6GeEf2e9QPdmgbvpvesjds4H9gG3aZJKAiDPy56OUO79HSHNImlqBEKEzC
	c7PhAd4I7IK0H/09wUfwS8m0o8XvB0ZfukiLhaxbkLlEdW1x7sDr586j+6K3xoOs+cfx0MTRMhb
	zIL+IxzR2wbZ59e7RaZD6qEkeGUTrw949PGZ/BaCCw0AbcOxj3ri4BE5hRD2s7a9D355Ofd2+bL
	ADYXSxXVvwIqfva17lGrm21bUVUwxcDbzrMeXB9ywkvVHBKtVSauX81ZOX9kkWEN0/mC/DzWR6T
X-Received: by 2002:a05:7022:6ba8:b0:136:ac69:b0f7 with SMTP id a92af1059eb24-1398f680985mr1117104c88.16.1781679612236;
        Wed, 17 Jun 2026 00:00:12 -0700 (PDT)
Received: from hardik-yoga.oryx-cobra.ts.net ([2401:4900:1c62:151d:8407:852b:5db:1408])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1386f20ad25sm14118376c88.0.2026.06.17.00.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 00:00:11 -0700 (PDT)
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
Subject: [PATCH v9 2/2] i2c: designware: defer probe if child GpioInt controllers are not bound
Date: Wed, 17 Jun 2026 12:29:22 +0530
Message-ID: <20260617065922.26004-3-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617065922.26004-1-hardikprakash.official@gmail.com>
References: <20260617065922.26004-1-hardikprakash.official@gmail.com>
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
 drivers/i2c/busses/i2c-designware-platdrv.c | 133 ++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 3351c4a9ef11..51172fffa2b8 100644
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
@@ -130,6 +132,133 @@ static int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
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
+	if (!agpio->resource_source.string_length ||
+	    !agpio->resource_source.string_ptr)
+		return 1;
+
+	/* Skip if we've already tracked this GPIO controller */
+	list_for_each_entry(ref, gpio_controllers, node) {
+		if (!strcmp(ref->path, agpio->resource_source.string_ptr))
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
+	ret = acpi_dev_get_resources(adev, &res_list,
+				     check_gpioint_resource, data);
+	acpi_dev_free_resource_list(&res_list);
+	return ret < 0 ? ret : 0;
+}
+
+static int i2c_dw_check_gpio_dependencies(struct device *dev)
+{
+	struct acpi_device *adev;
+	LIST_HEAD(gpio_controllers);
+	struct gpio_controller_ref *ref;
+	int ret = 0;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return 0;
+
+	/* Walk all child devices and collect GpioInt controller references */
+	ret = acpi_dev_for_each_child(adev, check_child_gpioint,
+				      &gpio_controllers);
+	if (ret < 0)
+		goto cleanup;
+
+	/* For each GPIO controller, check if its platform device is bound */
+	list_for_each_entry(ref, &gpio_controllers, node) {
+		acpi_handle handle;
+		acpi_status status;
+		struct acpi_device *gpio_adev;
+		struct device *gpio_dev;
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
+		if (!gpio_dev) {
+			ret = -EPROBE_DEFER;
+			goto cleanup;
+		}
+
+		/*
+		 * Defer probe until the GPIO controller is fully bound,
+		 * ensuring its IRQ setup is complete before we enumerate
+		 * I2C child devices.
+		 */
+		scoped_guard(device, gpio_dev)
+			bound = device_is_bound(gpio_dev);
+
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
@@ -138,6 +267,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	struct dw_i2c_dev *dev;
 	int irq, ret;
 
+	ret = i2c_dw_check_gpio_dependencies(device);
+	if (ret)
+		return ret;
+
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq == -ENXIO)
 		flags |= ACCESS_POLLING;
-- 
2.54.0

