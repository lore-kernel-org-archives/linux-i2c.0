Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C6235F191
	for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434854; cv=none; b=RNxZqKIZVQ1Ep+d2aVjCk7yK/0IpmzhoR8RMx5WlQhrM1/gmkQvKyBkSbnMZoK3fnn87jBSG6s/3g/FmO3OOABDO7XHnWqodEZtKrqAJr2Wlsay6EI67nLNdaw/EvvLjQ0nLV9ywKW+585fv4C40zSsE/6bTPu/Dr8d7nc45jPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434854; c=relaxed/simple;
	bh=Nwvv872uZXReY6PvLRaHQqXN99TKLRYH+/ajSwSPBXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khxvpV0bWL5fEZBkG2SFZmfCbeVwc8glob1KoXoHH7pzAa4Q8MeWeuLngv7mJGF461bAaNntxkeXu0i6znXD6vTWfD1M0aUm//iIOzFagx2OAcN4U3XocsSwcqESpEqpIxnB7tCn+DKGr8jPjukicbOYlO8ajhIml00JazhFBJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmwRiIf2; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmwRiIf2"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso3594126a12.3
        for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787434844; x=1788039644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2pv2EGjaR4WPSMZF2hTxBbXWP8nqmyPnemdCtbz8Odo=;
        b=CmwRiIf2c7rrpHRUESnk7X+hgFba9k0MwF4Xg9wK9E+3cpVwjwf/ny7w/kqzxZrEbj
         X9Jfepm4ouae2ZtJL81Lid4Z5WCVe0lrpX/8BKCZhf0ABZW9wul4IA0KRs9+2Eu5VBmx
         p4NjvXvwfYIitnfDq04dtjwbeYCZYKYm8xvQ9HCaT8fCrp8WN9Kdzvzqqiub+vDxlhdn
         T/APRsZl4OA/yWs4ydU/hWyGNxzbM9hXbbjbXyqARrCd5FQnd4JmU26kpeYMmTecqLUx
         Js89bvt3CodGfZiryNCzYL/5OiqU680w1s+NN4oFZ61Y63XR92Nk8D5WYcVUGObqPaGU
         OrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434844; x=1788039644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2pv2EGjaR4WPSMZF2hTxBbXWP8nqmyPnemdCtbz8Odo=;
        b=eD23cPUTv9mzMoGZLaN6YFSCGSTM4wwTmDMmXFLLoxh0BwY2MNT+CCpDTS7g5eKyL1
         7b8Gt/hq4RxdVv53ltJ7WAZdIlYpGszIj8AMXS5R0dodJMSGb+zsWGdIz/+dW4Ow4DaR
         oT7yjlfL3Fs59EkHiCmIX9VnEmE3s338+/m4vf8rwWWnhZd+FhbkzduFpD+Vjw3lTESO
         iOu9s2E+9pUEgo1xs7lMYwSv6WrrqbhRQrC8VYWWThn4/ZfaxfcwcisdrnUN4as3CDGn
         miuJFJ5rlJqR8I5hp1vLfhkN6arsLGZg4Dm2fSZsw+wbuLZ3uhOyQkSRzyBcFhdEnTCO
         eX7g==
X-Forwarded-Encrypted: i=1; AHgh+RqjeLOQY9Q6DfFS+2yB7po02AvUfIoWWQ4T0FmfFExXq3fc9NUR7PyXQ19xufPNn99/hvecVXrf3u8=@vger.kernel.org
X-Gm-Message-State: AFuF++nDjOjTZjeSziOBmEZ1fzhHZbau7rFdqwqDsJ+pGiQNy7Qj68D/
	yKrKeKCznvIgw+IUTHQdhMbTOEDglNVMeZBcXJU4yxoMUegsn2ieFV2tPz28sXh1
X-Gm-Gg: AR+sD13C7O4tt/NeBCFzvckoDDCt1dgKYdatKiTZEFWA+Q0O0zal1uM57ZcXTounx8b
	IJH6oFxoevhdXCZnMX7mMUw5EX/OFfwirALF5vOVQHDHbsJwqPSvNU6Uuctj33+ts0A9S0nUiw/
	YFGAttR37IHC8W4TCzMvKQuFL1jaT0+dvM2aotWjSg/D06JfF5wdtiW3lZxD+0W+kiiN03DfTN1
	qtV2jOYkZwKFb5L7hRXhChcb1HhE5Rpc2TY64tFgdcirQ2VCTIkdpMSIRY735S82cZmx4yMWnSW
	kNWCPTuCIvlLcM/7OL5IwZVViEE0PZ5FOS4s3QSLfU/GWcSPdTNRVJ5cwqnpg/eh5c/FRF1vz0d
	0wk0W5cJMQ7oEjk1eEZ0V4jhr/5KgOpqL2HZVOO/977Gweh/og0+o6fDKBKOo1arZsT60fVC+ZL
	6+lwAKPUhcx/Y/wv8S35tdUmi1iiho8u11t0i3eAqXYGuyop/ziwKtJNBsDxU=
X-Received: by 2002:a17:906:d8d6:b0:c21:34a3:4d9c with SMTP id a640c23a62f3a-c246a72174bmr1372738766b.21.1787434843762;
        Sat, 22 Aug 2026 14:40:43 -0700 (PDT)
Received: from m2.. ([37.142.151.124])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c24966f99basm466778466b.37.2026.08.22.14.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:40:43 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	Christina Quast <contact@christina-quast.de>,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH 09/13] HID: ft260: gpio: group sysfs attrs per HID interface
Date: Sun, 23 Aug 2026 00:39:37 +0300
Message-ID: <20260822213941.98882-10-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260822213941.98882-1-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split the single sysfs attribute group into per-interface groups based
on chip mode (DCNF0/DCNF1):

