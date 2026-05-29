Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6446351C20
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049360; cv=none; b=CPOF3tlvk9BI3deWtm5k9cYICJCfnYOoHkTszHZGRYXGHQb9vjviWX+pr0RfSxmQ8ZmrljilwTjCAc2b7M4MzBKVFdepeJZYoZgP/F9poFE29hC3PTBFigxWE0yG5LzFYp4/FVoAlBk1FYbP5q1dpCR69fmD3gPT3XUjSg8rsQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049360; c=relaxed/simple;
	bh=l9Ex1FNwwaHGC5QWfXsAWNwYQPMBie2vXLBEMIGp/uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgs0ckbrTJxpCap0l5bdIn8lpo2eB0yrQohqfLpNCPKQEgIzslzy1+FVWEK7TcjyhgZ0NDvlBCqeeFszzXq140hS++zdOGbBIVjQ57W6kMgMQ/Fzm/cRYJcfTIJ1xAzxkktUthMRqsC7T8SuviD4eynkYL/yciIPhgVnNmPJaf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRT98WSV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRT98WSV"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf1cda2b17so5784665ad.1
        for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 03:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780049355; x=1780654155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPaCnnP1+4ska0qPOYVJBMJOBmGpE7wwQFomGj95sKY=;
        b=SRT98WSVczaiukuYn4NO+Jf7sb/FSq+xF3ITYo10wCWmOojlJ5xlMSjkUCYri2m13A
         IEkWHfd3P0PPTPchEFwsvZgRdbBuTdnw+NGCnI1107ofT0Sn5db69mMD68BxFYhGWhqn
         h6uGVUnuMevYkZ3syMMIKnpExFL+5bavx4zNZaVu+v37ocldAbPOi3CsFS5mDsLZq7b9
         jaTMjG6f8JAjaIcm5OVS1GMXlAZk+29c/Ky7pWIJ5D/s2AGksIhfnszE61DJ7JYZYMcG
         +/lb/5w9vd7cAMls3LZAulxJ7y/DEl0Tpe+yFGtaCxDGxsmelcVRJuzzRo4KbnS98asA
         vHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049355; x=1780654155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pPaCnnP1+4ska0qPOYVJBMJOBmGpE7wwQFomGj95sKY=;
        b=IfXrpdjaYCtWGIMaptjLViJd0WbN0eXXWCqui4gHQ4NlGCdaHcicIuBS7wLJWLpo6k
         SrQoMrhw1JXrZo/u/2c0adl2hTJlD7Mnq39oO2DEePn+KIMf6BuoMmEUHH2u0zuUJIxX
         RITGxj9ZrvhhsTpK8BVkiC6gj8YW4vFbdP2yc/gnxUGe6Ii6YBb1nXOIVzWjNpD3RlBl
         FHYd13gyc69hZBRR78t5jh6h+pFQUjFsf+1a5fr3NpSJRG4LoMRiXMlBnc0SquEyrL34
         hYFOnWWEiQBk0gFkvFOC5FWoJg57eNcr6A6F+qVXmknx1JBzI1ua7eE7BVRcV2E5f32h
         mhZg==
X-Gm-Message-State: AOJu0YyXXJVUyWo7oEAy5wNeJobuLKl8awKRZxFYspjgzybJFi434Oxx
	KDsrIwkRxCRxAD4BlSkPaywTdcMpNz75KInIspg5oRG0HNmGacLbS245DPHxYuAt
X-Gm-Gg: Acq92OF3pTivLrv6yTiEiF462vkutjD2vL2N+jYIu1IAVtxpt8r/e2STK/Q1OzJr6Ra
	K5DQMzYrF5c+1aLciJQO5b/1QzMgArErMIDS8zLXYJI9CXFseJhZ0/DtEnoL3/4PylAjDU5lmhy
	mX0kaTijlBnoopywZZAq+6CFk160oAjtjuRECq8sPiITxf4Lpb0SvN7p/2Pi2G8kcbeqKurAi5k
	JA7bw7Hzr/azcrR7I8FtzdFVwKwmIkV8kLLdPPU9jvJfVKktDwrALTTgoDhr98A0Ut3xu8VKY0q
	O8b/Sdo1aKNaVIDFiM6D+19hR/QhyFOM8a7CJmWJyEDe8e9R3ZJwY4Tgp6eQ2emaUfa9+CiWt+d
	7MGWpLWGv4UKRv5tQ4MqUrRA/8k5KjJxFarAMvAaOvbIvrVcdloA+63D8Z3uK1m5rLwc/UOrExt
	L1nt98Q1aRm/sl7L+nEmRRb7jtc53bIcehauxKNc1xBsD6kAyjAYfweWaMlixUHmIn9B8E611w1
	ArjIYieLge65mfb+ier9IJ0RbC7khljIAU/G3Ne8Zfc+5wBMU9AGvsKrggSZyLHU8GCJnwDjNqV
	VIRTyjHuw4dyg+MdyCnMwZ4=
X-Received: by 2002:a17:903:8cb:b0:2b4:64cf:e8f8 with SMTP id d9443c01a7336-2bf204672e8mr28889585ad.2.1780049354558;
        Fri, 29 May 2026 03:09:14 -0700 (PDT)
Received: from hardik-yoga.oryx-cobra.ts.net ([2401:4900:1c22:2195:3f68:8568:1e68:2087])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b0122asm16051225ad.46.2026.05.29.03.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:09:14 -0700 (PDT)
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v8 2/2] i2c: designware: defer probe if child GpioInt controllers are not bound
Date: Fri, 29 May 2026 15:38:37 +0530
Message-ID: <20260529100838.8896-3-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529100838.8896-1-hardikprakash.official@gmail.com>
References: <20260529100838.8896-1-hardikprakash.official@gmail.com>
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
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
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

