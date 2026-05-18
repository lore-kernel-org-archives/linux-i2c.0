Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F51409DFB
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107323; cv=none; b=UU5oGrBOX9aNKkRuGkFKZhc0DU/umfsceni9AC4oPCyVlGvyYNYlOmophV3T0MtEF0cTayPIr3mqzqG8Jl+ZhsDwIY1zdoNWpSAGzsWec11Xr1DNDUUnhwNJvSlwFRXq4Q4jcIhXXiaWlkOc0fWPzBfpxJ5R2JTIt4QOiYhJ87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107323; c=relaxed/simple;
	bh=QPxh7Z6D0iaVS4xsx1EOOOTAteeoVyAQeoFXqCX9Gbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbcgCSe3EsRABB0MVcfRpF6ofnhm3dvEHvqokErzxaLRIn/tW50odcgi/CExN+j3Bzy4LqjoOxvRzezyDXNJ6X9HNMngiNkOJd4wiXp3ths09QDXKcgppdphsw0tz+rSqmH6iaZpubaXS3SK6a331TWYh1D1hvJjl1b0kaZqFGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeNiEOKp; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeNiEOKp"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8354461da74so908941b3a.1
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 05:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779107321; x=1779712121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5l7aqY3zITH/9bIv1x9E0Nee1ItCtMDSnbAcjovxwCg=;
        b=OeNiEOKpWkig5yq0RXvCox4XolnV4aNfm2q6zrpelIR88fxRYocGOb8UzxZBfKtLWK
         PcSq7mqGW0q04GRzYVZQ86KBWgE8uOOlRO4uoUxDcVEL+gF77voKTa82gzHfuPvT8Vyo
         6qoWWUrs7N5u7T3O4pINSlRc1NvJ/0OU4ZupTfgjd8Uy7+95PubvqJDd/PyoYyTOfCCw
         7P61xGQTNj2JXbBY/3+pZxuKXHjabKopJXJtglDScO5Up956p1z2/qdfDeW2aWecLPG4
         e3DzVOVvcwXSZh7of3lKhAUShofIVCp3QL5vGHnnYW+W4kEnxTy3BIYStdEVnnRqaOra
         Nvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107321; x=1779712121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5l7aqY3zITH/9bIv1x9E0Nee1ItCtMDSnbAcjovxwCg=;
        b=h2ErJ1vN2J+5z829JrE4EIW3/2/mrPucIDp1huU4H72Zrf+ePVJGrhK6adwuKHHts6
         /R4DPJuaOuPH35of2rpyiOGaQU2kS+hzhii8sb+rXC68VWZyBlIm8Ps9I1K08HuJtpbi
         qjZ75+hpLG68I68aV4h2j4IIby+SGjssLkxk1y26BfmqTxsiOmAqPyxotcfSqX50FXpz
         PBQ1Vqlkdud0UBLsJJAu2LAvCV5Vqt3e8ksPI8EB9J8Wj8EKgJ/b7MmTuD0d5wd93hEd
         Kl+Qk21ro8KWwgr5ROTbf6cFPMPEhEE73TCyWIc+5AR/3JYp/n3jiusxIJHgLnPSR2A4
         kdMw==
X-Gm-Message-State: AOJu0Ywuo8cRuFN02YJQrbSPoVujtF4T6+5YVTk/oqZCJV3wXrIlVhW3
	As4kW5lP004xQU7gtzfXuwJKAMShXltmT07btqCLE3TK3qTcbPcpfoPVOnacUiET
X-Gm-Gg: Acq92OFo7Hpn3Wt/sPF7B8bb6nOyZAl7j3GTWX0Tyt9csHyw8Jg3iMtdZoRRevlyXmL
	d4QIsi7dMHcprecRey23fpskGTMWcTLtiQ4J1t6gF90MgY3EMx6M7hTsY692Adsu73zD6YtAE+4
	BkADFmBJaoqoJ0R6r060mzXqr2CJdtAuezhhUvwloF/xxzawD5Y22FcEdverD1KXvW6/DKJxB5P
	k0bSWxSmP98XoiKv2pX/1MUBbVSFsTVxIO1NgR2GdRkT/kR4wYASOvAbbvkQOKbVVnOdYaUq8gz
	hHfsye+5RZ7JgvrTgqPrdvq8Px2iiGf8cvmcA9T2M26VGgMYhme26+ii3sgTce0+UQcRD61eq35
	2HrWdbOuzq2JzbeTil8Wz8XdyeCjo607U5kCXQm6ZQ9q3KT3xCxKm5fa6wH35P0PPEIKeOu3xUP
	NbGkYI0ELIQEApkAbWtvcNNAeJeUAlxn6GKCpJieIU3yGtwVn7q0PhIFaElXjQubxGWRW2KPbN2
	CuKkDdS+w4Zf47IdC89i14RhBBevbSKBlxalv/vGSyp4omRgEO7L3Xn+M7grSCV
