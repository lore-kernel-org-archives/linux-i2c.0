Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945922;
	b=0nsca5OW5b0aqE7PgO9Kg5UPPXnU9DXI/2k6qFk/vYpX6ZcNIzWOqKRh8BH6TovSASPA
	 nwhPYh+nS1OHM5Aiz+ME+Ggdlwd3EdD8RRL7UyPWWWs5q1ZH1jpTHRSxehO0aoTvMdzEa
	 W2A+XU/aeG3+A7WXRH0Mk/cWr1gkejpKqjKKu1Lvt/Ag5/Vn4gimayDKm9LA/lH6/T9u6
	 dTjCr4nJE7McuBlXC6BROsMIiURmy86BlRxRwP3wsgb24cltpzfvKpAXOYrJWwlbpNtw1
	 kTkfnb/50lpjobXHN3YLlXMNSq/SzGH2u6hID9QxyYWGE3cW5wo8lHGxdu+9uE7B1iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qot0PA90LNfDXcWgZyzfZ0KJXr+nIX8yb41eQHOxGnE=;
	b=nP+U3pAtq6byxyUZ0cYeE889zyqvfZeQJSryVGwphkPb3d7fnqqSaJbYsSZt95kCAgtB
	 /hcL7nUhJu2GJ3yNw0q6XIojrL7EjjRvgVYIpXBy5yAfXxtHPyL0bJ5ZkY/wATOasb+t8
	 fppBUxdPIhR4BLqF2pGCo+p63st/tr36DN6HSkQOrINMCsbt6ckj6UmywjtDxARTa8oZV
	 CJJawXyEIEQo0EVwT3iwOwlNJpHWsvTYWrTHe4rSR+qdg9qoRnStdk0ghwfpOVQs4lHGd
	 BeJsu5I53zDPBPyQF8yTkcIM+88TGEM4WiV6xojMdAwTuwyT2RqYJf4gxoxf2XEdF+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lfyZagak;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C726C606BDFF
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 20:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C726C606BDFF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lfyZagak
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e10a70540so77527f8f.1
        for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 12:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945920; x=1795550720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qot0PA90LNfDXcWgZyzfZ0KJXr+nIX8yb41eQHOxGnE=;
        b=lfyZagak0lvz3NFqdXQ8yhiXd2tpNXM+Qbw2Nj77DFYAQStT1qz/6g3DV/mQhHErA+
         bMLrdcZgZSlOUzJVPMVbvxkX9GbLnAAgXN9zwJbi5u+jgFxCqFZxo6v6yB2MH9B7BCGE
         iMiPMbkJH78VQmLuxW4iQXvpv7L7RLKBL39rmKMFLVFsrC8hKKrPsY1rhQ4JKfP65+WT
         ayYN0ywAAAbWyr4kC3ga5cjwsA+MCF37Z+KvmTCPUG75bofKj21OaVtpFXbdEACdorpk
         5pvakOznDCZGz+TshHago7aTeEkp+J0qB/rICOJsx/Ny5uVYSvLb8jzscSnxm7KPJuVr
         eyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945920; x=1795550720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qot0PA90LNfDXcWgZyzfZ0KJXr+nIX8yb41eQHOxGnE=;
        b=jkNBkhL/vmX0UalsAxEZKrYnAstwjgu35m1fkqljVnamRjORmuJ2AsrZ33VNSi4g4Y
         Rju9b2eEPgDhavYPXK6AbY4i5jzDkleD2zgk9VcZgEdlPonwqByOE5OYxugWFJdoHemk
         pSZ4AktokTN+lPui5Tbhp2HtjEkm0OM3q/fBRrDF4ZUylcTIXNhYF9yNLfxE5HR91Rfv
         6LITZ3/f0pG+Zd1GNni6OB1VPp79yM77ktLadWwdfnA88h67Fj1HwT2u+jz6EN+NDEvi
         W/oI1p9OWnp2apwK7U+pRHNYSEtVIBtfniozq6T5HvqfjPXG/ZlOw2q/fc+LaSOCQ+bu
         +ZQg==
X-Forwarded-Encrypted: i=1; AL+hErEwg351VrgDQht6IhpSC+1Ym/dXtFLbp/gEtcrUe5ohBb36hZTHCkZewijOyc9Xiza2MJLUIPMLG9Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/Gge9xQDmcmdWYtVHyGm6oSZVC5nRYOy0T3wMaiUg1KOAnV94
	eUsjyCRPtogKmZzvustOovsudq4EJyfb6BaSc4RxuDKoU/QUHnIjbuPC
