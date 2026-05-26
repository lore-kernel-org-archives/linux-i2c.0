Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A123DDDC7
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792768; cv=none; b=oG7toGeSvAdw7wg444hJqeuOgTq/COBeaiUIIVfQB1apBC0w9Eq1kgYi4JZPxgiy8WV/0Zc0ZN/V6nK0JPxXZgqeGY96Qh8S8s7gMJ9K0jrqNVrj+ai4KpfWdWHXVrtS3OJB6skGJm+baWV/jzvk2/KcbDHErRlj6rNVN9K6NzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792768; c=relaxed/simple;
	bh=yzTOT+2MRP17wpJcXcclVwzteiVg48P8SYgp86+zSOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNwrT7EARvlu0UFZknvNjpaxWRdHI4Sfoy+c0/tSNz/ujZ1BXnFD+eXuo1govZiBSYnAbaSXHa/c4QNpL5etIUuILA3oLmLhg01YfoT9ecPp0yYmTfoylg6dx9VIOEPbS66dzv2NxsfKkguZWX7zcEeM62ldT4zVTsQcNzN1L18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKpfgUbi; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKpfgUbi"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8419ab3a297so700915b3a.2
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 03:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779792766; x=1780397566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=se9FzMiLV7GwrhpSB8M3GIQFrqO9ekOTvkgpqCEp9P4=;
        b=UKpfgUbi0yq8v4vOAWPtJcdOQbkKPIsW5RUG5WKem1byP68uz2JSOv6ZyHFy1pmcm7
         N9n3CfLzlA87FwLW/0CPsOARQJvzz9q3ucd469Jp7FNUDihdEwn09d8uqlInQBGsKkhg
         EXjf4aYiJh5SzUcuWbgE6CeIaQi3gU2MnF0LoceETlEdIDmf0Np2sysfNdWNLGTlJoD+
         UjUzu1swbqfhIb90kFIQALsNHC+adoqXN4rDpd6HykQ0sqipdrcHs4BY0BwtXIMrdpXe
         c1vtmZTq5qHe0raELIh48Y7MJLh1O9wMPCbVrLOgAYo8Lg05Gk5OrCE63WWgc4S72Gea
         CDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792766; x=1780397566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=se9FzMiLV7GwrhpSB8M3GIQFrqO9ekOTvkgpqCEp9P4=;
        b=pu6nYtvTCsdMrclrmFu4b/BhHPIIZuBYVl1GtmZaPxlwbubrFSmVJwzJWg6khmU+4a
         qblgfC8wRQkahClWyHYuSaDdi6r86utmEnkcRLJjUvQdBuWfSuc9o9gjiFSvQqA/sEBd
         2SiD6EH/uWtH/+fO/hbss64QxYbB4aLwXO5OPqmezhxcJLP09L2ffkqHlLN4ZGQYN3ML
         /0LIbdQ9gIYmYG1Pjw1pILAA38yDMlsAzutGipD4gNR3R8U6GhvQyUrexSondC326Cmw
         fbNhzuioek1RiYc2eHEnDvmqz2irzCREVV7JJb232zfVd4FMmtpiIphBvzcLjUPzPe5g
         CNVA==
X-Gm-Message-State: AOJu0YyLnUaBgRFMWO0TqNfzpnncEw3hGHlCRyz8YJpT+ZOpn6w0GTIg
	pEpwnz9bH1gagtrJivmzB5VczI/5udwmVeLJvN35IEbj13MVSF/6qO+P57d8zx4f
X-Gm-Gg: Acq92OERTsJv4l7ObJOOhfWavOAqQtHJz1ZpiBqhlgaWzWEkwjYRVeq/phEly5nU0Aw
	2m7SnfcF7s8anmrSuxQur7QDTxUWEmAZEUCqwbwiPXVu4kLrS4iWWG3gpgUJenJ7MQ5M2vdclgK
	1hVkFFirqF2koC/Igg1NRR+gvGsfs/dLks7qyuR4zFLtCY651TUOQ+JhPq7NVzvM3JRdc4Ix7yk
	iOU/1oPG2YVVWwjoTxwPSfjaKeyCFxCobWv+Tcx61JL5QVthRyrBGe4SIVvZ5ozIcNblAzuOdUE
	Q8I5/6LNn92n63aDbbhUH7ZibGMM+1RUPuZvcgu4vuH4Tqxz1AVYEAJQraKac6FuUvIfrn9h8wy
	KD8wYxg+pGKv+DvtJoCF8WHuUeVoKBR8xPWPED6wckqV4LtY0FRdG9NtSX01Zp1by4BsVs2UXdY
	8P5N0A4tUs2GjcKn3eNglsEeoFhQGy1TYQec0pP3e5QsLI0EE+4PTGPBwRxkhABSUYuck6fRt27
	b9yXGMROFK1cGHuq1FR7Q1Aw9WrjYEvdQGCN95zFM7FyhJWcWxyG9zOhcWkJqV6u/27LDoQBdpu
	p1igvkJzHXxH
X-Received: by 2002:a05:6a00:8c04:b0:835:cc47:6fe3 with SMTP id d2e1a72fcca58-8415f3b0825mr19050467b3a.45.1779792765823;
        Tue, 26 May 2026 03:52:45 -0700 (PDT)
