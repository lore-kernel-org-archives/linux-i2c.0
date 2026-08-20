Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090743BDBB
	for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226487; cv=pass; b=K20qCkdejknruWrTVnr0idTVNgvcoNCH8/+jSG83FbhfAmqkc+1ZjKZ6lxOUcMy+DW7FKUKLSHp8sPQTvZNa/5adEOUu7ZmuELJulU55RGv1/u+0/d1ujAm1gn9Yaz5XwEChdmgSunUzORbVS0wjr7v6XpamhEVC5LG3Ajeyb5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226487; c=relaxed/simple;
	bh=N3XcxuvKeFv0jrHZq7jORW96HDTgTe/U58U3ymleexw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kC5mhXJiPpPK2pkTY308hwFCHWUrPE/6KEMdBOEB+1PawsGbIXsdDxoKSmG0pIY/xX9u1K51n6AtgHB9L3s8hQgDsDNlRXbyPI3ik00Lufq4GsPwCK/KZuL1NX0FH54H20ZN+1SN4yuGCgbpo9KDPFH8I/RmI872dD8IOnVmVEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h18HZxoa; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h18HZxoa"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c197eaaab00so391253866b.0
        for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 04:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787226482; cv=none;
        d=google.com; s=arc-20260327;
        b=N+M396368UCkyG6pog7nApbMwE7PomsVCLulfn+THDY92ZGPODsIRWHlnwuGMyGwdp
         hz6bmRbkf3ElwY0sVEio7J2v0mQ1pI3aZcZJDxVBmN6ILhuLPdNxAFXzOShSW3HQjl4q
         l5Cya+xNP9PxlPCND3mai9xpg04FOBS31dddrriWt50Sgma4IL0oekWh2fy2erkHb+Gd
         YsvoJ8uqQKVnI8HjDpc7lJnw0cCa9dF2mJCsnmLG9/DECdqRh5exQU2yQV3jyUsyy+D3
         2PBRuT7q8hLWQsYF8SlbHOypMVvomd1fkKXr8y9Gl8ewImo0he2XWhynS2IgP3bUybj3
         tx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=M4ykTKD26brTAJUSy1BqDUBmv6bxfPzSIe8lWvsCYHQ=;
        fh=q+FLwBFJz6A8kXvuJ8xsU0qnw5cjSUzkML5MosrXAqE=;
        b=GtJIhGWzMotiBvzv0fS9iZp6Dg2o1nl2luDesip3KiyX2t0a6u/ekMCYNgPMRd2Mz2
         wQ92JXiUvL44N0Ja4s8MfoCSdGr5HS2hkVUANSDo8ZUXqQT4KsqlTL1NY1vhjX7Ipuzx
         Y6j1fee/rJrCnOv2vxBzX4HVkQBUpq4rir2R7f2ldy/jZWboEI1NGZWW1bOvIQo6K/U2
         Sit/bnX00/FFFzRSo2LovP9lAGLI4nOGg5iVmsr0ij8uVFDIF2VryzsX8iA7p1MzhCih
         Gdwcrc1szdQPJySeibTG6j09FJgJRx+x13nik9Zl/qXoG9IbPgDf0A7mlWnfE++SyZ2l
         S09w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787226482; x=1787831282; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M4ykTKD26brTAJUSy1BqDUBmv6bxfPzSIe8lWvsCYHQ=;
        b=h18HZxoabvn9m/ScdqEyw2LXvAVg3a8Ks6k+ikg3eexYdUFCrjL54D29ghc9LxQC69
         x9Ih6lttJ/t432qM1uJYNSoVDUi5ARvRmIYuJceIXLw6Vh6PzGybvqvjvr2KFqWwYwak
         J9s7mTgxn3cyEBGN8r+9ztQuC8DUpUagH4QZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787226482; x=1787831282;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M4ykTKD26brTAJUSy1BqDUBmv6bxfPzSIe8lWvsCYHQ=;
        b=VZwBnpZE1LEJPXsmhXww6CZAAlVwWe8tgcO46zS/ydD53AiW34ojR8e496S5QLjVDo
         5UXmXgUU/GwKw4XOlS7v38RlELdTzpVxmHZa5/aIOvc0YLucG4vZQpAw1KiGwp5ppTQX
         AopruB6Rc3DkFe/BYFU9k6oMXsd2QfODUZ+L70i69AzjdsZyvqbN3gUEkDrawyoS6ErY
         6FNmt8VkJ6nYTfMRiWGoLGtysNfE7zslFQ52fmOgXmA0wizfADQWWJx2rmam+cSQx4yE
         ThUYKHUndrZAy9t3V6ZuGSHObswuxQU0UcEJxl0iJ3SpqKtKw6Cv6Zbyg/aeRUR+/Gfd
         Zwgg==
