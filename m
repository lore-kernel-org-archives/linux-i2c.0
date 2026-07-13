Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1F038B7D4
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927247; cv=none; b=r9i4R20K6MlbYL93CQBbaYrYhyMESfUFDXOOT0ZA+jmvHED0u2JGdBU67y9s7JripbMzrmJmSFSHjLfWts1+1XjZpkhouVRn2PlMP6v7UNu8UvmsXpa4LC6VnidA2dj9+e24Zhh+dzVBoqm6M4uECd5eVbacBkKNYxnSeJEsCfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927247; c=relaxed/simple;
	bh=tWBE+9nC9oYSk5UAsuWGi9/zHXxUjrXV0Pqxs0s1rgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jEucDPrb90gku9z2b84mwA5Qj70tzodrDiHeLGXikJzAoO6c1I17cI7b+GlDSALQBBMMYPbCAlPOukQRI5RrXf+kQ4OjdDnnWclo7WuBShhIClBRZUyvroVM7g6DD5ExHPQOqiwOP3O77etJ1Kwq2hWoA+tfhnFpbAPoAxPwW1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PinkzyY4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PinkzyY4"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b00ca000ceso2963938e87.0
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 00:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783927243; x=1784532043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2vmZPZjXbsjdRbGB07wKnlv0n+AtIoVZmnXS0nIYHMM=;
        b=PinkzyY4JUWehSZGCn5ufPKnNuPwus8gznIRcf7YOpd2IgepSFxIHgeyga+lNxF2k1
         5DozAfWSsnx5M/IcFLW9OajbM0XU2wYi9dZwQYl53+sAlBini3uoNVOcwQdY2B+N6oNv
         UKDJXRakHi3mWN6H5J3+CsIdag3Fdl0T17jbb6/7iZRdpnQALF3dhSA4Kh6ikGLp9sPC
         0RoI57sO11ZcnDyuHNtl/9aL7LTODlefUMcxVf7ghb5Gew54bs7DmOirKxhXXnTj1tYO
         T/F2SKH0bZoFS56POKkJ0Ba7CfWARzUk7AO0FMWZiofLOX2hvv6cNfu45Fit+aT8aFg+
         jkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927243; x=1784532043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2vmZPZjXbsjdRbGB07wKnlv0n+AtIoVZmnXS0nIYHMM=;
        b=ryYVQE5dnss8B2toZI+Bz4sFK5G4HO1FPWUSSayCTaqQLG5SgEOklQSxxoXZ7fUPeQ
         P+Jr1lzIl2sFXsBb57DsOcW4magou4oUj/4JbObkCptTFuy/fs0XzgbYUgOfkLP+ByRM
         RSZNhDf9maMJx/6au8lU+d3gYqD2/fEoQbi6pFlOAgBjLjujWqR3zZoaUWSSLzhtKm1t
         roKAQHJMD8K5MMZocMTnTTGAYJNwfKh1s6nhB1WEfvLSh56vXomSL88Wu5zADe32rfzg
         11LbhM4112Yh1giFtwc/cGZff06OYKtCwyJXKMDBnvFOibvahu71LIwCOp+re3yPaahw
         kF2Q==
X-Gm-Message-State: AOJu0YzzrnfqRXZqlEMAfRuYb1zwJMD53WugPBaYSxjp9U0UpIeH2GKb
	C2HhnHXejr1LfRY7J1rYB/i8FZpqeWHyHSJ6+TAzhB6PevJ2/Djc90Ci
X-Gm-Gg: AfdE7cmrzwEnA0PWH++kGhcZoh7y6xrZuJrtrJNrKqGeoQsW+RyuKcjGXZ9jfpUx248
	dLrbVWB9BIT9nJ62eZvtzSw1ar/AqA6inJVmwORJO4c0M2Zp3t0kj3TJuIw7oClaqFVHoDguz8o
	BB0sTjQpD8iNwGCahSX+EsJ18s7bwus7dg8BJmJvbxcTowWaY2Weit+cmlK2WqNIcFcP/h2wiBI
	YC1qzzPHAQb0gNfR9xKOhZWUwIewza7BUxzJfegnW752YFOt8uLktUx2sLZjh0mSxXwwDm+nEAL
	feDLVxWvHv4J9LbQ1xWa849qRPoIrR7on5kvsxkFy9RouAd0dCj65oMr23hjMN5ktkVi3eE0Z73
	rhsdyDglO+ACvYI9P/MfIDDoonylqVCOGiDMxbyh5KUI1f+p3P1yAVTQP8ew0AESjcY/SUTsuqq
	99MQVwDcDOlcTQyrI/N8yeQUanK1VIHb0+cdEK9Im38c1wOhO3gNf5qwI2zA==
