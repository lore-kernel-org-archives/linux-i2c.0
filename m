Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945917;
	b=z4Lkh/cwGCZZ0/WjRnWPxjB17bhWM5ebvX8ALLW93a4ROytHfd+e729JCBxkXJZgakWc
	 sXUoaZa8CfMjTC8giNbbUPLjYeDOX34M1tVpTpgUBKDLqCwP0ZEiY6QbNpN5F/lzBShQ3
	 LTildjSbbzttMjn+4MUoyZ5y+PcQKrKErJtUMueu0tcW1JvDvVznTGjkNaNT8B8ZQi+OP
	 14g84zYA/qUdwlmHfuQqk3C8tEJG9ZegRsiyszp8b2TkUwywJmENkaoI5uXveI+EFS4eP
	 +8irdwL/ErTfsP/OosRAcx5+i4tG4iernY3RBzqSVHBFuPAgRYqx7W80fIhrqOtU5pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oQ6kVNTKtHM/GlFIwNb9GkcrSJOUH3g4l0nbt5E8WPg=;
	b=afpezMqhVJSvkSpAEOGNnhy1F53QsWkVIM8isLnMOCc227FEt/ZfMfyIoJw4NHyL3iem
	 8DVgf7eN/nRd+EBn9uK8SMLa9/io1a2EBDGIgujb7YU6WK8lV0NoDM2Twwk25zxm9hYV+
	 GGgJCHQrxUqv6X1yBARrlbTw2xkkuOrM8Kehp9DIf8jMwluQvjqkU0ileuLEMdZqy9b+t
	 AodKlVuZAmVW5f28in+rbzg4Vld2fAKRJMsx4RtKDa7CGRwaiUCjcLZv2G863id44HoeL
	 6ZS6/T43Wf2eRAiCvq5E1q9WkRnDFY70e8OBU3qtkDEGrqzVyIiBm1uZx7nkw5zO8oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SUyVBPRK;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC260A6F54
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 20:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EBC260A6F54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SUyVBPRK
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so158599f8f.0
        for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 12:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945915; x=1795550715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oQ6kVNTKtHM/GlFIwNb9GkcrSJOUH3g4l0nbt5E8WPg=;
        b=SUyVBPRKvlIPfyyfb6ETZn6Oj8b+gAXpZ80SFzVZXHh1crDmixmj41Va2EnEXc8FOX
         9f98bIqfQM1Xa0Nksu+TZxCa+HmDaHxPppk8Y9ZM+BDDT1f5poSw3b/+kgZ/mIS1o2UV
         sWTKIA/hzmTGVe9vcRqtxbiZuKWqmGihhxzWNTxa/SicsmYe9eZeE++3LR7L+cKywBRo
         QiDIJxvRqORTekCjEsTfNBMPXP3ak0NIm3LBwDpSSB/pdziXocUb45WHMc4uJySF03eJ
         dKZuF+UFj2Cd5sKkR+fLI0RjiI74dwW62oojhyG9zJmBaNMS2UxMqjwXTBQQyD3YovYj
         0gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945915; x=1795550715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oQ6kVNTKtHM/GlFIwNb9GkcrSJOUH3g4l0nbt5E8WPg=;
        b=u2vhBlmPE4GpARsCZarq491bGXzxrPCDi2DQnFHuOZQ52xUbQtmwGFI0MA+E3fHAs6
         Z6/ryztJkskgeN5DTUbG4kW/5x6UaesCeg7K7E6EtcHlTIcy2FwWwLBR41Fga+lZqtSI
         vOD34QZO7yoxorFzBblFq2nnD9UUEp27O0u3NT7MJf32/HrTZSSkWPO33bjDmEowc0LJ
         3zLgJBtZ4TWM/6j7Uq5FvhnjvhjoDUYv8dhHq1WQSbEM5Uf+bUKJAKXYvJUC99+IUqQO
         3GSjO82PlaYWnGk/NmaB4cZq/6VjkAOHssu1LnVibh/t5DVnOP8Z/tAk0gN/H0uGXIQo
         HiTg==
X-Forwarded-Encrypted: i=1; AL+hErErb5s9YLsLJiYRrvwk7L9JZcmChKjwzvnMfz3ddcQ6NzjfOhnttx/kUAzduVd4V49fhUU6n1OMdCQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z84KFH2v/KklruoAU+ucRYKBOix609NcOL4pzor1FuyaFFpjMKA
	kvuS2TuZngfN1KlTSlD+bAWrzmhRQ/CNFds8o7v2G6Apo71VGMMGZHhXueJAZzhq