Received: from hardik-yoga.oryx-cobra.ts.net ([2401:4900:1c23:6e83:739b:c8ff:8cea:29c3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fb3083sm12053271b3a.43.2026.05.26.03.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:52:45 -0700 (PDT)
From: Hardik Prakash <hardikprakash.official@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	wsa@kernel.org,
	andriy.shevchenko@intel.com,
	mario.limonciello@amd.com,
	brgl@bgdev.pl,
	basavaraj.natikar@amd.com,
	linusw@kernel.org,
	Hardik Prakash <hardikprakash.official@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v7 1/1] i2c: designware: defer probe if child GpioInt controllers are not bound
Date: Tue, 26 May 2026 16:22:10 +0530
Message-ID: <20260526105213.85833-2-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526105213.85833-1-hardikprakash.official@gmail.com>
References: <20260526105213.85833-1-hardikprakash.official@gmail.com>
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
occur before the GPIO IRQ quirk in amd_gpio_probe() has run, causing:

  i2c_designware AMDI0010:02: i2c_dw_handle_tx_abort: lost arbitration

Add a generic dependency check in i2c-designware that walks ACPI child
devices, identifies any GpioInt resources, resolves the referenced GPIO
controllers, and defers probe if those controllers are not yet bound.

This ensures GPIO controllers complete initialization (including IRQ
setup and quirks) before I2C child enumeration begins, fixing the race
without device-specific quirks or DMI matching.

The probe ordering race was confirmed via dynamic debug tracing:

  0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
  0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
  0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
  2.348157  lost arbitration

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
Assisted-by: Claude:claude-sonnet-4-6
Assisted-by: GPT-Codex:gpt-5.2-codex
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605240959.Kcf1lIg4-lkp@intel.com/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221494
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 156 ++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 3351c4a9ef11..1c01b0460385 100644
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
@@ -130,6 +132,152 @@ static int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+struct gpio_dep_ctx {
+	struct list_head gpio_controllers;
+	int ret;
+};
+
+struct gpio_controller_ref {
+	struct list_head node;
+	char *path;
+};
+
+static int check_gpioint_resource(struct acpi_resource *ares, void *data)
+{
+	struct gpio_dep_ctx *ctx = data;
+	struct acpi_resource_gpio *agpio;
+	struct gpio_controller_ref *ref, *tmp;
+	bool found = false;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
+		return 1;
+
+	agpio = &ares->data.gpio;
+	if (agpio->connection_type != ACPI_RESOURCE_GPIO_TYPE_INT)
+		return 1;
+
+	/* Check if we've already tracked this GPIO controller */
+	list_for_each_entry(tmp, &ctx->gpio_controllers, node) {
+		if (!strcmp(tmp->path, agpio->resource_source.string_ptr)) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		ref = kzalloc(sizeof(*ref), GFP_KERNEL);
+		if (!ref) {
+			ctx->ret = -ENOMEM;
+			return 0;
+		}
+
+		ref->path = kstrdup(agpio->resource_source.string_ptr, GFP_KERNEL);
+		if (!ref->path) {
+			kfree(ref);
+			ctx->ret = -ENOMEM;
+			return 0;
+		}
+
+		list_add_tail(&ref->node, &ctx->gpio_controllers);
+	}
+
+	return 1;
+}
+
+static int check_child_gpioint(struct acpi_device *adev, void *data)
+{
+	struct gpio_dep_ctx *ctx = data;
+	struct list_head res_list;
+
+	INIT_LIST_HEAD(&res_list);
+
+	acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, ctx);
+	acpi_dev_free_resource_list(&res_list);
+
+	if (ctx->ret < 0)
+		return ctx->ret;
+
+	return 0;
+}
+
+static int i2c_dw_check_gpio_dependencies(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct gpio_dep_ctx ctx = { .ret = 0 };
+	struct gpio_controller_ref *ref, *tmp;
+	int ret = 0;
+
+	if (!adev)
+		return 0;
+
+	INIT_LIST_HEAD(&ctx.gpio_controllers);
+
+	/* Walk all child devices and collect GpioInt controller references */
+	ret = acpi_dev_for_each_child(adev, check_child_gpioint, &ctx);
+	if (ret < 0 || ctx.ret < 0) {
+		ret = ctx.ret ?: ret;
+		goto cleanup;
+	}
+
+	/* For each GPIO controller, check if its parent device is bound */
+	list_for_each_entry(ref, &ctx.gpio_controllers, node) {
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
+
+		if (!gpio_dev) {
+			ret = -EPROBE_DEFER;
+			goto cleanup;
+		}
+
+		/*
+		 * Check if the GPIO controller's device is bound. If not,
+		 * defer probe to ensure GPIO initialization (including IRQ
+		 * setup and quirks) is complete before we enumerate I2C
+		 * child devices.
+		 */
+		scoped_guard(device, gpio_dev) {
+			bound = device_is_bound(gpio_dev);
+		}
+		if (!bound) {
+			put_device(gpio_dev);
+			ret = -EPROBE_DEFER;
+			goto cleanup;
+		}
+
+		put_device(gpio_dev);
+	}
+
+cleanup:
+	list_for_each_entry_safe(ref, tmp, &ctx.gpio_controllers, node) {
+		list_del(&ref->node);
+		kfree(ref->path);
+		kfree(ref);
+	}
+
+	return ret;
+}
+#else
+static int i2c_dw_check_gpio_dependencies(struct device *dev)
+{
+	return 0;
+}
+#endif /* CONFIG_ACPI */
+
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
 	u32 flags = (uintptr_t)device_get_match_data(&pdev->dev);
@@ -138,6 +286,14 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	struct dw_i2c_dev *dev;
 	int irq, ret;
 
+	/*
+	 * Check if any child devices have GpioInt resources, and if so,
+	 * defer probe until those GPIO controllers are fully bound.
+	 */
+	ret = i2c_dw_check_gpio_dependencies(device);
+	if (ret)
+		return ret;
+
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq == -ENXIO)
 		flags |= ACCESS_POLLING;
-- 
2.54.0

