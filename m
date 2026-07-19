Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45E739B49C
	for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784474255; cv=none; b=ffxTEsKl9DwUBsMeg64SaDC9KfDu9Gp4Zg4GDWdiC/LMoIcrNwWLPyy/JEovZ6j8VfhNgMJY8ygwoB12DVebD5cHLvX18aEnKgX/JfamIr6KIwCFQKf8qM/1xoNrMApLM/JO5llt6qb1dBW31fGpYcGqSW1vIczWSR6Ox6dQk9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784474255; c=relaxed/simple;
	bh=yzE9PLCgDjOTow97MHP1nSRzWz6qa/3+7ghuIIxf6gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CouD+Ddau6JlwKnVkcHn1IffUFj5cv22c0E3/LCmCxKH3gCOLLXb/giz/Sh10r+me61B2O6qRGuDA9xoGGIKjJZ9cCUXgOyFBcCoL7V0syfTaj247zthQM+qbq1WjdNeni4079opWxoS27QbKQrsznxv4c5I2bXCBB8UXT+qkWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2gM8Zce; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2gM8Zce"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b29356f8e7so1576075e87.2
        for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784474252; x=1785079052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HlP6ff475vHhLHgiF4j8BdmWTsaSA5axHhKG28Cf3RM=;
        b=G2gM8ZceGYP86BxTSqLElSM3xzFzrfsG0VYmq4yx4f+LtI7r+Hg1q02My0FSN1Ywhy
         I8ya5PbgoYELKQ/IxLHAMaRA9KtTJY4Wjlr2Ll6L19VfujAiWqOzAuvCX/7n/fLKieL6
         QUukm1AUVpgTMWtZJ/yb/naBe/Mv2Q7GG2uVn4vkRzk3fBfRSgj3WscR5UnZ8XjopGbm
         TOqt77WMcwwLKbTxV87Q3npUNABdK4yddi4kSzTGcNcxLYp+gOoJwJicF08kBUEYU/VC
         F97tzk74FSTYmox6UQhlcgoNAPXLUW9YLfJ19iw17CtmRr+T3KAuPjbjkzbRGx3cW7dH
         hT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784474252; x=1785079052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HlP6ff475vHhLHgiF4j8BdmWTsaSA5axHhKG28Cf3RM=;
        b=Q//7E9P32fjV6gGzoUq79Xm4OTsbjirBiDLiw9dr1CWqNWVtniZUnWPJMCQc3RsiVb
         k8RykfKVDKYlptBRLrEplV/p/xz5TFbzicqFeWyjSlx5UMwjnsj3ZYg2cKftd/uEVXAs
         MDUWhQMPl9fjeeUjp8QwRjO5XV9jEdjK8YyCFVQ95Sz/PmtluGlcCYaZzw4fl5sbgwcW
         IbmF2nyCAXY8an3mwaUcBBA6fhGkfIBTneF/x7yzNk42xBGHpMfV4LkRd7gBKsS0O1hg
         MNHBMMoa5XzKnki6EQVR2xWevK+PhXqdNQkBfWuJPYwtpqfZvZCQyPRZNz1HR6/KYSYD
         Wrmw==
X-Gm-Message-State: AOJu0YxE980k70VyWu9qieGhzp2uG2ICdmj3d1YtCbo/6OEWHfbxtq8/
	8V3+IQdVohwVvRtZk/SFu8nsOAG/wjjoqCzbsnOCHDMjReB8mZ3+fgYb
X-Gm-Gg: AfdE7ck4k3qwbxArh5XPS9xhs4XW2uyaKXwmc/abwzwz9rJdBEBSLg4xFmDMTl6UY4X
	xR0Wlrz55P+pLTSMrZZDyrm9RwsBjqLhNj/i3qOKzP35HkT3P6p2JtrL8K5AYwF5uNS5cFJbqX/
	iXxZLmYQVf7zNEucyKipcUGBZPqkNUVDsUlCJWBwg+0VzYfZgUPlAxzTxrtpY0nhaWAii+44aCA
	lm56F1yo78zfu83kEKUzSP/xqB5iiNfdbI7BQLYKdzds0J/8biDAKCm5HbiU/7duMIUxaQOzWH9
	xYujdVoHaWaINji43Pp/9QgXjbSgEdHe+4LVFuyhoUdSHCZqYhAb1kAz/tAO6T5G0Mwi5reV8mG
	i7oxL4H98fMW03w/1h7SQA/lAIKzNh7XGGOzwkLV/wFFf6acG3owGM1Iz8JGmp5ZgU/fSaK+y/F
	TcrD7s0Zdr05xMHeM82wLLUOEyYnaNrumBtBzkN1G1yV7xCaE=
