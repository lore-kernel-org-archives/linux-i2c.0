Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1692A47D44D
	for <linux-i2c@vger.kernel.org>; Mon, 12 Oct 2026 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799731; cv=none; b=FPPQRwpAM5s+csJJR9v+A6+GFylwrGDDTniGWA/9ZrCDzGg5+egfgpCmJruIhf4jQw/lk8lWx/8CY7CPqnmfYc/UTy/RPOSj368WzlqCZDwXahvkBqmlqgNRGD08cXInaNhi2sHDf9TszD8XZN4Mijfyev5iA9mnfRXctae2IuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799731; c=relaxed/simple;
	bh=8Mnnl0Z3pOG5cs0RKth4xk3lylmk99qeafTSSPrIRo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ukYojl0NI7q9RgMpvYhdtegRY5vC+CGxwZGVJbpCb1i1GZi/fGErT/+6AJu8RLe9MmYrkHvoRNaVhpQEo0H0ng/Bhg/RKadRelSlw7xQjQmZtxoXy5AbqfZWW8i9K3v909bnnxzHsEhZuNBNYo36X19IdtauVVZITH/bS4/Va+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kC9HoJS2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC9HoJS2"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-487049569b6so1173479f8f.1
        for <linux-i2c@vger.kernel.org>; Mon, 12 Oct 2026 03:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791799716; x=1792404516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=58Hpz3IL7+FBFo99aVZrTh8mHeTaosnWqfT/ede3fC0=;
        b=kC9HoJS2nVLRsUWKN3F5hqe0CP4h6oBT2igIDW1TkWOgwyCJWxPPfjNSSJzMSJxmQh
         LQV2XkXu0uBKcH894XYlh3ANsyCW8Os5FUT9g8uSqQ/uR/sXNrRRrMlC31AqEh+oicnA
         aJrOihq0Gm7ew8ks+4XcSo+A+CiXk49nINmVeM3YfN7w63a6HFdIF8nAtBS7HKOCP5h/
         q4KiBoDnhylbgjKSXP1XKqGNQwhzaZ7K7Qv6iHeLYkEsi67HxJ/f7Wmg3nN0qQX+sMWB
         Fs7W2okVDyJh5HgO82D+cnzB5/aXd2pgm87X1bcJKTmwqfi/lY8D+vKlzM0oteoFv7Of
         rPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791799716; x=1792404516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=58Hpz3IL7+FBFo99aVZrTh8mHeTaosnWqfT/ede3fC0=;
        b=NT+Y+lMDFYjit5xaviJIRSMtfssJA6Dg4Mmg5scFD4O41xeIMgElC7DjBHxbL1SrFn
         VS0qPWtyKmbNzV7KCAyiVnzwRivgRuMj/fJImzm5D8mEkksLz7sR4KCMbnVyVYDjHiep
         bbfIhxUsAvCIiZTnxoXAjzgFeioe10dPY4oLCrBoaPnCPeDPiBKuxpInGS7gW/YjsfEj
         /rcM3/vlNkPEfm3v/CO4YzOgfHaqC8g/oipWMO+vLP78r9AiRGS0faQtPdXWAwN+9cIx
         AdVUPC14PvSEoUKLQIFoWNqiKP+SPZJ2lPXPdWHvvIEidXJVP2aA47AypO03OL89HNH3
         hgQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwx4G/6qQJI8I/g+jWopz1gGa82dXHB2gKQ0HfNBTj/rch4LHuU2UoBT32Mn+FGlb7HeQYwsGGx5w=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+qN2H2nRsrHajyJrApKzGLYBVMnTYvPV4p/mjgY7sqVy9ODCB
	Bw3ydXG+owjiTdLxT3gJH5cZDQJ6YFYgbdernJS8iZ4SJYC4HByYZIXX
X-Gm-Gg: AYBFou1zyhSjqrdwQhsv3tH57prrf5o+aDYVuLqAEts4S597Vw0I56CjrpTO5eUSkQq
	iAARyY4qmDPFFX1uTNiSKuZElqUpZAyMztuYygR/D/0XhpgEYfC6S1+7E3dOPf7kdc7xRD7b22b
	SWnzsCgbQ3RUYINQjVluip8G+kjc2qugYQAvvGo4woGGyKzQdbOS5ZrYIvC+poxmKhqA/T4CWlb
	FYH4emtPLHtksTmt3JewhFtIviiLLujUpHZjaYNm3e5TknCfqGpUg7BSpGXpLh0fidveqx+055e
	uZ1cN/EQ94ppDb9pWio9rmVhES3oU08jIugxCY4AeIYol5vQ5qgQHoxwfhHtXa/0/TvM6UgPCh1
	cjGP5PobzFpGrMVVjCZMsfRb0Pfi7k0MkHV4ZGAOXUg1VQrG72fLt8In8i874Rkpv6o1oVsJ9w9
	ActJwK86OsOW7JrgG/1+0oms/Fg3/GMRVOQEX3GlFIcpqft8iTU8KS1a286wBHfzCMDWs+QUaev
	XdLbfs2JdG9fnZppEQVZPSAtbiO3tYs
