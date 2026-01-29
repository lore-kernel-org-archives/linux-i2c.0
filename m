Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B7433C1B7
	for <linux-i2c@vger.kernel.org>; Thu, 29 Jan 2026 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703349; cv=pass; b=NmO9OgZjS8JAYtfTsWCE+Wg7HgJQyAWdpfqQO7PcRzQVevw4Uy9szp5yd7cJMhAmdFmicTD422NZOUpyCP3aph/ge0jed14s/cDT4qAXWM5/4ozSzbDO+Q415CGRd1Ilq0YtD89wPhY55YxvGlReKuQ75Zz/1IOHXuFNOdmPImg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703349; c=relaxed/simple;
	bh=1a2qdSYst23Ql9WM1gLQFpUCuswuU/Q+CP4seG8rf9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUmDgUakq6Puy6ftPy3+/zPLFHxIus31aGb0TafB8KvMYsqF+fPs+EnaXOCOlLgsxQzCF6bPbw9JUP63LauUOLzq57ANjRH2xwV69xFzHF3ZHeLXn5rVMavdeXFauojbZqzyGrTzkD1Ge4iRqQZ/BPAwJe0ilOUG237pC1YIYGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HtWuaZii; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HtWuaZii"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59dd3e979ceso1202663e87.1
        for <linux-i2c@vger.kernel.org>; Thu, 29 Jan 2026 08:15:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769703343; cv=none;
        d=google.com; s=arc-20240605;
        b=O2ReSrsGNy8lGUdFfU36Jos4UboQ+xzG5IHeKLGNjn5ojh3tDpO43UYL6X99LMyX2d
         5ZcpMZ2YeMM/ZV0x/0neb3GFGMtQUMmk5KyEAmFzN9H2TI2Cucx/gAHbXJBphO//KTWx
         M36bkLCiFoPG9NP4s7LijSVXGbmPdKCi631DIAQutymGU+SL01GETbQT+qafeWtuay1m
         11MOquTvjTfQ2x6MMP0XjZMbqaJa0wOGhTb5+6ehO4OqtgpwBGFJK30mGCddAYahQkmw
         bXdFCdn5F9ej3O2Bfsz91x7qXyzzbwecwwG+eIWDjQYbQAw/7LyJEo7FrIU92WrT/NYs
         Invw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mcZyL8rlWiol7qHJKX4MkvpKMN+RPE+vXis8g5P5uMA=;
        fh=5+RJ0cpihzuWgJ1wUzXxWah5H28gD1UtxTdjE7E8rCQ=;
        b=SvBcVOz9Pg1mXUJb3v+QSby8qJK2YiPlY38/QxH/KukEJetOcI8VdTG5qHvVst4ZvO
         6LQf8ntFEfMhg2G2fnuzBumb0qbCTFRNDBv8LrIkaUlQ6w6F6+sALyf1kq1oGW+BiKch
         XyQstRraio8dYuncXXRuZrR3L0+cKZZ3+7qlyNoPmNUfPd5f3RQBDLIXafTH+MEWvkyw
         afMx0dRc5j0Unmr+/yB+QUC7V0HwLu4SNlbPXTS660ggzr18CrjKIuLpBliaW/tAB8U6
         ichHJ8UH6hOe+/8/TwD58gh5Qi2a/8hY1QvH9OnD74pUNWUoyjSUlsVDxev+uxSyEogz
         6CBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769703343; x=1770308143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mcZyL8rlWiol7qHJKX4MkvpKMN+RPE+vXis8g5P5uMA=;
        b=HtWuaZiiIIttIDYuqQXvc9JwVdhw1g13h/MSl3cj41S1Ogt8ICxBfGSlgrlqdHD960
         BA4uczgz+WwyE+jKg82BAqrG7+xkY3jnQhPuJcu1EbHIOFz/NefO6ITbSGDtcLkQns0V
         8NnF7OF/kM498AUmRBINnK6kcgVezpFtE+LVc6uTNltgMhkFWRsaXVde1To+VDiOcaPu
         qXmRD126R2sDHYcthUEeOtMneu39Rt3sXWal1Ru6EMPB9IE+DrCyQPP4s0ClxvopG0WV
         7m2sre1fmjyGS/satGxi76j/FH3N2DELjnvIXdj73O6/Y5HuzamIVdXU4VKEhdMFdboG
         Ugrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769703343; x=1770308143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcZyL8rlWiol7qHJKX4MkvpKMN+RPE+vXis8g5P5uMA=;
        b=JoxtBr4UWjkOOzn5xjeBMlCUw0xY78LbISHD4dcUrJrYRRBPH4x3sGGtOs5qcrs5Xu
         jm6VDfIR1cdVphmF2WW90NUsLahROTx6ElIFF6y9odduU/ozWWMpWdcugi4p+RSVyi86
         +d6m8ZHE/bavsIFWQOqdqv0WBZOTIVm39TOyoLYzFQsFzevMh69ObwZ7phwRdO4f01Jo
         S2REA+5g2bC8q5IoitjfsQShRwB/FB27dqy77c5baNjz/8J3+UW53noLZH+MiMYobokA
         LYt4h+swVDCgVSSukm8TU0yQCZ0gQ0/AFpbgiU32sbtNP6crDk2XwPNGyb7NGPNOCDBS
         XX+w==
