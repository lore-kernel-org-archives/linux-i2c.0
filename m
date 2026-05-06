Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077EC3ED13C
	for <linux-i2c@vger.kernel.org>; Wed,  6 May 2026 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082029; cv=none; b=O5LWCJ6Ju1m6T2R3a2kq9JnuKlIXIy2bxabGnAjGT7bPb9OAedf4JaaZ6XQLrNXo2F7oUwc4aEXpkkC6HguzP5sJ7ztHRgrn8rbol/7/QifbqvxbEMC8apMajHPqFiAjCxR5gSl/0qo11Im2nWUb0dOtgsYmH5GrerCoMFkTULU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082029; c=relaxed/simple;
	bh=Iy6xIoZJS/4rNve+6RpwCwCKlBFAVTlcXJRyE7jwUdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7e8j9ZyFJoMlhH+Xb5zMayWv9fSx6n3F5Ph1QWLyDRyZsK0Bt7HfkdsiDux4tryXaQ2Kgp2l+oEzGZ3FNtUk/hPV0PVuyfu2wAC7UKzu1eODEqf11pwbMibT1gCs264Eq3IGVV1xhwzqz9pBrWQvvjlb2UB09y5CeS76GVBrvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ar0qceqr; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar0qceqr"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44a74032ff8so3750717f8f.1
        for <linux-i2c@vger.kernel.org>; Wed, 06 May 2026 08:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778082019; x=1778686819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neJP9/VPuuvU9YGwwVGKB/vSqGk8DVOZs8jLqr4GjWc=;
        b=Ar0qceqrZL3nSJd6ph9HT4KDHb1HjBV3gonD4NCynCsisjDndMzuHOAjz8Zd357Bi/
         ZyWVrCwXIJbH9oOzsnZGcmEnq0XtWn7S+UoTz8CrL2ptKvTU0Qm1GVM7Z/ozDIoZJynF
         DurEClLXJ1vDZRgcP/DNIoqCNtZkFudykdSABh0qWog9gegrh1s2yPZh2sE9/wb/1ccj
         SahWuvDBUi4MTmss08g+qubufP/+B2v68slD1TI0DorXjH2GTq2cRk888tSDpR3MxVp1
         vievxN9QXoctBUpX/A3Xm1Z0+0bM3arAc62QJOt4hSrgJaRI5YuxRt5dkxYUJoAB7U8+
         ymAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778082019; x=1778686819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=neJP9/VPuuvU9YGwwVGKB/vSqGk8DVOZs8jLqr4GjWc=;
        b=JPNIN2baSDzYd+Pz2hGdrIXzV7dC9hvLp4Xj+LxqAgiQ4rqLqCHc/jmFuAKo5KwEYX
         3E33plDkzEbZfFRnGvlPtwmHZaQHpHYtM7LZLazJVbUsLSGeyN0ubNlstQTkSWTCvAYL
         pZHAs3vSgKSLI2Fi8MpLr6GVold3w2qCBVSRiXAQzhhR+TwODs+YXJ/aIkhL5YQeee0V
         p7fBdFRzC2UhicWsu6uMAltsS1UBiWg14ECI735a9AQvDvlGJXufGVvYrlu82fLKB97z
         YjDRjrlQa9yaoq/Xa9pps+wTLaYF2xl9nKzTWoivPQHzkxrHeIE2A89Bti0psXvTbsqo
         QoEw==
X-Forwarded-Encrypted: i=1; AFNElJ+GGJ95exYSkX38VbqgLhA5EiLj2L3gMh3E/ZKryrUHUrJMsh8ZmGmQuz6BTFTo6HMssNTgnqM0ACw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx0LVtzt43u2vp32JU4NSOX0BPCq8HxJtZqQTcd4NH5ReffD9n
	sQovsRF4f0YxHRo6q0n2WbyiJvtgIHd9JL0pfnFJ/YXeZYbE+MAx1LZu
