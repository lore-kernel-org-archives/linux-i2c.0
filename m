Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3498F3B7760
	for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 06:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679594; cv=none; b=ExhbLulHwgGcmAD9H44yT6E9HIxsvhwkHgFpqX71x0zuyCi54N7iIr2MLsQUofUFRSIhJENGl/KrAg7N79XLcxd0YlN74bS608Na3IYeMZpzW2RPBN3lXO3xcr7R0GR9qmqjlr6R7YrJZpsQiR+hhmGx5aGDF7QE7qGEj1rXiA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679594; c=relaxed/simple;
	bh=bRnss1KOVWUXgDXAJVzVsvJ3vRsXXIkGIhUVaOcNJx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRKbfG4LGXO/o1RhsCOkDGqeMME7xfn0saSQRz6Y14qA8Hf0INyZOJdAR8xcvchoWqAAdF7wb2Oj8rfdqg/MikQ5c1M70OkNOaJOUxWqNRhvVMPYaTJSjJMgHcb2Y0hlvziMdkFqVO3uNa51f4p/3hLxXv11XzlmQlktFHgFt3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bM5xrbTI; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bM5xrbTI"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1397ad67f5eso4456678c88.0
        for <linux-i2c@vger.kernel.org>; Tue, 16 Jun 2026 23:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781679592; x=1782284392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IxSyLpBjOeBaJJmK/OyiKtaPoo7G3CXXKgAk95fwJM=;
        b=bM5xrbTInSY7UcY7iVbrnkcZ0ADqQ8IQCqcfQhZqb3biaj1Xio9NXEsx1oD0n4qgHd
         gXl4gbpY6xx8QrLhnfyVUEfg8NB/nbLK5sKBs6sVAlg0cq4PJtthU5rJXV8hUryiwAPZ
         Mb4h5cZ/IrfNB14p5NS7j/RnA6Ofe/eoLdNPaHLlNysOW0nxeXHtYZav1u3xSxskHWQz
         YotlOk1qYsbJ4gezhrIkKw7IrRuXluF0hxd0+Sa6e/cRLNbbSiKqdL9TEKA8NP9w/BNV
         W8XkmjfanYdJidkXoDxVO7M/34l4FxGPSXKV1jlFtIuwns3u/LqKdE+sQ25Sb50kTQkX
         PopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781679592; x=1782284392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1IxSyLpBjOeBaJJmK/OyiKtaPoo7G3CXXKgAk95fwJM=;
        b=ijTT+56owUOqiss5CUhjZBpDx5rP9HH2Vx6AhxKm+83lekuryxa0IV2gAo78LRYM78
         zOkcNCfjQydAoOwp62uox1DBImGCzuWfzedLmmExel8ORDrQAHva0Kuyw250/H1wA+ec
         exGEzoc97kRNRkW3pxaq6xR+/ANqJmkW+0Jq+vPJvFD3Upvb0ZFC1eGD4VfogvNp8coG
         hPC6PNVNAcxWx/M17bssis1JQNmcL0AgxLni98I3IMACi0T47OR046p+K6rjyEqaeon7
         +1s+OiEehZpmyRasYVv2UGY2MSvd7pF9NJPHA9ue4t9E+UPPTx1A9oBRcstiMLOP7Smq
         9GNQ==
X-Gm-Message-State: AOJu0YzWFWeuibyarF1tvPf0+DKiM9BvTmv7+a/ZMuAC7ymlZP8wl/14
	LFQPtBb7O22SKAbulJdn69bPKSl5Uqs+OeArGbyx7+QMnDLhflWbrsyGqLPLVZHh
X-Gm-Gg: Acq92OG+osThS1Y+qfqYO8w6346sGpzd7BVGD9eqrU85lJfYEh5TQS4Ln7ISe/24Cay
	ZMq8UuoTwVHLqSbzNZhvRZ0zcKowignyLpH8yO51P82icjHItednJl2Ruqwcad0E5wd7dq+ogA5
	lsMwFa4qD+v7lfZfEPDTQSK04hfh7k3z/PGAUSv6n6g/iiNPregMMa0fB6i5XioNvN4+02CsyeB
	Vna0Rj3ppa61ogR/Kx4G3+d1n/+NM6kdQDShiCuyxny2+IWdY0+SOIbTAJ760hsEFeqXDCRBd09
	OJBmc/9szg1ToCEjbRrzH2DY9szedNiCyzEUIX3CBbsSHGjp3gauB2h4TOCBrIzkNffWZc2WU48
	v3ZTFcFQ4tw6b728zmKxmJHFJy7MgTX8e9ZkWan0vERGqFX51eQT4w+vSUEuPqdVZQX8A2x3toz
	8iubXqG6s71l8bEtLEMWfnIi/mvM2aF5ES28iIRDHYC+0M/GHjb0TiDHTL+3VJ66BLPYsi2fNuy
	yyUBsDOt1I44NIUYD0BdziUZBmj17kHK4jeowfaUytb2aLJH0yniciYQ7gGyBSvEEjo5wikYqTu
X-Received: by 2002:a05:7022:406:b0:138:407c:1d20 with SMTP id a92af1059eb24-1398f6fe79amr966296c88.35.1781679592370;
        Tue, 16 Jun 2026 23:59:52 -0700 (PDT)
Received: from hardik-yoga.oryx-cobra.ts.net ([2401:4900:1c62:151d:8407:852b:5db:1408])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1386f20ad25sm14118376c88.0.2026.06.16.23.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 23:59:51 -0700 (PDT)
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
Subject: [PATCH v9 1/2] Revert "i2c: designware: defer probe if child GpioInt controllers are not bound"
Date: Wed, 17 Jun 2026 12:29:21 +0530
Message-ID: <20260617065922.26004-2-hardikprakash.official@gmail.com>
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

This reverts commit ef76a3a28c79b628890431aa344af633e892035b.

The patch causes boot regressions on multiple machines. A NULL pointer
dereference occurs when agpio->resource_source.string_ptr is NULL (i.e.
when string_length is 0), and a probe deferral loop causes CPU starvation
leading to kernel panic on Intel CI machines.

The patch needs a proper rewrite addressing these issues before resubmission.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Tested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/linux-i2c/90656be5-eca0-4a09-9b19-0c6e85f1d455@intel.com/
Closes: https://lore.kernel.org/20260602185339.GA404948@ax162/
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
-- 
2.54.0

