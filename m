Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697729;
	b=AIiO1mT/4Pc3R+dqs/mVzs9IEOX/jNFKVVKYZ6Gp+SMdmA3KdkHeUqN3HAflykiYOUZm
	 uzvXj3cqJrUix0fR/sidjWshVZNXX2+5GWfwZoaHieZFaAkg35/h1dnap7TzDdwyrLO1I
	 9zu6o3TnZ9YrLS4mFXp5/VnpgaM1TLPdMWY9t/Z7WOaWc/QZ2r/EYq1o2hlw758a37+nj
	 BJQqcZ6a/vmMvHhPcGRsu7ZRacQsHf9PPgln5ji2QB2m2dl8wAv51ru65qywKbp1t8tW0
	 H7Oagj1jX92SWpQwt2hwcXICkPBzObmtjnW7v53yRsGRc6ePKwAoDEI02ZQ+N2m9XWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tvw3aYJ/+J2kjwbuv/bkRl4wFmMEl8VZq/eLp4o6xu0=;
	b=bBa2ESVRikLxtDZ0I0f3PKf/X1dTV5xdT9dxX0hkR4l6trfQ61nu2yyS3ti29iMyIgzC
	 hbmJESJVp27UbDq6SXyEV9DBtzcP5wS4ENRqmf20fFtml/Xmh6lZGwKOI/AY9xhrHAsMO
	 LrDJIy6l4l1Js0b62lVS3HPIaIvUEx7K89FATAEonzihoQCcfPZmyiE95+qXrOkB4nU0h
	 TIo1BQEFOZPpJPOYFaHlzng7G+k8L56rRw6+bS7Z2yF8nXioqUcu/MPOlitKopf0iD5pg
	 TJJtd/rwwh1sd5xCekRK/EGBFprdffywmg4FSwhmxt5XWinL19onE1DxUBuU4QXtydg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nSi67exh;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E821960A5BC7
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 23:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E821960A5BC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nSi67exh
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb6057b333so3249085e9.3
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 15:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697727; x=1795302527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tvw3aYJ/+J2kjwbuv/bkRl4wFmMEl8VZq/eLp4o6xu0=;
        b=nSi67exhIRk8jUdZadpDQoHD/04fLVAUkYOOP+LdYhSx260g/2XClJpqWX17ObFQQa
         Z/1VDW8W1ebcenrVuU+TC04JvOQbFqK0R1n2jZoFjyxuMxbQcAoQ1iEvT4Z/51iTrorm
         p/ab8oXYDYRO7FeGjqX+slsvbENiJfUFCvBq00ynbXHIuViuKW3cS/csOKCJ3xNNEgQG
         XgPjolRRj+yl+NSbi9MYFQAVVa5n8Lfj9sXXWMb9moSpZ6fQ6NUJPP6PLvoB2nKXNH2k
         TaePaWSBbfLex0By7nkTNN4KTKO6TZMiPau9ynJMrr9RHzzMhSX+EYF2ArszbCJpfz8K
         ztQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697727; x=1795302527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tvw3aYJ/+J2kjwbuv/bkRl4wFmMEl8VZq/eLp4o6xu0=;
        b=GE6AV6b0KW3YUeTd6eJzanVKZxklElsYJD9w9v6pmFxHzsrUAOMxXmyXeOyCd1sMKC
         1s0cuDZ+par5NvG2pbaoiTiqkYxdoU/fWlnBU+9L4hvYrwYvPqXRE6SC3swEfGlvsDfH
         qFPR9RipUs+tc9k18NVBbCHRsH8aytDpMC0h3GgQ62X02hR0nqx3VsV9JW+ijCYaih/0
         aeltbChso3Ytbh/O4l3e1meuvAykBgElxUdkMi2P1Cr+haljK12wCOU4S6UsIhWQxQe2
         mEymGIjNOKON1fn7fcTwXYwGftGtQ51RPd7YLsBJoSc/KfcpKwxED5mZl7QqjISvFF3t
         T5WA==
