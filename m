Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697727;
	b=CFKpuTIrXStKldZdU6ZnMaewWfCcyD0sbMuLRWXKPKDUfMHe+k6q9XMu+rpdr09FxUKY
	 c2GNN7VH6Umyd1o8ZvCyia07nDUynIOFdciuaw6r9f6MG3hsxTePJNtMPHjDppkqkftPp
	 P80g9adz1IaR+0eqoEXpQ1P0h7w3AaG5r9fKC/cFbn2ilKCT9Zs5a0kodMxJbn14Ry1AU
	 oYDOpBV4gaCS5nsdY7XLG+hp6DWAYvJfRurBqtno5wFO9WGHma+NjtALgsP3ZJSeEa6Ft
	 C9DsMF6XOZy7IG/Q70FvNJH9fs/4b5+eoWl/X7WaHRqsuiXzPn0ADonwFZAvbS9nUPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Fi6R394tpyULzxVmbC3Vx9uenJnEBMSaSgcdI1bRBcQ=;
	b=m/QcNeUjO8sZet/YdYQHl5fybTiM5Wdv/dzW0J13Otqv46bJcgQckU8mUeykI67VO2u4
	 n7NZvGChX2P+qzcGVGaYqnBOtBqFnUttsKsLPUn9sreMzu1BdN9kzRwQiDGEXEY6kcrec
	 y9Y8EtYZpCz92sqg5NJQO5GX4Rs/Fqg/lGdrYhbUPqqwSjHK0EK7NbOu9ju3GNIto9fCD
	 bHfS23zyBlki0NPGRPz/6Omy4OzDU2BQqH/hOYomFXTO6ljtB6VksObB5fSLp1HEYe8d2
	 PDcDHzy6e3v8xAxLQHpKmL3h5LjAoszkd7x42Uns9bkVIDT8jCky3hWe/4/YbxKBRGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tYrbH102;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A848B606A8A9
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 23:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A848B606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tYrbH102
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4919a880834so1046062f8f.0
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 15:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697725; x=1795302525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fi6R394tpyULzxVmbC3Vx9uenJnEBMSaSgcdI1bRBcQ=;
        b=tYrbH1021A6e30gu05YxLCaxzs6ToQ/kzYtqbPcT9faITS/XXPPXPpM8RknxHrTyGp
         TSubDOwdHrMXpg8mJ6yw7t5ClHY1G4P/mBAO8iztKfxIfp5m9xKhKap4aMgZOYVSGxWm
         xHNYPDQ1aew49UzyRchGogeFItt1iE0PSXFz4KwXsD9sQ+8SCo6P4Fhsb8sHJvt7eayR
         q3yX9ckzyQk81vCS+BOT5aVHZlENGNEeHV7ByBQ5H4MqBa7wpn/1q8mfa6QkRQwy50VU
         3+21jK5Ic8ZISZ7AM2MFYmczLCJJDOrjqg05u0SWlYVLUl6Jfh6vLWC5AmAzbvf89bVA
         EFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697725; x=1795302525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fi6R394tpyULzxVmbC3Vx9uenJnEBMSaSgcdI1bRBcQ=;
        b=FAPgvbR//sUVP1ViFpWYXfRGnuTtcPEJ7WFi88Rxu8BaHMdWZOQSso9dSgfAAjFABI
         eHiCTj8AgyclcC6WkKJ9UTX1cufC6b5c/2ljw9ZiueAa9pcaf5DT+z9xPDXOa0rGwP0e
         bkjsV0OrhwGg+R3FtCgulC1uEUm2rH5eJWsCjKQqS5gtPxq3+R4+aKqu7pxPB8VY2vhW
         FqOS7/r7A3ehoDWfjRp0muQNTS95jdaXvLY9Et/AJfVn2ZqAxd9zZOhQDMflsIq7EKFa
         EvDSn0Yjs54YL4JIUCoWCf1dI5ns3Qfag4qTSvm81pfniwVJ9sMsAB5Qy6eNTwhIHToP
         jOSA==
X-Forwarded-Encrypted: i=1; AL+hErH/q6yx9lvf/1XdP201olQmfRg6STcnWka0vSoT/K36WlggU1ZbryFDoSb678NV0F2s1EMcA1j93Rk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XpHe/1leE1NipG8USqDIv5xPymokPnQvgt2A4vJd71Ricwutj
	tqgFlmPH7KM1aqa+twzCnmsXKY1jW6UYh3NkdR4d0t4Tev/uBMtyo40V
X-Gm-Gg: AYBFou2KNiKETGKPLyGE4tRBkRS1dJWA9xfysQ3v80z2gZ3QfXrPJw+XX/lPxjW0sfT
	J/t4iJr9sUh1LjBC8iBXtowPBVncz9ZbeYFYbcQEPWJgH9yNh+nMBUHuY4V4sdGpOoK6Cpn2v8+
	Q+9Pd5a6PCHmOqzq1XXScI6/8PcvjuoycNZFbSDQdP33X4GDSaoazM7sJeSDyrR05uQrLaHQvnU
	1au8WOyXZYwVQRKrSBmjdoq6v4qm56TsI8EdWIbBZ5GnJbkBOhRxTaaaKovaJr0L98VSEl27T7M
	pH0XlhPeG+xP8frRQEHJa/FluALNcdbWA8MQP/KVqbczf6vVc0XKxsCytrmsw71FVjwZtlUc6Nh
	0tYFCwCP4uIWJLsGOYPT2F7Gf+bkzCLuxEQB+fAWYcEPhHscI47ocuLOcXoNbqgaT3lCiiBLriE
	lK47/EUlZizmS3B98/gNkwJHmQQJ24acKng417teiPOneEOw3XHg9yg4BdKJxvefB9Nj6Nvjnk3
	pm9CQ9i/woFuTVtkFIp5DLyajFRBCVT2BDQcr2jWf9olzEF2LhiNp5Ab18WJKThFsDVmCKWCZ6s
	x4XyJU551slownZ1rUXeXtRRVUt3o/WTvLousgWKDa3AO6B3I+0=
