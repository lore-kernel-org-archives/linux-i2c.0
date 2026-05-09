Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BD522301
	for <linux-i2c@vger.kernel.org>; Sat,  9 May 2026 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778319973; cv=none; b=RMKjfoNnjCTVbh9UOqpn7vFjvn+jnw+Lu34VdeNWAQzYeMUYlDRvnqKfBaDHcfbx3DJ4yFljbRYuxkXs4ggnDc+ZlmNiI4LeV1dex4R8kwL1wSMAJribLDBQnEJGVgcH34JCO5dqEydM7qq1vA79J0BFWZJUuBfhNYeOCTCSR2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778319973; c=relaxed/simple;
	bh=6hSvrC6JqtJ3Ll+ikYPnEBdS7T/Rm4O1cnmAAUY5IGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipWCFmnw2wNTsZ10GVnDITnJFeMVJ6eWe9lrymEJKYBcfsUQl5TVuJyFu9fEP7eLcDMDkmr9J8SSG4cA1jXL0Wo4edOVfb6QE3YPfIB+fYGEopjVH244YmssKBaloB/A2Gonl16hsXU2CkZhCgmX9JeF6tSwtSIc4duvXpnT6NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+FuX61f; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+FuX61f"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so18149095e9.1
        for <linux-i2c@vger.kernel.org>; Sat, 09 May 2026 02:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778319970; x=1778924770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P7U/T5gN+6tbPfvjxQ18soHxdaMsEpG40WbKeR8e5d4=;
        b=h+FuX61fPQHt0vJlFlHoj9721+CKDqKOPvCSDgwm5GhtigYjQ/tphPAeIQbM0tCcj7
         rYPD1unMBX82/TPlEzKrxb9IjjGaSXejSEIk175fA3Hi+38CEVK+LIqLMFLFBlEIWXiB
         xtlp3veZ+rbjJg0UsLspwnLoalvxb1PToxAFFaqshdwFBz9JGaRHS3TNEpRBpd2WZ+Zi
         GMcFRrdZq/Gw7F2+xTMX/1A1xv7HP89y6cefCy4kEumi8blGgLtuSa6sTQ1Cv1HKyE6y
         WnY/1IYj9g2z9tWcGsYuuVS//wio47fYeFowdup4crSSntNLikrB2gwNo+8MY4u3eRw2
         4Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778319970; x=1778924770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7U/T5gN+6tbPfvjxQ18soHxdaMsEpG40WbKeR8e5d4=;
        b=aj5LvpVNnksjwFdSQ1bE+yCFlBku3yfBiO4G5ieDz+WoQdc1cO8YIXLZsGab55k4df
         1+KEgvWKjxPK6DncrIk8KQ5vm0Ge15tkR3nU2x/28bjjpkMXUkeSs4vxHOdtNrs4oTs4
         tCYa6CdFodqL4ZGR0dni017A3dI7Hb9iDkkYuGmxd4qNmBmcUiqJuQCnsa1qy//Kov01
         IW1M0/vdLuodJRM6M5zelzwjyrgXoSaNhsa/Jh6DgDScfjEXemNY4BLIg/a8gZ/9j1KE
         JJh+2o0x/RgYZYPyN12tzt49IxfK42fu+WljA/Kt+hA69tTIVCdWDp3j6zPFruUB3IWy
         FHxw==
X-Gm-Message-State: AOJu0YyB5zXkG3PQ+Y2ST/w7Elb+wwjl2WhD9Yl1R+WkfyRasLXOKOlq
	FeAumDX88Jp/NAh1zNVjXOG3q7dzvpcRy2APdMfnrOrC9bQ+k5FwdU50
X-Gm-Gg: Acq92OG5tJpR9RLAgq/gME5jKwxT25nOC0XSKPktTOSFdUND6uHE0IvEy9jJa2lGmj8
	P4NOOSH586p1Q9+dcZ5PAtZOvs4LknDIXaB/Aq10SqJqeYZCXkxPB/dNp5I1jMe6bZaRnZc3w6W
	8tzQTHbivczduw+K3LLbMmKU+f7e4GY1t1iNwtFOUMIdK6feETaYObMJeGUruK+KD9S3mpC05jd
	lTB3OdHpSMPn7w/M0ZMUCKac6ynOTGJs9CAF+4rEjNTXhWsfrG2LsaOAWgojWtWN26BlFuu1ghs
	9Y3XLl/WZOYmrTM2bPch+jQPGutk8YHj4hISf6I0OhqgmZSfhF1NUzMF9zhwWw5KAhBbWCMUgBK
	lTScJNEzsCrTKThXzXrnj6pJYs4nD41PcoO37q/FO+Q8HM/S8BnhXFd6wnY+gls8lvI1cv0Skao
	YKehtu8YypCw==
X-Received: by 2002:a05:600c:2219:b0:48a:5ee0:7781 with SMTP id 5b1f17b1804b1-48e5e007218mr123817685e9.16.1778319969794;
        Sat, 09 May 2026 02:46:09 -0700 (PDT)
Received: from ns3242901.. ([2001:41d0:a04:2e00::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491ca2fd6sm11224669f8f.30.2026.05.09.02.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 02:46:09 -0700 (PDT)
From: Florian Pradines <florian.pradines@gmail.com>
To: gupt21@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	Florian Pradines <florian.pradines@gmail.com>
Subject: [PATCH] HID: mcp2221: fix OOB write in mcp2221_raw_event()
Date: Sat,  9 May 2026 09:45:17 +0000
Message-ID: <20260509094517.2691246-1-florian.pradines@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mcp2221_raw_event() copies device-supplied data into mcp->rxbuf at
offset rxbuf_idx without checking that the copy fits within the
destination buffer. A device responding with up to 60 bytes to a
small I2C/SMBus read can overflow the buffer.

Add a rxbuf_size field to struct mcp2221, set it alongside rxbuf in
mcp_i2c_smbus_read(), and check rxbuf_idx + data[3] <= rxbuf_size
before the memcpy.

Signed-off-by: Florian Pradines <florian.pradines@gmail.com>
---
 drivers/hid/hid-mcp2221.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index be80970ab48e..e4ddd8e9293b 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -128,6 +128,7 @@ struct mcp2221 {
 	u8 *rxbuf;
 	u8 txbuf[64];
 	int rxbuf_idx;
+	int rxbuf_size;
 	int status;
 	u8 cur_i2c_clk_div;
 	struct gpio_chip *gc;
@@ -330,12 +331,14 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 		mcp->txbuf[3] = (u8)(msg->addr << 1);
 		total_len = msg->len;
 		mcp->rxbuf = msg->buf;
+		mcp->rxbuf_size = msg->len;
 	} else {
 		mcp->txbuf[1] = smbus_len;
 		mcp->txbuf[2] = 0;
 		mcp->txbuf[3] = (u8)(smbus_addr << 1);
 		total_len = smbus_len;
 		mcp->rxbuf = smbus_buf;
+		mcp->rxbuf_size = smbus_len;
 	}
 
 	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 4);
@@ -919,6 +922,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 					mcp->status = -EINVAL;
 					break;
 				}
+				if (mcp->rxbuf_idx + data[3] > mcp->rxbuf_size) {
+					mcp->status = -EINVAL;
+					break;
+				}
 				buf = mcp->rxbuf;
 				memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);
 				mcp->rxbuf_idx = mcp->rxbuf_idx + data[3];
-- 
2.47.3

