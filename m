Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680678;
	b=15M8LQq5W/UV1SIXK9O/5UMOd1x0m4sq2FtYZxSFj/7Fhir+FKG4s4wA6+jV91LUhHwO
	 KDCiFO74m2S/20jXFA7C9HEsD4Qc6iALpe73rI0k8tnLKm7DjE/oQzhsS5VfgLG+wu4oG
	 cN1+g6e8DYAFfIMtlNW+PCzLVaiN5mrFS+KwNYLFGMMRb5b+BzLPCMOkn8nRffBhC3st4
	 9i42jg3+N7LJJOt0SME1rkQLoXNNh+EGna+j23Xsv7KPNDPtwmlKqYOgxqYkF3s1SUhWp
	 kdI8Mtx8KOs5u7nbnlDSorgUBu5G4QKMIY2pLjUzkSCEKYivhlyjEcQd3FQHX2yLK1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+m0KRotnRI6Y4M0Q7c+lnB20WP0kpPO3hQuPyKu7qTg=;
	b=QfctJCQmblnCh5TAJDG38YkmO5adVJ01WWyoTY9ldzh254RWQK8vX6xUSw3Q8XyLVM4a
	 deAWVQHgCjVUJDXisUh+ldvKjO2ye5JrG3qwiVS2imAqEs8eTCQJJl+vF0s/zhSrTb+ns
	 0enUZ79brqGOZMBMV2u8jj/kpQIeOStm4Mjmnyc+EUuVar3I9u6zj5xXoAqy5ua32y1Sj
	 sG1iTIvHRzIoLMqTEyiunvExVkqfKgDerFHUGumRyFjuwS4YxxO5SGyjPDoI15DRwgYIR
	 oHnlA0q/79ooQ8zLZ53TXaDJCM1s0/ruiE0bciWKR5yNdGaJSQUwEoI1uspeN7OzcOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZKpGzlmX;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EB1606A32F
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 04:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16EB1606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZKpGzlmX
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso1327252a12.3
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 20:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793680677; x=1794285477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+m0KRotnRI6Y4M0Q7c+lnB20WP0kpPO3hQuPyKu7qTg=;
        b=ZKpGzlmX0djeNLrXuX9lTpy2ii6SP/KxxSi6BOaEFbrjgQBU3M2vDz2L4c67FfPral
         JfFDWMhXs1qA1QUSktgnWBvfFFLuvqdgkCOFmwIDZwxycU4385176BZckVSjX/CqV7ZQ
         +wfL45iXhYgGfu3vN5nwL+d1+dOh10dong9Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680677; x=1794285477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+m0KRotnRI6Y4M0Q7c+lnB20WP0kpPO3hQuPyKu7qTg=;
        b=K+K5pxSxhf42N5y2zP3EM+rIaugnbymJ5wIJFv5QyD7ECt31dU/lfIADAEVGUXK1Gd
         Qs9KCEEXszWG+VlhpkRSTp8/R/+mIpy/kRzTLVtEPyqV+MoB1DjdgcQytnqqJB9dsqEq
         rh1mhVbzzDlYnWA++gnaO4LVWkJ9u9jRpxiyDzCcdDFp54ZF5vi23KrebNNU8U71UOcE
         fog++tdoch+TEXZbDx7V7YtcL1qzif2zAEEMQ7Kkt3+vNtHzGO64pNaqoeOkDEq9hal5
         2CQrJa6DUKppdkp+6z77uiDPqBWbqTevjLsF1Q47lujn7cR4Zn3WDMK4C2v7NqIEfT9Z
         HP4A==
X-Forwarded-Encrypted: i=1; AKwUvByOjVFQQapY7g9yuXk/2cunriKdxyeiL9G8jQMmM3uTrE0PvjHeze6jSQ/4+z4lXfvoURli3ROzl6E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5jmEcL4H7RlhyIP3DZBhZ3DBN6JEIYqdIqc66kB4mwmMJ/xSW
	Z+0aZsA3SnCt4ORCW6Ggacb3rVJV8jyRg+aLoKpBb9nxoI/s91azz5j9BDycoYLtCA==
