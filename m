Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680683;
	b=4/lS996RasZrBbzfBeEuoMh/y63fMirdZsdgkCUa7VqG4Hv2z/aWNHZv5d9R+9UsziJm
	 TnhzaO9GH8MNi1yYJjqrR5VMy29orBEBFrbCrUCP+nrZv9TPwTlluySN1ZSvJ63+5FBZS
	 vX//zyH4bdnKlo46YbuLnxvNlpg9dpYQNSPsfH0d0Mc6NLLnah8xxtq3kvIy4LzxMdeyy
	 t2Kgk7mIirBODkgnwzYErEDtmKlhk3hsjBcLzPVrIoAE7DBlDy99T2skbOQMrU04smJA4
	 Ygj90Pgx3MF4Otzkoj8RdvG8MGPEAriq7ZcA0XbiCLQFWMsFqF0Bm6YiKmeurUrgm4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jwXE6HVPE3u8H2VoPGvf+65Nm9Ko3QG6ghTmXH3WIyI=;
	b=5KS1DRHCe5hZNZ4YggvmNUhPFsF12nUe89qHWc1mxUaM2avILyygCDz2Nb3pFoEy1IYF
	 HxLsvgkX3kCuxm5G+guwFenBzJBIBHA0J+xtXI7RzeXIhRrsr3kJI4AY0ux44a2qCU8Z8
	 5UAG/wk0SUSq9UJgB006e8BkgbIo+EsvVD6FOO0L1c7p9TAWI4tm6NIcw56swWoHWyiiJ
	 kG02LB2icy3KYAOB9VvK7rEoaQ8/GRE6OfyiwULZUqNSNEGoXI0iD9o49QnY3mKhiCjYZ
	 raWGAzkhDT7dxuBDG/4jWTnGjk+QK7Putcq4yTjvZ7Dd1spses4lFxSNarZjPyTS7Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=EjfUq8wZ;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E0A606A336
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 04:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30E0A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=EjfUq8wZ
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc502d509c0so1462840a12.2
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 20:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793680682; x=1794285482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jwXE6HVPE3u8H2VoPGvf+65Nm9Ko3QG6ghTmXH3WIyI=;
        b=EjfUq8wZKD3R/dDZ+kWoTopD8ZmC+9X4+EPqk09OXIxHyQJwsEL/xubPSC4orNaHsC
         +j/c1FlnEz1/o3R2o9ojMrNKFQ23qP0jDRDia+XjPzd6TuMFnBBOo48A9RaL8BJ7KaPx
         A1VcrY6HmIkHZq5Rsrz+3DJJmNd4RqZiZbUUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680682; x=1794285482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jwXE6HVPE3u8H2VoPGvf+65Nm9Ko3QG6ghTmXH3WIyI=;
        b=0j2n8NgVccGed+FRj8HcryYNb/5x2zf3ZD++zdRhdbKv6RjyAAfRfBJAaPR0uG4RWX
         XzfTiiiApY1UVMhaDJ+LipDMJkASAWtuUshe+C88ZAisbs4Y8vrzaiec9rLDGmV5tgg5
         0Hbsf0BDguhq3+eghVq+XdJvS8dCDHIeaz5JYjpO2lYvzPcSuJmFAE4qA8YpcsRev+Cp
         hvofIFhFCjOpoNtXQ3DdLPS0YLYMB/2jhsdbP/yDXYBru5chew8hq5KbIv1WVu7HD4FO
         9NXJ7maE7ZK4cDjzITPy3vcJFLwKna8Sg6srtEvq58Cl7aIhdKbOLL2HjAcXupFWo4v7
         Cn+g==
X-Forwarded-Encrypted: i=1; AKwUvBwbxpm9c5W6C/gg/nMocXOSFM3eSIzhxTzX49WVcgr5cnk1n4bky+Bx9bQAIbYKL/pglk/VFy+Zk4Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2CXAdAP/bcKcXzIKzOfGZy40prBsyX1nFOtJfsKD2HAOukJyV
	pCXgMsuG4Z24S5u3m5mMi7MEoxA2sxRCmMoB7jA/IFQyJ+AphkYCrR5YSqSGoN93mA==