X-Received: by 2002:ac2:4544:0:b0:5ae:c210:1a19 with SMTP id 2adb3069b0e04-5b0235657eamr1234362e87.12.1783927243380;
        Mon, 13 Jul 2026 00:20:43 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca55723sm2625636e87.35.2026.07.13.00.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:20:42 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 13 Jul 2026 09:20:02 +0200
Subject: [PATCH v11 6/7] i2c: mux: ltc4306: set correct idle_state in
 i2c_mux_core
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-i2c-mux-v11-6-72bb8af8ee8c@gmail.com>
References: <20260713-i2c-mux-v11-0-72bb8af8ee8c@gmail.com>
In-Reply-To: <20260713-i2c-mux-v11-0-72bb8af8ee8c@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=763;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=tWBE+9nC9oYSk5UAsuWGi9/zHXxUjrXV0Pqxs0s1rgA=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqVJHIkaxmStpAntzH4EF4X+3uFF8fU4VR6pxy2
 qW6K8bor62JAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCalSRyAAKCRCIgE5vWV1S
 MtMGD/9FeY+aRJXCArOuIHRATMXvNmzmm2bgWtK5fqndDZF+nnjxa4OdbmUDw0DXnTAcH41Q8zA
 SJNhPg7tHbTLyAk6hNZOffWpTPyBJSg2gREx/igaTf6UKjUR87MfTMbmw+U+tBRXgZqYnCCE5Hb
 hpcp3/m/jU5zsgbJ3qDYtWakO1FZQrVDyWi3dTC1hhH0i7p2sQ5ENgFeurVDF1pVlSaaGsf+EC/
 kgyWwU30RXT4n+KL17ExMRlgXhhe4oxV3QwtVXSmq0BlOSpT2/IM9sa0zIFJo+1fHNnIwPnkLWR
 67Qt/eextkWalgfMCPEn6gaLrK1o+Vi7UrLIgahGyBAjm9eEy1Jw64SEK++DLUwcWXIsi8KGJfb
 q9RCttMn626mXzsxoHwvdtYv2zqruEQ7hnVO4/UGisWqGSMZaYGMtOZ1UHGo5/GklY+15rM247s
 b0RbhhCyU4HjObSSnguyOiLPrF7KIxEztXnEbWH7/q4NvJaQVJe7DSl7wXv5uDJUL3OTKYImcdQ
 yOTjfkAYfvYjJsQ7hKfVyhOERuqKfFDP84o02XOKpDGyHWj7dOUJaC6QQsP5QbO2YMea/7kouG3
 +eU8T0kJ9YRxapahtHIj2Z3V93wWYZDl8aIk4CTfx399Ki30Uqw6Q80zcO5dFc/aLszH4qSiXi3
 Fg41PQK1pGG8siA==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Inform the core if we intend to disconnect channels during idle.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/muxes/i2c-mux-ltc4306.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/muxes/i2c-mux-ltc4306.c b/drivers/i2c/muxes/i2c-mux-ltc4306.c
index 18228f5b80e8..d1bd59d73799 100644
--- a/drivers/i2c/muxes/i2c-mux-ltc4306.c
+++ b/drivers/i2c/muxes/i2c-mux-ltc4306.c
@@ -232,6 +232,9 @@ static int ltc4306_probe(struct i2c_client *client)
 	data = i2c_mux_priv(muxc);
 	data->chip = chip;
 
+	if (idle_disc)
+		i2c_mux_set_idle_state(muxc, MUX_IDLE_DISCONNECT);
+
 	i2c_set_clientdata(client, muxc);
 
 	data->regmap = devm_regmap_init_i2c(client, &ltc4306_regmap_config);

-- 
2.54.0