X-Forwarded-Encrypted: i=1; AL+hErH2sTK6CwuIqkb6QedBdnCAI1KEzBmubuQnqIVkcSSCoXqaqFW/kjxPNo0Uixko9mLD+s63M/RX5Lk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dqr4nJvwHxnCeh5+2Bfm0GfF9jNOl+U1TRlVOS+o/c2vHNVPy
	/mAeBnyL61DsEK/FwG6tYU52W6gLnkiQ8fhZBexs6G6pblc5Asy2RUQ6
X-Gm-Gg: AYBFou1qJXgvMJMuG6RQpZxqxadhRJ074ozihRG26Aq2Qc2cx3rZ6XmePtovVTrWA5g
	VrSH8N3+EEpPN32LJ+tnkcN8tlkltTpCb7p1J3aRxcybJSSCeq8tMKcgSlVzZ6AV8dE4G+yvBrP
	D4rPtr5+If+QLBnssC1hd9ZBzNpEEEEfsKAVB+Avq4cMZnrQHFVCYY815nui6uAe3AfzWLRfuzL
	7S0oSkFbHfRr4ZfR2UaGhp1XWYt0Xa768l94iME57RU7RkRLev2/rrtcV9TLocxKp0Lu9AIR1kl
	S0WdW8UsYO3LJs6BPk+A9qu5gNT4H13rC01OT+ir+2dzpojP4nGQcxsPaipb1RlLpdMC01sgYCB
	VgCWWarBRR8eOwwKbs5chy4CG9nACuXfMCGJufBZUgH/DNyI9pVQcEHntmuxpmL+bC2uZIXp3Hy
	L0HOMQX4v2Ya4aJ+u615yuKLL96U2JbPOmCNkSSnDoOtvGmMU08VH5E5M+eAaMsCxnRywm5vQOU
	c9GxYVIhmzEweDz8YUsP6c6FIOOwPuFzQdZlmElV8Y1gdQo+co20Zic964m9CcvMlsYjwptknz7
	qB/5iAB7x9LUsJywgg7KabGE9EeN
X-Received: by 2002:a05:600c:2d2:b0:4af:c210:5b3f with SMTP id 5b1f17b1804b1-4bb55a63720mr101633985e9.24.1794697727220;
        Sat, 14 Nov 2026 15:08:47 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:46 -0800 (PST)
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
	Chris Keeser <chriskeeser@meta.com>
Subject: [PATCH v3 10/16] HID: ft260: i2c: fix large write transaction failure
Date: Sun, 15 Nov 2026 01:07:54 +0200
Message-ID: <20261114230800.1344401-11-michael.zaidman@gmail.com>
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
index b68cb0748a23..f160b5360f89 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -580,9 +580,14 @@ static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
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
 
@@ -616,13 +621,10 @@ static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
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
@@ -639,16 +641,6 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
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
@@ -665,6 +657,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			   int len, u8 flag)
 {
+	u8 bus_busy = 0;
 	int ret, wr_len, idx = 0;
 	struct ft260_i2c_write_request_report *rep =
 		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
@@ -677,8 +670,10 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
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
@@ -694,7 +689,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			  rep->flag, data[0]);
 
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
-							   wr_len + 4);
+							   wr_len + 4, bus_busy);
 		if (ret < 0) {
 			ft260_dbg("failed with %d\n", ret);
 			return ret;
@@ -735,7 +730,9 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 	ft260_dbg("rep %#02x addr %#02x cmd %#02x datlen %d replen %d\n",
 		  rep->report, addr, cmd, rep->length, len);
 
-	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len);
+	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len,
+						   (flag & FT260_FLAG_STOP) ?
+						   FT260_I2C_STATUS_BUS_BUSY : 0);
 	if (ret < 0)
 		ft260_dbg("failed with %d\n", ret);
 
-- 
2.43.0

