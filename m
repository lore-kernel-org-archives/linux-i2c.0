Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A7B3ED3BB
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784116068; cv=none; b=dXYe2Jh6+R9SY728Muy6VycN+bsZ5Ffj9PJH5cNU1kI0MWy76CanuR9GSoaplCXjaqszFY7d6yvJ9oToSwcbhFou4it/EJ3g4d70yZDXuT8g4Eami1zQr947jO3vcX3xROzQQ0e1QwthzYeibVVw1Egfddk4jnU9EhNJ5GVAbLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784116068; c=relaxed/simple;
	bh=L6vK6QEmjEwQifC9Kb/8JGs8ImSZPhdSqTFrXpwe7NM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BPG2E13qI6JhaRVZ+Sqxmd2UzpaZS71I8JOyv1oOYlR1hY1Zrx85Od9cHNLhhZpLtSKhVdJYPccHMQXCd9jHiN4XRGiLHSjZDSRavNowzCuJiAqHmNSToT9/4v/IkXuETKqgDbmEmiXlg1xS+AkeLL3nMhhZfj4SwgzwpDQAxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B59ZtDRV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B59ZtDRV"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84a2dcec51cso3825856b3a.3
        for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 04:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784116067; x=1784720867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9+qUyXycD6EN07yp82nhtEu4h23ddYrmOdc1hJNeRQs=;
        b=B59ZtDRVH77gO0gHI3o4m7Pse42rks9wG4gA6TLsfcIH40/SRqZ4wJtHqc5k/GhPOC
         RXUTAwbq1OgJmGQ/EruHPEPtvXdDoCc7PzMRBLHQgbtzDq+l1YoUV3dJ/KuVl6+dzKvS
         N+ys58cvWrCrchWmWJvKMYpaKfRnBHbFHnEQdbvIq4M848BEyS50j8owIhil4f75aELs
         hm+2SugCdyvRvCXkJEjZQP1hLCW7TBsM80NmgiZ45CYIhoroxvtzADL3Fxs57qPDFW8m
         BpUl8yeqx8t4a8Q7fllhEFDQ9qzp7sKT9V+y0Q+qGGWFVA3FQpEVc4l55kO70Ti1AcZq
         0SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784116067; x=1784720867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9+qUyXycD6EN07yp82nhtEu4h23ddYrmOdc1hJNeRQs=;
        b=Sn8WkFoHt8dBCJSsnLqbXkFF5W5SL/ewmYX16Lp0hg5AT6escNDefjgaJYmVwrB2Xj
         eA755l8UOVZeXOaYV1j5jujC5terSKvtBcZR9zJx6qPcedHmpjqbftVtj4UJHcCHIwRI
         mci4mNoyRiERtcLQ6h0rjPWF+ItddaQNBimHkQU1YvIFNU6Zb7w+8oiPIDJI+lEjyMi7
         vy6R2ZWLXk9GvMhniXu97E3/sttnPXkueZViFpzKPg1A5v4SlFPo9SslZXkPeLI9zkwl
         LXPNmvckxqbFXt16T9R54PIIf8efJc4PL4CR1XYbAnk5TqsxR9SdNEgUdQMFsNwv778+
         4bNQ==
X-Gm-Message-State: AOJu0YyMWCWfF+qXqAMY7y+++oKdz8bAYE0SldCqDvky+NWGk/sQ0o5F
	rj2hDvV3XYAK2kBGSuRzJb/yUAw7jHBcCuaFh3eFAZGh2wnQ9WOqH0FBCZo6MUkj
