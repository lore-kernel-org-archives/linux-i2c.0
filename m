Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4CC3911A1
	for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434858; cv=none; b=Hjogk8ROv6n8yLVx1bmqo29FI0Jh9aXUOxIUis1M2qB26IQy1X3CO3rYuVb218xBsgxopbQy25QQXgA/OwfTiHStIvn/271vmUSA0qVjWLVRQoTjQDpkkDOKGWpaDS/RMNhYU4CIqS4BGdjOb9TI9VKmbDr6I88NQrhKD2IWXBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434858; c=relaxed/simple;
	bh=+tTBPf/ITWlpNCLZqiExxTpUAgaWoqxWpXFOOAp5x4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0ZWHSg2W7nfBnWEybHLZnhXK6JGq+ZH1bsF8a7qirSUkzCEIh3wr6F9Hq8fpY4ePhzlXyuHJrKFZePW11QA/rcIdXcOQs3f5QsZl9H2Kdt9LNZDd7KVagvMBrLbfRyGvraJ7GUB+CqlMCexyGW9VtfvMIuRZAdXfAij+6JJz9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu5x/Oxa; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu5x/Oxa"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2055f5a993so254963166b.2
        for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 14:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787434848; x=1788039648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=10Eq5R/N2bfHPdqI9SBKLnnx+VXtAYQbeV+dq9RoJTo=;
        b=hu5x/Oxa/d3y6zWFCg3G6PNcMQX82Q+drWOWuByIgA6VhI6ZegzD5MUAvNMyarunZf
         bKgIYjg7agqc87krmzC8O3kNHWpnB311UfyWnPZNvvNtzWyXNojfgq17hmPsjWocUinJ
         Dh2Abt3ZgWqZj8rbRQgM04Gu8L0VFlzDdfBo0rQBTJ+2BpM2zo/3EL1lDaKaWrcdPU7/
         gX7cRsLrSk0CoVSTepl7ZwwBr/LxxNCZFhGguErMZRgBYDSsMilwOnKk0fBuIs4W5Whq
         apmrT7q4J2N7Bwi22UqoFJc4Mv6FqjEB5dTVblDowuh/+df0CDv/AAB5ikAS+k5gwpR+
         ql1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434848; x=1788039648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=10Eq5R/N2bfHPdqI9SBKLnnx+VXtAYQbeV+dq9RoJTo=;
        b=njCysxL6BoZ9IxP1fxyEELDw5p1WUyKZstrUImv0+rKAFQHOuAvKI4rWH7po7Qx1BT
         fFSWPVZx5Nawm8yPIa/VEpR/APiLm4QvLLMHekdU7xzyO0ntd9k9UkOWrsS31/xlGEE5
         Vp9yt11Coa7kzg454Jwa7WRGTtxRsbL9yUwLlzbvY+fMIxoupCeVUrIp1xfJA7h4eho3
         GET4CcmmEhXcj0uhin3/IFD2RzayC3r+XcUaBTAei3fEpbgzHIF0qNfHw02pfVW1qrpI
         kUiZjdUPp42ozUCn4/4rXqu7xBAgsPJJsCjh3drjrCSpdH2zkgUKhgn3HuEw3Y1QbayP
         AMPg==
X-Forwarded-Encrypted: i=1; AHgh+RoD/JpmsfuUV7ynrpLzucKPmUM+1tWjcZpNwK4RLO/o62++hRIKuIfKo4PHMnPMD3yfeuwBXQRjNHM=@vger.kernel.org
X-Gm-Message-State: AFuF++nmxxC+1zGIWNFwipGvucYQLftLZGiJmwvM4xhKSE6+lSqXoJgC
	CCONlfPS0sKGbbEgjkFuG6v1Z7qRKyeTe346OX7l+3VXavAyAcNm0BKe
X-Gm-Gg: AR+sD133dazrUa9QFc2MW4FTItNPRwNyaWbZO1259pnnxNlO8i5G+Nk0caaZYQvY3pR
	ODqALP+iIlUsnfiKFplly5CH9PyVWPp+OGLZl5LO78z9TfuaZm4jqS6prevMxLU/ySjwAL76/+B
	pjkY1gqfU3BVwmSwlIL4un8uhKQkdaPWvEvlauflKqoef3BgJOFN8Mh78maIFjs/CYJ5VNwYDDQ
	6ArCcBM0gujBEbW2FYw5111L2soZU1lloK4Da1qXdS9LBuXQi3hOLO0GpW5k0ig5Rx0Lr+Z8tFf
	W/Xz2PS7OX87yvgfxC3d4Zy1+ruMVvF3V5TSQs+Dbgrh1jfWEzMKplomHo+2nbBydK9YWwzXF8g
	itFmzr8MdOM02miarjeUFaecc+xAf97KAn9TOziBsOzC9HFSyt6+CII2PzaZkAqcXyn8S03i9aC
	eD7+B88RRgVddSy+5ILxZZBFdnTNHlWxtieURMAGVLqPHhURD3dYjdhuyagn1t
X-Received: by 2002:a05:6938:a086:20b0:c20:38c2:2b7f with SMTP id a640c23a62f3a-c246a684286mr1173749266b.12.1787434847817;
        Sat, 22 Aug 2026 14:40:47 -0700 (PDT)