X-Forwarded-Encrypted: i=1; AJvYcCV7uAbwOOz++P4UDxElcLScN25QAxTgTYKcbPrD1heeiaaDCjrYXyNz0qdAlIis58iFtBACeQVjvcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu84KOniMVAApHV6eKPNw2OiXU3DRRu2zt71WVdB/EDJIl++nP
	iiP6CcxZ4iCetAtTzmNG5jsZyolT86EM6lz9LyWGgiiwE5ljdjaqTWpJoyz8NlzshaFBspFUEDV
	51cjJKMyMeBaERUtYEc+U6ivvCJdFGqHW6u5BUkcagA==
X-Gm-Gg: AZuq6aJtHSr+kbkD1CqEJdLqoEHxKqZQ4BedbUOG3iv3YENuiEMypVD+n5xJOHP6VY8
	gY4C5/YXH/Mtd11TGk3izmRMTOu889DlB7WKwnYLRdYVU+8IotQ0YThRFxBBQdpLlsrHzLAxacN
	IMOry537YDzm9TKUzayzf6KDQOFAPLcyVuHdZtfZcgWv9vd1wz4i/V0X/X27+nMs9UuiW7tb5AY
	nLK3kf+ar11lxD9bhDcgLC/mpH1VKOZLvfwPjhNJ9NWERaV4ldxdCyRtHE0GDouAX9Y09FU
X-Received: by 2002:a05:6512:1394:b0:59e:15a:d704 with SMTP id
 2adb3069b0e04-59e04015669mr4368983e87.13.1769703343301; Thu, 29 Jan 2026
 08:15:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
In-Reply-To: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 29 Jan 2026 17:15:06 +0100
X-Gm-Features: AZwV_Qg3mhJxcxsaaNM16DuqcQOXYrDFWwz2xcBsELVK6E8j4cCnjP0a7TG6aus
Message-ID: <CAPDyKFp9StNf1eLaSETxC72=7sXYBmGFmHnv0CXysUGcYma5VA@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Jan 2026 at 15:46, Josua Mayer <josua@solid-run.com> wrote:
>
> Some Renesas SoC based boards mux SD and eMMC on a single sdio
> controller, exposing user control by dip switch and software control by
> gpio.
>
> Purpose is to simplify development and provisioning by selecting boot
> media at power-on, and again before starting linux.
>
> Add binding and driver support for linking a (gpio) mux to renesas sdio
> controller.
>
> Introduce generic helper functions for getting managed and selected
> mux-state objects, and switch i2c-omap and phy-can-transceiver drivers.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

This series needs to go together in some way. If you like, I can
funnel it via my mmc tree, unless someone (Wolfram for the i2c part?)
has objections to this of course.

Kind regards
Uffe