X-Gm-Gg: AfdE7cktCl7U0jqYOp+ZAWjEUx69jA4zswaJpfbzdU4ETmIddH9FdGynTkPXSTHhuaq
	WUsRYzkHCdYLbM916FQ6D1QFDWpeBEmC9qKmiXy2MX5mULjww/UfJglVlId0u+O5iBoqIQ49P+m
	aWyJOO9RMs3yFxtO2Aix9gOARn/m5Ide4rfdQ7hYeW5ZB2Z7HrvHT5iyKnsEoY3r+/gbMrrO3gb
	t/1BY11BRKjjuOkccyZtjFjOBms0cOzpsZCN0AP6zEcqDRyU023LjbeUZPUeL4kV/2YloQEnRY4
	sgqttJiFIgekqutFWGTx2wFSfDDd0NIH39XN3kMRiHe3+smbnhUF6HjPAW4sk/2bPO60hkXXTaS
	LvvfwHk4Pc3+iJFElfFlI7qPNSDW56XYrXBIL8WhzIEJ8MJfW+sZ0DjqmNLjxZGF0ZfekviIafU
	uEtgHkokpMUriZFs/R4gV/Fm1cV4im/8g66nnD8LU2VnbdDnLZlGxTKPsxPszK/qAeicVt0OPPZ
	RvTBJCQoGJf9Ir4jvPyaFCOb7qjgV8xW0pUinbmAw9xsMS5neVVm+rEbi/4qTGnm6qA/xynr+Hi
	gQ==
X-Received: by 2002:a05:6a20:a126:b0:3b3:f46:1ef3 with SMTP id adf61e73a8af0-3c357553e67mr7499920637.41.1784116066508;
        Wed, 15 Jul 2026 04:47:46 -0700 (PDT)
Received: from hardik-yoga.oryx-cobra.ts.net ([2401:4900:1c62:68f6:6523:490f:51d2:57b3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4344b8bsm649012c88.13.2026.07.15.04.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 04:47:46 -0700 (PDT)
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
Subject: [PATCH v11] i2c: designware: defer probe if child GpioInt controllers are not bound
Date: Wed, 15 Jul 2026 17:17:01 +0530
Message-ID: <20260715114701.7713-1-hardikprakash.official@gmail.com>
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
Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
Assisted-by: Claude:claude-sonnet-5
Assisted-by: DeepSeek:deepseek-v4-pro
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221494
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 80 +++++++++++++++++++++
 1 file changed, 80 insertions(+)
v10 -> v11:
- Replaced custom gpio_controller_ref list with gpio_device_find_by_fwnode(),
  as suggested by Andy, dropping the linked list and dedup logic (~60 lines)
- Moved resource-skip explanation from commit message into a code comment
- Fixed device_is_bound() to check gpio_device_to_device(gdev)->parent
  rather than the gpio_device's own internal class device, which never
  has a driver bound to it


diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 6d6e81242f74..597aa9706364 100644
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
+	struct gpio_device *gdev __free(gpio_device_put) = NULL;
+	struct acpi_resource_gpio *agpio;
+	struct acpi_device *gpio_adev;
+	struct device *gpio_dev;
+	acpi_handle handle;
+
+	if (!acpi_gpio_get_irq_resource(ares, &agpio))
+		return 1; /* not a GpioInt resource, skip */
+
+	if (!agpio->resource_source.string_length)
+		return 1; /* no named controller, skip */
+
+	if (ACPI_FAILURE(acpi_get_handle(NULL, agpio->resource_source.string_ptr, &handle)))
+		return 1;
+
+	gpio_adev = acpi_fetch_acpi_dev(handle);
+	if (!gpio_adev)
+		return 1;
+
+	gdev = gpio_device_find_by_fwnode(acpi_fwnode_handle(gpio_adev));
+	if (!gdev)
+		return -EPROBE_DEFER; /* controller not registered yet: abort walk */
+
+	gpio_dev = gpio_device_to_device(gdev)->parent;
+	scoped_guard(device, gpio_dev) {
+		if (!device_is_bound(gpio_dev))
+			return -EPROBE_DEFER; /* controller not bound yet: abort walk */
+	}
+
+	return 1; /* bound, skip adding to resource list, continue walk */
+}
+
+static int check_child_gpioint(struct acpi_device *adev, void *data)
+{
+	struct list_head res_list;
+	int ret;
+
+	INIT_LIST_HEAD(&res_list);
+	ret = acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, NULL);
+	acpi_dev_free_resource_list(&res_list);
+
+	/*
+	 * ret is a nonnegative resource count on success, which must not
+	 * be mistaken for a nonzero "stop iteration" signal by
+	 * acpi_dev_for_each_child(); only forward genuine errors.
+	 */
+	return ret < 0 ? ret : 0;
+}
+
+static int i2c_dw_check_gpio_dependencies(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
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

