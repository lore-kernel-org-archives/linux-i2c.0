Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFCB10F0
	for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080646; cv=none; b=VbDkibnFeQLgqj8MgHJVVl6aU9CriBQhU2yGh3P77S/s0dmsxLELd7sRV94oPinCI0XcSLczUDxYfRG/EcQMPr5HjG1GgcG5XzfXbqR9SWZMj9d+VnUYNsnGhohzNAeJRpjWlMHxd7dRVDuNI0ApZ1SDHVA0djRfqRd4PGYc3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080646; c=relaxed/simple;
	bh=kaishit0l3D7M91kmsDJgwCJTTWfCGNoHd3rbC0bz6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fyXo3yPq1xP+kkx48a2CFe73tu1DvOvJgbxorBnmGntpfxlz0hod8EzQjcrpChNqaiFztZOMI4Hl7lhkx2MkqL4VgXV1qxd0aj3pzWOm5zVqroBSWRBXm/rm3tTxjyN07Er+7ddAbn63cAo4RTRCG4i7NTHIiekN3NDToIVW/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFgucHH4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFgucHH4"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf237e1433so71590905ad.1
        for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 01:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781080644; x=1781685444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xTlLTPLQVob07Monee3VTFRy46RFeGt5gASHP+XGMa0=;
        b=eFgucHH4rRV+EM+SxB/B2YstHpe456xR5jOE0L6Syj36WHkQTPiSzbPvkJqSBm2jWk
         hdj5GMo2VqZgEU7YEKy4KOPFW2rQM4CnUyrEm0vEQ1ZYBdgKHfHpsyuF5/ZNptbjYWax
         v8KdYXKn91Fgg19uygQT3MJG7mLLNpzt+hx6SlbvH30KboUOAHHfFt9IZFO1uz1z/s4t
         wU3idruIMuS1J+CrNidgFvfPP1GDAX0YwrnzVbWidXWqAoRGzQi/69EFUOxNfjm94dEI
         i36DkXkRucrT8dl3QSs/BG+vWaJBkmsjAinhO/ckqKNA9r+nVI9Ya9Ab6ouUjUvlX1gS
         BGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080644; x=1781685444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTlLTPLQVob07Monee3VTFRy46RFeGt5gASHP+XGMa0=;
        b=CLEJCNK3H6pD+2kM+c8vJjqLhMKgAu4+51harpoTInC2QE0ygJKj2ogZzddgj02fgw
         v94LdEEaJUJsUOMPkx9e0V8GSES6g0lQNmbofivkuC54FbWKd1C9ejmd6mdT5Uc3uI7n
         zsFKoKeUeK08clmN7QV0z9Wttj/2OhuBJAer5gT6m9QSXhXwIEXiIgoXzzHJyQ5vIlso
         UT1fRjE9zX8P8Q5BfM/XQRIXNr/fUrEi/udUl6/ZHRJuGUzQHwNs4OmziOqmBrSoOrJV
         8IU9l0OgktLzsg6hU9eyneR8Z80KD6Q632QoWjZHnrpMa0Y1p6AnpbwUEVBkPK8sWdWD
         nXSg==
X-Gm-Message-State: AOJu0YxbCM4jFWH/BkJOKk8MXt7086huokGmUloPlfWASVlOzJcZjIYK
	ed+26zxarlsor2aWGm5hl2OJfdSZYrP6hkGf9SSpwC5kgSlOVK3kzL81Zw6IRhtZ
X-Gm-Gg: Acq92OGDMRI8zzYYji7j+KcY4Zc4RURUWZioKcSLqgQ6yp4JIg3XV0/E7mm3Vj42D96
	L5pSiwAaxQGSFM0KfcNurYCpswcs/vq4qljb3+FA/tzwa2t41efFO8e9kD+YzEPVBSzx6Rw9h2+
	CMpEH2OoD3946NP5siOEgfIDop2sMZ2VHOr3gjn/YumfphXsVOrH5TPIN93DYecJm2YYbZH6ZdA
	7zbVQj2wW5rnTPto7YJymzcmjrVQUDuSnJcgK4dPbex/RbzbRH5XFVuv+N92J72Omq+SlgoRDZw
	bfEUmYSFCuWadukaEBPDND8IzUZO0o5VjxScbiHOcLmyFJvfevlSqxuMB9PFpBGj2q53jQ1xVlO
	cn10e1QPA0aafh//fAN0z/Z0asliptYJXo+tLk1PgI+IMvX/odPfCziqKpUi6M6XLB0XsIkg0X9
	SBHknqufAN9BZbYlh687/yhX8zgnX7zh/f287flqsr3qOUSCinw9PSt3aaDC1/Dd+X2/E8kB6jh
	1BQ52GGvZlvzSfZng747PkTojkNQo59xIo9lcE3+z77rytjsswlTg5aNYPn6+Ies9c2HULlnQPI
	poy28BeuOIt/ptlwfEk=
X-Received: by 2002:a17:903:90c:b0:2c0:b7e1:7f08 with SMTP id d9443c01a7336-2c1e859fc13mr290306175ad.28.1781080643939;
        Wed, 10 Jun 2026 01:37:23 -0700 (PDT)