> ---
> Changes in v7:
> - picked up reviewed-tags
> - fix Kconfig change to add the missing prompt for CONFIG_MULTIPLEXER,
>   and enable it by default when COMPILE_TEST is set.
>   (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
> - fix another kernel build robot warning: undocumented C struct member
> - Link to v6: https://lore.kernel.org/r/20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com
>
> Changes in v6:
> - replaced /* with /** for devm_mux_state_state function description.
> - collected review tags.
> - fixed checkpatch warnings (space-before-tab, void-return).
>   (Reported-by: Geert Uytterhoeven)
> - fixed use-after-free in mux core mux_get function.
>   (Reported-by: Geert Uytterhoeven)
> - fix mux helper error path uninitialised return code variable.
>   (Reported-by: kernel test robot <lkp@intel.com>)
> - Link to v5: https://lore.kernel.org/r/20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com
>
> Changes in v5:
> - implemented automatic mux deselect for devm_*_selected.
>   (Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>)
> - because of semantic changes I dropped reviewed and acks from omap-i2c
>   patch (Andreas Kemnade / Wolfram Sang).
> - fix invalid return value in void function for mux helper stubs
>   (Reported-by: kernel test robot <lkp@intel.com>)
> - Link to v4: https://lore.kernel.org/r/20251229-rz-sdio-mux-v4-0-a023e55758fe@solid-run.com
>
> Changes in v4:
> - added MULTIPLEXER Kconfig help text.
> - removed "select MULTIPLEXER" from renesas sdhi Kconfig, as it is
>   not required for all devices using this driver.
> - added stubs for all symbols exported by mux core.
>   (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
> - refactored mux core logic to silence ENOENT errors only on optional
>   code paths, keeping error printing unchanged otherwise.
>   (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
> - picked up various reviewed- and acked-by tags
> - Link to v3: https://lore.kernel.org/r/20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com
>
> Changes in v3:
> - updated omap-i2c and phy-can-transceiver to use new helpers.
> - created generic helper functions for getting managed optional mux-state.
>   (Reported-by: Rob Herring <robh@kernel.org>)
> - picked up binding ack by Rob Herring.
> - replaced use of "SDIO" with "SD/SDIO/eMMC" in binding document and
>   commit descriptions.
>   (Reported-by: Ulf Hansson <ulf.hansson@linaro.org>)
> - Link to v2: https://lore.kernel.org/r/20251201-rz-sdio-mux-v2-0-bcb581b88dd7@solid-run.com
>
> Changes in v2:
> - dropped mux-controller node from dt binding example
>   (Reported-by: Conor Dooley <conor@kernel.org>
>    Reported-by: Krzysztof Kozlowski <krzk@kernel.org>)
> - Link to v1: https://lore.kernel.org/r/20251128-rz-sdio-mux-v1-0-1ede318d160f@solid-run.com
>
> ---
> Josua Mayer (7):
>       phy: can-transceiver: rename temporary helper function to avoid conflict
>       mux: Add helper functions for getting optional and selected mux-state
>       mux: add help text for MULTIPLEXER config option
>       phy: can-transceiver: drop temporary helper getting optional mux-state
>       i2c: omap: switch to new generic helper for getting selected mux-state
>       dt-bindings: mmc: renesas,sdhi: Add mux-states property
>       mmc: host: renesas_sdhi_core: support selecting an optional mux
>
>  .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   6 +
>  drivers/i2c/busses/i2c-omap.c                      |  24 +--
>  drivers/mmc/host/renesas_sdhi_core.c               |   6 +
>  drivers/mux/Kconfig                                |   8 +-
>  drivers/mux/core.c                                 | 178 +++++++++++++++++----
>  drivers/phy/phy-can-transceiver.c                  |  10 --
>  include/linux/mux/consumer.h                       | 108 ++++++++++++-
>  7 files changed, 277 insertions(+), 63 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251128-rz-sdio-mux-acc5137f1618
>
> Best regards,
> --
> Josua Mayer <josua@solid-run.com>
>
>