X-Forwarded-Encrypted: i=1; AHgh+Rpoh2v9EyCIhwloKDSB/7uzRVjR79SJYLxvBOwI1327IdOlSji/IUi7sZtkmQ+MCEyylFYoNot0hcg=@vger.kernel.org
X-Gm-Message-State: AFuF++mtJlaulZcpLO/pH4En5do5BegRAcWzCdL7mHRTuOPhSZpKYnRz
	bi1dp9YUMcT3tOgjibzBjm8Dv1G8VPXO2X/lx4NteWvpwYHF/Cy6aqwq6PGlart27Om0AJlNDGz
	fW+VJNG9F847Vz5/f2Zcb3Ltrl5ir7du99Tebhkh/
X-Gm-Gg: AR+sD13CNN5zBT+C4bUT0HgeS4aJ8QhTIlyu3q6Vh1z41xgnscEFiDpq0sNoGEu+Vzm
	w8g6P4f09B4oIK6JMXZfS2QAm1cS2byQ7cGPWIdn18GgXyCXCYlUSPG7Af9idADClRB4V/E0C8m
	eLsMGXW8E9jzj7gOXc6kYCahjz1N59PZ9S4K4XCKzxqCyvACM5wTNa1mq0g83Vf5rWDiw3JeQ7v
	gcnN/IxjKdQrXGGIiHaKwPjz8a1xCOf0cpCjypetxxZYvtbW0kKzDuQjU08HqvNIhq9ZUeJIiMo
	C/0TFa/IFjzFL/dEAyuQM2lMy9/nodbWjhBHyprnt1I=
X-Received: by 2002:a17:907:c08c:b0:c21:96e8:578d with SMTP id
 a640c23a62f3a-c242e22d1e9mr985944566b.15.1787226482262; Thu, 20 Aug 2026
 04:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810121121.210040-1-vlad@zlab.su>
In-Reply-To: <20260810121121.210040-1-vlad@zlab.su>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Aug 2026 05:47:49 -0600
X-Gm-Features: AcwNN1XeIHyrOI_JtbOBD7QmUWCfs6jOmGCxaoJ2CvViBz-nzt4BaJLUZj-8m5s
Message-ID: <CAFLszTiGPVD1UvGcdE64H1To3OWjOYTd9BNV+jHM0=_dEkMsDQ@mail.gmail.com>
Subject: Re: [PATCH 00/25] ARM: rockchip: Add peripheral support for RV1106
To: Vladislav Leonov <vlad@zlab.su>
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Aurelien Jarno <aurelien@aurel32.net>, Brian Masney <bmasney@redhat.com>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Golle <daniel@makrotopia.org>, 
	"David S. Miller" <davem@davemloft.net>, David Wu <david.wu@rock-chips.com>, 
	Eric Dumazet <edumazet@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heiko Stuebner <heiko@sntech.de>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Olivia Mackall <olivia@selenic.com>, 
	Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, linux-crypto@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vladislav,