X-Received: by 2002:a05:6a00:2793:b0:837:40f6:cb88 with SMTP id d2e1a72fcca58-83f33d39d8cmr14641673b3a.26.1779107320864;
        Mon, 18 May 2026 05:28:40 -0700 (PDT)
Received: from hardik-yoga ([2401:4900:1c65:166e:af67:d4b8:e4e0:1695])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19664a59sm14650472b3a.1.2026.05.18.05.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:28:40 -0700 (PDT)
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
Subject: [PATCH v5 1/1] i2c: designware: fix probe ordering for AMD GPIO on Lenovo Yoga 7 14AGP11
Date: Mon, 18 May 2026 17:58:13 +0530
Message-ID: <20260518122814.8975-2-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518122814.8975-1-hardikprakash.official@gmail.com>
References: <20260518122814.8975-1-hardikprakash.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Lenovo Yoga 7 14AGP11 (83TD), the WACF2200 touchscreen fails with
lost arbitration errors on AMDI0010:02 at boot. The root cause is a
probe ordering issue: i2c_designware probes AMDI0010:02 before
pinctrl-amd has finished initialising, so the GPIO 157 interrupt
needed by the touchscreen is not yet enabled.

Add a DMI-matched deferral in dw_i2c_plat_probe() that uses
device_is_bound() under device_lock() to correctly wait until
pinctrl-amd's probe has fully completed. Use acpi_dev_get_first_match_dev()
for robust HID/UID-based GPIO controller lookup instead of string
name matching.

Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
Assisted-by: Claude:claude-sonnet-4-6
Assisted-by: GPT-Codex:gpt-5.2-codex
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=221494
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 76 +++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 3351c4a9ef118..d09cd47bf4b9b 100644
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
@@ -86,6 +88,76 @@ static const struct dmi_system_id dw_i2c_hwmon_class_dmi[] = {
 	{ } /* terminate list */
 };
 
+static const struct dmi_system_id dw_i2c_amd_gpio_defer_dmi[] = {
+	{
+		.ident = "Lenovo Yoga 7 14AGP11",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83TD"),
+			DMI_MATCH(DMI_BOARD_NAME, "LNVNB161216"),
+		},
+	},
+	{ } /* terminate list */
+};
+
+static bool dw_i2c_needs_amd_gpio_dep(struct device *device)
+{
+	struct acpi_device *adev;
+
+	if (!dmi_check_system(dw_i2c_amd_gpio_defer_dmi))
+		return false;
+
+	adev = ACPI_COMPANION(device);
+	if (!adev)
+		return false;
+
+	return acpi_dev_hid_uid_match(adev, "AMDI0010", "2");
+}
+
+static int dw_i2c_defer_for_amd_gpio(struct device *device)
+{
+	struct acpi_device *gpio_adev;
+	struct device *gpio_dev;
+
+	if (!dw_i2c_needs_amd_gpio_dep(device))
+		return 0;
+
+	/*
+	 * Find the AMD GPIO controller by HID/UID and get its physical
+	 * platform device. We need the platform device (not the ACPI device)
+	 * because that is what gets bound by the amd_gpio driver.
+	 */
+	gpio_adev = acpi_dev_get_first_match_dev("AMDI0030", "0", -1);
+	if (!gpio_adev)
+		return -EPROBE_DEFER;
+
+	gpio_dev = acpi_get_first_physical_node(gpio_adev);
+	acpi_dev_put(gpio_adev);
+	if (!gpio_dev)
+		return -EPROBE_DEFER;
+
+	/*
+	 * Check that amd_gpio probe has fully completed, not just that the
+	 * driver pointer is set. The driver pointer is assigned before probe
+	 * finishes, so checking it would allow i2c_designware to probe before
+	 * the GPIO IRQ quirk in amd_gpio_probe() has run.
+	 */
+	scoped_guard(device, gpio_dev) {
+		if (!device_is_bound(gpio_dev))
+			return -EPROBE_DEFER;
+	}
+
+	/*
+	 * Create a device link so the driver core enforces probe/remove
+	 * ordering between this I2C controller and the GPIO controller.
+	 */
+	if (!device_link_add(device, gpio_dev, DL_FLAG_AUTOREMOVE_CONSUMER))
+		dev_warn(device, "failed to add device link to %s\n",
+			 dev_name(gpio_dev));
+
+	return 0;
+}
+
 static const struct i2c_dw_semaphore_callbacks i2c_dw_semaphore_cb_table[] = {
 #ifdef CONFIG_I2C_DESIGNWARE_BAYTRAIL
 	{
@@ -138,6 +210,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	struct dw_i2c_dev *dev;
 	int irq, ret;
 
+	ret = dw_i2c_defer_for_amd_gpio(device);
+	if (ret)
+		return ret;
+
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq == -ENXIO)
 		flags |= ACCESS_POLLING;
-- 
2.54.0

