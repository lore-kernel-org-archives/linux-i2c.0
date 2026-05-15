Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279D31960B
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 23:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778888491; cv=none; b=HRgQ/uS2c23XiUl4rzaP7tNmcsNYeik92dW5pS0Huix4rY+uEDtTt6NuKXIntb7RPLLH6NtvTVqWMFrghAgZlOcK1bi+r9KT/dUAj3Jc/b55SZcnyOkFOrxoF92wKzHxLnf7czDfIMRSlK31/i0as/HY6r4QaT3B4RP71T6H4i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778888491; c=relaxed/simple;
	bh=YDBE2ArsELeNB+Y4PMsO25/KObn90CcdR++ZSkVKlAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qYHq6LlwXfdDo/X9N6HwU5sZXBREOErA6+c47/jZlufDenAEWpMgFpT8qcL1pxQAXDJYGaHtirra6JK0KXTMxroSTdI7aRH1B34QT9c0tu34W1kKcCObP8DISRxIlcaUXef0DBw8cchejVVTqW3wpzest2n8XcIfbz+XLjUQv3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cteAsQrt; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cteAsQrt"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-393b0fa758fso583961fa.3
        for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 16:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778888488; x=1779493288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BHWPbTLVhyzrvf6dcInOldanu4NBC4mlHmqadjXQ//0=;
        b=cteAsQrtY8VU+8zDWkpf8fW31Nq9i9hxWMEczp8RwQ6M0j2bedW+KCdacJUmJm1ahw
         oDIW+bizvLYnlO2RTJZsdg/YHzZVUX4hY9Urmsb0VSK9KHNIGJUozVWXh/uCzOd2nr5L
         x9fDh8QN2aWxLkhfKLuBZ6b8IqEmHcdf8WGS6ZMwK+kpnT9hMpapaHJnVq0V2nHyzwOp
         sFKwYE2CTRj40mcsJu3aHNibxzo+/PH+CN23StiWdGMy4LVQPGGZiZ17UClSqxOwmug6
         hSq25E5M1k3XaSxCbIqfEskz+NthC2+DzIuvX0J38KHRm8sOoy8AzE7PIIGMWIOE2/pq
         dW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778888488; x=1779493288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHWPbTLVhyzrvf6dcInOldanu4NBC4mlHmqadjXQ//0=;
        b=SxZjcTh759kkgmZWjgjG3f0jf4cEG/UuxFkc7AJmVOTQO6UXkXJFTRide8R5q+34sp
         b/Fwje9thHlvZ0iu0bSv03ifEeubrgPT+op5m4J6+S5fudINnnm7zAD23UEKIelA+juH
         hpCaaAQNk/4Dhym8heiXZDNaRtqvOBWrRAgE1YolWxJ7yFfN2bJ1JnRLu0X74fg6mKae
         jOQmtDup/aGYtKM5K+UQ4CsJ5jNIZFy4o5y9bwC1FTs8WsPUTYIAVGpsqd1ea58w7GK8
         o8MX4GLU0MMJH9Epkqu4vZrZczeRSJx4wbWFGtq4u3ZncfbFWjg4pOxIvtqF/m774zd0
         fROA==
X-Forwarded-Encrypted: i=1; AFNElJ+6k0Yg0Ju7cAFQ5q+hmUCmTDmvt3DARqvXt24foN+sp9krayploDYIyfJChIjiNUjDY7aoWvSYGp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+Ba3HRUGM0DygHK5WUMVlw7ZwNFgi6hcUWZs4Qfg5hKeDQSU
	XtvSmKLffWIxdYf25AXxT0PCLRgRdzMJkPR2ApWt2LpgRmzTgJxwebsU/mQi16PkeBL1Ww+Hc9P
	0ZTPf
X-Gm-Gg: Acq92OHGhyfeHqsjOrzEuW2XkoB52L+wXK+U3kypQJQbcqW8wH2PuMHg1e4Z5eJNeyj
	QQsvEiSlLSljxvcH8U0GL0WJOmT3RE+7dABaiwc54aMBA8APz0OyTfHdhfAlVKCuMAn8R8BZ5n5
	j3A5malAhGNOh1JNKXA/V6cmxoFHVR+y36exDokyVt6KaOAOHFxxWNEDTDb1c70l+kGiKs/asi9
	p9mWKv67i73fLWZCuYW0K6VHmRxEePGzpLn41GsXnZF7kAogHwmPhY02x99eQKEssfe3CFVsMii
	qSTUtkR6yyczoNVQA4YX+JG5oi8aN7rHiuBnbs4AlN3pitNK57dxmJrhUVFcgb7/4oyVeoKaoIU
	J4BZkwlD3XPcQxJ6HsdzMTdSEqbp5Roy3YiyKt16BpYyI1k+G/5v7jXe0ZX+194vLLYpBeImsjE
	+l0BxrsTFU3GGr9q+gJ1IH4z3bXQEEUmbXN+Q3EQQEkl8AOGquwctMQqGTjhBuU04H9jbkS5pfF
	LWr
X-Received: by 2002:a05:6512:1254:b0:5a1:4712:376a with SMTP id 2adb3069b0e04-5aa0e7655a2mr786891e87.8.1778888488335;
        Fri, 15 May 2026 16:41:28 -0700 (PDT)
Received: from thyme.. (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c710sm1631384e87.7.2026.05.15.16.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 16:41:28 -0700 (PDT)
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/4] i2c: qcom-cci: Fix NULL pointer dereference in cci_remove()
Date: Sat, 16 May 2026 02:41:17 +0300
Message-ID: <20260515234121.1607425-1-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On all modern platforms Qualcomm CCI controller provides two I2C masters,
and on particular boards only one I2C master may be initialized, and in
such cases the device unbinding or driver removal causes a NULL pointer
dereference, because cci_halt() is called for all I2C masters regardless
of its initialized state, the bug is present in the driver since its
inclusion to the Linux kernel.

Along with this fix a number of driver code simplifications are added into
the series.

Changes from v1 to v2:
* remove junk accidentally added to one of the commit messages.

Link to v1:
* https://lore.kernel.org/linux-i2c/20260515152003.1604187-1-vladimir.zapolskiy@linaro.org

Vladimir Zapolskiy (4):
  i2c: qcom-cci: Fix NULL pointer dereference in cci_remove()
  i2c: qcom-cci: Do not check return value of cci_init()
  i2c: qcom-cci: Move cci_init() under cci_reset() function
  i2c: qcom-cci: Remove overcautious disable_irq() calls

 drivers/i2c/busses/i2c-qcom-cci.c | 50 +++++++++++++------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

-- 
2.49.0

