Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399836;
	b=ERzx1Bv/HMs+1+pFQUuKHryIOOIX54bv2LAv88OyqcSh9KU2/g6bamqqa86WMy22p1Cd
	 wU2UOoC2zNNnlNa2CwwSNSu3I5h1VJIzE6uN1AgRD9b37MSMAC5TvsuiPQ/7oR+8JgjtS
	 g5ZlgrY5rKG8eBHM531HZz8KfRZIT0FMhMSSYZgkgckexgSok+8LE/wQVDVZXpd1ZpV7H
	 PxXKQPyVoOLnBBaSrwq23y6N6rSvhtC4G7eUn8/H3f/jhYQVYDEbJoO9mA3VR8ippMNg6
	 5riCleEnMNrbGd5A6AyKe8cGRIbTmHnK2KkoUX9JSTRPATHHE7G/m2vZy4w+TWN6H9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tZyvsNnXMh56pai5U5Ss1kd8tGraHDrvslv6z3x9w14=;
	b=Z0/XWTsLYIbxmFB16qI8/N/OwrvXzL8u5FTH8FtaEIJNZxGaFM3hR5O0tQpDPNWheEOo
	 C3bDq0tYkxVHHb8fFVskPs/j0c/zj5eovLyIHvvmeX9s4P1HLDLbchcxJVeRfmBn2WMmc
	 PmJGje592qCi0nQ6hQsEVdbANFT3UBV3eGRKHQWP48Ojbw6Q3IRYCUW3N/xxVxxsbGWht
	 lT4yGuicVPcduNuI5qCp75WhmmhbAeUKpluTE5hOWGGf8UVRGa4MvSkinRn3/hPysSJRr
	 w9+crOI9EH2Y8BD3j4I7fKF7J7jbMUeAHF4ysCDxznGfmGYrdi8o35Oz4lf93aMLVHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lXsEmerP;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A660A2619
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 22:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 399A660A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lXsEmerP
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so12763135e9.2
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 15:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399835; x=1794004635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tZyvsNnXMh56pai5U5Ss1kd8tGraHDrvslv6z3x9w14=;
        b=lXsEmerPy41FiZUadHpGhU9/RRwjtTquaIaHnhtDYeUcOZvVZWKp/jBfv1dkqYKa4G
         W6DB2wLtmrbrxq0ocPiK9ZdVMNdgQcxNSH9xjXG5vkgP2Hr7XGCSMO/Rs45yyfvr+OJM
         G6N8WxO8cVxARay1xNjZbMXcnoBeicgNvfMpozJJdRP6ab9AaSDngIy/h6bpW0LM/JqN
         FyqmRiR8m96n8b+ukhxa4hDp2cW81X7TAchROnadfKxNc8U1e5i/X1C7TLwi9zs5msgr
         c8mWwuqXKMKeBFMu+7hjNd4iQYEqmcbfT8MZu51UlMbbadeXoWVG+KQdfV0frKVH8bqh
         hWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399835; x=1794004635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tZyvsNnXMh56pai5U5Ss1kd8tGraHDrvslv6z3x9w14=;
        b=0UDvklBuIJ2TKJNnBx+rq6+dTgZ2R/JkZDF3Si1/5UvX0PZVYw4/Aw0Y67z179yyr8
         q6RQywZ4wrusWjUSBfwxSSZcYr0BcYvfWhNj5DfuJUflMjF5Tb1PcIycFLhsClCJn2hH
         KsFpeBGq7HFQFxsJJRcmxZnFown0AKBFh6ib7IzfWVCdj9IlF+OrK59G3wmwa/E6LZv1
         8Nae8NYjaihPQlggbFio9xETmE32ySTGgbS+9cmsvcumQAK4otVpzAaQijlQLFwrEkWB
         LDazaUubY3B9yiHnLVkZkG9QfEEEM9U5GoDkZE0PP8FEF16zpHcUniPnGos4KoDNJyen
         eC2g==