Received: from hardik-yoga.oryx-cobra.ts.net ([103.52.208.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8429fsm291897375ad.18.2026.06.10.01.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:37:23 -0700 (PDT)
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
Subject: [PATCH] Revert "i2c: designware: defer probe if child GpioInt controllers are not bound"
Date: Wed, 10 Jun 2026 14:07:01 +0530
Message-ID: <20260610083701.18663-1-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit ef76a3a28c79b628890431aa344af633e892035b.

The patch causes boot regressions on multiple machines. A NULL pointer
dereference occurs when agpio->resource_source.string_ptr is NULL (i.e.
when string_length is 0), and a probe deferral loop causes CPU starvation
leading to kernel panic on Intel CI machines.

The patch needs a proper rewrite addressing these issues before resubmission.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 156 --------------------
 1 file changed, 156 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 1c01b0460385..3351c4a9ef11 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -8,8 +8,6 @@
  * Copyright (C) 2007 MontaVista Software Inc.
  * Copyright (C) 2009 Provigent Ltd.
  */
-
-#include <linux/acpi.h>
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -132,152 +130,6 @@ static int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
-struct gpio_dep_ctx {
-	struct list_head gpio_controllers;
-	int ret;
-};
-
-struct gpio_controller_ref {
-	struct list_head node;
-	char *path;
-};
-
-static int check_gpioint_resource(struct acpi_resource *ares, void *data)
-{
-	struct gpio_dep_ctx *ctx = data;
-	struct acpi_resource_gpio *agpio;
-	struct gpio_controller_ref *ref, *tmp;
-	bool found = false;
-
-	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
-		return 1;
-
-	agpio = &ares->data.gpio;
-	if (agpio->connection_type != ACPI_RESOURCE_GPIO_TYPE_INT)
-		return 1;
-
-	/* Check if we've already tracked this GPIO controller */
-	list_for_each_entry(tmp, &ctx->gpio_controllers, node) {
-		if (!strcmp(tmp->path, agpio->resource_source.string_ptr)) {
-			found = true;
-			break;
-		}
-	}
-
-	if (!found) {
-		ref = kzalloc(sizeof(*ref), GFP_KERNEL);
-		if (!ref) {
-			ctx->ret = -ENOMEM;
-			return 0;
-		}
-
-		ref->path = kstrdup(agpio->resource_source.string_ptr, GFP_KERNEL);
-		if (!ref->path) {
-			kfree(ref);
-			ctx->ret = -ENOMEM;
-			return 0;
-		}
-
-		list_add_tail(&ref->node, &ctx->gpio_controllers);
-	}
-
-	return 1;
-}
-
-static int check_child_gpioint(struct acpi_device *adev, void *data)
-{
-	struct gpio_dep_ctx *ctx = data;
-	struct list_head res_list;
-
-	INIT_LIST_HEAD(&res_list);
-
-	acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, ctx);
-	acpi_dev_free_resource_list(&res_list);
-
-	if (ctx->ret < 0)
-		return ctx->ret;
-
-	return 0;
-}
-
-static int i2c_dw_check_gpio_dependencies(struct device *dev)
-{
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-	struct gpio_dep_ctx ctx = { .ret = 0 };
-	struct gpio_controller_ref *ref, *tmp;
-	int ret = 0;
-
-	if (!adev)
-		return 0;
-
-	INIT_LIST_HEAD(&ctx.gpio_controllers);
-
-	/* Walk all child devices and collect GpioInt controller references */
-	ret = acpi_dev_for_each_child(adev, check_child_gpioint, &ctx);
-	if (ret < 0 || ctx.ret < 0) {
-		ret = ctx.ret ?: ret;
-		goto cleanup;
-	}
-
-	/* For each GPIO controller, check if its parent device is bound */
-	list_for_each_entry(ref, &ctx.gpio_controllers, node) {
-		acpi_handle handle;
-		acpi_status status;
-		struct acpi_device *gpio_adev;
-		struct device *gpio_dev;
-		bool bound;
-
-		status = acpi_get_handle(NULL, ref->path, &handle);
-		if (ACPI_FAILURE(status))
-			continue;
-
-		gpio_adev = acpi_fetch_acpi_dev(handle);
-		if (!gpio_adev)
-			continue;
-
-		gpio_dev = acpi_get_first_physical_node(gpio_adev);
-		acpi_dev_put(gpio_adev);
-
-		if (!gpio_dev) {
-			ret = -EPROBE_DEFER;
-			goto cleanup;
-		}
-
-		/*
-		 * Check if the GPIO controller's device is bound. If not,
-		 * defer probe to ensure GPIO initialization (including IRQ
-		 * setup and quirks) is complete before we enumerate I2C
-		 * child devices.
-		 */
-		scoped_guard(device, gpio_dev) {
-			bound = device_is_bound(gpio_dev);
-		}
-		if (!bound) {
-			put_device(gpio_dev);
-			ret = -EPROBE_DEFER;
-			goto cleanup;
-		}
-
-		put_device(gpio_dev);
-	}
-
-cleanup:
-	list_for_each_entry_safe(ref, tmp, &ctx.gpio_controllers, node) {
-		list_del(&ref->node);
-		kfree(ref->path);
-		kfree(ref);
-	}
-
-	return ret;
-}
-#else
-static int i2c_dw_check_gpio_dependencies(struct device *dev)
-{
-	return 0;
-}
-#endif /* CONFIG_ACPI */
-
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
 	u32 flags = (uintptr_t)device_get_match_data(&pdev->dev);
@@ -286,14 +138,6 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	struct dw_i2c_dev *dev;
 	int irq, ret;
 
-	/*
-	 * Check if any child devices have GpioInt resources, and if so,
-	 * defer probe until those GPIO controllers are fully bound.
-	 */
-	ret = i2c_dw_check_gpio_dependencies(device);
-	if (ret)
-		return ret;
-
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq == -ENXIO)
 		flags |= ACCESS_POLLING;

base-commit: 3f786abd23951f3f600a62fef42469d9200d5f52
prerequisite-patch-id: 22fa9ba20fa28cf94185281704c51feef7abc701
-- 
2.54.0

