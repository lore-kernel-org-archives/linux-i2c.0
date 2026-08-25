Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81B21A23A6
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787632412; cv=none; b=URuXUvBgxI4yL+rYPY2QS5iR/3fxPwC8bKdLC2YCKmOCYoBR2gSrrIpQ1VtOJ3s5V9XYT+EH+yPYB8dAHt9x8AVef7VmdgGBcsA7dOP7WPhCubo924w1hkh3zGC5YHHWglFPvuE7ZFaSwZRjypkIUiid6o01SAX2RaD8EuyMwqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787632412; c=relaxed/simple;
	bh=naC7PasILh7V9am2ebalC0RbUKLTLStW+MGCGU/CcoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oeb+jpmGGf9pnNcKd+T3HwskOFy0sxJfuM6xEPFojp7Pe5rGSeHWdhjatdqWrWg2I5aSPQR8QbmNWOcPiURV6bUBRxZXlM6GjYsowRKmVkgPbvpxRdLMLib7YUVgRgnmL4oJj4jEg9YVrgCeO0s7CtU+bCXFivvGiM4Wg9hpIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y7/B5QMb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y7/B5QMb"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso4905549a91.3
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 21:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787632410; x=1788237210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hJaZXX8cNoxV0uNCu7A5Ojv5p0WSmZqW9OZzrJevJb8=;
        b=Y7/B5QMb+bCNmBRydiHDAb0sTpa1MQeSmvK9vTYEJL9T+vmFeszFsm2P6YpK5bLwxA
         +Qsl6cXxJP6rNA5DBC361ITOjnWz6K59fH+gtkOf5u154BkIDnljl1yEQxUVL5hddrRq
         lgM+KFcHWuLXdUGm/1TG4b++LO/416pGprfrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787632410; x=1788237210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hJaZXX8cNoxV0uNCu7A5Ojv5p0WSmZqW9OZzrJevJb8=;
        b=FySFbqRIFJcsVgvXnpdmS12e0RqzPJpOMrkjjflUiiyxwpoxUrcvoZd0qmmB+Vwd2k
         fjc9lNxDykztiU9adXgdg4o9wnbA1sZxYBUmEV9sgPvLYpUnHfGicwzANVvKvZtUWXR4
         WOBLRpkIZt6hNVYcjmhOO6wMSq4oEUTBnFVTYEMQAT1anOK2XBopQRuApNwqqVf2NQ5v
         kE4jnm03flQLdZX92QqjKwvRkDOwkEX4Q9i+hlCznIg7Cus19tsTdnDNHLlTGZdO2Bjq
         feTWmteAH5ZxIuSLgxEWiNjTAhz7gHZ9BR1r+7t57s/o6KQuS0e5iPNWBkUy7aq5rDXM
         01cA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+eotj7Ih5/tBfNb7OOCTdgx7JLHV7uYd5iAJjhmPADccUnkMaTEZx7u6mWQmkeKRBErj5g0Bo7+Y=@vger.kernel.org
X-Gm-Message-State: AFuF++kkLs5SsZ6Rlm+BRfdBzAPEUe41f5Q5HEbaGQU4LWPgrjM/03wO
	tsIOz6FLltMvCPcAZBf2bI+4rO0iE/DT0GtSqBK7gA6UWxLQvMfvXCVQelQelU9YSg==
X-Gm-Gg: AR+sD1232SVLv87ojNrc3f6hGpTVjINiamfLJKAY052gsDoQW/QWJf1dDfUtYppwc8b
	Pshnfxgvooj/Ax9tZ2BtZ3EDZ6IrKF+PvdykwdZRnGRPhzN9cQNh1/bm06760dHP2fQeFrZxlBC
	NIZlW5urWprMI4jHASP/1Y52r291i1Z97mk1N4EiTefRlh30lbw07YbtSHvsCuCQXbQ3Kw+3oVx
	j+DC/rQ15wJQ3AGcdoZWjC61wBEwRgJ5Fq48xHBsN0vMjkSrXw6lJWNzD5vXrJNfL6w9n9lKDm7
	6e4A/74VfEp4duZscIS6Fk44wpVxqAztfBIfYz8jm3Q75jweDzOg7AQOMTqG56hXUWbQ6e4mLv/
	63HUjoaa2nUf6wsXofsWE6bNeO3aRtfOz3gwh0L4S3e/x2YqZwApHVi7rYoNDvFDqYfJUNmSIcn
	H0wVpfH7jXOLSxpfZLo/OfJhWvQ8eQJ947LZbyazKYZbA83+4UvQi5HI8Jw0n4ZfShLGR55yjhh
	aGYUGRwImuDrhoXfFFTjK9VN3Jnxmfiq4/HMNYoNH2k4D0=