X-Forwarded-Encrypted: i=1; AKwUvByA9f0sCiGdBqMXi0NnyAVwc61sgFbb8o47KH/AfdubTFLXZ7TmZjuOYiZdhxZ9fU8kxRALQv4Kpr4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmjV3gnECqXmryIm1g5wGYrcNZQAMrM7ZJPs5ttmfhe9CvYCJA
	OJLoMEeAtW1DTg9M64G9neHVzwyjJWTtnZg6kD7jLgNlY0+L6/xdPojV
X-Gm-Gg: AYBFou3jO2Na1HfWz1ZxSB63+1WFmT9s2MMa1Dp0iTiq77tLJPQ57Y0l5IVLZivNNAw
	rU0C9MVp1IGrJp20k7g/KepLSrlCXqKBm1YGIPrivPOAlG93Wi3pvLH4Y0X2k8djJxBD+HvR16f
	VhYgaDxdAl7O6wrhd0P/w0CVCJAuOXwE1rCiAtaIi6+bPfJXIfg0jU5h+R/Qy0JBKrYMa4Y+nR3
	Odz44AabO1qidC8deLxi2Rnzwf1B9BpZtZ70nAgJ5Pt9zrfWAnJRA2uYHS+TOnVYfKsR7N5E2X6
	F5cnaWOeB1lZTia600mqm8CmCa1hBGcUD54bSXW/JmW7zWBeH6/SBcTrn8irRyEo1NKoOxImtEE
	A3n84dbAchg+gYnSEmOJNHDqbfy+IjTeaXHhgaL4rQ+xmEK0YppCETfwMBD6UgJEafwgI/+x+Bm
	Z+R8GAtFJ7oE9dTTklOtVsvEhNfw6r2QLnVn5Qjz3+Dmm2MdApJxPWQutXq3DfWjfTWpVqZFab2
	ZlgBKHU826kX78Qpa/lNiCpX5mA5CFGhAZg6nQZ5Ny61YE9pJDO78GM5FJUv6IpZd+Bc81+pRZi
	9PHqoPTTbML/jG8p7lJ2VgYwmGQlmoki+03MvOmeZ2QkCmSVyQ==
X-Received: by 2002:a05:600c:840e:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4ac17d168b1mr89453445e9.11.1793399834458;
        Fri, 30 Oct 2026 15:37:14 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:14 -0700 (PDT)
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
Subject: [PATCH v2 08/15] HID: ft260: uart: add modem pins control via ioctl
Date: Sat, 31 Oct 2026 00:36:30 +0200
Message-ID: <20261030223637.86907-9-michael.zaidman@gmail.com>
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

Add TIOCMGET/TIOCMSET (and thus TIOCMBIS/TIOCMBIC) support so userspace
can drive DTR/RTS when the modem pins are in GPIO mode. This enables
programming an ESP32 over the FT260 with esptool, which resets the chip
via those lines.

Also key GPIO sysfs registration off chip_mode rather than USB interface
number 0, and include DCD/RI in UART mode 3/4 GPIO sets so the modem
mask matches the pins esptool needs.

The RTS, CTS, DTR and DSR pins are active-low, so TIOCMGET inverts the
sense of those four lines and TIOCMSET drives 0 to assert them. DCD and
RI are not inverted. Rio Liu found and fixed the polarity.

Keep the errno from ft260_get_interface_type() so a failed status read
does not probe-succeed after teardown. Return -EINVAL when the modem
pins are not in GPIO mode, propagate gpio_get_all() errors from
TIOCMGET, and copy the GPIO shadow under the port lock for TIOCMSET
(reported by Sashiko).

Co-developed-by: Rio Liu <rio@r26.me>
Signed-off-by: Rio Liu <rio@r26.me>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2: polarity fix folded in (Rio Liu); preserve get_interface_type
errno; tiocmget/tiocmset error paths and locked shadow copy (reported
by Sashiko).
---
 drivers/hid/hid-ft260.c | 150 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 131 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 4b0b55c98f90..4106066b6a89 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -16,6 +16,7 @@
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/kfifo.h>
+#include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/math.h>
 #include <linux/minmax.h>
