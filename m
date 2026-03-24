Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254433EF666
	for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774360483; cv=none; b=ss9Wf5v24dVmcEIiC0WvVzffaw9tVxAsZ4hW9m8Q4xZU5VonCDSxHXG320raTIj6n9GUt1vkqmOxmqlddzJzwOnUyIOhS5V/Q1RcOJ3m50uQSr/Gkg8rI7Gvn1ob+RsTmfItc1nmatA2QjonQMzKBFfw1k3hwdlk84S+D5IK+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774360483; c=relaxed/simple;
	bh=XZVd7p9mIBaNy+NIKUZiBgjkJyYONlNCoWZWgB7A9Zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RmGQzizjn1IbzHxDaS83Z3IMmTYJAMKMo/6dotOjxkKisDxk4oWGVEmpgpGouAVq3ZmOfIcG+rKcYL6qJM410E3RQvL72aAQBW0k0Fmap1YaRvO2JVQEF8a96KXyWVytdAJM0lhv+lwtE1t3Zh6TVIX0Zk2+qh+Aq6YgnCqjc60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlbRaQAf; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlbRaQAf"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a13e1cfa45so4547604e87.2
        for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774360480; x=1774965280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdAp6xh8xeBfkhw2oXmLZzz+7TGqiyYSvmIRi8yYlCE=;
        b=qlbRaQAfd3yZdKfAvSIBHTej0Om9PfcMEdsEWyodiqkxcJPgkOr64OPXFJ45uLyzXK
         HmbLISv8qj2oGIOsELd7TEqn8+o66IOSBpQ9s3ToIstm29TlSQBT/TJ1aWeYBXW/CdiD
         PJbQKawXtrSD+pWynqnURmEovpwrvcumzc1Y7tv8l6nphEyhNIIj0V+z4DuvicoyQoZK
         Ly3XYDEWmaln5fAyNWIuCFikvo6Ex+oDs+0e0UqB5zwGZ3EWIa9GeGyBuVurRCXB5hZx
         CbYcTFtXq8I1aFnhJK7DDn7a/jpYan9ZsbPAgtF7au6IB1yvjIghOOgrq0CDky+SxjiM
         W6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774360480; x=1774965280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JdAp6xh8xeBfkhw2oXmLZzz+7TGqiyYSvmIRi8yYlCE=;
        b=cz38UjpmQo+Jdw0A/QxSGsHvNP3jmlMjn/1n/1016cf360NbCMGCar3dVYTC3CugSC
         M+yzLVteLTmzgLJOQm73qWR1Q76tPkMub2KmwtZNEaJktt8klIihke6K1Zqh2NFKSS8y
         n+rI8rhihxCIR2GMXQoZ6EKnxdHIBwdYoz2wgGqg3t+M0Lc4qYFpho8UZROyr7p3zV6p
         9Xf4MahTntDIeOVaumUJL56/vMLymn5AKaf48N+kgclWpBGvXRu3aDGbXsziThaUMmVD
         bwcISTbVAVsegKF/2fXusSzZMnaYBOi4xKRzjIMjN+6jhbYnU68eqaERWCAomBSxU2DG
         W6XA==
X-Gm-Message-State: AOJu0YzeGKaBT5JTzUX81+j4+hlxxOF5YldpSE1gNd48x8y8o8t76afm
	7CCJYjVNJBm/eAUHcDc2Ogc0YHGcw1eYvq4A4qB/21JrSeUqWNfru65K
X-Gm-Gg: ATEYQzzZQYQhCtv+fHr4ErRQ+A8HuTIYyfgPU2uN9Yh2q48d47VCor5GtTJwhTx/IJh
	ePj2WH7uWvF+rSFyZMqEGZU0NptkPNoElA57Nwp8oC46l0VaasMzE/71YcwNkFGP0JCMslsgZ85
	ZFrUnnPeEQ2D26vfU6ZT6pNV647wD7hqyaVjfrSZK2wDqRcue+GdyWfe9XriobHiBxPWBfphGAI
	2jt7CkpHdZdp5KUV177EOOlMSpkhZ0qKKrqtIub+ldD3ejrxyMotC7V8LE+z0sRSiGStQpYNj7j
	W211X4vmq+zvBLy7NFtmpH7H7gruVS0PkGjqGRBsHxEtiDowlS88oN6wafMFc6rYYutSAHVZDey
	1F7J2530pXpo/+UiJSGvAdE/9mh7/Q5YtOEU6nMDOF5sJS51VRyCgBCMjC5lqnrX9VGWGPQIoAP
	CTeQANp0pJCIL6o/o8Bn8n1Q8/e3QQeTcLVavkvnz0nh1c1R7pwbni5QLaW3WQIEWqvPip