X-Gm-Gg: AZFdTZc0zG1xoD5qngWuMIFZjD1uwVmoQz8ITZc2+27oN78s5H/lC5Jn8IlSkP/Vl2S
	7R+jNlBkJ+QCVNQLt68IHWaBftctl6/zsiw3WHkkk5V+dEx3c7TO7yg/ZYsB/uZxC8Vi+lVIW94
	oUZ9w3KxZrGZlKQ/ZLmbp0ZRhcOjiGhrV63K79PZwW7+XoXoUhciOK1WiBpij6vfewirr1Fy+hi
	EQj09Gp8V3xC4wxxBj63OY3hFzOBAt9YaG3oVe0DRAjE/YATj7p0PwbCNGEH0py2KqTrtEeM4X/
	0tKkoyU+Ox9kz36de6jx10hGTcU/Sn04kOz70klH627LADduZL+SIdTl91kGzrcnXqBG3+0Yt6p
	OOcjLfri9Qf85z3iFMyAfEPIMDzpRKgRiuqtcuV42YsTX4JFiskRUd3DhNz7J3tVQ8ydI60XqAK
	yFUDyY3Bjt1ao21D0PpEy+C2i076o1tSpKyhAkxEpH6Xl7sPkiQobpkFexLlY24fR5K5hvxHj+E
	Fpe8J0oQvlJgoCuNAjsn64AfEJw7S7eBffQf/rR5GuhiJHidtFv7vQ4r8gBbqqn4tlWCsATW8Fb
	3676B3yVxlsTzDd0U3iTxPCNCrdf
X-Received: by 2002:a05:6000:46ce:b0:490:9fe2:6a2d with SMTP id ffacd0b85a97d-4a63a5b55c8mr653841f8f.26.1794945919501;
        Tue, 17 Nov 2026 12:05:19 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:18 -0800 (PST)
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
	Michael Zaidman <michael.zaidman@gmail.com>,
	Maarten Brock <Maarten.Brock@sttls.nl>
Subject: [PATCH v4 08/16] HID: ft260: uart: add modem pins control via ioctl
Date: Tue, 17 Nov 2026 22:04:14 +0200
Message-ID: <20261117200423.19561-9-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117200423.19561-1-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
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

Set up the gpiochip and the sysfs attributes on the UART interface when
the chip mode has UART, and on the I2C interface only in the I2C-only
mode. Before, the choice depended on USB interface number 0, which is
the I2C interface in mode 3, but TIOCMGET and TIOCMSET run on the UART
interface and need the GPIO state there. Add DCD and RI (GPIO4 and
GPIO5) to the GPIO set of UART modes 3 and 4, so that TIOCMGET can read
the two lines from their pins.

The RTS, CTS, DTR and DSR pins are active-low, so TIOCMGET inverts the
sense of those four lines and TIOCMSET drives 0 to assert them. DCD and
RI are not inverted. Rio Liu found and fixed the polarity.

Keep the errno from ft260_get_interface_type(), so that a failed
status read does not let probe succeed after the teardown.

TIOCMGET reads a line from its pin while the pin is a GPIO. A pin in
UART function reads 0 in the GPIO report, and no other report gives
the level of RTS, CTS, DTR or DSR. TIOCMGET then reports CTS, DSR and
DCD active and RI not active, as the get_mctrl() comment in
serial_core.h asks. It reports RTS or DTR under flow control active,
because the chip holds the line active while it can take data.

TIOCMSET ignores RTS while RTS/CTS flow control owns the pin, and DTR
while DTR/DSR flow control owns it, and sets the other line. The
TIOCMSET ioctl always passes both RTS and DTR, so an error for the
owned line would make every TIOCMSET fail under flow control.

Both handlers check gpio_en under port->lock, so that a termios or
sysfs change cannot switch the pins between the check and the GPIO
report. TIOCMGET returns the error of the GPIO read. TIOCMSET builds
its report from the cached GPIO state, which it copies under the same
lock.

The tty hangup does not wait for a TIOCMGET or TIOCMSET that already
runs, because the tty core handles them without a line discipline
reference. ft260_uart_port_remove() sets port->removed under
port->lock before the hangup, so it waits for such a call. Both
handlers check the flag, so a later call returns -ENODEV instead of
using hdev after hid_hw_stop().

