Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E66443E41
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450868; cv=none; b=FVoL9utRIRXqgVzI5tE4A5Wfvu3mImW2zo9i/f+1Zw7yCJtf/rLkdugXWMXovUE2wnaOvEaNZ704n3bba/OHwKOq+UwCWu+GhEsEkf8aOU2GWX1HogXjltTjaSCZxevZKVnfdCW5vxOy5w9f8kkJMnL9JOEypx7lP5S8B2X9r+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450868; c=relaxed/simple;
	bh=uwYCui3c4XPv1rsWnK/RPsaDrOamMJWwHcg3hSpC47c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWSXRB892BJunKSPg73z+Cx1LHZ/BcH6Qo318SC9s5hzaLfmbU4dRvmQo1RdZNBPWvvITUptToAMYRAqCUNh314m0xmQ5W5PJ6mvG3dCI1y+JsMZ1Si+Sblz5ysxfY6Z2fB6sJvK3nVY0ExlXJyK0pXg27Huv1sq0yT2h6Z8UA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Mt0pGgZR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mt0pGgZR"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84a652535dcso1696162b3a.3
        for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786450866; x=1787055666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dA0DiMJYo6Co7ip9aLY71U3LlTdqy5LziCnokKFtcGE=;
        b=Mt0pGgZRc+dMa2v2Jtyuct2spmGKye97vRGWyNhkzFej6BiqmCMkw0CDCBQXn6DBlC
         yzq3Ra4XxWvU/X3utTCIlFd8oYR90cn/KbgLOSpOQao/M8fZvIzK+VY8jv7Oby8qg+s7
         9dYDux8EqV9kZNtESFbJp1HiumNLjwBgqys84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450866; x=1787055666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dA0DiMJYo6Co7ip9aLY71U3LlTdqy5LziCnokKFtcGE=;
        b=WaaiQ7c4cNpv+aQiYb29E5XXISCdSNvVNpATrO52JHhrkmeSo1SoMh9dDLklSF1ALY
         LNMJ0uLmO4w5UYC6k19VzMGmsXrXMZgsPL1AeYLkRxR7nzLnvs6W1geD9hLRxYqDaOvC
         kM/Lmdx3yJbsisySqKDhL4zaLC7t7h7KeVnu0avqFQYfdR7Dqy+u9JNELeQNuTNVBStU
         dffKMnP6OU7Tz1irgmZGXOegWcBOOVC+6PhMYAQ/FE35O/f5FhoznEG9hMS79hB0eGIu
         rgQBmvhfASJ6wqkNROZbjXrXgyOyYOg2vtLkatkOtJlUNFEERoqkxJ5jBOddcHQHEu3n
         hHWw==
X-Forwarded-Encrypted: i=1; AHgh+RoXAQkWZF/yADbZ7qxn6jb90SQUHhINH+qKdRsTsLnsUHVgS/ZuWbUchOgjdhxa9bxbn2ETP9sKWHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnz19anUPZG5hU2BXc34SS16VvIt5HKiiSSdqNL9Flq7/8Hp6E
	jdgDHFkqAVkdcrvoSbGl6soGGMV9rZFv7fneNATqsGZWep8kTyZ1NAZuA9752VJWLg==
X-Gm-Gg: AR+sD115HPCmPHcTjyKSGO5Zoj6n7ySR4uYMCcNp3RgqjQTWU6rDu7Z8djOyvlsnxKR
	YGJwqO2F1DidlLGWIBdMo75zSUoY8TFB/jnqsxLoK7EOwKjNVaFgX0meGI0/Y1sbhP3stmZ9AZm
	KpA65VavMEimuVhlrWxzWCrpn4Ypk0Q7vlrGhpy1gYjDajueaPtf+kVQ8nBKy/4mlZxXYUbQ7R7
	uYAKVPJDAnKkJA43Kmx5qMBIKhTIUEG2pzMRI43fSNlFlAtSCqBBOI4gj0JivuKZ9ClrcOnWUEK
	FAzRrut4J3N3n26RwrFUFfbwvp1q8NMQmoTTlLqvYLTeBHUqHtRRN+VYcKww2NHRXGgGNLfAJFH
	WNDtt5XhQQhNj02hsPVkyfNDFChwiN+GrVhrXg321d4e975g9O4th6IjQ7/NhtuOSo5C1O7SNC7
	D672GrcDiI6/KPUIemPmL8eom7dkAe/kmgJERXp2pd2McZcqBOzSFlCemiFuqOiiTGf+frQ5gFY
	9odrMxBcHSXb8GIKyJjSyrhyWUIMkmWs3q3hUgRMQcUTg==
X-Received: by 2002:a05:6a00:181b:b0:847:8504:9946 with SMTP id d2e1a72fcca58-84fa882d05emr2571459b3a.25.1786450866341;
        Tue, 11 Aug 2026 05:21:06 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:12e1:df26:6add:1ea7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa9574e9dsm662454b3a.54.2026.08.11.05.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:21:05 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/9] platform/chrome: of_hw_prober: Add delay for hana trackpads
Date: Tue, 11 Aug 2026 20:20:07 +0800
Message-ID: <20260811122011.3539250-8-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260811122011.3539250-1-wenst@chromium.org>
References: <20260811122011.3539250-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Up until now, the MT8173 elm/hana device tree has set the dedicated
regulator supplying the trackpad as always-on, simply because the Elan
driver was missing proper delays. As a result the delay for the
Synaptics trackpad was also omitted, as it was not strictly required
under such a model and delayed the availability of the trackpad to the
user.

The Elan driver recently gained proper delays after power-up, with
adaptive skipping of the delay if the regulator was originally
on. The I2C HID driver and I2C OF component prober library gained
similar adaptive delay skipping. The device tree will be fixed to have
the regulator not be always on, and proper post-power-on delay time
added to the I2C HID device.

Also add the post-power-on delay to the ChromeOS OF component prober,
so that if the regulator is off at the time of probing, the prober knows
to wait for the hardware to initialize.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/platform/chrome/chromeos_of_hw_prober.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_of_hw_prober.c b/drivers/platform/chrome/chromeos_of_hw_prober.c
index 8562a0e89dc6..54d8941617e2 100644
--- a/drivers/platform/chrome/chromeos_of_hw_prober.c
+++ b/drivers/platform/chrome/chromeos_of_hw_prober.c
@@ -70,10 +70,8 @@ static const struct chromeos_i2c_probe_data chromeos_i2c_probe_hana_trackpad = {
 		/*
 		 * ELAN trackpad needs 2 ms for H/W init and 100 ms for F/W init.
 		 * Synaptics trackpad needs 100 ms.
-		 * However, the regulator is set to "always-on", presumably to
-		 * avoid this delay. The ELAN driver is also missing delays.
 		 */
-		.post_power_on_delay_ms = 0,
+		.post_power_on_delay_ms = 110,
 	},
 };
 
-- 
2.55.0.679.g6767b8d81c-goog

