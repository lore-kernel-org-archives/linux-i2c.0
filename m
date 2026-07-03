Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF83CE096
	for <linux-i2c@vger.kernel.org>; Fri,  3 Jul 2026 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079790; cv=none; b=cDfJ+GVTVezBGv/qsPSmwnZtocZSLWMcJgm5rL7wPw5jKQNciLkoagAkMnAdFOOI3e3upVvrpkOkEPwUVsOwDxek0qOy9jdu/g9uhDQt1tEcjO2vX4onbt6kjgWaedaLkjHQ6gFFYm4Q5jtRCKGpyJXjXOZXxvrq5MsznDY4s0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079790; c=relaxed/simple;
	bh=hOFZgLaEu0fgbaHLQ2K0UZhu3A++ABratulLxCJEZq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDq/qoaugtb0D2/ho52HrG4H1bNzbDZ7Ss1xnsYOpJC4S1gLZbQeoORYeFJOPgBn7hEev/ThCFdH7u6sROD8ecJ2Xj0VqFFaNWuIiIG0FjeRFuMLsrMeGwoj6s2MY/6uuFyw4q0zg8fZ/InKMjAyTYfvbsleOQ/nsSvaqSfshjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B41Lxoci; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B41Lxoci"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c8b49639fbaso370285a12.0
        for <linux-i2c@vger.kernel.org>; Fri, 03 Jul 2026 04:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783079788; x=1783684588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzs61HZr2e08vLjlcHcnU81Qx3P3Xyhgqf6PYo21bZc=;
        b=B41LxocigSMqSi2e71qckO4dG9zNUkMV3sd3FznDwmrLjgj6726PhT2j7KA64EbiUH
         JwCIZu6gf/G8eO2FALDLKhF3r5VZGC0+e+isR0AN0nFGLkfx4hBCZZQl2Wec5C1qI2Oj
         NBvmtI4Y88G++6y3EGo4+N6WVzJ31qFCsma7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783079788; x=1783684588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gzs61HZr2e08vLjlcHcnU81Qx3P3Xyhgqf6PYo21bZc=;
        b=DOKcNcWCHnFUfMlcIy97HmrX8s/cHE73zCRYnnan4DHZBOnMVMXAoEU85o72AKljOe
         YMJUIDz4WzZIDXQjX8wjGkbvJ4UZmfwiw/n2Cqfvfmh60H89/QrkQXa+gU0TY75khqw2
         k2eRjG3tCascYv+IiPPhGUkH5oN/YmHPRP8ZGX1F325dxqVy4bqRttjOoDha406HRP5+
         W6ptOPnDzvSBeHUBy8phv3dBqsG8KZVm464XFiafanPjVrsn1EndripqN6ZzqOlx4eiy
         G5RQTqRaubkjB3rESzUGGj0I2MSEF+LIKOHL3oCrbE1KIi/3YVtmR9JJ75WanmStFKRQ
         X76w==
X-Forwarded-Encrypted: i=1; AFNElJ933sOIdGX+N9zM4fwGBZvwvPefyw7A/pYsX6eSLwHXkiBS8BmZ0loW5w2p/fgZnJIUHybnSs8Tbgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywluf5jdYg2dbDYjC3HhIrkQiXKrMxPcsnsDW4+oMt9+NhZmFcL
	sGQFWM4vTPQst321F3ZASJHUjqlv0zrT3CfA7jHt2euRx6d6nNTwcxcs5dPiLoUI4w==
X-Gm-Gg: AfdE7cnecPX6ZDKWLXAiEItSVkyj7u/siFqGcID4FlBPI1cWN8vMZMoxCurmiKI3dVS
	2+Wxekl0el8wg4b5bGsKiwfXb9I6z2c6H6xwgv8hQoqJ7Vl5RyfVLEiivbXtgHND1MW2AfDkuZE
	EVRrvaKgHCQj0JRFQ42SOsCWV7r0lIreE8FYN+YjhLfpI3mo6wRSqktdMai7zr0Gdt8/Bx+FAJ8
	pSEKH7s9OrD00Ua1bA6vpgvSSlOanOsIbIvM74eCMHxRWbz1TCvNjPBdtSxOhFHzhv9y4b9n0pn
	BMS03hUK0MurtoPHq+/Fy18FpkNcNOAEmLX7WhFZnPVbIIxBzWqruZci9JqAep6fEHmePQMtLAQ
	LCT8S1Baz1fTArTxnPUaagM7VQUjjTyfy6Pel2MtRSdWKXGm1MRO2vns9OnfMH71OQbYYk6T/tQ
	qy9jbfYPeQd7Vgxcd/790Nw5InmvhtiUuCou/LuCm0LdSVpGA6i3W+ZF5Kl5Lhe9N8JSZQYQ==
X-Received: by 2002:a05:6a21:1f84:b0:3bf:77d7:667d with SMTP id adf61e73a8af0-3bfed47019dmr11801134637.28.1783079787514;
        Fri, 03 Jul 2026 04:56:27 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8bd30ca5sm2569540a12.0.2026.07.03.04.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:56:27 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
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
Subject: [PATCH v2 5/7] platform/chrome: of_hw_prober: Add delay for hana trackpads
Date: Fri,  3 Jul 2026 19:55:58 +0800
Message-ID: <20260703115601.1323491-6-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260703115601.1323491-1-wenst@chromium.org>
References: <20260703115601.1323491-1-wenst@chromium.org>
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
2.55.0.rc0.799.gd6f94ed593-goog

