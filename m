Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F118E025
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513007; cv=none; b=fPfi+Il8tmv9NpG+Uw2qxlNzAfMgRSzyBh3TL/oZKG1NYdkgd0vpGbsNVBxUc2I3wpnWb5gSEE+zpkj9BmVN3R3maTCqhnokRJEHok0HrW+0Xoo4eOrOYrAEUFOImnW3NB7S4Ya4KkvxoSqNaya05FijSxX7wpbFE0kivvE5Zac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513007; c=relaxed/simple;
	bh=utkdIrJtEC44DqqTUyxORrRSv5x0AbtRsT4oMW64lXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LoHY+LXJEIFXaqP8TAbFjDI6KA6sPoxeyhlAprP8TIpq4wLgs48gXAf1UDSZk9auBQ6Wc2F4PxJAKJ4k9gxO97g/qQAy8kSWuUMQMTZCwi9ORG7RJb4UnXvok5k4LgBqvCutzUA7dv9XaAJtJJjCI+ztxpUO0HQ0k38506kXU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUfKUlhl; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUfKUlhl"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so552022e87.1
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 05:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783513004; x=1784117804; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mUX26WpwvVrJFwxAmnUDIQNXofqL2zgl9QzvPbM33SE=;
        b=rUfKUlhlNbiuTMxNVZH9eKnKn4ZbdZuIIcXCpoYsBCMbRTxuUKLRU+6UeP13tPWWcD
         HcQ1EF/Um38cdurGqUtpV99Whhm38xzH72wazoGlceibT6NTbfHyyUQz9e/E11WCVPb+
         +pVuK/vo0CDKv+w4u5dmTzW3Y5UR/PwEzDfT83h37vctpG1xNjQRuojyN6xaNXAA3pV9
         fxDe+oqzeA2GNlcQnJRkBSPCsBmOaIhuXhkRs8SpOSrFF1SnHvL/e0Zx/obqjXjP5oWe
         ZsZWTC2dricbQoE0Iuv9GORmzROHv7w9EswhJXavSY3E9dqH3ksdPdvn1y9VrtPe16eD
         HpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783513004; x=1784117804;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mUX26WpwvVrJFwxAmnUDIQNXofqL2zgl9QzvPbM33SE=;
        b=cWI0ToQmT+apI87ub246bk8sovo6RUsQQmZN8AECCHyaXGqsKvhF+yqksp2aUyfkl+
         Gey+0bb/Tz5a41lYk2h/jlnyXaS6VGDIEbCRPTVxkQ/U5PkQg24Uy2N6FTd38FgaQW0H
         poAOq+mT1xEsOS3SgiXeRQ3DKDT/AduvIewMtME+8uKgaQuKsxDnjNYp+SWAyD8geE+b
         rF91H1nLJl/LWBg++hPb9aY77HWZVEXY5HMKnnx6tjN1J+d4cVFxXktdqDRPJc6DsT3r
         odokKXq78h6NgYO/5enkixNVnw+T5RjeHAmYnC0ZmaHSYedDiYRF/26NjStajEFdliuW
         604Q==
X-Gm-Message-State: AOJu0Yy8JhciB7RB4qEgEMoacHC7+rUn2yBh641o+kAdUUw3oxnzIJD9
	vwhucak7QpUmkrj0HghBKMKha9vHGKPeZ6PbLDEvNu0VE2CfjeG9Q+U5
X-Gm-Gg: AfdE7ck0j1bPVJKBO0d6aR/gtmnd7IBGXjRoy7AbC/YFJKhzXhIhHCtdN5wcUjZuiG3
	sXh6lp0PL6/UV3vf36onJQRBamZ2Vr/I02krCalcsHuWkVw7ispZcajrBV577jPk6gGnRKJY+kC
	sa9j9nYSjtBGS5kY9xUbO8RmS1IHrA+q404XhTZHyJ8E+UE8s/KW6yD2YRdc/mmVc6Crgk4t3ap
	XsWdcVvSYADBN+AhueSmzwXtDoBbAbPMfgcF8toWYGJh4zCBDRyBx6mHBhrPWjW5FCjZ5UQXSCl
	ClpXRccVEqJFAW0Ftb/USct0O8bDsJRhkG/5ZVZ8yhzBn1qioZD3Gxjc+Kmbhox6gQbznePQP0x
	kAvb0OHZAP+Q8Te/s/pYhbnS3Y16xn/JolIyDJSzuCzprAy89vpA50Bif9LF993plw6RVCKqCwf
	cqFeZJ6EOoz6odLqmXBXHXrT635qjjTfNiThoGaOvg5c4o5LX3u0gdo1/9VQ==