X-Gm-Gg: AYBFou3IlfqOadKLYeDjWjM35z3pYI4k2RWwmliV1SqnkiIuysvnHXuId6uZhbagGRO
	z/XBDTVMb2f4zu77O4Q68X++7tz0MQNxx26CvMMpvzQ1MI0Lrf3l9h6gnzNaIEMroehaaXzYajg
	we4yhX9mehFHrh7aYnQzVmKcoNECZxgvis3iPZgbAw3LNYcE/QILEykLNhuvUz2Mv7bNwS/uzhH
	xd1NON5u2/qiM6U9k4kCha/F24ScNouTeZDL8aoAmFbem2Y2xoroHBPBL6HB2Y3h6jX3Ie5au2K
	wSbMpYVlzhWRWcxSc/6/fUFZRIHsE9RqYhZd6dzyD0Kz3RZP/alxN23IUGpC3csmQqBKK1hf4Lb
	XDjHV8z6TUTKs1H9ydljC6tG5EYOToAHchULIerQwEr1mDAsotFjCIi5aFzwUJLv+QINaTVq1V4
	yNVwsjQp/uknaj+amWfDzQ82YwaHwYKxipT1ZvJXuKYJe2epWnhvOc8UXcgCTYgDsEsCUe3aMSo
	pk+UYZ/7Imt7RpJSz3o+2IS7Xd9D4jwnuZ9fehihgJQLUMb4JZbA7AvwfC088tMHGhrf/SqW1KT
	ovgobGnp7WBBmqL4Nu7YsaZRwnHft1/0K9KT33lBymOyPPz4T69UsAgiomYdl7RqRMBZ9o7jVJh
	1zeObaxdo5pxh
X-Received: by 2002:a17:90b:2fcd:b0:3ac:a7ee:6780 with SMTP id 98e67ed59e1d1-3ae8986606fmr10535707a91.66.1793680681667;
        Mon, 02 Nov 2026 20:38:01 -0800 (PST)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:dea6:6326:4502:bb8b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c71c253sm2072761a91.16.2026.11.02.20.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:38:01 -0800 (PST)
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
Subject: [PATCH v7 4/8] i2c: of-prober: skip post-power-on delay if powered on sufficiently long
Date: Tue,  3 Nov 2026 12:37:28 +0800
Message-ID: <20261103043734.2179858-5-wenst@chromium.org>
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

On some devices the I2C component is powered from an always-on power
rail, or the power rail has been left on by either POR defaults or
the bootloader. By the time the prober probes the device, the device
most certainly has finished initializing and can respond. There is no
need for the delay.

In such designs, the system integrators tend to work around the delay
to avoid the boot time penalty by simply omitting it from the device
tree and the component prober. This is undesired, as the device tree
is not fully describing the hardware.

Switch to the new regulator_enable_and_wait() function that makes sure
a certain amount of time has passed since the regulator supply was
actually enabled.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Switched to new regulator_enable_and_wait() API
---
 drivers/i2c/i2c-core-of-prober.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-prober.c
index 6a82b03809d4..f9f3c0ef93ff 100644
--- a/drivers/i2c/i2c-core-of-prober.c
+++ b/drivers/i2c/i2c-core-of-prober.c
@@ -18,6 +18,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
+#include <linux/time.h>
 
 /*
  * Some devices, such as Google Hana Chromebooks, are produced by multiple
@@ -226,13 +227,11 @@ static int i2c_of_probe_simple_enable_regulator(struct device *dev, struct i2c_o
 
 	dev_dbg(dev, "Enabling regulator supply \"%s\"\n", ctx->opts->supply_name);
 
-	ret = regulator_enable(ctx->supply);
+	ret = regulator_enable_and_wait(ctx->supply,
+					ctx->opts->post_power_on_delay_ms * USEC_PER_MSEC);
 	if (ret)
 		return ret;
 
-	if (ctx->opts->post_power_on_delay_ms)
-		msleep(ctx->opts->post_power_on_delay_ms);
-
 	return 0;
 }
 
-- 
2.56.0.385.gac671c819a-goog

