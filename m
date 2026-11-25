Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610658;
	b=nbAeEfop+A0nefcFoBx4oblDyrjeNDdGvkAVEcsoOTbwEfAgDqO5p65utcamUzKCCWVl
	 eHp7GIua60PS/FDe5OS13NZ0bTJfWQbX1tyIvQ+OA49l6ZS684Q46MdVDVKvmrhcHewmf
	 EUvQq+V/kSUdEN1azAmqf1fMVMP2CQ/Juf2tXfj06jH3OsJ5F1PTeiz2Qsot9tGABOYOz
	 2ucfgeAiqxZztLoeV0KnBnYqHHUqE30rvoaPdzSzIJ7kSQE4mcRXgpNO0HmHq0TTQpwnV
	 wU0seu+dFkmiNYNy+QHhiO7VLZzhDfd5B3BZmm3OnPaNArVPelSpbPeO7wddN7sj1qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610658;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=B0GAGZCB4wcz4EWht71Bhu3l8vS6nHzZaxGeRP6mJPA=;
	b=w1d4HNSYmJsp4aR14R09rVUdwQLbDv/2TkSKZBR30TV4pmB75Anv88jPmX2rnrYKRTQA
	 xrpUGMFx5TV4P/hRYmn/Ni6HIMFnEXGQaMGnbklvi7Gn290xtcvuww2sFPIpPkmprY1pn
	 JBCsbCXVCfK+ndfgvmMlzaFCMyY1DFM7XPEZW5CiJ5zdJ/rmeUuU2sgWsw1rsl7Y6GFKj
	 fe8Kj/V38lWN4er/31Yz2WjXpFlktCbyACJjUd6r/6I5uhz1OH8Zq02Yv+tNljZIEYTZ6
	 AymRrOcbslc0Dwmm3eherSsH0P49SGTT0hAkO/+AfZruMo8S5IFZleMNwc7+adSVAug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=nmtyNYBk;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE2C606A327;
	Wed, 25 Nov 2026 12:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CE2C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=nmtyNYBk
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 8FEE64C936;
	Wed, 25 Nov 2026 23:44:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1795610647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B0GAGZCB4wcz4EWht71Bhu3l8vS6nHzZaxGeRP6mJPA=;
	b=nmtyNYBkFvc+wb09Oh/TGJs+Ek4VqEhtEtxptzrmjCOSD2qemtgAf4OMEqZhLVyhURzpv0
	TlxmzqLjKp6XjmzWSCQQg2kw/8bZQUOCgtEx+5+8iDPAUdR0vSf38tLunaII2/Tumwe0pO
	oe7Br24ZitijD7xDQWvOQ+7trLYJqhonBSgI4yWuEyOAzJxtiWu5BXAN37oj9ZLUJ5L8TF
	jHjBmTmd6SMKLUXOL3EZILjhDK3HQa3OhMwXnW52fnczCdhaeJ6Cyh1gQTTFM3rnCb+nlg
	Dxk9Osviesfs1DiBBDx9eZKegxLdei+R76+pki65y0oeY8wM1zL02Fv4nhWN8w==
X-GPT-Reason: legitimate; the email is a technical software patch
	submission for the Linux kernel, which is consistent with the sender's
	domain (alastair@d-silva.org) and the technical content; the subject
	line and body describe specific hardware support (OrangePi 4 Pro)
	and include standard kernel mailing list conventions like "Depends-on" and
	"Assisted-by"; the URLs provided point to lore.kernel.org, a legitimate
	domain for kernel mailing list archives, and there are no signs
	of phishing, urgency, or unsolicited marketing.
From: Alastair D'Silva <alastair@d-silva.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 0/3] arm64: dts: allwinner: Add Xunlong OrangePi 4 Pro support
Date: Wed, 25 Nov 2026 23:44:04 +1100
Message-ID: <20261125124407.4098345-1-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial devicetree support for the Xunlong OrangePi 4 Pro board
(Allwinner A733 / sun60i-a733).

This series enables the UART0 serial console, SD card (MMC0), and the
AXP318W PMIC on R-I2C0. It also documents the allwinner,sun60i-a733-i2c
compatible already used by sun60i-a733.dtsi so CHECK_DTBS=y passes
cleanly. Audio, WiFi, USB, and Ethernet are omitted for follow-on
series.

Depends-on:
- A733 CCU v7:
  https://lore.kernel.org/r/20261112-a733-clk-v7-0-db7c5451ffa2@pigmoral.tech
- A733 firmware clock v2:
  https://lore.kernel.org/r/20261112-a733-fwclk-v2@gmail.com
- A733 pinctrl v1:
  https://lore.kernel.org/r/20260910133519.459011-1-andre.przywara@arm.com
- A733 pinctrl IRQ-bank RESEND v3:
  https://lore.kernel.org/r/20261124215048.42074-1-pmazzini@gmail.com
- A733 pinctrl voltage-mode v3:
  https://lore.kernel.org/r/20261109-a733-pinctrl-v3@gmail.com
- AXP318W PMIC v8:
  https://lore.kernel.org/r/20260910-axp318-regulator-v8-0-e906a61a7f3d@baylibre.com
- A733 8250_dw UART v2:
  https://lore.kernel.org/r/cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com
- A733 SoC DTSI v5:
  https://lore.kernel.org/r/20261121-a733-cubie-a7s-dt-v5-0@gmail.com

Tested on OrangePi 4 Pro:
- make dt_binding_check and make CHECK_DTBS=y pass with zero warnings.
- Boots to /bin/sh over UART0 with RTC, pinctrl, PMUs, and earlycon.
  (Note: ttyS0 hits the v7 pll-ref 22.15 MHz bug reported separately.)

Assisted-by: LLM

Alastair D'Silva (3):
  dt-bindings: arm: sunxi: Add Xunlong OrangePi 4 Pro
  dt-bindings: i2c: marvell,mv64xxx-i2c: Add Allwinner A733
  arm64: dts: allwinner: Add Xunlong OrangePi 4 Pro board

 .../devicetree/bindings/arm/sunxi.yaml        |  5 ++
 .../bindings/i2c/marvell,mv64xxx-i2c.yaml     |  1 +
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../allwinner/sun60i-a733-orangepi-4-pro.dts  | 75 +++++++++++++++++++
 4 files changed, 82 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun60i-a733-orangepi-4-pro.dts

-- 
2.53.0