X-Received: by 2002:a05:6512:2305:b0:5ae:bd53:70f6 with SMTP id 2adb3069b0e04-5b011463cf2mr624254e87.4.1783513004130;
        Wed, 08 Jul 2026 05:16:44 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bbbc6sm4471459e87.41.2026.07.08.05.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 05:16:43 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 08 Jul 2026 14:16:13 +0200
Subject: [PATCH v10 1/7] i2c: core: add callback to change bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-i2c-mux-v10-1-09dca03c8a15@gmail.com>
References: <20260708-i2c-mux-v10-0-09dca03c8a15@gmail.com>
In-Reply-To: <20260708-i2c-mux-v10-0-09dca03c8a15@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Peter Rosin <peda@lysator.liu.se>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=utkdIrJtEC44DqqTUyxORrRSv5x0AbtRsT4oMW64lXM=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqTj+US5C5h6YJPHKyg1kXnT7uGDQt41tAj01+Q
 Q/k9ARFUR6JAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCak4/lAAKCRCIgE5vWV1S
 MgC0D/9EB/lGjZgB6dbelePtnyOsjC2haV2h6OkN2vGF0Nu+yPgaGMEOAcv217k+w4byZn9re54
 62OQ4lQQ0pSD0/329QijKx2ALqdJv1K5zGzjFZRQrRsinZHtwNGF76jFudbvToWsneG5lBy8GXm
 6ynHtHO7gj4UjB72ukZF3x3Pa0T7aXJTusds4JqMuOwTd6Mc+mHbFPxeilWiaLyCLB3eTASs1i5
 YhhoUqOY1gPJ+wGylbnGzFa4ldNuokx1vvSm9nJ631PFyQxNlo4iV5ONp/pwimmcSBPiqnkKUOW
 xd1uTKLxRUjK5e5lcINMS1HC+im0h6P3INTLwKuZmGg4cQrPHOoP+g0yy4AfqntAJESqGI+uVa6
 2skTPtFbMov0hZGpW0XKgFDokrYUr4KkxFfy+MdRMdmpjJoUX7HzbtZ1rHNmnfNInNxSllmskJ/
 rtBWfkOYPby97qplgtdgCbxAvFSUwXrw6If679jcqcq+3d/79v0psOSOdSpiA2zU6gqZUoGkZMm
 gE+JBbvDKHOtGiXINcFF8kF7ccAMP66Icr7vnH1CwUxHeTZS5jWQmi97j0S2G6i7Oaca/PCMVBX
 AncZPfSP0z2XDj5fCQ2bCIQyOHdZF3cCKLrZ6TvdApxTumGsEm9xyHB8x8Xp5cAsg0jFJ64aIz8
 oAEbyziSuLOWQCg==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

All devices on the same I2C bus share the same clock line and the bus
frequency has therefor be chosen so that all attached devices are able
to tolarate that clock rate. IOW, the bus speed must be set for the
slowest attached device.

With I2C multiplexers/switches on the other hand, it would be possible
to have different "domains" that runs with different speeds.

Prepare for such a feature by provide an optional callback function to
change bus frequency.

As a side effect, several bus drivers keep the bus speed in a
private structure and can now have this value stored in a uniform way
instead.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 include/linux/i2c.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20fd41b51d5c..c5ba07f03ada 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -729,6 +729,9 @@ struct i2c_adapter_quirks {
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
  * with the access algorithms necessary to access it.
+ *
+ * @set_clk_freq: Set clock frequency for the adapter. Returns the actual set frequency.
+ *      This function is optional.
  */
 struct i2c_adapter {
 	struct module *owner;
@@ -742,6 +745,8 @@ struct i2c_adapter {
 	struct rt_mutex mux_lock;
 
 	int timeout;			/* in jiffies */
+	u32 clock_hz;			/* bus clock speed */
+	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_hz); /* Optional */
 	int retries;
 	struct device dev;		/* the adapter device */
 	unsigned long locked_flags;	/* owned by the I2C core */

-- 
2.54.0

