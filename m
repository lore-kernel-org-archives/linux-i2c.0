Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F20844102D
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450835; cv=none; b=dxLOKZ1BAOZM0yYF7EaFtAubjnsIAzzRwswv8DbDQED+XdPTQGKjxxYWTzFYwuPIa253TysFGG7knKBb8aLh5kHgJ7Qxqzb2dYpGsTdRiD2i9Fx/JSJkTm2MiPomsxI3MFppIH2iwFju/wWsxwqzTjMIHSiF0Xrb1uEGB+R3qms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450835; c=relaxed/simple;
	bh=z3+Ivh2jCKhd8EuEEzRHJUPYWNvKLd1Q/rinjxIyM9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ps9fQOA1JYawyzvHrMkjXvo1gXtxXogLUpca6vUDndC6bJbD3+9kFHuAalCsLMFwfvWVchVRnuvYsSGJP53kejWxNjGgPJ5+q4qbbaEfvyvAlD/7VJmckUoFEF3UyHzkghGzO3lG+fo4MEDJu1js+N2mPWpmFCRePPJg2YIlh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e4o95Xdd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e4o95Xdd"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so750348b3a.2
        for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 05:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786450831; x=1787055631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iDHJIqp5FLLywri4WBqUbQEMXacNkK0ILuDy9FjFATE=;
        b=e4o95XddhIuH8EX9nfVTvDTSIqGRI2lyBhnra/cplPNt20aNbeGQFWZ4WLFNH+O3/c
         SQ++UY95jGc978dyiksQlaGAMY8Op3Q+r/KvFzIugsjG9wRSsETm1bIHNilPp5385jBE
         oAb6XaDi3F9hOf3GjFy3Tp4vNLaIbYUTk+eOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450831; x=1787055631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iDHJIqp5FLLywri4WBqUbQEMXacNkK0ILuDy9FjFATE=;
        b=gDra7Ij3ioL1KpXSmvKl5mzJgFYyW04bx9P6pWDK9mzqLIA//fpNUU4n+CJvNHk6oX
         Hv5+tJ0uXyENUOtLAN98PfSc4fNss0ynB2XwJb42nXGXoJFzb5/8m7hPgCAH6Vr9kr70
         +Bks8WHC3Vbk+5SlfF3G3+IJ/l5gyeihsw2eAaaUGAWf+JmzSzRhXNKPzYY9vgkIbQTp
         cdyDzRTMPuz58CkGlIqf2zbe9ATxeKx2y8OwNJyz3Tjd52F2roYYbU9quqgRJ4KxIwZ9
         NmEJ8qOWtAmjyToswVDTPiGGQYysq+CAvT0F/TSmuvwpPyP702gL6kcQ15esmZDC9lef
         Z2jA==
X-Forwarded-Encrypted: i=1; AHgh+RoAJQKBozLGgTMyNk8EUcaNJpnlmtFTrYCQ1iKCcesjjv+RLWwSAduWHTDvhgycwdp/5/+gk1La/oI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw10xhhFoXYjCLpLI/pweu4FQoUEcg5Uj4/IrjLVPozIhuLo4DH
	q7lSvMqjliocYehVfsfUCoJEAFNgrgqoM9UyzGQpLcbJmeCs92lqJIWqa0mkNX65dw==
X-Gm-Gg: AR+sD13p5SqXAGQpneKFMgOF6hSpmozpjb4adIHMFmoId+8/CM6v3xnyt/RxSyqRsQb
	ohcUFPewmiuFJ8HDRqmnOX3vdqcx+fKIkRgG+yE4iIiq53rzXVlZXmAa92SUni+PwH2Xi202hfL
	HyZTwJvuJvp0hoJtclB+HUvdEWbi5KjCsN7ML8fAy1ZvBRgWhibYaxHBRZy4RG8wc84avaR8XHq
	eMGaKISJUMSlQZ8ziw1ahajQh7tCKNgyaB9U8pMQ1K+WtBu01e5f7RlhCg/EGlv6YANb9ZapX0r
	S7FvaV733AfMNYNQJtjArKgNeX/bpmpF859drlxwQ9Of894VzFosMNwnWGnwUkNODPG5v8uXc7f
	E4LPQ2ZEp7ppiKRc6r7tTAL/AsIKtpqaWzpqw9O0AcuVnvAFThnCOTsdL6sKv9bFzmzDz3tjVzC
	acBLA0uUzku+aRL97JivAaDe2raVWAh/PCzlwPa71wz8NditkrDKPmxGa59c4/fGD3+sQ3Q7YEE
	P4bet8lvW/LxGEiB3LWX+5UjhSrh/lxynuitJu47BwkaQ==
