Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945913;
	b=hAyAzIBgBvaAgXgacxNkPQxbngaL1LvsSdgIZ36JZ+xdwQI/GbsN66hmdzr/hcNUsCT5
	 GHOJ578nmSKDjB7Mopkqti6rMo5NFQEmLrrnqe+3B0KcCUGUH13Me3W30cOdha7EIL0GI
	 cqZqXx77qZrBYZVkzFH3C8nZYv4fRetdEmg7C59zhy0s6/Sm+zBdqGcVE2OBHO8RNK6Ha
	 Rk/VKdbFtmFDOTLx8T1yva5XekeAlYJj8uC7KiPh4JaOvTtfma04eEQnR5LvQAlAD/9r6
	 Xgt7o/Pga1SRjZ7R++BYtCGujcLh0ywCqwP2ujDEFtkThMPzn5NS5bEckluxzwdsMDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945913;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TCa0RnoydsxVLT03DHyYOZOOaLc5gZ6BJdmvsECF/XY=;
	b=jYo3PpYCPbfijBNJH2Vg/ROLy6A1iG0nd9vtcFBFVByM+kN4EbEHL640HrN7ng5F/bJi
	 T0IJReclwfA3wYz8Pg4xR5rNxUsqCQJFPIS8nTy447l5y48nqRydZ+RGHqRm/vsvU9ubJ
	 pBtAiO7YCl3Id24OehVrZZ/GP17V4BdpNeDbKrxQUkZYY9OnvXyC1de5m1tPdtfOJDr7n
	 QArzMMktWPsz8JyWTWcT6HZKquJlH/2JlzV6voyIvs2PeBROM0CUcdchTWx6zyKzvZtcA
	 1qIu+aaMrwueLpbEdC/DHAitTQj2l6JHmmhvenddZ08vXRZranF5Fs2gOdzcnd0OP1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yqUGQQpu;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E33D60A383B
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 20:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E33D60A383B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yqUGQQpu
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so2847735e9.3
        for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 12:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945911; x=1795550711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TCa0RnoydsxVLT03DHyYOZOOaLc5gZ6BJdmvsECF/XY=;
        b=yqUGQQpuFJfvOn1h42r+LKmqo0q175gJjUF3epjGfvLDK5HX26guRRThmenDneYDkC
         9sThMksbVW4v5LHTnhemmT3QBDdgqwZIcfrAzbxN5CSp4OSD7fmvjTeY/a43YIMkfDII
         RI9UGb6JQxo7G5y8LapHWcLjjoJLO8VQnk533f2krl1DgWNJVCRabC7hRQvvXrTLK/rI
         sv9/S+OybdFtEWsteLjFYS97fnZHOGu/ns78MjRvAQpB7VeeInOtZBxOkyBp2yghk1gf
         FP0Dod+NFxC4hVsgZTaC0/8aTqe4qPVfz/F88mzAWdyjzx3ltItTmMyy1tq2kgHVyIjD
         tvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945911; x=1795550711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TCa0RnoydsxVLT03DHyYOZOOaLc5gZ6BJdmvsECF/XY=;
        b=eYHEKtGT8aW1YjN61E2X4Pv+zOQqg6KPdlvHiLH0UafABA1qZ9VeD11HZMCeRyzcSV
         7dAJMrIU5Mq3UCUqZAjmo0G/Y72LzjaT/djUh92SRR+O5zTToFq7VAC3y/B61mxVLiT0
         BALC1dF2gINXQ8o97XEEWP7apBB9hmURE1/nR42VXF+KSR57PX7TU7UpMTkou6ITJH8l
         eOQjuee61e57SEoJtK5Px2k5h+PMLZ7I4CoB8Q/CTz5ZT70xoqd8joybDrol3azKqidO
         H8G9lZpuv4i7/F9ZGNw83OppkUnnXNg++vCSVRYFQKkJSJRKSGnH7yievd7O3DbPt3fp
         WMdw==
X-Forwarded-Encrypted: i=1; AL+hErFa1cCpZJ31/Al9vneXup5/Ve+fFfJlLU0mkI4LcpjRCLP38ooPlfxnEeg/HKlni5kALMB/DWKcD4Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4O/QNG8GABaBhhtmjWfhvM8CfrQvtqig2cBDVxByBjfffPAkr
	LbwoCmnV7hGrIena/D7fVpGoy3ZOJQlxn0Y6V0iMs1cfI/LqXrdxIXm6
X-Gm-Gg: AYBFou2yuia1gHxZRBhg33VoaPl0JFl85CIN+E4ms7sw01h6Cy3mmAYRdPGcodA4Asc
	BauihuHUho2/S+Kg3xoez6IXG7i7qxtKxHfM9TGD+HiKKDRkRU4iPGLe+XjeDc4XWkkGsiC9Q4J
	R6q7XFpDfUX5Sii3/HoLgzIyNLPz+PvaOue9LJZp1mu6s7E09OcCnbJoFq8j05Dd4bYlvCindgn
	/brAJJEVPIcq5dq2U3Fu/cndCWbxSuMVIGfIyN5hgHwqoQow+Fq1KOLjmXM5kur/5mKKm72O+Av
	QkWZvCLSCWHmrM52R2iSvRRn5j/HIrbCf5qh17OpolWTPyzU7MB+3O7R27OvYJpbtLHCfrw2TFe
	V9np7aHp0soaZbTIihhLYubFOnX9ybNeHWwjvjwOfSCgqy+6ssS1EcLXMR5yt2uXIsnw+GaPei5
	SO9IqD2IKgQ88E0eorJ6eAU9wYwzwNrfLyOWpOOfWX4TazkRA1KzJ8FZuzgkChwqs7tyO6+nqbX
	FaqvBfU2rcbWehoIj8grqw3Uka5U7iiIPO8KAOnL8bDHZF9OI2lpvTiTJIc6sprVdYNRMm/YjGs
	VCQ6J0vgbBBgCtiJVSbPsjbz/2jTVg6w854OtNIPL1zJO4YTLQ==
