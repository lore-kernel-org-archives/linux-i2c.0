Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399838;
	b=gcO0dGU1Y24S2mREZN7pzppKpQofd004HN0HgSSkUhD0rlz1mIOsiKxsy68/Bm/jFusl
	 /qlSs8KqtlmuAhc04SiNznLx48UBE7+o5xbQzUoHpQW2GhEELo82h7gQ91l13Q/qO8rQ0
	 ts86IySArib13GNrHjx5jX5HQt3yMjRXdIFRFgvOI3MC4mUs6hOYAcLZyWup8OlEIxGNu
	 CuIpqQMkozRR5uIwbk166VkwXg3lchFN1tNXyJt5Zf24EGuJAst6FGQiP2zlrvYRsY86K
	 JtyDLObrZURGYt8DPyudD3oKcLC1rxpB5wlrKbgBXUQoZ1G6wsCex7XShB4ChEoAz2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pNehLARC7qvOa4dOkHR5b0YmY6kYtso4GzuHZMjqnQY=;
	b=eqkS5C7YN+vIni22P+HwAsPAzekw2iOJUUSmq1qvyGRypGpqXKHoMP62PEi4gv2O+d16
	 ookd0faFDpWTQr87WW6zKrV8ut6RUmTUFd/HBX6aI08VzxY+w5dfmqveunnE2GuTARYrL
	 23fL31APDN7jVZnteD3qaJHZ4DB9dDAoCeJ2hU9drsUsoa7tA7HGguwZJ3kfqfzJNpSAB
	 6MF133opKM0GBp8NLCx+ANl1FVEuMPbCBGtSLa/RysBqhTg+sqRYwK3I965Pvuhj5N2i8
	 7r7lI2Ly93E3UWt8rIMrgOYYBfHHehnXDwe194JpoCpSkMOerbwX6XTw1fiEW7zYWEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lj8XtCWp;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7DF60A2620
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 22:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D7DF60A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lj8XtCWp
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b001cd92bso712332f8f.2
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399837; x=1794004637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pNehLARC7qvOa4dOkHR5b0YmY6kYtso4GzuHZMjqnQY=;
        b=Lj8XtCWpgrhdkkc1l0JBl7kexeOB2LGOh6ikC1MoEHtPGNa+QPgwcnBzjEluqZPFFs
         FdMV0s81vmkKar/h4lhnyGuNDfIdzW5XLbl8TjMtQ2rhTp/n8SNfDhbA6GOBxXr7fuhv
         QnNszvB0Xzl6eoQXd+uT7fzvkYnSC95SAxDLzIzfsVkYzvzCnOj6ffL7KgyVwYbCk8tn
         sITMf2BA+k+TKjy538d5NZSqj4PqD8kmAFIlc2zEqOIMzPfYS39PN7Asv/UCQIRfgseG
         E6gME8Cl+dXKqn2+ugabSg7oi1yRj2+E4IeZyH+1F0WeAdhXArd/KGorhYr2XZEfAJTA
         qbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399837; x=1794004637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pNehLARC7qvOa4dOkHR5b0YmY6kYtso4GzuHZMjqnQY=;
        b=rQ3mHYfF+L6UY3tQE4ptIdbpo3/X83Ac7bgPLbwELoz1rCGS+vSlzkS9/h6SMXWUO7
         bl2zsMOzqx+BQiaoIP7fYdgvS3ZrM77Rc6aQdv/DpNvMPFq4uPvViiW9pnwHMaVOZ4h6
         h2IyT7HKUD+2rnCXR205jK1lm/ng751rQfOQSmTN+EPHkZ0++hA6qYpsiFiFJAtdJyHq
         3bZwmDHEuv5xjprItBJkIqLlwSABzlLa8aF8dq+xGoGvjbfZ7KeMXTRmWk//VzZOD8yt
         zgP4buxfKoKMoDk+031VNOexLeAw0KRMzNQuryQ6bZcTTLd/FuXTBGppupkeSe8MVMhg
         Arqg==
X-Forwarded-Encrypted: i=1; AKwUvBzUwLvUNasAYSM5d3g4WEFIgfnfGQ7xYD0L6RvtnGhRHhYiMt7nJvuWm6tR/hnQXp5AXJNWmEAm6dw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLewOrOv33UwxoJZuNF2W9G3ig5B9aYkhocYdNQlZ9yXOvR8aFB
	sesSBRKOv8TyxPD7vPUHrZhIeAe3paQdHAFwkBKX1UeZaF6wsUlTaPQb