@@ -183,7 +184,7 @@ enum {
 	FT260_GPIO_DIR_OUTPUT		= 0x01,
 };
 
-/* GPIO offsets */
+/* GPIO bit masks */
 #define FT260_GPIO_0		BIT(0)
 #define FT260_GPIO_1		BIT(1)
 #define FT260_GPIO_2		BIT(2)
@@ -213,7 +214,8 @@ enum {
 #define FT260_GPIO_UART_MODE_1_SET	FT260_GPIO_UART_DTR_DSR
 #define FT260_GPIO_UART_MODE_2_SET	FT260_GPIO_UART_RTS_CTS
 #define FT260_GPIO_UART_MODE_3_SET	(FT260_GPIO_UART_RTS_CTS | \
-					 FT260_GPIO_UART_DTR_DSR)
+					 FT260_GPIO_UART_DTR_DSR | \
+					 FT260_GPIO_UART_DCD_RI)
 #define FT260_GPIO_UART_MODE_4_SET	FT260_GPIO_UART_MODE_3_SET
 #define FT260_GPIO_UART_DEFAULT		FT260_GPIO_UART_MODE_0_SET
 #define FT260_GPIO_UART_MODE_1_CLR	(FT260_GPIO_UART_RX_TX | \
@@ -223,6 +225,16 @@ enum {
 #define FT260_GPIO_UART_MODE_3_CLR	FT260_GPIO_UART_RX_TX
 #define FT260_GPIO_UART_MODES		5
 
+/* UART modem control GPIO offsets */
+enum {
+	FT260_GPIO_UART_DCD		= (4),
+	FT260_GPIO_UART_RI		= (5),
+	FT260_GPIO_UART_RTS		= (7),
+	FT260_GPIO_UART_CTS		= (10),
+	FT260_GPIO_UART_DTR		= (11),
+	FT260_GPIO_UART_DSR		= (13),
+};
+
 #define FT260_SET_REQUEST_VALUE(report_id) ((FT260_FEATURE << 8) | (report_id))
 
 /* Feature In reports */
@@ -449,6 +461,7 @@ MODULE_DEVICE_TABLE(hid, ft260_devices);
 struct ft260_device {
 	struct i2c_adapter adap;
 	struct hid_device *hdev;
+	int chip_mode;
 	int iface_type;
 	int iface_id;
 	struct list_head device_list;
@@ -1106,7 +1119,27 @@ static void ft260_gpio_en_update(struct hid_device *hdev, u8 req, u8 value)
 	else
 		ft260_gpio_en_clr(dev, bitmap);
 exit:
-	hid_info(hdev, "enabled GPIOs: %04x\n", dev->gpio_en);
+	hid_info(hdev, "enabled GPIOs: %04x, bitmap %04x\n",
+		 dev->gpio_en, bitmap);
+}
+
+static void ft260_gpio_output_cfg(struct ft260_gpio_state *gpio,
+				  u32 offset, int value)
+{
+	if (offset < FT260_GPIO_0_5_COUNT) {
+		gpio->dirs |= BIT(offset);
+		if (value)
+			gpio->vals |= !!value << offset;
+		else
+			gpio->vals &= ~BIT(offset);
+	} else {
+		offset = offset - FT260_GPIO_0_5_COUNT;
+		gpio->ex_dirs |= BIT(offset);
+		if (value)
+			gpio->ex_vals |= !!value << offset;
+		else
+			gpio->ex_vals &= ~BIT(offset);
+	}
 }
 
 static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
@@ -1155,7 +1188,7 @@ static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
 			rep.gpio.ex_vals &= ~BIT(offset);
 	}
 