X-Gm-Gg: AeBDietAiK+xnMIJhl/0ugNKZ62xgDtogcdqliWwnOHtTlVQVyxZ0io0+3vZVdLdK3A
	rNG3igIfjHtGn1CtwjeEXYpEz/5YvrMk9z1xQ9ePd4SvePshp4NpjdbdBH1pHCyt9wJtDxCBlY/
	dvWDgdCXZmZQLApyUd0K5qSTSOl/Vz06gAYyjyfuwLRFusmhe3MQKiETmzxgHyLmDOqrfNPhfnu
	p1mitdP/HtknMLN6wB7oLdHp6UgXK7q5L1izTIkQTXEyeEBQkGMiKnIiezdAH71Lk3Kj07njLTu
	a6/feucrrQO9rrnTq7E+QM2txMstxf7zk1z0caWK7DDU3uKKgIl4XPbtJ2eYX1cQOddAVcU2iRX
	82u2C/Nyn3wRPs5+7FQKsvzWLAYQh349NfMpAhe7rLtJfb0r1zudB8gZcA9MBVc/glxbC8msWo7
	EZBOXEj63mkovtxWoRzmoHWcKQjThBV5oPEb+v+hiOcMcUJLal/ebccVPeBU9jm/EA9zBrx0T1b
	kEKCAzLu01sK5gklXrK4w==
X-Received: by 2002:a05:6000:2c05:b0:43d:7868:21f0 with SMTP id ffacd0b85a97d-4515b056a7dmr7290655f8f.9.1778082018952;
        Wed, 06 May 2026 08:40:18 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4511d8cd160sm8696929f8f.8.2026.05.06.08.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:40:18 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: zhoubinbin@loongson.cn
Cc: andi.shyti@kernel.org,
	chenhuacai@kernel.org,
	andriy.shevchenko@linux.intel.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2] i2c: ls2x-v2: return IRQ_HANDLED after servicing an error
Date: Wed,  6 May 2026 16:40:15 +0100
Message-ID: <20260506154015.94815-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506044818.19842-1-devnexen@gmail.com>
References: <20260506044818.19842-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The event ISR reads SR1 and, when an error flag (ARLO/AF/BERR) is set,
calls loongson2_i2c_isr_error() which clears the offending flag, issues
STOP for the AF case, records msg->result, masks every CR2 interrupt
enable and completes the waiter. The handler then returns IRQ_NONE,
declaring to the IRQ core that the device did not interrupt.

That report is wrong. The device did interrupt and the handler fully
serviced it. Because the IRQ is requested with IRQF_SHARED, the genirq
spurious-IRQ tracker counts each error as unhandled. A bus that emits
sporadic NACKs, arbitration losses or bus errors will therefore march
toward the spurious-IRQ threshold and the line can end up disabled,
wedging the controller.

Return IRQ_HANDLED on this path. The other IRQ_NONE site, taken when
neither an event nor an error bit is set, remains correct.

Fixes: 6d1b0785f6d5 ("i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C controller")
Assisted-by: Codex:GPT-5.5
Signed-off-by: David Carlier <devnexen@gmail.com>
---
v2:
 - Add Assisted-by: Codex:GPT-5.5 trailer (no code change).

 drivers/i2c/busses/i2c-ls2x-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ls2x-v2.c b/drivers/i2c/busses/i2c-ls2x-v2.c
index 517760d70169..9df73557ecc4 100644
--- a/drivers/i2c/busses/i2c-ls2x-v2.c
+++ b/drivers/i2c/busses/i2c-ls2x-v2.c
@@ -304,7 +304,7 @@ static irqreturn_t loongson2_i2c_isr_event(int irq, void *data)
 	regmap_read(priv->regmap, LOONGSON2_I2C_SR1, &status);
 	if (status & LOONGSON2_I2C_SR1_ITERREN_MASK) {
 		loongson2_i2c_isr_error(status, data);
-		return IRQ_NONE;
+		return IRQ_HANDLED;
 	}
 
 	regmap_read(priv->regmap, LOONGSON2_I2C_CR2, &cr2);
-- 
2.53.0