Co-developed-by: Rio Liu <rio@r26.me>
Signed-off-by: Rio Liu <rio@r26.me>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2:
Polarity fix folded in (Rio Liu).

Fixes for the issues reported by Sashiko:
- The errno of ft260_get_interface_type() is kept, so probe does not
  succeed after the teardown.
- TIOCMGET and TIOCMSET return -EINVAL when the modem pins are not
  GPIOs, and TIOCMGET returns the error of the GPIO read.
- TIOCMSET copies the cached GPIO state under port->lock.

v3:
Fixes for the issues reported by Sashiko:
- gpio_en checked under port->lock in tiocmget() and tiocmset(), so a
  termios or sysfs change cannot switch the pins between the check and
  the GPIO report.
- tiocmget() and tiocmset() return -ENODEV after ft260_remove(), so
  they do not use hdev after hid_hw_stop().
- tiocmget() cannot run before dev->gc is set, because
  ft260_uart_probe() registers the TTY last since patch 2.

v4:
TIOCMGET does not fail while modem pins are in UART function. It
reports such a line as serial_core.h asks, and RTS or DTR under flow
control as active (Maarten Brock).

TIOCMSET ignores the line that flow control owns and sets the other
one, in place of -EINVAL.

The removed flag is now added and set by patch 2, in
ft260_uart_port_remove() before the hangup. This patch only checks it.
---
 drivers/hid/hid-ft260.c | 178 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 161 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 21789e97fd18..eeaf8179adcc 100644
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
@@ -1113,8 +1126,27 @@ static void ft260_gpio_en_update(struct hid_device *hdev, u8 req, u8 value)
 	else
 		ft260_gpio_en_clr(dev, bitmap);
 exit:
-	ft260_dbg("%s: enabled GPIOs: %04x\n", dev_name(&hdev->dev),
-		  dev->gpio_en);
+	ft260_dbg("%s: enabled GPIOs: %04x, bitmap %04x\n",
+		  dev_name(&hdev->dev), dev->gpio_en, bitmap);
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
@@ -1163,7 +1195,7 @@ static int ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
 			rep.gpio.ex_vals &= ~BIT(offset);
 	}
 