-	ft260_dbg("dirs %#02x vals %#02x ex_dir %#02x ex_vals %#02x\n",
+	ft260_dbg("dirs %#02x vals %#02x ex_dirs %#02x ex_vals %#02x\n",
 		  rep.gpio.dirs, rep.gpio.vals,
 		  rep.gpio.ex_dirs, rep.gpio.ex_vals);
 
@@ -1307,8 +1340,6 @@ static int ft260_gpio_init(struct ft260_device *dev,
 	char prefix[] = "ft260_";
 	u8 mode = cfg->chip_mode;
 
-	hid_info(hdev, "initialize gpio chip\n");
-
 	dev->gpio_uart_mode[0] = (u16)FT260_GPIO_UART_MODE_0_SET;
 	dev->gpio_uart_mode[1] = (u16)FT260_GPIO_UART_MODE_1_SET;
 	dev->gpio_uart_mode[2] = (u16)FT260_GPIO_UART_MODE_2_SET;
@@ -1352,7 +1383,6 @@ static int ft260_gpio_init(struct ft260_device *dev,
 		goto exit;
 	}
 	snprintf(label, label_sz, "%s%s", prefix, dev_name(&hdev->dev));
-	hid_info(hdev, "initialize gpio chip on %s\n", label);
 
 	dev->gc->label			= label;
 	dev->gc->direction_input	= ft260_gpio_direction_input;
@@ -1423,6 +1453,7 @@ static int ft260_get_interface_type(struct ft260_device *dev,
 	ft260_dbg("wakeup_int: 0x%02x\n", cfg->enable_wakeup_int);
 
 	dev->power_saving_en = cfg->power_saving_en;
+	dev->chip_mode = cfg->chip_mode;
 
 	switch (cfg->chip_mode) {
 	case FT260_MODE_ALL:
@@ -1440,7 +1471,6 @@ static int ft260_get_interface_type(struct ft260_device *dev,
 		break;
 	}
 
-	dev->iface_type = ret;
 	return ret;
 }
 
@@ -1941,6 +1971,80 @@ static void ft260_uart_set_termios(struct tty_struct *tty,
 	ft260_uart_change_speed(port, &tty->termios, NULL);
 }
 
+static int ft260_uart_tiocmget(struct tty_struct *tty)
+{
+	struct ft260_device *port = tty->driver_data;
+	int gpios;
+
+	/*
+	 * The modem lines control via ioctl is allowed only
+	 * when the related pins are in the gpio mode.
+	 */
+	int mask = FT260_GPIO_UART_MODE_4_SET;
+
+	if ((port->gpio_en & mask) != mask) {
+		ft260_dbg("Illegal gpio config %#02x != mask %#04x\n",
+			  port->gpio_en, mask);
+		return -EINVAL;
+	}
+
+	gpios = ft260_gpio_get_all(port->gc, FT260_GPIO_VALUE);
+	if (gpios < 0)
+		return gpios;
+
+	return ((!(gpios & FT260_GPIO_B) ? TIOCM_RTS : 0) |
+		(!(gpios & FT260_GPIO_E) ? TIOCM_CTS : 0) |
+		(!(gpios & FT260_GPIO_F) ? TIOCM_DTR : 0) |
+		(!(gpios & FT260_GPIO_H) ? TIOCM_DSR : 0) |
+		((gpios & FT260_GPIO_4) ? TIOCM_CAR : 0) |
+		((gpios & FT260_GPIO_5) ? TIOCM_RNG : 0));
+}
+
+static int ft260_uart_tiocmset(struct tty_struct *tty,
+			       unsigned int set, unsigned int clear)
+{
+	int ret;
+	struct ft260_device *port = tty->driver_data;
+	struct ft260_gpio_write_request_report rep;
+	struct hid_device *hdev = port->hdev;
+	int mask = FT260_GPIO_UART_MODE_4_SET;
+
+	if ((port->gpio_en & mask) != mask) {
+		ft260_dbg("Illegal gpio config %#02x != mask %#04x\n",
+			  port->gpio_en, mask);
+		return -EINVAL;
+	}
+	rep.report = FT260_GPIO;
+
+	mutex_lock(&port->lock);
+	rep.gpio = port->gpio;
+
+	if (set & TIOCM_RTS)
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 0);
+	if (set & TIOCM_DTR)
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 0);
+	if (clear & TIOCM_RTS)
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 1);
+	if (clear & TIOCM_DTR)
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 1);
+
+	ft260_dbg("dirs %#02x vals %#02x ex_dirs %#02x ex_vals %#02x\n",
+		  rep.gpio.dirs, rep.gpio.vals,
+		  rep.gpio.ex_dirs, rep.gpio.ex_vals);
+
+	ret = ft260_hid_feature_report_set(hdev, (u8 *)&rep, sizeof(rep));
+	if (unlikely(ret < 0)) {
+		hid_err(hdev, "%s: cannot set GPIO: %d\n", __func__, ret);
+		mutex_unlock(&port->lock);
+		return -EIO;
+	}
+
+	port->gpio = rep.gpio;
+	mutex_unlock(&port->lock);
+
+	return 0;
+}
+
 static int ft260_uart_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	int idx = tty->index;
