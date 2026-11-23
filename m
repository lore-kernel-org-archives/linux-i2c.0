Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424076;
	b=OFat7DbDYLFHZYR+647Z+WxeTRwLRTjzAv4UlcDJZU53B8f4Bv/E0Sba3ohw5AicmCfk
	 u+co2rQl7HE/fAUep+8Crs7oat5ZefPtaa3JcwUiwcqvKp+8RZW83RXtQxyQDFSTZehbJ
	 lYom09FYa+DuNj7ndORaGnx5DsDJGHKCujw7W8WvvevO/l72iEInaMavdS6OpjQRR1hEV
	 YBj3OMfDxhu7yTCwv2aeJEy4S4rfiB2KHfZL5xSFXdkvo6iY5rWMuMfK1M6Z2CzuFXq44
	 KYDz65mWkxkLWj5MAdwwp2TbhEw2rNGqqPwYjB9pQB9wO109P9fmJ9BWUVdLmb+KPRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QamzTu173meryiVykuqXvUnX9iKBK1FbtEwYukzyOTc=;
	b=Urm6U+0Snz8aUNglcDG9zW/V7yS0dqA5e/jbABGD5m4adekZ65pCJ2LFyyvQJrZrfXSv
	 QuWZWOMUcurp6gRViUr5iLbjTREd6dQw53CRz3VUBtiF6CjDZwi97AUQf8QaWRo6lqR20
	 MPXWMRU9lZzmmmL+a59XMQaK3Grad1Me0V4UAeFzY5nFKUiP/whC4HYs3q0pTzqZnuKdm
	 njmC8iQ7Yt/RhfZgDOHpDgpm44KisAZzuKel7XsCqTNbdEhPlTEBrQ49KWg9Ku99+e0Sm
	 6FHw83XVYTwr4SLRtsnO/44V/phVGUHouVvWhIze//ijZTCymkMQAYaJ7f/+MjqVarw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ocMqLHet;
	arc=none smtp.remote-ip=74.125.228.135
