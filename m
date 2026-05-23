Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339E62EA754
	for <linux-i2c@vger.kernel.org>; Sat, 23 May 2026 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779558322; cv=none; b=JeNqc/I6SjVKQyW+NNOJPIEKAYHmx64HEFtRqx5j8/tAGnlDiLLj3R7bJWqGmQ3gCqzogt15z7cOKVnWWzbhBcu5zT2XOP/m3j/gRpB9dGnMt1vH7FlpKMz5oxXnIspQOYQhBGwMVp9W2J9h2J1+MOksPN10997fI/XrKpsU70I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779558322; c=relaxed/simple;
	bh=U+5vCKqyIckZlH0kgbI/uv6uNwr6fLXXR3ZmeXOw+60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdZ83B/mbZ4T6OxPq7Hqn1HHof0IhP1rwgu0kPsjDR077JYz1V+EOGpfM1zDC1Df1drtSgHIgvzozJ/aHUA8oTkyDlXZXldwzTPZ9slnLRdRDQB0MQ3Y+85NfAg9m5IBeVNh7WXXnkcjXSBYdTY3Q6z+gVoYZtWbqNXcUS4QNTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VE2vYkqP; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE2vYkqP"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3698e34a567so7557334a91.2
        for <linux-i2c@vger.kernel.org>; Sat, 23 May 2026 10:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779558320; x=1780163120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaCDSTZKkQ9+zQXiJKKfMsq7ZcmXLMVrknxtIyNSzsE=;
        b=VE2vYkqPRPJbZRlgth21EJkD72RxNoy3OLN9JuW/3+5qzrj3DckUpNrXdkVbGZXJGX
         tc2edSx8d1ccBAl3UnZoxZB9pOh+WE3eB0cgvdc16jvnc/QBRYot82U3wEMiY5BdlB88
         6gLFLqbKhMYz96y7tVsuUdGZ5IbdPA9w9uCKrhtUNsnR/qHpXbEJEOsH0SbxcBq7JTX8
         z6sl4HHaCP1sShzZaf2NWzlo8BB3hBeAwEoPrUlY6A6gARnKK0f6YwPJU2c2m7210HI9
         2I3dYcju0o1OyN4K/6UWCDMCjaANedWUJYONX6+qte82iEAetalaMfNthl/XKefZnwON
         pOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779558320; x=1780163120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DaCDSTZKkQ9+zQXiJKKfMsq7ZcmXLMVrknxtIyNSzsE=;
        b=TZ9lH2k7+7Ebsbjly2sTb6JMgixhgMkoz2s4rP1enpwddMb2AVD4VJ4Kn2iG3Kstip
         dpDR9Iv7KwxB14c1r17hnCURauW0s+ga4auX6QGsJKaBjznjsSvEMUGsS/1yGwJdz6iL
         NVjlwpnr0eu0cWV5yIjgHbVYOzhD2eGguE2ho4KT/HJkXkxK8TrSEcrckKY4FMX+5/OM
         iZH4ORWPWklZdBhKiYEgcrpZ82OF8LIRHZSB6Ld8AmVVsU81ro3d8z7a2lVS+7WGbgyJ
         87KzLMXIqDLfcBRA0z1kbUadDbKTBzoMsvzuqWdpQozvBjYgzoE1LQIY3dWboxIaxlIA
         LWww==
X-Gm-Message-State: AOJu0YyUuqKew7PGfGxY3y1ZHAwvZxYu/rJ7HrFgXWylw2HsiRqlMP6r
	InlEK1vrzlG+KlspPcceeyJ/E+ipmKdtLqRPWjt4q/aDIQ1JI5dxRkAGSw7/nxN2
X-Gm-Gg: Acq92OEyOBI1XlDm/RD/HqHQbLpERLG1YlaB0SvwqO0/b41xH9hTl08qYpUlmmpT26L
	uHzrCKi56dv/8GdyhB9r5ymmQPmj9RNtJrXNRYOtGjzus3aAEkCGZq0OJnKG6NbTNkqkFgDrk0F
	tmHcV1kCm/EMM77CadNLbgrteldNftvsDIE453F2QBUyBOkkzzJKxUkg8yUSsu41SxCaqSomGLk
	Vudu+o90B/j0SCHMmrU9Xcz0RsjBlr1HpGR6e3LLbXTjdsbe0xGjlHwRtL48HjvpTI0K7rgU1oI
	qQna952ebsAb8uI7EpRX/e5+njI0G431qV9L2GHd3qp+z0UQg6mBc8QWiBwQSzYR6EZMeyYcbSW
	tcG6Dn3kyxZzm9LoVHaEJJrwcB9oWLSiM9cs6NQAhfW51abQLC8GRw2K+H2EL0zr7jD/6ewtMJI
	3QCVNxAXbY+4rIzyL9/hppc8S6lqwuJEjrIfumlQpTtBpP2ahStf9Hafqu8a7NSB/xmyyf24BHc
	ji9pRZc8wY+wMvsBlNcVhFBk+qNyNazH76y+Yekp0IHrAi32WTR9oquazWTva/ZAtA3C6pNm4Ny
	4uZu9JSQ91W1
X-Received: by 2002:a17:90b:564f:b0:368:ed92:6f3 with SMTP id 98e67ed59e1d1-36a677ce506mr6735004a91.18.1779558320292;
        Sat, 23 May 2026 10:45:20 -0700 (PDT)
Received: from hardik-yoga.oryx-cobra.ts.net ([2401:4900:1c23:1260:c040:19f4:9706:1050])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a71dbc38fsm5127139a91.5.2026.05.23.10.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 10:45:19 -0700 (PDT)
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
Subject: [PATCH v6 1/1] i2c: designware: defer probe if child GpioInt controllers are not bound
Date: Sat, 23 May 2026 23:14:40 +0530
Message-ID: <20260523174440.9629-2-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260523174440.9629-1-hardikprakash.official@gmail.com>
References: <20260523174440.9629-1-hardikprakash.official@gmail.com>
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
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=221494
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 157 ++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 3351c4a9ef11..a789c54de433 100644
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
@@ -130,6 +132,153 @@ static int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
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
+	int ret;
+
+	INIT_LIST_HEAD(&res_list);
+
+	ret = acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, ctx);
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
@@ -138,6 +287,14 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
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

