Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ADC330676
	for <linux-i2c@vger.kernel.org>; Wed, 25 Feb 2026 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021292; cv=none; b=W5w2yl5VdV1sJ6QQzI6ZHiLsN1NTnekMhzGHLp7Yar7/Q4gQX75r+Fklz5cuIfodpdbXjJRWkUz5fe6RvA6KJE8/dcF9GnlU35wtdIb3CSaddBI4RL5MsULfTKetjwangmjJj6iE5XRym5yXSPJhMy9/8kf1MveEpjAENVyyRgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021292; c=relaxed/simple;
	bh=b7bATi+E9HIWEWXTAIwNa4451ABKjWAafWaU1v8UUAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iItTeqbKUrL+Rhu75vUZ3B/sbMubghJkVD1TIiSC6TNHh52pVxpMl8PxcZ6Qva4YRSYEr6LrphTXSHQB9fQY61Z1GOiljzlsqNjNFphfTSAcN979JPN2EhjvbUWGzj+TdNhA7jqyVmIxoweTglOx7uKhMZgo6isD5Uat55nwzJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94ac7f22d23so1785732241.3
        for <linux-i2c@vger.kernel.org>; Wed, 25 Feb 2026 04:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772021290; x=1772626090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TQ9plTAtoqFGycuAV6Q4VO2kslCQXeQ3NGwgtKeiuo=;
        b=ZXl/BEodWpTG9jpeNnTBiDJiiYGmBDmpZWRfczHvpj1xHzmCEMFHittWWPL1BWh4v7
         OuxRvEA4faucPuDWt434hk8wr6gv2bp8yJ6JK1rL0O1Q2uiVxA2lxsF4UENdSDy/hwLS
         04MBInB9WhZCwiQzAeIQltoDJcTpmYZjWDN6tw2CbqBeojC7ci+tv+hR5ius4C+yHiHG
         BHPJ5zYsChvqsYcdP2rWUrAsKYEG2TL6o2HDTkM4s1YwcQHDNk9PdkV8H4wmrn5Znc4E
         AuToCdhYlsW2wuwe9top3D4/FlmpqM7MKgBZkdmtvxnSmsn9x6oX3nrz3bAnlV6c5b+C
         qirg==
X-Forwarded-Encrypted: i=1; AJvYcCXFop602SUTv51hhK1E15L+aPB0aZ+gUke8X4/gqY48tx/HgHtxFd4xMgs6L7ehfawC0tvQb+1Oyhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqZkOrmEzrb7eTwa4QWaXCR+Fxey9EEYX5ksPX462o5pwKPU/2
	hNYwHqO1alVA/CjXKaBy/c0ODEyAd+WbGvKZ1W8SFRKzHsM5jD25Ce3VbCp4Njce
X-Gm-Gg: ATEYQzywM4Br47Q034v1S46XYCCBvvcct4SBU61n30NiU1Jli16XmE0KGYDcQfu/Jc1
	UXLk+cSHt5Nju5PEIbkgcNSs6WCamQiIE3nJKEQLXq6Th4eFopZVbefkGeU8ClyWRCWrSjLN1TV
	95xW2oZomePRXyMpjUpwp0KxjenJA8lzYlhCgjhiQyltuRIIKT+I6lLGRB+WaUqYlFBb5PmBECo
	vX+mloOJD3Hvo2MBJIlFJw78uwc/P7mwI39olZDQ7MZA8qBv/KM4hWq9piGu3GsjNYpEGtwvoDC
	Puj3+SyKw3myjUjLwkV4XSg77ZqGRuWAXd8wdhVpBUa1yoBakpmjst9C//QtyfX85XwHVueuRAF
	dkyImjPZ0euPAC8DNFj2tdtVcUnqa9VtG5Fkzki+6ak/ABizhOoJDx7ixosYkmzi44vzXW76nwY
	dJwEQSQm1uEZeP0vNMzXbyIjQZbHldCzGq2GqE6y0DCN5AM/5/PlSwADRJGDyHrH9O
