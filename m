Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D32E43E9C3
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513017; cv=none; b=uPg3xbnJ/0uPSj8B1eMw0FLjHfzLLFlCl9xwCBIuYjTCnEvO5gLn1D2jHuO+dWaYCXO/3qw0K/xU1eoJCnYgGq5SsBc1JcdsYdHxy259TArQDWMi5fOgKikp9Gi6CT/5yRImyLZCt+WG7vToopmeqFjS8u6qvvy/NsflnpCNJEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513017; c=relaxed/simple;
	bh=tWBE+9nC9oYSk5UAsuWGi9/zHXxUjrXV0Pqxs0s1rgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bxIyvcmwwnqBmoLYQTg65eVxcq77r8gHY3Y26pSOjQM6+dD7/nd4XCBoqZNkigKI6H3PqBp8U8KrhtCoBGQn0tfOSQNPST5F9vE3Q7BMBgeqdZJLsRF1qpgbap20pKHT++mCsesdkOoAMe8T1t8ItB2rkycCYc1m4EgqwnShQJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKY6a08A; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKY6a08A"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aec6360133so476432e87.1
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 05:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783513013; x=1784117813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2vmZPZjXbsjdRbGB07wKnlv0n+AtIoVZmnXS0nIYHMM=;
        b=qKY6a08ALMpblJrUKJpqMBHt+J5FCIefEdO0lTYrWJl5INa9N/M7jL8ovO82N830mx
         IKyHWyHGuaj+2jKpMyJ0fTuwPucDFUE+KiCeSwdbqPvGP3bGmNO3X7+2i61WtOggfnUb
         UY/82Fez0Tlpkbtkw+U4Z1XK6rAZXHtFw1YyJuipH4Ua0Aq71xenXERW6NUTso8ti3oi
         yXY/NAC8md7pB1HQk0fj6maPJYRNfZghA1dE0St3fG+eC8URA/9RQMQq0JQS6P0uFaF+
         H/fuMk/D7nL22VCmm4DC471wkKc2kvR6F1Fw26s22VPzRvfzzYPxMXDrG4nYV+mM9F/W
         o2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783513013; x=1784117813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2vmZPZjXbsjdRbGB07wKnlv0n+AtIoVZmnXS0nIYHMM=;
        b=goam/4kLEqi+fZfadx45gnz1abGiZoD6ebEjMmWpuwrKmvImSvDwsf+ZzTnK4L53hl
         XFq0HzFbn7gkdNwLVzyrWf2l/QzF9lNPuslwBVoIokj4uKTExDpVgRr88aPczVVP3gEg
         SryXTBC/ZkV+AoXXyiGlLVn/q1HxEsTKC6aRwGnymhtpulF3lox6Uk9jWmo4C1Fm04DG
         +n0JkxzfYv1jp6r/wEOuw1XFn6oOQN/gcT8cRKVBnB0zVADWrmANod+uRkrl8I3W3wSG
         LULh103eMCXk9i5Ipn0hA39TunYWlPXDrx8M069IK21kEBskH5oh7knOjpcZYzN5KAK6
         zyOQ==
X-Gm-Message-State: AOJu0YxawmBF0KuNMPgJxmAiutIN5DA0aOtVp9+hm/fuVpQQkEZsmPLF
	eD3Zx7KO/ZXhzsC3U9BzRD7x7s9pKoleEMsY07SGyjj1SQ/BPstMnOD4
X-Gm-Gg: AfdE7cnjwk5ZJuF1VxpOQeWW07gi4P+ioc7YwPvd2+Qa7YCIjbO4WuiY5xSDZxIDJ7p
	UtpBINCaMPeP+JAncTg55WMEu7wBkn/2vB4KABJ+6HabXuPSrun9+4F1Ss233f7w0S4XAl3PlT6
	InXwzyofGAP9suQQp1Ld/jD/734328tkEtJ4iWmh0rH7hpfSkxECGxDy9pyZdNljUDx/oEvLgsl
	48EnVoLpAnfkz1JDs70LS8OUJeLMLwm3Q0ARNMN08Nf04hqEmg5NaGxK9YPPYyXlHAXIugo3kJb
	347FTxo99xKwJHKIIa788CeP//npTPAnQTIbxlL0yPU/Eq6TODYeob1JkEj1ldRX55c5sdLZSse
	AQNB7uhnyispNcViHU7qx7hd7WtxGk40oaCakRyndi87vyuuLX7bFmAkb0C4USG3YKtWVUbTVgO
	muwbt2/MVLujPOpl1jeaseszLqRtgoWvl+54BLZcPdfCY1IEulac6qrm7fCA==
X-Received: by 2002:a05:6512:1556:b0:5ae:c3ff:ad03 with SMTP id 2adb3069b0e04-5b0114a1798mr401304e87.64.1783513012467;
        Wed, 08 Jul 2026 05:16:52 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bbbc6sm4471459e87.41.2026.07.08.05.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 05:16:51 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 08 Jul 2026 14:16:18 +0200
Subject: [PATCH v10 6/7] i2c: mux: ltc4306: set correct idle_state in
 i2c_mux_core
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-i2c-mux-v10-6-09dca03c8a15@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=763;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=tWBE+9nC9oYSk5UAsuWGi9/zHXxUjrXV0Pqxs0s1rgA=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqTj+t/hfQEjggqeMYycAhhahuTzJfFGICtE6JR
 HN7+5jvvr+JAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCak4/rQAKCRCIgE5vWV1S
 MlZoD/9yv62s1VvnHa59NCKpr13J5p0XHsobTQ9Js0FkXajv8kKDavWpMXaPqA1/AmtkrMXqMqw
 ZwMkdvj1jCPSXkEFHKZwBFbzulV2f72Blr+RO/mN2mgHxWz+z3j6tl0ADhg9hqj39d14S1SsPcQ
 jVxGmpmx+YP9/c1Olpi3DN9g02IUvUSNUYrU+sbmySAKTXyDOlTwSsXUuiUdlF+EzdFsnv4FkK4
 U2fY4/9HibrnawH40WqgEF0d9yYyqNvVtdnIR5K08U6qerNUrsJ079KaCpgf4JB+SljjkF/h6mu
 1i1KREngKDsvvVB954tvy29pXw8MVUdA+EVazQVbaUURn5KXsOC8tMQ8wZLp1SDgw/nKrBr41I4
 Ng2dZVhl2qNMagQmM41lnRtpweOGPMQuSFxfkCDSyJCOAC76MHyxbGW5AuQDiYjOmyed/b75mYj
 /taenYi+VAO/4QCRb9PLG6j5/BBgWJ21aKUgBtnMV9Ey6Bjy9OFQCc9x5SQdyNBtQ+lIRp2JsFL
 RPPo41wwABDjZ5ghBkx+8pylqT5wr01QDsRj4A8HoXdDfm2Qqj13f2ncXrc6zOnR/+kvmKLUeRF
 /IFl1ju2d9A9MIXz/sHCnhA/UYAFNT3BW1B/K6ic7V3XWg4eATshSWTYcoi8VYKoPsDHcmtougp
 xYoEGDuOb1AaQcw==
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