X-Gm-Gg: AYBFou1uPZRz9KkigGQXFgj/a9n4Oi8/wBMF9k57sJMsoeOdLZ3j43ub9TurKyAVI4B
	7BXmewbRlWl+CWSNYqKf++ipr2t/sSnSZDaal9KgFFSUAM3i+WBzxWkbVBBEaoaH9FiCmv8/tn3
	ZT89B3W4QmbNp+WoGrlwYcQ4o/hHn8alXvr7KtYMd/ym1bBJsYNGAr3DQ8Ii9/l4to+KTLA4dUh
	uoB0pdK0YjkGCyzMgGbTb8pqzSiMUaBBQ/zeXYmwVyjo0lvqS6FSiDiVnpz86ChFJgOK/kyfKrL
	muzY990R/qC4eFmwB1ULzVR/EkJ+viVvdcndesnu98FoMQLQy2w5lx4fUogeI1otMC9a0cRtliA
	2KDdned29znnETwxOSgkYag4Zyb/AXQ/zhwpmTh8+jr7h8uc03Zd4yCTlG3lSPZaxSMxu3oVRpu
	vPQ3eyk6MJzu5qeLL66Di87uqtRxa4uOe7lzLBWj9sY8z6BC3CdDVH52J1OWZDIt0CfLv15H3SP
	Xs5KHLswLCh3fnbXlwQNaAaULClSwFZJmx9L4xCZRrhXuWyvTJd1e2gaeVbHEn7nOVJ0uCUELml
	JZRAWDG07gsm9JO6D77gW/g89apml4BT45p0OX8uhjHYXppatA==
X-Received: by 2002:a05:6000:4021:b0:48e:4300:c70e with SMTP id ffacd0b85a97d-48e6e304059mr8145616f8f.46.1793399836599;
        Fri, 30 Oct 2026 15:37:16 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:16 -0700 (PDT)
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
Subject: [PATCH v2 09/15] HID: ft260: group sysfs attrs per HID interface
Date: Sat, 31 Oct 2026 00:36:31 +0200
Message-ID: <20261030223637.86907-10-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030223637.86907-1-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
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

Put i2c_enable on the UART group. In modes 0 and 3 ft260_gpio_init()
runs from the UART probe, so that interface registers the gpiochip. A
write to i2c_enable updates dev->gpio_en of the interface that owns
the attribute. On the I2C interface the write would re-mux GPIO0 and
GPIO1 on the chip and leave the gpiochip's mask unchanged, so the two
lines would stay unavailable.

Do not expose i2c_reset on the UART group (reported by Sashiko).

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2: i2c_enable moves to the UART group, which owns the gpiochip; UART
group drops i2c_reset (reported by Sashiko).
---
 drivers/hid/hid-ft260.c | 60 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 4106066b6a89..dca0250f2c25 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1630,7 +1630,7 @@ static ssize_t i2c_reset_store(struct device *kdev,
 }
 static DEVICE_ATTR_WO(i2c_reset);
 
-static const struct attribute_group ft260_attr_group = {
+static const struct attribute_group ft260_i2c_chip_mode_1_attr_group = {
 	.attrs = (struct attribute *[]) {
 		  &dev_attr_chip_mode.attr,
 		  &dev_attr_pwren_status.attr,
@@ -1641,8 +1641,6 @@ static const struct attribute_group ft260_attr_group = {
 		  &dev_attr_gpio2_func.attr,
 		  &dev_attr_gpioa_func.attr,
 		  &dev_attr_gpiog_func.attr,
-		  &dev_attr_uart_mode.attr,
-		  &dev_attr_uart_dcd_ri.attr,
 		  &dev_attr_clock_ctl.attr,
 		  &dev_attr_i2c_reset.attr,
 		  &dev_attr_clock.attr,
@@ -1650,6 +1648,32 @@ static const struct attribute_group ft260_attr_group = {
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
 
@@ -2275,7 +2299,16 @@ static int ft260_i2c_probe(struct ft260_device *dev,
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
@@ -2341,12 +2374,14 @@ static int ft260_uart_probe(struct ft260_device *dev,
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
@@ -2464,11 +2499,18 @@ static void ft260_remove(struct hid_device *hdev)
 					   dev->index);
 		ft260_uart_port_remove(dev);
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

