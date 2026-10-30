Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399848;
	b=WLvkScNFWpv+PhKX6XIcaacJJOmMh2v8bO17AFDH3k4Xo/utL0ZQtXgCnXjbkWjb/n9u
	 BQYpOIpvf4iAwEGmRITo+gRLbH5jfA0kjVfr0H5eEsVvUFNWvfbPiP0lnffQc4LFU5Jgq
	 qJMOkWYIc8swaELplGDp3wtDhpAIkO/D+1qTWJfZTScpS+ZaVYE60AdGIgUBe2ZH5QK60
	 Yl+ut/Wu0eRuSkR/rvM8LyGkKxQt3pTAybWhz8Wn8ytpqRD1JibTOO/2LUWjJh4wL34XW
	 iwmjBItcB8i9pHsRhrK0IK5KYxv9FwHQRgZifXZiCUSEFoKGXuGcKzRsqiGsFlJUZJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uJVUWRv+X+dXynVZ6IIPhUljYt+AbMuyn+nbQfPo/N0=;
	b=BNEjq/+SvD+4V+34MEQr7iuBpkQWCaAe1rvWBxqCVgfdpCava0EsmCfn8C9H8coKgLos
	 Bv3sIvfVmpQQew9Hu+kl+X93MJu95mrqsQ0XKR9QUizFgYSdwBSTsx4144il3GlsXZuV2
	 LSLYFwRLCNmyfKOEBYA+mVGSklUymPf9rwZvoSjY8n1HMeuFonrlvFmEr0J/FLKAh9heK
	 4ZbHeYVPK67uiFBi5Ylqza66L2lk3jrY789Jsj6/a0sMFzCfNaLR9bQ9BdqPtkD75ONih
	 EVqmqzsA4GI5PFmr9RsJrS3Va03NLf1PkSvVfthTIciEXzFwkTF+Jpn38uEdiLuVziw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yd5EpnNO;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AE860A261A
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 22:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65AE860A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yd5EpnNO
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a215e64962so12085195e9.1
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 15:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399839; x=1794004639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJVUWRv+X+dXynVZ6IIPhUljYt+AbMuyn+nbQfPo/N0=;
        b=yd5EpnNOD2uZtleapc+hZXnJ+TEjXTpUZJmmTe21kU25Yu9fYu/s/whBTAuP3x/wM1
         V8WVki5h1ivcr/NvTgB/TSTWqpQTfTVwqIwYn553dt0xaJtEb4TuWmeWmnHx1JLLAAxE
         KzWhcuPfI4kmVS06PeLeQrrNtckKErC+nCg+N1oO+yVXbrfyqwLpyZ5NFcj4nE6Mqdg9
         X6rQHL3kift3MfQof0XedmmzQedYkMTMeFTRGx1/MGrKVve+vxLlUKZTBOQ2EtMfYtQO
         rkHZJIzfu/mf50nmcYlvQACKBaK5OR7zp48II0T/3RsRzqTqddDLj3P1fHHUCj57nHC4
         8jZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399839; x=1794004639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uJVUWRv+X+dXynVZ6IIPhUljYt+AbMuyn+nbQfPo/N0=;
        b=A5kNVWYR31Z1N3B2AdrtL0LyxmtYB5dh5pEC0lEwpoPdIe1GVcBdBYKXdWImdbd8Jv
         RPZ08WGB/VmvxJ3/sP+uHTxlSSuRIfcYiao1csK1FRA+BWSulQ2mjXldAi4CNpuqs0Fk
         e33uDGUi4698kkMpeVkUVsfHqr8m6UnpijH7N7QDThVoUSo4HEZDbxt8BtZAMgk68TzU
         cIwRCC18rEvhDWJfuad35ZemYiIEmcQVFLNaOxm5e3Llapfaw38IVcE7kp0KUoiYSQuL
         Qi6Emiq3ggdch6ZvOxY7xKFFmG6jv1kH5nmUZzvOgkeMgScla6FDmWGIapkM1Vm9Moy6
         FPYw==
X-Forwarded-Encrypted: i=1; AKwUvByZSEdVh8nGh4Rx+OiJCx6zGGG3lxZecjhhyhPl5SdPJpOQonNIVt4nAyYyw80W5QlXQjNnnbRPI48=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWZIFIPDEpo1rjBqC8Sst+FFO+S5UcdpT3ZEQxQr/2FVqGcpHd
	VHFppVnw9XVo2/BFUiqOQf0Sj20g/q85QwdyrAy6AHyyWyEQO0oxERM1
X-Gm-Gg: AYBFou1eSz72UMMyuUWoRJEbRv+aGnNsCBW6Wd6klQe/maUSeCq6zbGZsANAtO/nsRH
	s3OpZDkB91U/5KgqHRmzQFweshxUVn/6N+xnO0gClRzK3ReY/U9TOo43XnRxnIe/nfF/QhhCwlf
	5I4LJqAcSFW3ZPTOu5j1QqrEoA5tOAVEIKOq2KHMECkzsnBY52r4f6DhIZH9ZSIlQEopjb2wOPA
	4YNlDPiIWXLWjAj9B/6VdGnvuRFgvmT31l98WIBQO8WGvs66rgQTCgG/w4qqHUDMu4szezG2IjS
	p5aK5prob3g0Cs30IB0A0CGNj11ENRo7qb+wumlDVDJrXf5Zy+5+NKWf8gXu+FPSXjJij86qX62
	tU+qoxqzID7re2WVJPjA8GeO0hVLzMND5ZBn196E5P25e/JjGUsRcuPmiQIqfh4jqKQ+DPd5yEv
	WFJgitmWerXv3FJAHU/Ea0Cryn2/uE+vc7AZHTj359Z1n7UnM/ayqSAr9UCJpJC4eXy+EAPlb5B
	EgAwJcAtaL0Iok/uRST/1zT3lU4yn4MNwaYq/SVQ3gmxwjC9cLWI8itgKLXLrs0RoqRJb1hj1ob
	7RcESHljSg/Mxk336KYXCzqnf9jM
X-Received: by 2002:a05:600c:1f93:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4ac182dbc34mr81626205e9.14.1793399838726;
        Fri, 30 Oct 2026 15:37:18 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:18 -0700 (PDT)
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
Subject: [PATCH v2 10/15] HID: ft260: i2c: fix large write transaction failure
Date: Sat, 31 Oct 2026 00:36:32 +0200
Message-ID: <20261030223637.86907-11-michael.zaidman@gmail.com>
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
index dca0250f2c25..65835e13fa2a 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -576,9 +576,14 @@ static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
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
 
@@ -612,13 +617,10 @@ static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
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
@@ -635,16 +637,6 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
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
@@ -661,6 +653,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			   int len, u8 flag)
 {
+	u8 bus_busy = 0;
 	int ret, wr_len, idx = 0;
 	struct ft260_i2c_write_request_report *rep =
 		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
@@ -673,8 +666,10 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
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
@@ -690,7 +685,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			  rep->flag, data[0]);
 
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
-							   wr_len + 4);
+							   wr_len + 4, bus_busy);
 		if (ret < 0) {
 			ft260_dbg("failed with %d\n", ret);
 			return ret;
@@ -731,7 +726,9 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
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

