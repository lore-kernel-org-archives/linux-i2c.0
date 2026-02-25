Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752FA3AE6F9
	for <linux-i2c@vger.kernel.org>; Wed, 25 Feb 2026 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022340; cv=pass; b=ffYY1wHB0Y5mToDBz2uAa23uxUCbFmtRVc8SAw9Ktl5kgbxmzC39s+KjZKyIbq4jCc9YHKh+iRQty6Y4dqNtdQF8eRPUtkAzxZpYdeAeqHCXqiXd/kdpSCRD6mqml5muQFhDl7V6MtCRtBiQNb3pnz6wtdLSjKI1kUd8Q4kqzRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022340; c=relaxed/simple;
	bh=jXjctxlX2mOd4kESSuh+dmt6ufaPRbeKlSyIRNOCp10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3BsdfhqBkUfo/qgtEH64Pjidw11lqJIAloyYAznPWL9ZiufmNVDAdxst+TpEcKdqnIj9OhbulOucEHJ+ItHpTVmy0LJXvryQXVhYO4VFfafN+tABwcJ6FG0TeK9v30gfe0ogsn8iUYlZV75sogK0mwU12zkBThkBXSIoeA1Rz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sDSkUWOS; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sDSkUWOS"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59e5eaa491cso8350611e87.0
        for <linux-i2c@vger.kernel.org>; Wed, 25 Feb 2026 04:25:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772022336; cv=none;
        d=google.com; s=arc-20240605;
        b=UTQ4i7sVNOKq0O09H8sdvPNbUMVtegKDXKs5ODWZ1B9OxmPalJu6mYv56d8nfQH9Cw
         ZS335kY87Ham91Jvv7Etjel62W0hKUThn8KIhS5b0Mpt0cCo5VUTipeHTH7F8G6KTAKg
         KZgMuwtZvsy99LhNn86tCdVBViNmryf/nplrjldNvzs0l1nZgMMwomAdbXx77v7ellcq
         iKY5N8CECwLaTsRZEA7pHqyZ+GampLnuBIFNzJrmqlSo4XQ0ddYVPGBpEepE72Y1ExEm
         4QSw5yKdLovBcYIE7nvT4krMk+pYi4tjkjcOmJXWDOY5SVRLPG9rkb9TajBlh01cTTy5
         E3XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ySl6ydztfTvafF7H4MeeeCO8Ou666oUNAgwfiGo+Y6c=;
        fh=3WS1C2HgZospSXIi/SP2CFJiuGWOWhLbfbFGMAzKiDc=;
        b=JMKXuiS/Fu/4BqoEV2VjDHU01XAjDcyA/Nq5++6Oki4OTnejcuoLL77u1DcvQl7+Qb
         RRwcnujzZ+5y+15yVqGNgZq7mGoJdfdiEA+XPq/2XMgAbJ4wlyopufprnGf23/1QI15m
         Dm8RbJ6mbTf5yZVKkD0W0qIRtZstAkhokxSjnnw8pnfzy+juqACeXZ/K5gVUWpTJLP1z
         REz+gH9wqP3QYcDSWF8PubonPmg5+GRvxFxM2bC9M6dDbyyds2xzvwijAYeTC6WkrzvI
         uhwKPnXmJobqTPBOZdZpKVXbn6XXHjBmI8nHudE+6Q9ugSPy7gcqNN309gYQgEnKUxg3
         rV2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772022336; x=1772627136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ySl6ydztfTvafF7H4MeeeCO8Ou666oUNAgwfiGo+Y6c=;
        b=sDSkUWOSKvxKxjfBRCLCeRWRlaT6myxGf91d+cFmFgdZeVpuujfiENdVsDX7udA6j9
         pq1oYL0Z44XH1uBM1U0j5o6vT/g0VHsuPW7VKOlAh3vAFVAvv4LSR+zBB1m/xA4aZuQP
         i5b4HPUHtjrCPeOGTsRUIZ53UfjBprittrXK7qS+s2NnOcfPo7honzsfS27MXC/InZGi
         RL8Qld4kNmEEetpOF6OzFZMCoqxqAhGutWICH0o8TsfxY/Nn5QlMLG1KV2qjgaR2HxkK
         675I+ZHxJ5EURxmjfCPiXQ6IFhuz/eZzLTmEdkYhokM8Xaw40D5sfnIjoz4pNhP09wFU
         Qwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772022336; x=1772627136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySl6ydztfTvafF7H4MeeeCO8Ou666oUNAgwfiGo+Y6c=;
        b=bL5I8CDt78cJ8M/3dj1C4XL6UslWVpEr3VxDz84lkIMFna8cOQpeyZ00mxP+160LNe
         L9fe/Y1qzeJuqhLSsIXn6bNT0gOsgQS4vhvCx7bUEtWoZnIN93h8yhhB3NG0Jh3l6MRV
         121q9GrAtFzE4o9aH0CSFslt2TYmveMyPbhitIWDMc7vQhkWZWgNjxmahOXTPq1gSn5W
         vx7g1hICUyeehs7DZ/x31Ph/txQeCweXNSz0mAfnxK+Y5yjMP9vUxihqr9bcgAGP08SY
         BhgvOkOB50XUWKz0aD0CgexUmZUYfQ9iNHVKIf4bVRhBJhov2sHXRau1flwOuhOIY2w2
         7fkA==