-	ft260_dbg("dirs %#02x vals %#02x ex_dir %#02x ex_vals %#02x\n",
+	ft260_dbg("dirs %#02x vals %#02x ex_dirs %#02x ex_vals %#02x\n",
 		  rep.gpio.dirs, rep.gpio.vals,
 		  rep.gpio.ex_dirs, rep.gpio.ex_vals);
 
@@ -1421,6 +1453,7 @@ static int ft260_get_interface_type(struct ft260_device *dev,
 	ft260_dbg("wakeup_int: 0x%02x\n", cfg->enable_wakeup_int);
 
 	dev->power_saving_en = cfg->power_saving_en;
+	dev->chip_mode = cfg->chip_mode;
 
 	switch (cfg->chip_mode) {
 	case FT260_MODE_ALL:
@@ -1441,7 +1474,6 @@ static int ft260_get_interface_type(struct ft260_device *dev,
 		return -ENODEV;
 	}
 
-	dev->iface_type = ret;
 	return ret;
 }
 
@@ -1986,6 +2018,110 @@ static void ft260_uart_set_termios(struct tty_struct *tty,
 	ft260_uart_change_speed(port, &tty->termios, NULL);
 }
 
+static bool ft260_uart_pins_are_gpio(u16 gpio_en, u16 pins)
+{
+	return (gpio_en & pins) == pins;
+}
+
+static int ft260_uart_tiocmget(struct tty_struct *tty)
+{
+	struct ft260_device *port = tty->driver_data;
+	int gpios, ret = 0;
+	u16 gpio_en;
+
+	mutex_lock(&port->lock);
+	if (port->removed) {
+		mutex_unlock(&port->lock);
+		return -ENODEV;
+	}
+	gpio_en = port->gpio_en;
+	gpios = ft260_gpio_get_all(&port->gc, FT260_GPIO_VALUE);
+	mutex_unlock(&port->lock);
+	if (gpios < 0)
+		return gpios;
+
+	/*
+	 * The GPIO report reads 0 for a pin in UART function. No other
+	 * report gives the level of RTS, CTS, DTR or DSR. Flow control
+	 * holds RTS or DTR active while the chip can take data. A line
+	 * that is not read is reported active, except RI.
+	 */
+	if (ft260_uart_pins_are_gpio(gpio_en, FT260_GPIO_UART_RTS_CTS))
+		ret |= (!(gpios & FT260_GPIO_B) ? TIOCM_RTS : 0) |
+		       (!(gpios & FT260_GPIO_E) ? TIOCM_CTS : 0);
+	else
+		ret |= TIOCM_RTS | TIOCM_CTS;
+
+	if (ft260_uart_pins_are_gpio(gpio_en, FT260_GPIO_UART_DTR_DSR))
+		ret |= (!(gpios & FT260_GPIO_F) ? TIOCM_DTR : 0) |
+		       (!(gpios & FT260_GPIO_H) ? TIOCM_DSR : 0);
+	else
+		ret |= TIOCM_DTR | TIOCM_DSR;
+
+	if (ft260_uart_pins_are_gpio(gpio_en, FT260_GPIO_UART_DCD_RI))
+		ret |= ((gpios & FT260_GPIO_4) ? TIOCM_CAR : 0) |
+		       ((gpios & FT260_GPIO_5) ? TIOCM_RNG : 0);
+	else
+		ret |= TIOCM_CAR;
+
+	return ret;
+}
+
+static int ft260_uart_tiocmset(struct tty_struct *tty,
+			       unsigned int set, unsigned int clear)
+{
+	int ret;
+	struct ft260_device *port = tty->driver_data;
+	struct ft260_gpio_write_request_report rep;
+	struct hid_device *hdev = port->hdev;
+	unsigned int mask = 0;
+
+	mutex_lock(&port->lock);
+	if (port->removed) {
+		mutex_unlock(&port->lock);
+		return -ENODEV;
+	}
+
+	if (ft260_uart_pins_are_gpio(port->gpio_en, FT260_GPIO_UART_RTS_CTS))
+		mask |= TIOCM_RTS;
+	if (ft260_uart_pins_are_gpio(port->gpio_en, FT260_GPIO_UART_DTR_DSR))
+		mask |= TIOCM_DTR;
+	set &= mask;
+	clear &= mask;
+	if (!(set | clear)) {
+		mutex_unlock(&port->lock);
+		return 0;
+	}
+
+	rep.report = FT260_GPIO;
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
@@ -2067,6 +2203,8 @@ static const struct tty_operations ft260_uart_ops = {
 	.chars_in_buffer	= ft260_uart_chars_in_buffer,
 	.flush_buffer		= ft260_uart_flush_buffer,
 	.set_termios		= ft260_uart_set_termios,
+	.tiocmget		= ft260_uart_tiocmget,
+	.tiocmset		= ft260_uart_tiocmset,
 	.hangup			= ft260_uart_hangup,
 	.install		= ft260_uart_install,
 	.cleanup		= ft260_uart_cleanup,
@@ -2229,14 +2367,16 @@ static int ft260_i2c_probe(struct ft260_device *dev,
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
-		goto err_gpio_remove;
+		ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
+		if (ret < 0) {
+			hid_err(hdev, "failed to create sysfs attrs\n");
+			goto err_gpio_remove;
+		}
 	}
 
 	return 0;
@@ -2291,7 +2431,8 @@ static int ft260_uart_probe(struct ft260_device *dev,
 
 	cfg->uart_mode = FT260_UART_CFG_FLOW_CTRL_NONE;
 
-	if (dev->iface_id == 0) {
+	if (dev->chip_mode & FT260_MODE_UART ||
+	    dev->chip_mode == FT260_MODE_ALL) {
 		ret = ft260_gpio_init(dev, cfg);
 		if (ret)
 			goto err_hid_report;
@@ -2386,8 +2527,9 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = ft260_get_interface_type(dev, &cfg);
 	if (ret <= FT260_IFACE_NONE)
 		goto err_hid_close;
+	dev->iface_type = ret;
 
-	if (ret == FT260_IFACE_I2C) {
+	if (dev->iface_type == FT260_IFACE_I2C) {
 		ret = ft260_i2c_probe(dev, &cfg);
 		if (ret)
 			goto err_hid_close;
@@ -2426,10 +2568,12 @@ static void ft260_remove(struct hid_device *hdev)
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