X-Received: by 2002:a05:600c:64c8:b0:49d:1df6:2592 with SMTP id 5b1f17b1804b1-4a18e4c41b0mr155420775e9.21.1791799713755;
        Mon, 12 Oct 2026 03:08:33 -0700 (PDT)
Received: from debian (ip-78-137-176-146.broadband.digiweb.ie. [78.137.176.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a192d3efb6sm166229885e9.1.2026.10.12.03.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 03:08:33 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Pablo Mazzini <pmazzini@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v4 00/11] ARM: sunxi: add Allwinner B288 and the PocketBook Verse
Date: Mon, 12 Oct 2026 11:08:05 +0100
Message-ID: <20261012100816.331033-1-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner B288 (sun8iw10p1) is a dual Cortex-A7 SoC used in e-book
readers. This series adds the CCU and pin controller drivers, the RTC,
I2C, NMI and watchdog compatibles, the SoC .dtsi, and one board: the
PocketBook Verse (PB629), a 6" reader.

The B288 is closest to the A64: most of its PLLs are bit-identical.
The clock and pin descriptions come from Allwinner's BSP, cross-checked
against ccu-sun50i-a64.c. Tested on a PB629, boots to userspace.

The pin controller relies on "pinctrl: sunxi: dt: number the IRQ banks
from the first one that has IRQs" for correct PIO interrupt mapping.

Changes since v3:
  - CCU: reference parents with clk_parent_data and clk_hw pointers,
    as newer sunxi-ng drivers do; add the audio PLL's sigma-delta
    settings, as on the A64; fix the PLL_24M rate and parent the PLLs
    to it.
  - RTC: register the 32 kHz clocks, reusing the A23 data (Sashiko).
  - DTS: take osc32k from the RTC, as on the A64.
  - DTS: allow the eMMC up to 150 MHz, as on the A523.

Changes since v2:
  - Drop the MMC binding patch, applied by Ulf.
  - Rebase onto sunxi/for-next.
  - Constrain the RTC clock outputs and pinctrl interrupts in the
    bindings (Sashiko).
  - Add a B288 watchdog compatible (Andre).
  - DTS: drop the memory node, the arch timer workaround and the
    sunxi.c entry; add disable-wp and the eMMC 1.8V modes; DLDO1 no
    longer always-on; mainline pin function names (Andre).

Changes since v1:
  - Add this cover letter.
  - Drop both new bindings; add the compatibles to the existing
    allwinner,sun4i-a10-{ccu,pinctrl}.yaml instead.
  - Rewrite the pinctrl driver in the DT-provided pinmux style.

Pablo Mazzini (11):
  dt-bindings: clock: sun4i-a10-ccu: add Allwinner B288
  clk: sunxi-ng: add Allwinner B288 CCU driver
  dt-bindings: pinctrl: sun4i-a10: add Allwinner B288
  pinctrl: sunxi: add Allwinner B288 pin controller driver
  dt-bindings: rtc: sun6i-a31: add Allwinner B288
  rtc: sun6i: add Allwinner B288 compatible
  dt-bindings: i2c: mv64xxx: add Allwinner B288
  dt-bindings: interrupt-controller: add Allwinner B288 NMI
  dt-bindings: watchdog: sun4i-a10-wdt: add Allwinner B288
  dt-bindings: arm: sunxi: add PocketBook Verse
  ARM: dts: allwinner: add B288 and the PocketBook Verse

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 .../clock/allwinner,sun4i-a10-ccu.yaml        |   1 +
 .../bindings/i2c/marvell,mv64xxx-i2c.yaml     |   1 +
 .../allwinner,sun7i-a20-sc-nmi.yaml           |   1 +
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |  22 +
 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml |   3 +
 .../watchdog/allwinner,sun4i-a10-wdt.yaml     |   1 +
 arch/arm/boot/dts/allwinner/Makefile          |   1 +
 .../allwinner/sun8i-b288-pocketbook-verse.dts | 114 +++
 arch/arm/boot/dts/allwinner/sun8i-b288.dtsi   | 292 +++++++
 drivers/clk/sunxi-ng/Kconfig                  |   5 +
 drivers/clk/sunxi-ng/Makefile                 |   1 +
 drivers/clk/sunxi-ng/ccu-sun8i-b288.c         | 749 ++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-b288.h         |  10 +
 drivers/pinctrl/sunxi/Kconfig                 |  10 +
 drivers/pinctrl/sunxi/Makefile                |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-b288.c    |  49 ++
 drivers/rtc/rtc-sun6i.c                       |   5 +
 include/dt-bindings/clock/sun8i-b288-ccu.h    |  82 ++
 include/dt-bindings/reset/sun8i-b288-ccu.h    |  45 ++
 20 files changed, 1398 insertions(+)
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-b288-pocketbook-verse.dts
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-b288.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-b288.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-b288.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-b288.c
 create mode 100644 include/dt-bindings/clock/sun8i-b288-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-b288-ccu.h

-- 
2.52.0