On Mon, 10 Aug 2026 at 06:15, Vladislav Leonov <vlad@zlab.su> wrote:
>
> Basic support for the Rockchip RV1106/RV1103 SoCs currently under review.
> This series builds on top of that and enables the peripherals needed to
> bring up a board beyond a serial console:
>
>  - CRU reset controller support (dt-bindings + clk driver), needed
>    by most of the other peripherals below.
>  - Ethernet (GMAC) via dwmac-rk.
>  - USB2 PHY and USB3-OTG (DWC3).
>  - I2C (rk3x).
>  - DMA (PL330) + support DMA for the UART nodes.
>  - SPI, including a new SCLK_IN_SPI1 clock gate.
>  - RNG.
>  - SDMMC1.
>  - A dts-only quirk (arm,cpu-registers-not-fw-configured) needed on
>    the ARM timer node when booting without a secure firmware that
>    pre-configures the CPU timer registers.
>  - PWM.
>
> Each new dt-binding is added ahead of the driver and dts nodes that
> depend on it, so the series bisects cleanly.
>
> This series depends on:
>  - "Add support for the Rockchip RV1106 and RV1103" (v3)
>    https://lore.kernel.org/all/20260729133609.3465563-1-sjg@chromium.org
>
>  - "pinctrl: Add support for the Rockchip RV1106" (v3)
>    https://lore.kernel.org/all/20260729132736.3807082-1-sjg@chromium.org
>
> Testing: boot-tested on custom RV1106 board, with every peripheral
> touched by this series: reset/CRU, Ethernet, USB2 PHY/USB3 DWC3,
> I2C, DMA+UART, SPI, RNG, SDMMC1 and PWM - exercised and confirmed working.
>
>
> Vladislav Leonov (25):
>   dt-bindings: reset: Add RV1106 CRU reset definitions
>   clk: rockchip: Add reset controller support for RV1106
>   ARM: dts: rockchip: Add reset bindings to RV1106
>   dt-bindings: net: rockchip-dwmac: add RV1106 compatible
>   net: ethernet: stmicro: stmmac: dwmac-rk: Add RV1106 support
>   ARM: dts: rockchip: Add Ethernet GMAC node for RV1106
>   dt-bindings: phy: rockchip,inno-usb2phy: Add RV1106 compatible
>   phy: rockchip: inno-usb2: Add support for RV1106
>   dt-bindings: usb: rockchip,dwc3: add RV1106 SoC support
>   ARM: dts: rockchip: Add USB2 PHY and USB3-OTG (DWC3) nodes for RV1106
>   dt-bindings: i2c: rk3x: Add RV1106 compatible
>   ARM: dts: rockchip: Add I2C nodes for RV1106
>   ARM: dts: rockchip: Add DMAC node for RV1106
>   ARM: dts: rockchip: Add DMA support to UART nodes
>   dt-bindings: clock: rockchip: Add SCLK_IN_SPI1 for RV1106
>   clk: rockchip: Add SCLK_IN_SPI1 gate for RV1106
>   dt-bindings: spi: rockchip: Add RV1106 compatible
>   spi: rockchip: Add support for RV1106
>   ARM: dts: rockchip: Add SPI nodes for RV1106
>   dt-bindings: rng: rockchip: Add RV1106 compatible
>   ARM: dts: rockchip: Add RNG node for RV1106
>   ARM: dts: rockchip: Add SDMMC1 node for RV1106
>   ARM: dts: rockchip: add arm,cpu-registers-not-fw-configured to RV1106
>     timer node
>   dt-bindings: pwm: rockchip: Add RV1106 compatible
>   ARM: dts: rockchip: Add PWM nodes for RV1106
>
>  .../devicetree/bindings/i2c/i2c-rk3x.yaml     |   1 +
>  .../bindings/net/rockchip-dwmac.yaml          |   2 +
>  .../bindings/phy/rockchip,inno-usb2phy.yaml   |   9 +-
>  .../devicetree/bindings/pwm/pwm-rockchip.yaml |   8 +
>  .../bindings/rng/rockchip,rk3588-rng.yaml     |  11 +-
>  .../devicetree/bindings/spi/spi-rockchip.yaml |   5 +
>  .../bindings/usb/rockchip,dwc3.yaml           |  35 +-
>  arch/arm/boot/dts/rockchip/rv1106.dtsi        | 426 ++++++++++++++++++
>  drivers/clk/rockchip/Makefile                 |   2 +-
>  drivers/clk/rockchip/clk-rv1106.c             |   4 +
>  drivers/clk/rockchip/clk.h                    |   1 +
>  drivers/clk/rockchip/rst-rv1106.c             | 340 ++++++++++++++
>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    |  55 +++
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c |  76 ++++
>  drivers/spi/spi-rockchip.c                    |   1 +
>  .../dt-bindings/clock/rockchip,rv1106-cru.h   |   2 +
>  .../dt-bindings/reset/rockchip,rv1106-cru.h   | 305 +++++++++++++
>  17 files changed, 1272 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/clk/rockchip/rst-rv1106.c
>  create mode 100644 include/dt-bindings/reset/rockchip,rv1106-cru.h
>
> ---
> base-commit: ac414f5eda0814030636177593400acdacfe5e1e
> branch: rv1106
>
> --
> 2.47.3
>

Just to note that I applied this series and tried it on my Luckfox
Pico Mini B (also RV1103 but more basic) and it boots fine. I enabled
the RNG node and the driver seems to work (i.e. the CRU is good).

For the series:
Tested-by: Simon Glass <sjg@chromium.org>  # Luckfox Pico Mini B (RV1103)

Regards,
Simon