- I2C-only (mode 1): full I2C + GPIO attributes on the I2C HID iface
- Dual mode (0/3): I2C-facing attrs on the I2C iface; GPIO and UART
  attrs on the UART iface
- UART-only (mode 2): GPIO and UART attrs on the UART iface

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 58 +++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 554d8e3ddb6d..0a1875a1a7ec 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1592,7 +1592,7 @@ static ssize_t i2c_reset_store(struct device *kdev,
 }
 static DEVICE_ATTR_WO(i2c_reset);
 
-static const struct attribute_group ft260_attr_group = {
+static const struct attribute_group ft260_i2c_chip_mode_1_attr_group = {
 	.attrs = (struct attribute *[]) {
 		  &dev_attr_chip_mode.attr,
 		  &dev_attr_pwren_status.attr,
@@ -1603,11 +1603,35 @@ static const struct attribute_group ft260_attr_group = {
 		  &dev_attr_gpio2_func.attr,
 		  &dev_attr_gpioa_func.attr,
 		  &dev_attr_gpiog_func.attr,
+		  &dev_attr_clock_ctl.attr,
+		  &dev_attr_i2c_reset.attr,
+		  &dev_attr_clock.attr,
+		  NULL
+	}
+};
+
+static const struct attribute_group ft260_i2c_chip_mode_0_3_attr_group = {
+	.attrs = (struct attribute *[]) {
+		  &dev_attr_hid_over_i2c_en.attr,
+		  &dev_attr_i2c_reset.attr,
+		  &dev_attr_clock.attr,
+		  NULL
+	}
+};
+
+static const struct attribute_group ft260_uart_chip_mode_0_2_3_attr_group = {
+	.attrs = (struct attribute *[]) {
+		  &dev_attr_chip_mode.attr,
+		  &dev_attr_pwren_status.attr,
+		  &dev_attr_suspend_status.attr,
+		  &dev_attr_power_saving_en.attr,
+		  &dev_attr_gpio2_func.attr,
+		  &dev_attr_gpioa_func.attr,
+		  &dev_attr_gpiog_func.attr,
 		  &dev_attr_uart_mode.attr,
 		  &dev_attr_uart_dcd_ri.attr,
 		  &dev_attr_clock_ctl.attr,
 		  &dev_attr_i2c_reset.attr,
-		  &dev_attr_clock.attr,
 		  NULL
 	}
 };
@@ -2240,7 +2264,16 @@ static int ft260_i2c_probe(struct ft260_device *dev,
 		if (ret)
 			goto err_i2c_free;
 
-		ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
+		ret = sysfs_create_group(&hdev->dev.kobj,
+					 &ft260_i2c_chip_mode_1_attr_group);
+		if (ret < 0) {
+			hid_err(hdev, "failed to create sysfs attrs\n");
+			goto err_i2c_free;
+		}
+	} else if (cfg->chip_mode == FT260_MODE_ALL ||
+		   cfg->chip_mode == FT260_MODE_BOTH) {
+		ret = sysfs_create_group(&hdev->dev.kobj,
+					 &ft260_i2c_chip_mode_0_3_attr_group);
 		if (ret < 0) {
 			hid_err(hdev, "failed to create sysfs attrs\n");
 			goto err_i2c_free;
@@ -2306,12 +2339,14 @@ static int ft260_uart_probe(struct ft260_device *dev,
 	cfg->uart_mode = FT260_UART_CFG_FLOW_CTRL_NONE;
 
 	if (dev->chip_mode & FT260_MODE_UART ||
-	    dev->chip_mode == FT260_MODE_ALL) {
+	    dev->chip_mode == FT260_MODE_ALL ||
+	    dev->chip_mode == FT260_MODE_BOTH) {
 		ret = ft260_gpio_init(dev, cfg);
 		if (ret)
 			goto err_hid_report;
 
-		ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
+		ret = sysfs_create_group(&hdev->dev.kobj,
+					 &ft260_uart_chip_mode_0_2_3_attr_group);
 		if (ret < 0) {
 			hid_err(hdev, "failed to create sysfs attrs\n");
 			goto err_hid_report;
@@ -2418,12 +2453,19 @@ static void ft260_remove(struct hid_device *hdev)
 		ft260_uart_port_remove(dev);
 		/* dev is still needed, so we will free it in _destroy func */
 		if (dev->chip_mode & FT260_MODE_UART ||
-		    dev->chip_mode == FT260_MODE_ALL)
-			sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
+		    dev->chip_mode == FT260_MODE_ALL ||
+		    dev->chip_mode == FT260_MODE_BOTH)
+			sysfs_remove_group(&hdev->dev.kobj,
+					   &ft260_uart_chip_mode_0_2_3_attr_group);
 
 	} else {
 		if (dev->chip_mode == FT260_MODE_I2C)
-			sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
+			sysfs_remove_group(&hdev->dev.kobj,
+					   &ft260_i2c_chip_mode_1_attr_group);
+		else if (dev->chip_mode == FT260_MODE_ALL ||
+			 dev->chip_mode == FT260_MODE_BOTH)
+			sysfs_remove_group(&hdev->dev.kobj,
+					   &ft260_i2c_chip_mode_0_3_attr_group);
 		i2c_del_adapter(&dev->adap);
 		kfree(dev);
 	}
-- 
2.43.0