X-Received: by 2002:a05:6a00:9286:b0:848:63c9:ee39 with SMTP id d2e1a72fcca58-84fa8842387mr2815346b3a.12.1786450831335;
        Tue, 11 Aug 2026 05:20:31 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:12e1:df26:6add:1ea7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa9574e9dsm662454b3a.54.2026.08.11.05.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:20:29 -0700 (PDT)
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
Subject: [PATCH v4 0/9] arm64: mediatek: Chromebook trackpad supply fixes
Date: Tue, 11 Aug 2026 20:20:00 +0800
Message-ID: <20260811122011.3539250-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This is v4 of my Chromebook trackpad supply fixes and optimization
series.

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

Patch 2 cleans up header inclusion for elan_i2c driver.

Patch 3 adds the correct enable delay after enabling the supply regulator
for the Elan trackpad to initialize. This uses the new "enable and wait"
regulator enable function.

Patch 4 applies the same logic of skipping the power on delay to the
i2c-hid-of driver.

Patch 5 applies the same logic of skipping the power on delay to the
i2c OF component prober library.

Patch 6 adds a delay between when the device node found is enabled and
when regulator_disable() is called. This gives an asynchronously probing
driver some time to increment the enable count of their regulator
reference, thus keeping the device operational and allowing the driver
to skip the initialization delay.

Patch 7 adds the correct delay for probing trackpads for Hana devices
to the ChromeOS OF component prober.

Patch 8 removes the "always-on" setting from the trackpad supply for
Elm / Hana and adds the correct delay to the second source trackpad.
This corrects the hardware description.

Patch 9 adds the supply and power on delay properties to the Synaptics
trackpad on the Spherion device. Combined with previous driver changes
this should cause no actual functional changes or delays.


Please take a look. Patches 3, 4, and 5 have build time dependencies
on patch 1. I suggest placing patch 1 on a separate immutable branch
or tag for the other maintainers to pull in. The three patches all have
different maintainers. Or if it's not too late, Mark could take patch
1 for v7.3-rc1 and the rest can go in later.

The DT changes must go in after all the driver changes land, especially
patch 3 that adds delays to the Elan trackpad driver. Otherwise the user
could potentially end up with a non-functional trackpad on the device.


Thanks
ChenYu

[1] https://lore.kernel.org/all/20241001093815.2481899-1-wenst@chromium.org/


Chen-Yu Tsai (9):
  regulator: core: Add "enable and wait" functions
  Input: elan_i2c - sort include statements
  Input: elan_i2c - Wait for initialization after enabling regulator
    supply
  HID: i2c-hid-of: skip post-power-on delay if powered on sufficiently
    long
  i2c: of-prober: skip post-power-on delay if powered on sufficiently
    long
  i2c: of-prober: Defer regulator_disable() on successful probe in
    simple helper
  platform/chrome: of_hw_prober: Add delay for hana trackpads
  arm64: dts: mediatek: mt8173-elm-hana: Unmark trackpad supply as
    always-on
  arm64: dts: mediatek: mt8192-asurada-spherion: Add Synaptics
    trackpad's supply

 .../boot/dts/mediatek/mt8173-elm-hana.dtsi    |  8 +--
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi  |  1 -
 .../mediatek/mt8192-asurada-spherion-r0.dts   |  2 +
 drivers/hid/i2c-hid/i2c-hid-of.c              |  9 ++-
 drivers/i2c/i2c-core-of-prober.c              | 25 ++++++--
 drivers/input/mouse/elan_i2c_core.c           | 23 ++++---
 .../platform/chrome/chromeos_of_hw_prober.c   |  4 +-
 drivers/regulator/core.c                      | 64 ++++++++++++++-----
 include/linux/regulator/consumer.h            | 21 ++++--
 include/linux/regulator/driver.h              |  2 +
 10 files changed, 105 insertions(+), 54 deletions(-)

-- 
2.55.0.679.g6767b8d81c-goog