X-Received: by 2002:a05:6512:6885:10b0:5b0:f9d:f7a0 with SMTP id 2adb3069b0e04-5b28f85e9e8mr1213236e87.8.1784474251690;
        Sun, 19 Jul 2026 08:17:31 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b291e26e5fsm1835096e87.80.2026.07.19.08.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:17:30 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sun, 19 Jul 2026 16:59:49 +0200
Subject: [PATCH v12 6/7] i2c: mux: ltc4306: set correct idle_state in
 i2c_mux_core
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-i2c-mux-v12-6-a5010d623a57@gmail.com>
References: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
In-Reply-To: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=767;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=yzE9PLCgDjOTow97MHP1nSRzWz6qa/3+7ghuIIxf6gc=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqXOqNBqVDEiT8/ZRgbDKXqttDBy3Co+sTZ+EAC
 DdKTTE4iWKJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCalzqjQAKCRCIgE5vWV1S
 Ms52D/9ZWJxpXc+69YwDbf5mbGgWacFFbjO/I0QaymoY0pE4e8SbHnyw1DsTqcsABQykmYAE1cx
 ulrzhhYNkteLeEqN9QTbdJuRZ8G3aNthHgQ9QkQeGjjL+3W39YmbUeyVndbjR8RXpFJuUgsS1MV
 lxztf7vEp97T5aXYjH1wMXOB+QdMqBl04UkHRJRJwrVAV5vELLZ6IaKqUwfq5z0EoYYa8Vgb1d9
 1AgViuvhriqlBp9dYwDHJ7ACM7cqdnOm7PNIk9InQUtRkeP9lhU0wFbzICCiX/UXzc9bLURDsuy
 mBksggtiAlAUcev2DvGpXW3T2P2qKsKCqKUCXIvTbJ/bsDhLUW1SlII1gZW1g9VTjeP/VP4I+S1
 6DzYHfDJhmKxccKhQPQFvSU3Gexb1ZrYuO3hdlh6Bw3bCesHntRkiepaMjBfmA3uiELxPrWay7C
 SBuT9gtX+uMXJa9DqedphJbPKBZQFDtniEpytnTSUpmJ/fmZwA2/OGYQbh5L1+iZY4tQm4rHXMS
 5SNJlthuyPLE3r+iaKKgurQ7tq5Ox9WE1CxIp1rHs/tRr7MMvfm5WMnwgF51hqHvBu/hXRS1K59
 yh3FoIjEtF1SaSYh0jXH4l0qoZI/FwmjWfKCRF/FzGvWAT+GS9hVgj8iZxgH6Hj1NsJRPOTX1nM
 Gnksjc+ueyP077A==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Inform the core if we intend to disconnect channels during idle.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/muxes/i2c-mux-ltc4306.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/muxes/i2c-mux-ltc4306.c b/drivers/i2c/muxes/i2c-mux-ltc4306.c
index 18228f5b80e8..df7136b7b042 100644
--- a/drivers/i2c/muxes/i2c-mux-ltc4306.c
+++ b/drivers/i2c/muxes/i2c-mux-ltc4306.c
@@ -232,6 +232,9 @@ static int ltc4306_probe(struct i2c_client *client)
 	data = i2c_mux_priv(muxc);
 	data->chip = chip;
 
+	if (idle_disc)
+		i2c_mux_set_idle_state(muxc, I2C_MUX_IDLE_DISCONNECT);
+
 	i2c_set_clientdata(client, muxc);
 
 	data->regmap = devm_regmap_init_i2c(client, &ltc4306_regmap_config);

-- 
2.54.0