@@ -2021,6 +2125,8 @@ static const struct tty_operations ft260_uart_ops = {
 	.write_room		= ft260_uart_write_room,
 	.chars_in_buffer	= ft260_uart_chars_in_buffer,
 	.set_termios		= ft260_uart_set_termios,
+	.tiocmget		= ft260_uart_tiocmget,
+	.tiocmset		= ft260_uart_tiocmset,
 	.hangup			= ft260_uart_hangup,
 	.install		= ft260_uart_install,
 	.cleanup		= ft260_uart_cleanup,
@@ -2164,14 +2270,16 @@ static int ft260_i2c_probe(struct ft260_device *dev,
 		return ret;
 	}
 
-	ret = ft260_gpio_init(dev, cfg);
-	if (ret)
-		goto err_i2c_free;
+	if (cfg->chip_mode == FT260_MODE_I2C) {
+		ret = ft260_gpio_init(dev, cfg);
+		if (ret)
+			goto err_i2c_free;
 
-	ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
-	if (ret < 0) {
-		hid_err(hdev, "failed to create sysfs attrs\n");
-		goto err_i2c_free;
+		ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
+		if (ret < 0) {
+			hid_err(hdev, "failed to create sysfs attrs\n");
+			goto err_i2c_free;
+		}
 	}
 
 	return 0;
@@ -2232,7 +2340,8 @@ static int ft260_uart_probe(struct ft260_device *dev,
 
 	cfg->uart_mode = FT260_UART_CFG_FLOW_CTRL_NONE;
 
-	if (dev->iface_id == 0) {
+	if (dev->chip_mode & FT260_MODE_UART ||
+	    dev->chip_mode == FT260_MODE_ALL) {
 		ret = ft260_gpio_init(dev, cfg);
 		if (ret)
 			goto err_hid_report;
@@ -2311,8 +2420,9 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = ft260_get_interface_type(dev, &cfg);
 	if (ret <= FT260_IFACE_NONE)
 		goto err_hid_close;
+	dev->iface_type = ret;
 
-	if (ret == FT260_IFACE_I2C) {
+	if (dev->iface_type == FT260_IFACE_I2C) {
 		ret = ft260_i2c_probe(dev, &cfg);
 		if (ret)
 			goto err_hid_close;
@@ -2353,10 +2463,12 @@ static void ft260_remove(struct hid_device *hdev)
 		tty_port_unregister_device(&dev->port, ft260_tty_driver,
 					   dev->index);
 		ft260_uart_port_remove(dev);
-		if (dev->iface_id == 0)
+		if (dev->chip_mode & FT260_MODE_UART ||
+		    dev->chip_mode == FT260_MODE_ALL)
 			sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
 	} else {
-		sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
+		if (dev->chip_mode == FT260_MODE_I2C)
+			sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
 		i2c_del_adapter(&dev->adap);
 	}
 
-- 
2.43.0