X-Gm-Gg: AYBFou2LiO2QePPdLpAzCjjXNF9AMBKjxmc0RaH0Oq/4VALSmY0D3Z0s/TR7Y2vHNYE
	DfqC3SmPpKekuIwsZSUw9teBDPPNJC1+cWNZ0cYfex57Wm2s3KzJYiiiYVMrxdLC3fyTbJjsas0
	yKHYlooP13IEOny9+DuG40Un7U1vOZPvLFzvi4hiO+Sjs7pjMk81M8doncmnAbAywVg66yLVXnm
	taG9WfMeA2r2JNTFxE4gYeWkomEykOtUdxOiEp0y6i6+B8+58GZ7B7WwaWjJXwMqv6wr1Jfwhfj
	0B0rxVQiUmpxPsLkeBUnvoJg8qE4BCjlm6UrW/7PM6gkR2IHIxxsPyHbCZs9DNADKXkDR5AgUC1
	buN9tgIGKUn0LT//Xc+5O8Snt2orCaFWa0jIBY+K2Nk3T2jYhHZMppMViYH+rvMdrq6PMYFoiDf
	2fUNh3LxybMsGK403ZLmpG/xdzrQ2aKAR8K/4+EL9tK94tFBb1Z9Xp8mKqlEQtIdVf9zJuWy2Xf
	6iytq6EulTxQWsbQFTLR1JTek/OyMIgtYPrp1s9yjVmH01VVEjSgFBc3cqNqwu1y5sHrx3fC+Hn
	Z2r4r3LJPknnFuR54D9wFgeMOsgr6aNiGqzlTCkEPAS+O4xWmBKJPmqB0PGCb5yqgokt5RsNqAS
	e4HFtdGqyNS/l
X-Received: by 2002:a17:90b:3b51:b0:3a0:cbe2:9e0c with SMTP id 98e67ed59e1d1-3ae897c8800mr10534419a91.63.1793680677425;
        Mon, 02 Nov 2026 20:37:57 -0800 (PST)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:dea6:6326:4502:bb8b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c71c253sm2072761a91.16.2026.11.02.20.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:37:56 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/8] HID: i2c-hid-of: skip post-power-on delay if powered on sufficiently long
Date: Tue,  3 Nov 2026 12:37:27 +0800
Message-ID: <20261103043734.2179858-4-wenst@chromium.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103043734.2179858-1-wenst@chromium.org>
References: <20261103043734.2179858-1-wenst@chromium.org>
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

On some devices the HID device is powered from an always-on power rail,
or the power rail has been left on by either POR defaults or the
bootloader. By the time the driver probes, the device most certainly
has finished initializing. There is no need for the delay.

In such designs, the system integrators tend to work around the delay
to avoid the boot time penalty by simply omitting it from the device
tree. This is undesired, as the device tree is not fully describing
the hardware.

Switch to the new regulator_bulk_enable_and_wait() function that makes
sure a certain amount of time has passed since the regulator supplies
were actually enabled.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Switched to new regulator_bulk_enable_and_wait() API
---
 drivers/hid/i2c-hid/i2c-hid-of.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
index 59393d71ddb9..fdaad451e710 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/regulator/consumer.h>
+#include <linux/time.h>
 
 #include "i2c-hid.h"
 
@@ -48,16 +49,14 @@ static int i2c_hid_of_power_up(struct i2chid_ops *ops)
 	struct device *dev = &ihid_of->client->dev;
 	int ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ihid_of->supplies),
-				    ihid_of->supplies);
+	ret = regulator_bulk_enable_and_wait(ARRAY_SIZE(ihid_of->supplies),
+					     ihid_of->supplies,
+					     ihid_of->post_power_delay_ms * USEC_PER_MSEC);
 	if (ret) {
 		dev_warn(dev, "Failed to enable supplies: %d\n", ret);
 		return ret;
 	}
 
-	if (ihid_of->post_power_delay_ms)
-		msleep(ihid_of->post_power_delay_ms);
-
 	gpiod_set_value_cansleep(ihid_of->reset_gpio, 0);
 	if (ihid_of->post_reset_delay_ms)
 		msleep(ihid_of->post_reset_delay_ms);
-- 
2.56.0.385.gac671c819a-goog