Received: from mail-ej2-f7.google.com (mail-ej2-f7.google.com [74.125.228.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D1606A32E
	for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2026 08:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 743D1606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ocMqLHet
Received: by mail-ej2-f7.google.com with SMTP id a640c23a62f3a-c505c4d8ba0so122523966b.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2026 00:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795424074; x=1796028874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QamzTu173meryiVykuqXvUnX9iKBK1FbtEwYukzyOTc=;
        b=ocMqLHetxUUEUvPJlTmVpsJ6tVylhUi/vDrdR+NMBn/6Jx805uiETf0acB3VFi9qkN
         tMxIn1ccKUWOOR3NvLUglwwcOVO3mJ+BNzr21sl4jHerx++kT9OoRsy/T7f7NRjz8bdQ
         8wMBEaGc/H0smdUH1gpfg5asH2xdyY2v2r4u1FNxTtPPXiaHiklerTstDrCqbCdFezDp
         Y8eJDzf2VwOZ2SdIVWUmp1XvEHzty/Xlg0xK9EA/LBZSfGkgLTlxIXMRGQDy4qfu3gCR
         vBlsMQEob4hxG0na0C7nsk8zMCysJoQPEpj4acZ9U/q8rPxAuwkFIa0ZsieYbaN/BGxv
         QFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795424074; x=1796028874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QamzTu173meryiVykuqXvUnX9iKBK1FbtEwYukzyOTc=;
        b=YUAQ5Q/135pw5+/ntA3Vrz7ooHVRTWtWUfm9UhDi1GAiop1rryYtgYXuPLgUkQFKIF
         z8qIPNR07j5/kD97kRXYA4CfzwhsZ8ZdVm1g3gfY9Lmz6ZA2MZV1dQcqtRaEIGhLT4Wa
         Id5XjcDEYqIdqbdnO1TJf0BKZAEZJT1713VVPBk9mqPyOHDt1R30jvqt3L2GMUZpZj+t
         m1QZ/LXH6NgYt2i2C12xS46DZkOHqg70BEvOf7qotfaftC0RTxJ3DKkyeRp2eLbGxY+0
         kCUkxrnqkvtCoVmOMsEYiL93PJXEc3Y22H590sbVBdpvtu0oh5hkGs7CXRS3u7pKch7b
         vAgw==
X-Forwarded-Encrypted: i=1; AL+hErFjlyzsKulbyEPP53EnLCXjiAG6fGURMMvOyFHSaW60rjjC5LQhvLnXhRFz8GBAysIEk9SXXw4UDCY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JAUeFYxoEB3l1wgE5JDIr+Yzsh18gmdR03jaHzxn7CcZuO0G5
	ed2REHRkEf3e3uWRu+laQ7icndXmPKoTZEjefl1FCJxWamoUAlRpMLfT
X-Gm-Gg: AZFdTZdowMsK0/ycqLFg9TRR4JpS/Sc+hXqxWCsTyHBkR12QH7tByXRxN1r+RQLmEhl
	8NsRGhexdZfE4xXqwJ6eDhEnoh/DvrvY2l5s6ZzJ/eXk4RV1K8q9NRyZzlgUIla1Suo3wcK2VqE
	FzRimMHp0MAcevLRH1Gtadh0f5MEwTO655KkVsXDBgwhQtJYp1TdpAdTm7+WczujiwNHx4IaelG
	uQAnKz16+BujKKTMlHJ2rRw/M1wRfN29RK9NbfVbRKgr1Gn+tVquRgomee9T67V4zqoMR5U+LbP
	ioXuqYdkFkquJsa1Q/MfDQ1fl6F0qrjZBqQjaUZtOzutvC4u8gy1O7EqyYAT1R2vHoMsnklh+yy
	ceMdK7gFgdYjM1+asGdyNfPQ5By0qHmNcRsyvsk8H+O/U+lYRLc5U2UigToQh8rQGIsqqBoonB7
	MABZySdknGvj4slF/KGD7sTErx1rQXNcmwtZ7mjw10XaJnZqI4EW43115FIKdjIQlMUkpaKtC8d
	O2bNnNJkipcKuX0aPve750JzInC6sMxvJfeA3Q35q25j8AMgNMqCPmgR68e68RimPbPVYKGU3FK
	VnfF/sHQzeiWJvUZdkB+B+zO+eV3gPjZBmHmpIrLZqH9KTwRxJQH1dAVUTyHdEhRftnOYPtXXIP
	4oKe04RuYU5wstTmESETiOqNHdTy0B/rH2h9kuF2/svwm0ZXEdyIrgIRqnG8gjscxCEekQs2Hgk
	b0Pw==
X-Received: by 2002:a17:907:6ea8:b0:c51:3bde:bfd0 with SMTP id a640c23a62f3a-c513bdec070mr821979266b.47.1795424073497;
        Mon, 23 Nov 2026 00:54:33 -0800 (PST)
Received: from thi-server.fritz.box (dslb-092-076-092-047.092.076.pools.vodafone-ip.de. [92.76.92.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdf022sm377880166b.67.2026.11.23.00.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:54:33 -0800 (PST)
From: Thilo Zirnstein <thi.zirnstein@gmail.com>
To: michal.simek@amd.com,
	andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thilo Zirnstein <thi.zirnstein@gmail.com>
Subject: [PATCH v5 2/2] i2c: i2c-xiic: fix waiting/clearing while atomic
Date: Mon, 23 Nov 2026 09:53:52 +0100
Message-ID: <20261123085351.3415122-4-thi.zirnstein@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123085351.3415122-2-thi.zirnstein@gmail.com>
References: <20261123085351.3415122-2-thi.zirnstein@gmail.com>
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

Use non jiffies based waiting functions,
if in atomic context.

Suggested-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Thilo Zirnstein <thi.zirnstein@gmail.com>
---
 drivers/i2c/busses/i2c-xiic.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index c5693135d820..2f0aa341d89b 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -237,6 +237,8 @@ static const struct timing_regs timing_reg_values[] = {
 #define XIIC_BB_TIMEOUT_US	4
 /* timeout waiting for the controller to respond */
 #define XIIC_I2C_TIMEOUT	(msecs_to_jiffies(1000))
+/* timeout waiting for the controller to respond in micro seconds */
+#define XIIC_I2C_TIMEOUT_US	1000000
 /* timeout waiting for the controller finish transfers */
 #define XIIC_XFER_TIMEOUT	(msecs_to_jiffies(10000))
 /* timeout waiting for the controller finish transfers in micro seconds */
@@ -359,16 +361,28 @@ static inline void xiic_irq_clr_en(struct xiic_i2c *i2c, u32 mask)
 	xiic_irq_en(i2c, mask);
 }
 
+static int xiic_poll_rx_empty(struct xiic_i2c *i2c)
+{
+	if (xiic_getreg8(i2c, XIIC_SR_REG_OFFSET) &
+	    XIIC_SR_RX_FIFO_EMPTY_MASK)
+		return 1;
+
+	xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
+	return 0;
+}
+
 static int xiic_clear_rx_fifo(struct xiic_i2c *i2c)
 {
-	u8 sr;
+	int rx_empty;
 	unsigned long timeout;
 
+	if (i2c->atomic)
+		return read_poll_timeout_atomic(xiic_poll_rx_empty,
+				rx_empty, rx_empty, 10, XIIC_I2C_TIMEOUT_US,
+				0, i2c);
+
 	timeout = jiffies + XIIC_I2C_TIMEOUT;
-	for (sr = xiic_getreg8(i2c, XIIC_SR_REG_OFFSET);
-		!(sr & XIIC_SR_RX_FIFO_EMPTY_MASK);
-		sr = xiic_getreg8(i2c, XIIC_SR_REG_OFFSET)) {
-		xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
+	while (!xiic_poll_rx_empty(i2c)) {
 		if (time_after(jiffies, timeout)) {
 			dev_err(i2c->dev, "Failed to clear rx fifo\n");
 			return -ETIMEDOUT;
@@ -383,6 +397,12 @@ static int xiic_wait_tx_empty(struct xiic_i2c *i2c)
 	u8 isr;
 	unsigned long timeout;
 
+	if (i2c->atomic)
+		return read_poll_timeout_atomic(xiic_getreg32, isr,
+				isr & XIIC_INTR_TX_EMPTY_MASK, 10,
+				XIIC_I2C_TIMEOUT_US, 0, i2c,
+				XIIC_IISR_OFFSET);
+
 	timeout = jiffies + XIIC_I2C_TIMEOUT;
 	for (isr = xiic_getreg32(i2c, XIIC_IISR_OFFSET);
 		!(isr & XIIC_INTR_TX_EMPTY_MASK);
-- 
2.43.0