X-Received: by 2002:a05:6512:1150:b0:5a2:7eb8:2f9a with SMTP id 2adb3069b0e04-5a285b60fa4mr5257979e87.21.1774360479973;
        Tue, 24 Mar 2026 06:54:39 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285207454sm3162823e87.48.2026.03.24.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:54:39 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Tue, 24 Mar 2026 14:54:15 +0100
Subject: [PATCH v9 1/5] i2c: core: add callback to change bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-i2c-mux-v9-1-5292b0608243@gmail.com>
References: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
In-Reply-To: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Peter Rosin <peda@axentia.se>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2485;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=XZVd7p9mIBaNy+NIKUZiBgjkJyYONlNCoWZWgB7A9Zk=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpwpeNI6OmaQ0d2ac8J3iIBGEysEYB0qwzhghkE
 0W3akq+mXyJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCacKXjQAKCRCIgE5vWV1S
 MtN6EADTibXYTvwLToTRixa2sh4rGUbNLanpKU1sKffHdHOLtUuOEo4bHoRHV4E0tjabv595SmY
 1SMoGPf/phfw7YneGwh/MyGjm/bXChh2E226fW1kkqhRa2OEyU/mVQVKzxuHhD8axJJKo30NYJv
 79zdaNSTsOHy+Jf7dUytw2FXXwi75TI8dknQ2QCRl5mYIzMpwF6aPerYGnna97pwjvUMngzgTOq
 Ug8wZvq6eMINF8G1LRrblPT2MwedfA5QVaIIzIlgTwIF63Et/o0g1nBNJIq6YEMQX0kwTL+kwSj
 IyD4rGtU5yjFjPQK1qhnWtslh+METP8OL0dJkBHCyZFfQOXo+GyIEif4s+xTQmeqwiaFo3i7aK/
 RAD0r2qN0zfBbE8AhzftKThJCECn/IrRMdgt1F1gFfKsqOnRLexMvdq56g9bNHEUjWxIr5NaS4J
 65pO+YAXVUpcXp80l341Xq0LF85vejFvK2mlDnQpMqsYS7Sz683IVEQDkOrwFGTaOnEKYM1gB+h
 tfEcw/4Cn9jnke4nbM1av4S2MXAV+fbaPI4+pEPTQNCz0r4yBc12t0G12WoP+fq/WKdTA6yiN3V
 ExYkKdrb8kyorl6UN/JsBiS04Twgaqh6HsC43OrXnbAzqqzSSs6G3ur8jaBryTt8SvCpf5XCVa4
 a8wntfiGesMABpQ==
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
 include/linux/i2c.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20fd41b51d5c..712f9608108e 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -742,6 +742,8 @@ struct i2c_adapter {
 	struct rt_mutex mux_lock;
 
 	int timeout;			/* in jiffies */
+	u32 clock_hz;			/* bus clock speed */
+	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_hz); /* Optional */
 	int retries;
 	struct device dev;		/* the adapter device */
 	unsigned long locked_flags;	/* owned by the I2C core */
@@ -835,6 +837,39 @@ i2c_unlock_bus(struct i2c_adapter *adapter, unsigned int flags)
 	adapter->lock_ops->unlock_bus(adapter, flags);
 }
 
+static inline int
+__i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_hz)
+{
+	if (adapter->set_clk_freq)
+		return adapter->set_clk_freq(adapter, clock_hz);
+
+	/*
+	 * If the adapter is a root adapter without .set_clk_freq() implemented, this feature is not
+	 * supported.
+	 */
+	if (!i2c_parent_is_i2c_adapter(adapter))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Update the clock_hz for non-root adapters, even if .set_clk_freq() is not implemented,
+	 * to allow the clock frequency to be propagated to root adapters that do support it.
+	 */
+	adapter->clock_hz = clock_hz;
+	return 0;
+}
+
+static inline int
+i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_hz)
+{
+	int ret;
+
+	i2c_lock_bus(adapter, I2C_LOCK_SEGMENT);
+	ret = __i2c_adapter_set_clk_freq(adapter, clock_hz);
+	i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
+
+	return ret;
+}
+
 /**
  * i2c_mark_adapter_suspended - Report suspended state of the adapter to the core
  * @adap: Adapter to mark as suspended

-- 
2.53.0

