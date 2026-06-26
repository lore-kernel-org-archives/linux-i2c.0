Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9382F39DBCC
	for <linux-i2c@vger.kernel.org>; Fri, 26 Jun 2026 02:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782442768; cv=none; b=LF+wvtntABpGno7tNw7CX+SE/fsD4dC4jJqHSoVeOw5zzDQHFm+mR5yyERjTl7Mqln2tWt3TEoM9yKgiL0vqDA7bdRV143IkqxJR1Z6t81YgEkjuNBeo5IDna29USBMPt0WINPUFW9tJ//w/Yclhzl+EjCwwI4iaxCepC7N46NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782442768; c=relaxed/simple;
	bh=tQZ+TbPP0OfRqvbdFrI+mIBSR8Nopvc3RSiL9bMw4Y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LLmIHtVPsKF4e18bqaXGrwlQH+zi0RCu49WUZvJMfojL5XD3quayiSC37s0CbUVNwLs0I+aAAwuZySbk9At+FsfqDRlAPo5hwmY2ssEiqys4cdd26pQfVhpqyv1rq0XfuVdFHaw4/ZQ+QEC0MHfkuPS2o8I6aecvQnI162DoB7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9KzUsUJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9KzUsUJ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c7cfa17fedso5674735ad.3
        for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 19:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782442765; x=1783047565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4muAkhfm5VzCuxMXlVVQ1rf7i8L/csvKiPTRJAXnMMY=;
        b=L9KzUsUJIeyCXWmA04VzEm9u6qyVvP5RYKkW/gQOIgkiSsD2bnEnNTJyjL1/+i03ZE
         yOxPD6MEEphNKrUdTUQiLy/1YEObHa3q0eJ3E6UfkwxMzEIxQEqNY2htUHB0lYUzktBC
         MTferVPkkS4f9fCWskHI531MdUPdaDyThiO9vPf2v/bOHHNp3llZlHhFQBvdEW/n7/cC
         Zkm78YUYpE9mais+DhJOlwaU3vzU9l4W73+K5dj3xJJ8VZvHh3wNvvEb3TMDbETqtM0j
         uQQjuRF8xFt59Z9OkoMHccTfAC8MZ2ShEMEzmDku9HXbX1ZxE5MVYDxgY3aDv3N7AtUB
         aoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782442765; x=1783047565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4muAkhfm5VzCuxMXlVVQ1rf7i8L/csvKiPTRJAXnMMY=;
        b=LpOLjQntJidcRfqxCF7HxUxz/yUEWo0S+uNW1CDbCC/VvjTGz2Yo9Q7+sIivjcOtW+
         2M0RyScXLi6O2dm7++q+dtE2vLFHtKhEOR5qpuZnkTo1sbcepUVcI4sp8DiHvBwz0DWi
         s2jOCZBvz2N6KLXi7jmvULjHPdO+Ox1UWxYDeMDyKrgJdAiVAFmECyEG8yZnrRoc+46X
         DNHpJM5oZeSOu2aiu5zT7pASvwUPPFZvhrRmmkizJpdmX47J7/aYR1vlOyDmbr5gAzuZ
         XrQQY9EtlwptXvKr7QBfkkE0TJUgHfmrQEvzVSnGC9uDAJJWXHGcCWLpTpM0H6ZtDM6o
         P+oQ==
X-Forwarded-Encrypted: i=1; AHgh+RrLhHS+x1XS2+YmoH0qqTsb8c1oEP7Kr4wV4Ph9gLiY6o0GLchRPpByoL1CyZeVpDzlY7hIgrX0A8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfwygQHnvoHJX+AtDPoAkDvpP4mXwcSUPb3bemfWIFacGRGwe8
	N/qWx+PomIN+5eFw+QB15yvks702zXV+wXrLFW5/Txjtr6Sw88RwcFVc
X-Gm-Gg: AfdE7cmyMrcDlrOltKllOIFQNjLWhJTzENRzW1oEvHLtmXFySaiDcHsxW4Jx5L9WrTh
	g5bj/FAeW3IlSYcdbkQMIUdkcXJZ6F+1qMCIKRzTY3HiZi2d0spjQrtb2CoDYls5htVINZVjCHZ
	LJeE440Pj1GEgW8K9cPES57jKvUxQRVhd1ir2Ht0q5lqr7OweJSF5Qiy9Q8eRgwiY1T2U1Cr6uU
	7iJ/OC20v5FWJD9zybQUaiOccE/ngQqdBCYXnavefDT8YCIAE2X+ty7oiVefIE1arsKeS3kAdHF
	ddCnXVyOEDfeAAc9OHVNwR64to7OW/1iYN8y7bL6o1wLTsRkGpzjaLZ9tOtv2AMpRx8PcLWm64m
	XmEvJsxMTkT5+DZ8j3mowcOyzjXTF3xzSDgEVrwIllHUixQaLMwm/tFW2sO7jGQUue3ohVzX4Nm
	QA45kimuT4yPg=
X-Received: by 2002:a17:902:e545:b0:2c1:ed61:36ab with SMTP id d9443c01a7336-2c7fc73b73dmr47872215ad.19.1782442764905;
        Thu, 25 Jun 2026 19:59:24 -0700 (PDT)
Received: from archermind.. ([182.150.55.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5afb1e0sm31252535ad.29.2026.06.25.19.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 19:59:24 -0700 (PDT)
From: Liem <liem16213@gmail.com>
To: frank.li@oss.nxp.com
Cc: Frank.Li@nxp.com,
	andi.shyti@kernel.org,
	biwen.li@nxp.com,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	liem16213@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	s.hauer@pengutronix.de,
	stable@vger.kernel.org,
	wsa@kernel.org
Subject: [PATCH v3 2/2] i2c: imx: Cancel hrtimer before clearing slave pointer
Date: Fri, 26 Jun 2026 10:58:46 +0800
Message-Id: <20260626025846.106157-3-liem16213@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626025846.106157-1-liem16213@gmail.com>
References: <aj1UR5ddawsdMbZC@SMW015318>
 <20260626025846.106157-1-liem16213@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In i2c_imx_unreg_slave(), the slave pointer is set to NULL after
disabling interrupts.  However, a pending interrupt might already
have started the hrtimer (i2c_imx_slave_timeout) before the pointer
was cleared.  If the hrtimer fires after i2c_imx->slave is set to
NULL, the timer callback i2c_imx_slave_finish_op() will call
i2c_imx_slave_event() with a NULL slave pointer,which results in a
use-after-free / NULL pointer dereference.

Fix by canceling the hrtimer and waiting for it to complete after
disabling interrupts, before clearing the slave pointer.

Fixes: f7414cd6923f ("i2c: imx: support slave mode for imx I2C driver")
Cc: stable@vger.kernel.org
Signed-off-by: Liem <liem16213@gmail.com>
---
 drivers/i2c/busses/i2c-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 17defb470776..f02c216ba299 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -959,6 +959,7 @@ static int i2c_imx_unreg_slave(struct i2c_client *client)
 
 	i2c_imx_reset_regs(i2c_imx);
 
+	hrtimer_cancel(&i2c_imx->slave_timer);
 	i2c_imx->slave = NULL;
 
 	/* Suspend */
-- 
2.34.1