Received: from m2.. ([37.142.151.124])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c24966f99basm466778466b.37.2026.08.22.14.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:40:47 -0700 (PDT)
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
	Michael Zaidman <michael.zaidman@gmail.com>,
	Chris Keeser <chriskeeser@meta.com>
Subject: [PATCH 11/13] HID: ft260: i2c: fix large write transaction failure
Date: Sun, 23 Aug 2026 00:39:39 +0300
Message-ID: <20260822213941.98882-12-michael.zaidman@gmail.com>
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

Fixes a regression from commit 5afac727defa ("HID: ft260: missed NACK
from busy device"), which waited for bus-idle after every HID write
report except when the report flag was exactly FT260_FLAG_START.

Multi-report I2C writes keep the bus busy between chunks for atomicity.
Treating those middle reports like a final STOP caused ft260_xfer_status()
to spin on -EAGAIN after the second HID report and fail large writes.
Write-then-read combined transfers still worked.

Pass the bus-busy check policy from the caller: ft260_i2c_write() and
ft260_smbus_write() wait for idle only when the report they send carries
STOP; intermediate chunks and the command phase of a combined transfer
do not.

The SMBus side matters for register reads. The command phase is written
with FT260_FLAG_START and no STOP, because a repeated START read follows
and the controller deliberately keeps the bus busy to keep the
transaction atomic. Checking the busy bit there makes
ft260_xfer_status() return -EAGAIN on every retry and the command write
fail with -EIO, which breaks probing of clients that read registers:

  ads1x19 6-0040: Failed to read config register: -5
  leds-pca963x: probe of 6-0008 failed with error -5

Fixes: 5afac727defa ("HID: ft260: missed NACK from busy device")
Reported-by: Chris Keeser <chriskeeser@meta.com>
Closes: https://github.com/MichaelZaidman/hid-ft260/issues/35
Tested-by: Chris Keeser <chriskeeser@meta.com>
Reported-by: Bruno Giacomazzi <brunoceg1@gmail.com>
Closes: https://github.com/MichaelZaidman/hid-ft260/issues/42
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index a2f4b6e5a16b..36687c086b40 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -566,9 +566,14 @@ static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
 	}
 
 	dev->clock = le16_to_cpu(report.clock);
-	ft260_dbg("bus_status %#02x, clock %u\n", report.bus_status,
-		  dev->clock);
+	ft260_dbg("bus_status %#02x, clock %u, bus_busy %#02x\n",
+		  report.bus_status, dev->clock, bus_busy);
 
+	/*
+	 * Do not check the busy bit for combined transactions
+	 * since the controller keeps the bus busy between writing
+	 * and reading IOs to ensure an atomic operation.
+	 */
 	if (report.bus_status & (FT260_I2C_STATUS_CTRL_BUSY | bus_busy))
 		return -EAGAIN;
 
@@ -602,13 +607,10 @@ static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
 }
 
 static int ft260_hid_output_report_check_status(struct ft260_device *dev,
-						u8 *data, int len)
+						u8 *data, int len, u8 bus_busy)
 {
-	u8 bus_busy;
 	int ret, usec, try = 100;
 	struct hid_device *hdev = dev->hdev;
-	struct ft260_i2c_write_request_report *rep =
-		(struct ft260_i2c_write_request_report *)data;
 
 	ret = ft260_hid_output_report(hdev, data, len);
 	if (ret < 0) {
@@ -625,16 +627,6 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 		ft260_dbg("wait %d usec, len %d\n", usec, len);
 	}
 
-	/*
-	 * Do not check the busy bit for combined transactions
-	 * since the controller keeps the bus busy between writing
-	 * and reading IOs to ensure an atomic operation.
-	 */
-	if (rep->flag == FT260_FLAG_START)
-		bus_busy = 0;
-	else
-		bus_busy = FT260_I2C_STATUS_BUS_BUSY;
-
 	do {
 		ret = ft260_xfer_status(dev, bus_busy);
 		if (ret != -EAGAIN)
@@ -651,6 +643,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			   int len, u8 flag)
 {
+	u8 bus_busy = 0;
 	int ret, wr_len, idx = 0;
 	struct ft260_i2c_write_request_report *rep =
 		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
@@ -663,8 +656,10 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 	do {
 		if (len <= FT260_WR_I2C_DATA_MAX) {
 			wr_len = len;
-			if (flag == FT260_FLAG_START_STOP)
+			if (flag == FT260_FLAG_START_STOP) {
 				rep->flag |= FT260_FLAG_STOP;
+				bus_busy = FT260_I2C_STATUS_BUS_BUSY;
+			}
 		} else {
 			wr_len = FT260_WR_I2C_DATA_MAX;
 		}
@@ -680,7 +675,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			  rep->flag, data[0]);
 
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
-							   wr_len + 4);
+							   wr_len + 4, bus_busy);
 		if (ret < 0) {
 			ft260_dbg("%s: failed with %d\n", __func__, ret);
 			return ret;
@@ -721,7 +716,9 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 	ft260_dbg("rep %#02x addr %#02x cmd %#02x datlen %d replen %d\n",
 		  rep->report, addr, cmd, rep->length, len);
 
-	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len);
+	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len,
+						   (flag & FT260_FLAG_STOP) ?
+						   FT260_I2C_STATUS_BUS_BUSY : 0);
 	if (ret < 0)
 		ft260_dbg("%s: failed with %d\n", __func__, ret);
 
-- 
2.43.0

