Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FFD33A701
	for <linux-i2c@vger.kernel.org>; Tue, 10 Feb 2026 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770710274; cv=none; b=oBbxCMcmtMEcO4yx2e2R7e6Q+YwD2GNfy+q530jd/6SmOmkcNq7SNnzYLtc9Xt/N9zhdY4/IWR8+CIrEcz1dgAocx9l0iO/1ucgKP8u16BrXL1IrOtr6AjnCcL/kkawQ+4ovSIAPY+cdL1pSnSviJt8xuH3Xa57HYRtjfRs65lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770710274; c=relaxed/simple;
	bh=ZBrn2V6Ps9nAXfcemoiQWj+7Cl/HyRPhAU9WPaB6Fxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQQiPwtoa2MidbMbJAqqGDmgP0PtcG1GIHQwIAqcP8rXtNkmsLBYeApWteUcRg2KjS5IMNoOOZheVEdTtjT21uwTbE3SiBNXr1CdiEczIB7ghNaM4Mj5R2XswDmnruHEkYkMgQmsmfhxqsMNVAWaruDhkANnsLDA/0/bItgCCNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so2163322a12.0
        for <linux-i2c@vger.kernel.org>; Mon, 09 Feb 2026 23:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770710272; x=1771315072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za+ffUzQm9VRZ3fSQVHtfuOR3ywRY/ywHi+DZoQjMUc=;
        b=HTGDbJXpoinmkOSfcAemBW5+lyljSlnew3R+Jm5soo9HkKyROAmFt13VfZ0et+lxB5
         QposzJ55wtTXLcnlUonazWnlQH6XKiGGif1QC/x9jWJ6tmAe3iNS945IaJ0LgdnqWBP4
         GpH3I+H7H4X/XZTStKO3fF69zulRGYPQ8IaEDxg1YGqPWGaE6nGqbuNC5mmknknIHTgX
         aFmBi2yNvmNqcNrQuabOkJBUiwev2aYFQmzvAguf1hO5q7OZZbNNgEK87YC07QBK2qfo
         4w8Ed1J/SQT1BU1lMRxwNLGyXcApJ0mxLpsPa76AdtasJutG9ghZNA2jT8ibn5yzMVZU
         GH6A==
X-Forwarded-Encrypted: i=1; AJvYcCUvjNGqiPFWTLtdDxZphw5kwh8ucMcmp3jlFYXxta/3EzFuXXcUrtc2xxGO9d60Hg2AHjXNvqVlQXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYsLo+k+dNU+JcynNgJcTeJqLd+diR7j1ugBHulroOEfvKtcvv
	kANBQJqECstKE2h70QuaZ81v2XegZJmmIXlfcRI8bS9p2e69bY8Oi+aztrtXnK1U
X-Gm-Gg: AZuq6aKVE9eJmHtalir51Z6wqbI1tfP2AxOUQXMuvLd1qiYp3xdFZiEQLZyAamws3li
	E6UE8dtz32gER0Xj0aJnA4MdZaP4LMhydAhpdu7Jkc9mcfnPCReSxLDRkIHcOXV7en1bAUA2moD
	xn/thfnuVS3BDniUsdpDHmYAFMNIO1Nct+FKOr5ujUbzu9Ehh5O7IUSuyTviw+oKVtJ9TIAwyzM
	4KwuBE9B5idRUklDpLQAwZIvrthoni3G2mqQth4bLG15JI+5CWbA95xqguHA8VNvPFzPvP2KyDM
	7zoB/dSEe24C+d21nTHWuBhaXgfg7QdIp5AT/tLCvkfjvXIppHlhR6gNLT96YjyNv3mS4FoxH28
	IRjrFiYuSeiywK1TFQ0eZPfKiBjIXyLUR9qKF5kfvLS3pyvGPglM//pUjpdvKbA8ennFXhKNh2o
	KWezxmo+KsHm13EADI6YNpjWul8sV+2n1UcUR6ZKFcoiip2PoOSfmUqF3/PZPgY8yke/2Sez/r+
	Q==