X-Gm-Gg: AZFdTZfAZGfKfVhn+ZFdfSnq6i5nW+Hchdgo62dyHpLg2PveLTo441/KDWlfCVGSzGf
	Dj492F/Md4WEy7B1PY+HxrKL/3nxeNYTJApdXcsvW1/axPDlgiIq41cdEKbCoZ2VD6VLguIS/oZ
	mlNHjJLQJ8Ogq0S8wvv4bxAIc6vY8DKeyqfIL44ZwpcwsfvUqqEIhGbn6o343dODGYvQkxrozAy
	BnD9CZOnDNBXbl+0XDxtn6StBD4aKwyg4oKORjWFSaXlxAApMWY9pT+uXpoWZyPKQFcLmcjeMes
	6KMcXaZ7p9TX9AI1a2kKN4nL9OG5TJPq5W0ZJ4Y2WvVEVnALFoU0miQJ3gqQNEsxNilYnt8C1m9
	YkzHSnyR/RBfrnY6qqrJ/YaxfsojB6HLFBNISYkuTx+AfzTOSnrPtbdmQOjIDw7ziM0kD4DyZiF
	mupDP6v+OjQ/ep7UG6NApNSRHd4cwGjCCiWFCivA1eargVJWyOelR3UeRG0vKG0oEA5JMf1glte
	a6cgrLMZh/pN+q2pfYnViHOKSETSElx83o45cgmwMb0D2G8YxZU23ehtBENkGCHEE3EVr/BUGIm
	p5mpNECYPdMhbCRoq2yBTEQb1x84
X-Received: by 2002:a05:6000:4555:b0:4a4:7328:21f1 with SMTP id ffacd0b85a97d-4a63ac6be9fmr782897f8f.24.1794945915115;
        Tue, 17 Nov 2026 12:05:15 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:14 -0800 (PST)
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
Subject: [PATCH v4 06/16] HID: ft260: i2c: reduce bus-error message severity
Date: Tue, 17 Nov 2026 22:04:12 +0200
Message-ID: <20261117200423.19561-7-michael.zaidman@gmail.com>
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

The driver logged errors when the FT260 reported an I2C bus error or
when ft260_i2c_write / ft260_smbus_write failed after such a status.
That was meant to flag unexpected failures, but bus scans (i2cdetect,
HWMON discovery, transceiver monitoring, and similar) hit missing
devices routinely and should not fill dmesg with lines such as:

  ft260 0003:0403:6030.0001: ft260_i2c_write: failed with -5

Keep returning -EIO, but print those via ft260_dbg. Still use hid_err in
ft260_hid_output_report_check_status for actual HID/USB transport
failures, which are genuine errors.

Drop the extra __func__ from the write-path ft260_dbg calls; the helper
already prints the function name.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2:
Fix for the issue reported by Sashiko: the write-path messages
printed the function name twice, because ft260_dbg() already prints it.
---
 drivers/hid/hid-ft260.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index bdd55b35df9a..f722ef0ddf06 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -579,7 +579,7 @@ static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
 	 * to 1, bit 1 is also set to 1.
 	 */
 	if (report.bus_status & FT260_I2C_STATUS_ERROR) {
-		hid_err(hdev, "i2c bus error: %#02x\n", report.bus_status);
+		ft260_dbg("i2c bus error: %#02x\n", report.bus_status);
 		return -EIO;
 	}
 
@@ -613,6 +613,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 
 	ret = ft260_hid_output_report(hdev, data, len);
 	if (ret < 0) {
+		hid_err(hdev, "%s: failed with %d\n", __func__, ret);
 		ft260_i2c_reset(hdev);
 		return ret;
 	}
@@ -652,7 +653,6 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			   int len, u8 flag)
 {
 	int ret, wr_len, idx = 0;
-	struct hid_device *hdev = dev->hdev;
 	struct ft260_i2c_write_request_report *rep =
 		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
 
@@ -683,7 +683,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
 							   wr_len + 4);
 		if (ret < 0) {
-			hid_err(hdev, "%s: failed with %d\n", __func__, ret);
+			ft260_dbg("failed with %d\n", ret);
 			return ret;
 		}
 
@@ -699,7 +699,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 			     u8 *data, u8 data_len, u8 flag)
 {
-	int ret = 0;
+	int ret;
 	int len = 4;
 
 	struct ft260_i2c_write_request_report *rep =
@@ -724,7 +724,7 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 
 	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len);
 	if (ret < 0)
-		hid_err(dev->hdev, "%s: failed with %d\n", __func__, ret);
+		ft260_dbg("failed with %d\n", ret);
 
 	return ret;
 }
-- 
2.43.0