X-Received: by 2002:a17:90b:1b04:b0:38d:dfd1:7c1 with SMTP id 98e67ed59e1d1-395c33406e0mr52907259a91.2.1787632409907;
        Mon, 24 Aug 2026 21:33:29 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:a442:9780:24da:cb4e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396458212absm2187823a91.0.2026.08.24.21.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 21:33:29 -0700 (PDT)
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
Subject: [PATCH v5 0/7] arm64: mediatek: Chromebook trackpad supply fixes
Date: Tue, 25 Aug 2026 12:16:18 +0800
Message-ID: <20260825041628.988369-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This is v5 of my Chromebook trackpad supply fixes and optimization
series.

Changes since v4:
- Made regulator core try to set last_on timestamp for regulators that
  were left on by reset default or firmware, but not enabled in kernel
- Dropped two patches that were merged
- Link to v4:
  https://lore.kernel.org/all/20260811122011.3539250-1-wenst@chromium.org/

Changes since v3:
- Added __private modified to regulator_bulk_data.wait_us field and
  switched to ACCESS_PRIVATE accessor for the field (Andy)
- Moved wait outside regulator lock scope (Sashiko)
- Moved "remaining" value assignment closer to conditional (Andy)
- Fixed variable unit name in regulator_enable_and_wait() prototype
  (Andy, Sashiko)
- Added commit message section showing average delay needed for I2C
  prober (patch 6) (Andy)
- Link to v3:
  https://lore.kernel.org/all/20260721075226.2347933-1-wenst@chromium.org/

Changes since v2:
- Added new regulator "enable and wait" functions that wait until at
  least the given amount of time has passed since the regulator was
  last enabled.
- Converted patches to use the new functions
- New header inclusion cleanup patch for elan_i2c driver

This series fixes the trackpad descriptions on some MediaTek-based
Chromebooks: either the trackpad's supply was set as always-on to
workaround missing delays in the driver, or the delay and supply
are missing from the trackpad's device node.

v1 was just the first patch [1]. It has since grown to cover multiple
drivers and devices.


Patch 1 adds new "enable and wait" functions for single and bulk
regulator enable.

Patch 2 adds the correct enable delay after enabling the supply regulator
for the Elan trackpad to initialize. This uses the new "enable and wait"
regulator enable function.

Patch 3 applies the same logic of skipping the power on delay to the
i2c-hid-of driver.

Patch 4 applies the same logic of skipping the power on delay to the
i2c OF component prober library.

Patch 5 adds a delay between when the device node found is enabled and
when regulator_disable() is called. This gives an asynchronously probing
driver some time to increment the enable count of their regulator
reference, thus keeping the device operational and allowing the driver
to skip the initialization delay.

Patch 6 removes the "always-on" setting from the trackpad supply for
Elm / Hana and adds the correct delay to the second source trackpad.
This corrects the hardware description.

Patch 7 adds the supply and power on delay properties to the Synaptics
trackpad on the Spherion device. Combined with previous driver changes
this should cause no actual functional changes or delays.


Please take a look. Patches 2, 3, and 4 have build time dependencies
on patch 1. I suggest placing patch 1 on a separate immutable branch
or tag for the other maintainers to pull in. The three patches all have
different maintainers. Or if it's not too late, Mark could take patch
1 for v7.3-rc1 and the rest can go in later.

The DT changes must go in after all the driver changes land, especially
patch 2 that adds delays to the Elan trackpad driver. Otherwise the user
could potentially end up with a non-functional trackpad on the device.


Thanks
ChenYu

[1] https://lore.kernel.org/all/20241001093815.2481899-1-wenst@chromium.org/

Chen-Yu Tsai (7):
  regulator: core: Add "enable and wait" functions
  Input: elan_i2c - Wait for initialization after enabling regulator
    supply
  HID: i2c-hid-of: skip post-power-on delay if powered on sufficiently
    long
  i2c: of-prober: skip post-power-on delay if powered on sufficiently
    long
  i2c: of-prober: Defer regulator_disable() on successful probe in
    simple helper
  arm64: dts: mediatek: mt8173-elm-hana: Unmark trackpad supply as
    always-on
  arm64: dts: mediatek: mt8192-asurada-spherion: Add Synaptics
    trackpad's supply

 .../boot/dts/mediatek/mt8173-elm-hana.dtsi    |   8 +-
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi  |   1 -
 .../mediatek/mt8192-asurada-spherion-r0.dts   |   2 +
 drivers/hid/i2c-hid/i2c-hid-of.c              |   9 +-
 drivers/i2c/i2c-core-of-prober.c              |  25 ++--
 drivers/input/mouse/elan_i2c_core.c           |   7 +-
 drivers/regulator/core.c                      | 117 +++++++++++++++---
 include/linux/regulator/consumer.h            |  21 +++-
 include/linux/regulator/driver.h              |   2 +
 9 files changed, 149 insertions(+), 43 deletions(-)

-- 
2.55.0.860.g4b6b3295ed-goog