X-Received: by 2002:a17:902:f547:b0:2a0:b7d3:eec5 with SMTP id d9443c01a7336-2ab106e69e3mr15733455ad.33.1770710272475;
        Mon, 09 Feb 2026 23:57:52 -0800 (PST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com. [74.125.82.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521baf7fsm159727385ad.59.2026.02.09.23.57.52
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 23:57:52 -0800 (PST)
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b86671f87eso2032610eec.0
        for <linux-i2c@vger.kernel.org>; Mon, 09 Feb 2026 23:57:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRJgt0D1HyF7Kj2ka7XgXotQQnN+l5VrRn10q1mHOFKYSw/M/hXUGsQeVDcZTNRF3krXnJjc5O2lo=@vger.kernel.org
X-Received: by 2002:a05:6122:920:b0:55b:305b:4e31 with SMTP id
 71dfb90a1353d-5673dad68b3mr278879e0c.17.1770709845104; Mon, 09 Feb 2026
 23:50:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-3-9a3be13c1280@solid-run.com> <bc5fbfc5-6f71-eeed-ad90-0c1b835e65ea@axentia.se>
 <fcef2798-1645-41fb-952e-daf3657bc231@solid-run.com> <704210e0-2e53-09f6-9f8c-3ae0c4b8e0da@axentia.se>
 <9d7bda92-e520-466a-a0be-d01686af1d56@solid-run.com> <f4d8547d-3de3-0de5-da61-3de57d9af895@axentia.se>
In-Reply-To: <f4d8547d-3de3-0de5-da61-3de57d9af895@axentia.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Feb 2026 08:50:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUEZZ+p+yaQDWhVCRNEQUygR2j=HpCp5LuzFU3E=qVNXg@mail.gmail.com>
X-Gm-Features: AZwV_QjWs_kGwWtLP-4KOwLJynmxdzZD9XMo5f_JCKEF6YiXm5BZAUIGiU8_kRM
Message-ID: <CAMuHMdUEZZ+p+yaQDWhVCRNEQUygR2j=HpCp5LuzFU3E=qVNXg@mail.gmail.com>
Subject: Re: [PATCH v9 3/7] mux: add help text for MULTIPLEXER config option
To: Peter Rosin <peda@axentia.se>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Peter,

On Mon, 9 Feb 2026 at 14:09, Peter Rosin <peda@axentia.se> wrote:
> 2026-02-09 at 13:07, Josua Mayer wrote:
> > On 09/02/2026 13:43, Peter Rosin wrote:
> >> 2026-02-09 at 12:31, Josua Mayer wrote:
> >>> On 09/02/2026 13:10, Peter Rosin wrote:
> >>>> 2026-02-08 at 16:38, Josua Mayer wrote:
> >>>>> Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling this
> >>>>> option thorugh the kernel configuration without explicit "select" driver
> >>>>> dependencies.
> >>>>>
> >>>>> Select it by default when COMPILE_TEST is set for better coverage.
> >>>>>
> >>>>> Signed-off-by: Josua Mayer <josua@solid-run.com>
> >>>>> ---
> >>>>>    drivers/mux/Kconfig | 9 ++++++++-
> >>>>>    1 file changed, 8 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> >>>>> index c68132e38138..4f7c6bb86fc6 100644
> >>>>> --- a/drivers/mux/Kconfig
> >>>>> +++ b/drivers/mux/Kconfig
> >>>>> @@ -4,7 +4,14 @@
> >>>>>    #
> >>>>>
> >>>>>    config MULTIPLEXER
> >>>>> - tristate
> >>>>> + tristate "Generic Multiplexer Support"
> >>>>> + default m if COMPILE_TEST
> >>>>> + help
> >>>>> +   This framework is designed to abstract multiplexer handling for
> >>>>> +   devices via various GPIO-, MMIO/Regmap or specific multiplexer
> >>>>> +   controller chips.
> >>>>> +
> >>>>> +   If unsure, say no.
> >>>>>
> >>>>>    menu "Multiplexer drivers"
> >>>>>           depends on MULTIPLEXER
> >>>>>
> >>>> I'm not comfortable with making MULTIPLEXER a visible symbol. It is meant to
> >>>> be selected when needed (and there are a dozen or so instances). The kbuild
> >>>> docs has this on the subject:
> >>>>
> >>>>    "In general use select only for non-visible symbols (no prompts
> >>>>     anywhere) and for symbols with no dependencies."
> >>> The patch description didn't make the decision logic clear,
> >>> and I plan to submit a standalone patch for this after v7.0-rc1.
> >>>
> >>> Basically existing drivers using mux core used "select" to enable it,
> >>> even though the core can function standalone with device-tree.
> >>>
> >>> Some of these users (phy-can-transceiver) function perfectly
> >>> perfectly fine without mux, and use it as an optional feature.
> >>>
> >>> Likely drivers only used "select" to avoid writing helper functions,
> >>> prompt, kconfig description and stubs - which this patch-set added.
> >>>
> >>> So I will argue that some existing users relying on "select" was wrong,
> >>> and that the mux framework is generally useful on its own.
> >> When I wrote the mux sub-system it was very much intentional and by
> >> design that drivers needing a mux should select MULTIPLEXER, and that
> >> MULTIPLEXER should not be a visible symbol.
> > Need is a strong word here, and doesn't address the optional case.
>
> "Need" was the correct verb up until you needed the subsystem to be
> optional. If you need the mux subsystem to be optional, you need to
> do it in a way that does not introduce headaches.

In the other thread, Josua pointed out that there are already several
drivers that cannot be enabled if MULTIPLEXER is not selected by
something else:

drivers/mux/Kconfig:

    menu "Multiplexer drivers"
            depends on MULTIPLEXER

    config MUX_ADG792A
            tristate "Analog Devices ADG792A/ADG792G Multiplexers"
            depends on I2C

    config MUX_ADGS1408
            tristate "Analog Devices ADGS1408/ADGS1409 Multiplexers"
            depends on SPI

    config MUX_GPIO
            tristate "GPIO-controlled Multiplexer"
            depends on GPIOLIB || COMPILE_TEST

    config MUX_MMIO
            tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
            depends on OF

While MUX_MMIO is selected by some/all(?) symbols that need it,
the other three are not.  Are these three really dependent on another
symbol selecting MULTIPLEXER?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
