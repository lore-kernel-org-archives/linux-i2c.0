Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3551DEFE8
	for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 21:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434844; cv=none; b=XZZjbdV6FyHniZcAOO2Ig9BpQ2zX1IkYggrR9tVTA09xHR097DeIp4ZLHV1+nQSzHPASt5QO6R6poZPvtne1Zz97eT7LA+zUQvAUM34fG/tfiQ+jMkYE3KR1U3J9ImyTxAvCBVmyowc6L6kiWzYAh8da22zA2vAXw6HYWdWduUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434844; c=relaxed/simple;
	bh=DYI0nXh+SYMeDAto8oGYKYCMKaYc4QTLn0hrspq5Dx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGiOD1mIduNL9FbjgmQOTxq6DRebwkcep5uuH8URPB0PYfY42HrTfA+qcaJr4cbZU0ORxQs3KqPxhT91MawfefRXjj93AVj1jwFIS3OLBb1aQONN701QdSysVNv+fcC/7pEJylYlltR98+7BLLAGZJD3vxKKYmS4gyxTP8JQgsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhVzEaBh; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhVzEaBh"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a051904222so2781156a12.2
        for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 14:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787434835; x=1788039635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x8pH0U2xaFDXVXpg5ddmhyUBND/R6AGE2iAuyBIz7BE=;
        b=MhVzEaBhfwNqlisK5Nl+jlWSnlOs7d0h8b29c8vA3nl9uWAGaq8b05wGe2d0IMMf4R
         BBMLrul65uMwj9GhGqj7Pm+BWXifMhgzO1Znd0QR9Q1+kFpycK20upEMjuELlYbbhg+6
         C1fu0JiIfFWWmxvQufHgWTyQcHX90uPa4396hj+0xKDEE3qPh8rDsDuEfj7DdjxckKxs
         liJu7E7+6M2IrF79pe3pUs5RQ23q9h28Y6xAG/tvyexUNs+0MFrOPjP8aHICnRaKQHHf
         lDYV66bcf5xLZiSF3Lg6oVZGmE2QgJWrqvceUZkubsCrOMdsojn/OBHnga32ESOJp4RP
         je8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434835; x=1788039635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x8pH0U2xaFDXVXpg5ddmhyUBND/R6AGE2iAuyBIz7BE=;
        b=Si4GvtJEU6upjN72M3QcciRNCFtZOAsTdPjdUhjEQEYRjoEIFOzqfM0sTHWby/d3fq
         CyTnHV2cOUegJetFjId/dgq1cTPxoXVZa9nf1atpxSbAoW92WMccZBIkWLAMF/h/C9Gw
         fDWPbl5LQC3/WlJZIy8fBzoDqllnlH8c/zVh6riTctKgn8Zi5i8T9hKmilK3/QCBs/Ao
         O3+BxuXvrJtwN1vaWgl8zrB5AdIkZMME1amsPbpYjFTOeIoa4bbveVEjXdE7XqFoMPE+
         ughVF2wKtdv8lrjXoXYn1V/yYqboKAnlBPm69/AaUps6rPZwOSepD3YB8ufi/dq7nyd5
         yTMA==
X-Forwarded-Encrypted: i=1; AHgh+RroI9ABJ71qYGPu1y1nPAKZE1dci33pFRTe5MHQLrB6DivxyPq/r+7EzqAQZd+S/hnM+/WNSvzGKdY=@vger.kernel.org
X-Gm-Message-State: AFuF++kWmJDBCe4CVfdp9bi8vR4TBOHOf98TWf34xmgck4lTPQ6V388U
	Ai0VUcNodUI6BXJxUuGAY+cutYVn7avwx3xJm/+Z6+zE1DS/uE3BJOFYD+XlAHOj
X-Gm-Gg: AR+sD12z0GPVZ+z7nJS4cZsi8qw9pWytMFFGUlZZMdXTLzrh/jeR645PZY2VOzUWX7Z
	4Q4YfKNIqKDvLf36WH8ycKOjIpLaUeLO983Up92HAsQTgOAlaNWb09ZiYBfO0X+gsJ/lija57RM
	Kwg5yVZFhm7s/hZOLQeAoojokJWduV4ECa6GjLkz65o5sOHUDO3LTnK+mlps/CL1eczbSwQfOG7
	JhJlPsDtcDhtMVm+W7pnKDS5oZOT7ovyco5HiXOfaesV+Vu7+kdKA9Uep985kWkuF/W6/o1az9z
	OVJla0Vw2uZsSMPgWOf74QFpMObsXmrMG5uaYySBuugI7nBcGVXVBHOms3CsbLEG72F1GOKR2nj
	oZaaIIV5Y14Vo8YLZYnnGYA6QIM2PMaq4+vBh/SSW1gmlHiUkkuZ0DvrHMQKPkO7H9VIltpr7OK
	i1cZ9yt+u1J8RPB4B1zEwnSMDpTGaBX2yiMV7ZH7ZRY4F7cZB9c+CIGYkY8Bw=
X-Received: by 2002:a17:907:3e16:b0:c16:3074:657f with SMTP id a640c23a62f3a-c246a4ce3b8mr1701833566b.9.1787434835007;
        Sat, 22 Aug 2026 14:40:35 -0700 (PDT)
Received: from m2.. ([37.142.151.124])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c24966f99basm466778466b.37.2026.08.22.14.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:40:34 -0700 (PDT)
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
Subject: [PATCH 04/13] HID: ft260: i2c: reduce driver module loading time
Date: Sun, 23 Aug 2026 00:39:32 +0300
Message-ID: <20260822213941.98882-5-michael.zaidman@gmail.com>
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
needs about 9 ms on the wire and the 180-byte chunk about 27 ms, so both
keep roughly a factor of two under the 25 ms and 75 ms limits and the
timeouts do not need retuning for slower bus clocks.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index cc3b8f5791de..4435a39fce23 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -56,6 +56,13 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
  * read payload length to be 180 bytes.
  */
 #define FT260_RD_DATA_MAX (180)
+
+/* Time in ms to wait for a single report read data transfer completion */
+#define FT260_RD_ONE_REPORT_TO (25)
+
+/* Time in ms to wait for a multi-report read data transfer completion */
+#define FT260_RD_MULTI_REPORT_TO (FT260_RD_ONE_REPORT_TO * FT260_RD_DATA_MAX / 60)
+
 #define FT260_WR_I2C_DATA_MAX (60)
 #define FT260_WR_UART_DATA_MAX (62)
 #define FT260_GPIOCHIP "ft260_gpio"
@@ -713,7 +720,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 {
 	u16 rd_len;
 	u16 rd_data_max = 60;
-	int timeout, ret = 0;
+	int timeout, timeout_jiffies, ret = 0;
 	struct ft260_i2c_read_request_report rep;
 	struct hid_device *hdev = dev->hdev;
 	unsigned long irqflags;
@@ -732,10 +739,12 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 		flag = 0;	/* no fresh START - continue current transaction */
 	do {
 		if (len <= rd_data_max) {
+			timeout = FT260_RD_ONE_REPORT_TO;
 			rd_len = len;
 			if (want_stop)
 				flag |= FT260_FLAG_STOP;
 		} else {
+			timeout = FT260_RD_MULTI_REPORT_TO;
 			rd_len = rd_data_max;
 		}
 		rd_data_max = FT260_RD_DATA_MAX;
@@ -762,8 +771,8 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
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

