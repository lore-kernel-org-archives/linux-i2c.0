Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697716;
	b=MGQ44jqF2h7o7gTz/RXJ3qj3jTEobv2SV+kMdjPJul5wHs85DKavzYrt3V3z8GVHmEqc
	 /WJDYUWmbuxapofAQiytz1525ZGbA/C5TOfkkgqjlf9YnYbeGSh1Ti5UyhanmgGkMNkcs
	 aw1hVN12biuQOET4+0ayvg+qhwrjd4boCfWrwSIxOUcfr7fepVMF7ErjwjJQBy5kS50s9
	 i04iVLbtB9PbwSqAbqBd4FTk3b1l7lSSs6ZWdNPiNyhk+3N/ws/DBYf9fktewX5tCJ0n/
	 AIzS1btpWeGwsYk7Oz7FpeprqSDaIdCdsmY2NItieIvSO36OH8wCzLZbM4w/o2hPDNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7tlqBEORNJM+EJ64JjfZpDzizcgcXj+RIpcTDkE/fcA=;
	b=xtDz/fcGvelD046ortaX9QVbBltPA8sl514hRupLS4psMsApEPhxRFywzEtRzySszzOe
	 7Nn/csTpJ22kdVgq1iEle3bXywLm3Bc/oUF4QJDn/d/F+zjGmb2JSLpiZ0FP3GLe0aa22
	 ILuMwfkpk4xZQkyamqlvISlmbo7QbWFgEBXFA77+5s8t/GJcH5dycI/6YwtuhfdcO2U7w
	 nA5gaYcCvdJKRbvLMaWZHQrAg4AHGIiAx0c9afSYZyPZX/NTTp0zeJEZAG4oHX1dJE5Iz
	 5uQORn4cK1bAPzHmEfYqLX3NwdBv7ZEiFapdlWzKfSvznonVV36x9bTKHBg8oPERVlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jx83ylx2;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E117060A2600
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 23:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E117060A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jx83ylx2
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48fd2e38825so1318332f8f.2
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 15:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697714; x=1795302514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7tlqBEORNJM+EJ64JjfZpDzizcgcXj+RIpcTDkE/fcA=;
        b=Jx83ylx2taxMD9eTcVWDa1NgH5ig+fmVfCT4xi+3Re12S4rD3N/khXcjy3CM0rwUP2
         Hl9tX63MSY/oLIvpiysvkZYFtW+Vn+MrbYUFMSovwfsr/VrYEWV9mvtk532lpYRfk/yY
         P3zcSkzJF5W32wGxL3w7TovLmlAzO7GpGgVjifTObB/y9LbODTcH1HmWsQjaVATRw/2z
         Sk8gRc3Mo95d3pPQLUHGBQh2OTIhWE33uqLHPCON5NlGPI3wdcJHqGWwPxlgYIWbNm18
         2YR0GqHBSTcgAwNrXAXK7eMhJ1NdFwd57ziPd8Q/FiE2XlIkHwtVEAG6RaWboaJ9rP7E
         HZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697714; x=1795302514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7tlqBEORNJM+EJ64JjfZpDzizcgcXj+RIpcTDkE/fcA=;
        b=EPnUE9OOzlHkidacLenqEOWz3+p4RN+IBimTD+9FHbzneValRVnkh8KkfwHx8K870H
         0NmlK+036ybAlzJeyX5UVuABHii64ZcvjdS7jN1sHMmC1kNpEbOWfPePyfEo3PXjO57C
         fPdFvTZGeqbbPUv24Ao86IZ55hFzxp2aumBJAX3IRiZYxDHPoTKzpGIvzIB+BZ0X1Hik
         cP0pq6WlRf7eTNBgRDw0m1F3ZEANnglXL0e8z0kARgCN23CFiHUT9JOYle+kdsokyWsR
         fNxptafzsAuNuL1wBKpA2t01rAjpKVc/MAfsUNIk6heEhTXVL1XL5lNbDRdXO51aX3NC
         tmwQ==
X-Forwarded-Encrypted: i=1; AL+hErFMkOe2W7/pyVj3w8bHa9kBbkTPNwOQqsZpgJDRB8hmzUtJuGGUJsdAIlzhQTj/JY1gfB1cKqL6/tQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+K79rM1sQQlM8Kmi9XIWIGm7mGfgtck2jNiyGe7u13xi6Qw0V
	KFW021PSLmHWHhyMS5F4REf+RXVlvb6ozhqvJW7FLSvrR0jSlbG5V/F6
X-Gm-Gg: AYBFou0saD8dW8+XX1mSwzU3gC4jWHIvS0dKGTX3vn046BTZeefKcFuVy4rWmxUsHJu
	oopzKryf9/DiPOa0R81RhqQaAYspb6yZFN+lBTQF3kqMdwH9ao2liEArmrKlktNIANKr4X2qxFT
	F1hVqJ1xNNwCatc5B1hbr2t2aSXfqbs1z5ZwJnZZ5f0M45edNiLKi0j9EXYdkPmJ60CE4jghXvk
	ng0+HFcHyhG1EcnKqpwlrG1TcsecSfen1DzO1PziUOi4QXbVIqx/X1e4Wy0vD3TBUTTF/NXbEza
	BEfPoCWApVdWQk8yU4Gv+/ufaDN/+EEMmfOjAGLvMSSSF2Qs3SANGvMFXpFql1EThNpzy1RyOGG
	bsKCXpCkYcWOTjEl6/m9we7KYkrUXyoqUm0o4o/sBDK+nCX91Qm+fJhzoNtQ76+ZsxS03qYLCl0
	DUO5ql8crjUdlIU5gxf2vI0DPmY7bhb7SHcVq/sCZlr4mn5eImku+9vKN0bCqrvt0jUJ3nEAqd9
	WZq66J/dYrNHM9kR5ISDsSK6AiDj30ZFsrEpmlG78ao7FLiF33bQ+ixGu63vyj66ZHo/VDYu1c/
	TNYQb2ZlcnxzXermIgFkt23M7XJeSg==
X-Received: by 2002:a05:6000:26ce:b0:48c:571a:a1aa with SMTP id ffacd0b85a97d-49c70de38a0mr13439813f8f.19.1794697714304;
        Sat, 14 Nov 2026 15:08:34 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:33 -0800 (PST)
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
Subject: [PATCH v3 04/16] HID: ft260: i2c: reduce driver module loading time
Date: Sun, 15 Nov 2026 01:07:48 +0200
Message-ID: <20261114230800.1344401-5-michael.zaidman@gmail.com>
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
index a924ca2eef88..50389b3e79d8 100644
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
@@ -724,8 +731,8 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
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
@@ -750,6 +757,8 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 		} else {
 			rd_len = rd_data_max;
 		}
+		timeout = FT260_RD_ONE_REPORT_TO *
+			  DIV_ROUND_UP(rd_len, FT260_RD_ONE_REPORT_MAX);
 		rd_data_max = FT260_RD_DATA_MAX;
 
 		rep.report = FT260_I2C_READ_REQ;
@@ -774,8 +783,8 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
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