X-Received: by 2002:a05:600c:3107:b0:4a1:825a:56fd with SMTP id 5b1f17b1804b1-4bb7da47d19mr4644125e9.32.1794945910693;
        Tue, 17 Nov 2026 12:05:10 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:10 -0800 (PST)
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
Subject: [PATCH v4 04/16] HID: ft260: i2c: reduce driver module loading time
Date: Tue, 17 Nov 2026 22:04:10 +0200
Message-ID: <20261117200423.19561-5-michael.zaidman@gmail.com>
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

The HWMON class I2C client drivers register the address range to scan
during the I2C master module probing. For example, the lm75 module
registers eight bus addresses scanned during the ft260 module loading.

In the case of ft260, the bus is scanned by ft260_i2c_read, but due to
an excessive read completion timeout, it took about 40 seconds for the
ft260 driver to scan the lm75 address range before exiting the probe
function.

Adjust the i2c_read timeout so it depends on the amount of data to
read, reducing the lm75 address range scan time to about 200ms.

The 25 ms per-report budget was checked on a UMFT260EV1A with a 24LC512
EEPROM by shrinking the timeout until reads began to fail: a 60-byte
read still completes at 9 ms and times out at 7 ms, against 5.4 ms of
wire time at 100 kHz, so the fixed USB, HID and scheduling overhead
costs a few milliseconds. At the chip's slowest 60 kHz clock that chunk
needs about 9 ms on the wire and a 180-byte chunk about 27 ms. Scale
the wait by 25 ms per 60-byte HID payload so a last chunk of 61..180
bytes gets 50..75 ms, not the single-report 25 ms budget.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2:
Fix for the issue reported by Sashiko: the timeout of the last I2C
read chunk is computed from rd_len, so a chunk of 61..180 bytes gets
50..75 ms, not 25 ms.
---
 drivers/hid/hid-ft260.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index acd92248256f..1b31b484a11b 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -17,6 +17,7 @@
 #include <linux/serial_core.h>
 #include <linux/kfifo.h>
 #include <linux/tty_flip.h>
+#include <linux/math.h>
 #include <linux/minmax.h>
 #include <linux/unaligned.h>
 #include <linux/bits.h>
@@ -49,14 +50,20 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
  * The ft260 input report format defines 62 bytes for the data payload, but
  * when requested 62 bytes, the controller returns 60 and 2 in separate input
  * reports. To achieve better performance with the multi-report read data
- * transfers, we set the maximum read payload length to a multiple of 60.
+ * transfers, we set the maximum read payload length to a multiple of
+ * FT260_RD_ONE_REPORT_MAX.
  * With a 100 kHz I2C clock, one 240 bytes read takes about 1/27 second,
  * which is excessive; On the other hand, some higher layer drivers like at24
  * or optoe limit the i2c reads to 128 bytes. To not block other drivers out
  * of I2C for potentially troublesome amounts of time, we select the maximum
  * read payload length to be 180 bytes.
  */
+#define FT260_RD_ONE_REPORT_MAX 60
 #define FT260_RD_DATA_MAX 180
+
+/* Time in ms to wait for a single HID input report at ONE_REPORT_MAX */
+#define FT260_RD_ONE_REPORT_TO 25
+
 #define FT260_WR_I2C_DATA_MAX 60
 #define FT260_WR_UART_DATA_MAX 60
 #define FT260_GPIOCHIP "ft260_gpio"
@@ -726,8 +733,8 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 			  u16 len, u8 flag)
 {
 	u16 rd_len;
-	u16 rd_data_max = 60;
-	int timeout, ret = 0;
+	u16 rd_data_max = FT260_RD_ONE_REPORT_MAX;
+	int timeout, timeout_jiffies, ret = 0;
 	struct ft260_i2c_read_request_report rep;
 	struct hid_device *hdev = dev->hdev;
 	unsigned long irqflags;
@@ -752,6 +759,8 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 		} else {
 			rd_len = rd_data_max;
 		}
+		timeout = FT260_RD_ONE_REPORT_TO *
+			  DIV_ROUND_UP(rd_len, FT260_RD_ONE_REPORT_MAX);
 		rd_data_max = FT260_RD_DATA_MAX;
 
 		rep.report = FT260_I2C_READ_REQ;
@@ -776,8 +785,8 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 			goto ft260_i2c_read_exit;
 		}
 
-		timeout = msecs_to_jiffies(5000);
-		if (!wait_for_completion_timeout(&dev->wait, timeout)) {
+		timeout_jiffies = msecs_to_jiffies(timeout);
+		if (!wait_for_completion_timeout(&dev->wait, timeout_jiffies)) {
 			ret = -ETIMEDOUT;
 			ft260_i2c_reset(hdev);
 			goto ft260_i2c_read_exit;
-- 
2.43.0