X-Received: by 2002:a05:6102:5122:b0:5f5:328e:73ab with SMTP id ada2fe7eead31-5ff141317ddmr95133137.32.1772021290072;
        Wed, 25 Feb 2026 04:08:10 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff09d7757fsm1282644137.5.2026.02.25.04.08.09
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 04:08:10 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5637886c92aso3165118e0c.0
        for <linux-i2c@vger.kernel.org>; Wed, 25 Feb 2026 04:08:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhWz8d1oWMtBKJyO0P8iua5p7jpTy6dRVnCwJaLr1gO8c4JCs3qqhNY/ru/xVPDMLEYMrL7GykFsM=@vger.kernel.org
X-Received: by 2002:a05:6122:8c27:b0:563:702b:e2a7 with SMTP id
 71dfb90a1353d-56a8bcb7a04mr108622e0c.19.1772021289726; Wed, 25 Feb 2026
 04:08:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com> <20260225-rz-sdio-mux-v10-8-1ee44f2ea112@solid-run.com>
In-Reply-To: <20260225-rz-sdio-mux-v10-8-1ee44f2ea112@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Feb 2026 13:07:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUSU8Y9gj5qJ7qNE1UVhp7=HTjAxEsL6uZXPXFgwTd+7Q@mail.gmail.com>
X-Gm-Features: AaiRm538QW2lNPSmHsPdoAK0GxPwumP2I07aJZ0lsRKIlDak2p-vOeVkZ133ww0
Message-ID: <CAMuHMdUSU8Y9gj5qJ7qNE1UVhp7=HTjAxEsL6uZXPXFgwTd+7Q@mail.gmail.com>
Subject: Re: [PATCH v10 8/9] mux: add prompt and help text to
 CONFIG_MULTIPLEXER making it visible
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Josua,

On Wed, 25 Feb 2026 at 12:35, Josua Mayer <josua@solid-run.com> wrote:
> The multiplexer subsystem was initially designed only for use by drivers
> that require muxes, and did in particular not consider optional muxes or
> to compile as a module.
>
> Over time several drivers have added a "select MULTIPLEXER" dependency,
> some of which require a mux and some consider it optional. v7.0-rc1
> shows 15 such occurrences in Kconfig files, in a variety of subsystems.
>
> Further some drivers such as gpio-mux are useful on their own (e.g.
> through device-tree idle-state property), but can not currently be
> selected through menuconfig unless another driver selecting MULTIPLEXER
> symbol was enabled first.
>
> The natural step forward to allow enabling mux core and drivers would be
> adding prompt and help text to the existing symbol.
>
> This violates the general kbuild advice to avoid selecting visible
> symbols.
>
> Alternatively addition of a wrapper symbol MUX_CORE was considered,
> which in turn would "select MULTIPLEXER". This however creates new
> issues and confusion as MULTIPLEXER and MUX_CORE need to share the same
> state, i.e. MUX_CORE in menuconfig must not be set to m while
> MULTIPLEXER was selected builtin. Further confusion occurs with Kconfig
> "depends on" relationships that could reference either MUX_CORE or
> MULTIPLEXER.
>
> It is common across the tree for subsystem symbols to be both visible
> and selected, e.g. I2C & SPI. In the same spirit multiplexer needs to
> ignore this particular kbuild rule.
>
> Add prompt and help text to the existing MULTIPLEXER symbol, making it
> visible in (menu)config without breaking existing "select MULTIPLEXER"
> occurrences in the tree.
>
> Select it by default when COMPILE_TEST is set for better coverage.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Thanks for your patch!

> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -4,7 +4,14 @@
>  #
>
>  config MULTIPLEXER
> -       tristate
> +       tristate "Generic Multiplexer Support"
> +       default m if COMPILE_TEST

Please drop this line.  Merely enabling COMPILE_TEST should not
enable extra functionality.

> +       help
> +         This framework is designed to abstract multiplexer handling for
> +         devices via various GPIO-, MMIO/Regmap or specific multiplexer
> +         controller chips.
> +
> +         If unsure, say no.
>
>  menu "Multiplexer drivers"
>         depends on MULTIPLEXER

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