X-Forwarded-Encrypted: i=1; AJvYcCXKz4OThDabHqlsU0+SqDRpUhY4FwGAB7GN/yKfhNR2rsgUwfqh1qw9uSSUG0MejDGFU1Rja3G+13Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmQjrxG/mZAdCMlWtVit4Ze5uaO6H45DpNPdd/1VBvfrDgqZb
	hUdRP9u/sEYgEoQbeg0RPY+JvIgMgU/I+oY25lA85Di5aTzDjyL3IV4pQ8oE072L8LZBqoEKOWN
	bSV35/Np1SFW6PjeH1ZJtnL3HOvUW6MHI8aZzfuuLzA==
X-Gm-Gg: ATEYQzy4mIwtNQxDHX1xL7TI4r+PLN7SGHWQsRk1ig2tT6kxu7QwmKdHTXmPwMnOABp
	eyOo+kXMheK1JUWdkSCZul4WHR3RbylYEXBdQJM2jli/B4DTePwvRqURZe4OkxN+EMYWOABrLbc
	KnO4dlZSY/KvSrkgf3c5KVoJi5fVI0AdvoYtSoCC8plPkQsMdGu2bNij/nGEJm99NAYnVrpo5Ma
	PyYCMXRBu/5QtjZoIgPfP3FaTX1seHkIP9YXRGG/ZVzd7WuKpN/nVdxj23ApGwwseqGNZaNcbr9
	izAA1oe0
X-Received: by 2002:a05:6512:32c7:b0:59f:8e98:5dc4 with SMTP id
 2adb3069b0e04-5a0ed8a5ef7mr5479022e87.23.1772022335501; Wed, 25 Feb 2026
 04:25:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com> <20260225-rz-sdio-mux-v10-8-1ee44f2ea112@solid-run.com>
In-Reply-To: <20260225-rz-sdio-mux-v10-8-1ee44f2ea112@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 25 Feb 2026 13:24:59 +0100
X-Gm-Features: AaiRm51lt-nfdrgge9ulVu4LPr2JQVPo_YLU5CXuzn9PVqh2A9E2AaS4fZriRp8
Message-ID: <CAPDyKFoDZr33tQXofsZzPrJbZM=3VhpeeOk1GqvRA1UK=LO5Ww@mail.gmail.com>
Subject: Re: [PATCH v10 8/9] mux: add prompt and help text to
 CONFIG_MULTIPLEXER making it visible
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
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Feb 2026 at 12:35, Josua Mayer <josua@solid-run.com> wrote:
>
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
> ---
>  drivers/mux/Kconfig | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> index c68132e38138..4f7c6bb86fc6 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -4,7 +4,14 @@
>  #
>
>  config MULTIPLEXER
> -       tristate
> +       tristate "Generic Multiplexer Support"
> +       default m if COMPILE_TEST

Allowing the core being a module makes things/code a bit unnecessarily
complicated, I think.

Similar to other subsystems (like regulators/clk/etc), the core is a
bool and the menu below it for its provider drivers depends on it to
be configurable, allowing them to be tristate.

> +       help
> +         This framework is designed to abstract multiplexer handling for
> +         devices via various GPIO-, MMIO/Regmap or specific multiplexer
> +         controller chips.
> +
> +         If unsure, say no.
>

continuing from the above comment, this would instead be:

if MULTIPLEXER

menu "Multiplexer drivers"


>  menu "Multiplexer drivers"
>         depends on MULTIPLEXER
>
> --
> 2.43.0
>

Kind regards
Uffe