X-Received: by 2002:a05:600c:1553:b0:4bb:5e6b:49e with SMTP id 5b1f17b1804b1-4bb5e6b0656mr94794265e9.6.1794697725036;
        Sat, 14 Nov 2026 15:08:45 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:44 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH v3 09/16] HID: ft260: group sysfs attrs per HID interface
Date: Sun, 15 Nov 2026 01:07:53 +0200
Message-ID: <20261114230800.1344401-10-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114230800.1344401-1-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split the single sysfs attribute group into per-interface groups based
on chip mode (DCNF0/DCNF1):

- I2C-only (mode 1): I2C and GPIO attributes on the I2C HID interface
- Dual mode (0/3): hid_over_i2c_en, i2c_reset and clock on the I2C
  interface; GPIO and UART attrs on the UART interface
- UART-only (mode 2): GPIO and UART attrs on the UART interface

i2c_enable is GPIO-related too: it switches GPIO0 and GPIO1 between I2C
and GPIO, and its store updates gpio_en of its own interface. So it is
on the interface with the gpiochip, the UART interface in modes 0 and 3.

i2c_reset is an I2C attribute, so it is only on the I2C interface and
not in the UART group, which holds the GPIO and UART attributes.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2:
Fixes for the issues reported by Sashiko:
- The i2c_enable attribute was missing in modes 0 and 3; it is now in
  the UART group, with the gpiochip.
- The i2c_reset attribute, an I2C attribute, is no longer in the UART
  group.

v3:
The err_register_tty path, which patch 3 adds to ft260_uart_probe(),
removes the UART attribute group of this patch.
---
 drivers/hid/hid-ft260.c | 63 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index d795355fc26b..b68cb0748a23 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1633,7 +1633,7 @@ static ssize_t i2c_reset_store(struct device *kdev,
 }
 static DEVICE_ATTR_WO(i2c_reset);
 
-static const struct attribute_group ft260_attr_group = {
+static const struct attribute_group ft260_i2c_chip_mode_1_attr_group = {
 	.attrs = (struct attribute *[]) {
 		  &dev_attr_chip_mode.attr,
 		  &dev_attr_pwren_status.attr,
@@ -1644,8 +1644,6 @@ static const struct attribute_group ft260_attr_group = {
 		  &dev_attr_gpio2_func.attr,
 		  &dev_attr_gpioa_func.attr,
 		  &dev_attr_gpiog_func.attr,
-		  &dev_attr_uart_mode.attr,
-		  &dev_attr_uart_dcd_ri.attr,
 		  &dev_attr_clock_ctl.attr,
 		  &dev_attr_i2c_reset.attr,
 		  &dev_attr_clock.attr,
@@ -1653,6 +1651,32 @@ static const struct attribute_group ft260_attr_group = {
 	}
 };
 
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
+		  &dev_attr_i2c_enable.attr,
+		  &dev_attr_gpio2_func.attr,
+		  &dev_attr_gpioa_func.attr,
+		  &dev_attr_gpiog_func.attr,
+		  &dev_attr_uart_mode.attr,
+		  &dev_attr_uart_dcd_ri.attr,
+		  &dev_attr_clock_ctl.attr,
+		  NULL
+	}
+};
+
 static DEFINE_MUTEX(ft260_uart_list_lock);
 static LIST_HEAD(ft260_uart_device_list);
 
@@ -2297,11 +2321,20 @@ static int ft260_i2c_probe(struct ft260_device *dev,
 		if (ret)
 			goto err_i2c_free;
 
-		ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
+		ret = sysfs_create_group(&hdev->dev.kobj,
+					 &ft260_i2c_chip_mode_1_attr_group);
 		if (ret < 0) {
 			hid_err(hdev, "failed to create sysfs attrs\n");
 			goto err_gpio_remove;
 		}
+	} else if (cfg->chip_mode == FT260_MODE_ALL ||
+		   cfg->chip_mode == FT260_MODE_BOTH) {
+		ret = sysfs_create_group(&hdev->dev.kobj,
+					 &ft260_i2c_chip_mode_0_3_attr_group);
+		if (ret < 0) {
+			hid_err(hdev, "failed to create sysfs attrs\n");
+			goto err_i2c_free;
+		}
 	}
 
 	return 0;
@@ -2355,12 +2388,14 @@ static int ft260_uart_probe(struct ft260_device *dev,
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
 			goto err_gpio_remove;
@@ -2383,7 +2418,8 @@ static int ft260_uart_probe(struct ft260_device *dev,
 
 err_register_tty:
 	if (dev->gc.parent)
-		sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
+		sysfs_remove_group(&hdev->dev.kobj,
+				   &ft260_uart_chip_mode_0_2_3_attr_group);
 err_gpio_remove:
 	if (dev->gc.parent)
 		gpiochip_remove(&dev->gc);
@@ -2499,11 +2535,18 @@ static void ft260_remove(struct hid_device *hdev)
 		dev->removed = true;
 		mutex_unlock(&dev->lock);
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
 	}
 
-- 
2.43.0

