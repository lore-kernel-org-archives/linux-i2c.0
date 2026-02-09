Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7202331200
	for <linux-i2c@vger.kernel.org>; Mon,  9 Feb 2026 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770624782; cv=none; b=PJme52kzgHF93R/FXxzSEU0N6zcywuSGmbFAFyDC8pYw3nDoRLCc932jIAKukFh6haY+YloQKNKmr9GXO9Z56T2U4Sh9e+eYeWWjt5n+u0/Z5O+G4a1dXINQ9Wul+XcBWtvuuykPn5gsbbqjCQVl/nuizuC9XLLSwEeNBsDZP+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770624782; c=relaxed/simple;
	bh=jGnKFIqAqLu+rNpANBkHFw8kJ3LdtX3G4oazBBlCuPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l19341DOJLvrUXA6CchC9bpfV9MevFBtmCUnZXwv7/IQnlN9YPR42tiSooDQ4qAjRvm1iJiGg+V8oHmA9QPCykj1d5HVqX7AiRPvZvCJNDXSl5IHK6nWj06TFfafTS3YrnkUjeX7P42JdfKMZLBytRDxTX6cXlj4n+TIulG5nyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c7199e7f79so381451085a.0
        for <linux-i2c@vger.kernel.org>; Mon, 09 Feb 2026 00:13:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770624781; x=1771229581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l9pK4QYIZutXAE3AMWeCiy3lF4Ku+2UbgC78kdie5tY=;
        b=uyA65huLNbYDsJssCTIhR5GPgdzpcHXsomzfdtTsywy6/iNihrpftJ7+MksmJcOclW
         ETYQwuKyV1D0p/zeXuOQdaRukXoO0D5fVl23owkLYPJu0dt7HjRyKUOK8kfKMSyYSUWp
         imdf0M0nEht8b+tOagXfJa+No4m2leJ3jtDegaPWDHCBUMUfpLNLLuGDdFy1T1+Bj9hW
         FiXiyjYKjSi3+dPBc83hqoLdFJJMi2KT+YilblXwM6GsVSu6lr7oOH4bzVZT5Qk9L+6o
         B2WAabi1Amnpm4jDtIQ9rAafaATWTm/T9O91tq4CBZQ/B30Xe7qfoBmsdc+gzU5dDpWc
         7nng==
X-Forwarded-Encrypted: i=1; AJvYcCVSrf3lVaT/CoTmYv+dLu95QUIxRpVQFn5W0KPAvMzRFkUFNXKCLWXmd5iFQ/NWV3P5p0TvRz8IiAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysOQ+bSeyL8rHyMb3QWeJfO27owvsfs/1LpbM5OhkNo4qQCVkU
	9PQ7bdkmm+hdvT5Lzph0lWZvN9sOh+VHn3JsZuWqt35E9CMH9kHnpByPehcxrqHf
X-Gm-Gg: AZuq6aLEo6L+pWnJQj1EAIzbQ2JhFokRXpWS01rPZX8I1zBcvCUoaMWJpxd4XcExg2e
	5ev5HB9d0cEYaTUxms0d14c64+1RwT8duyfVIgDQcsDHC0OioGyLSuckPcttl7OgoZU8UT9h6sA
	0BedvOjMyzzswL21/OnUQK+WxZX2Jjq+Fo0Bqf/rG/68RicafBas9ZlqkyBX//ktiIZZIgPo7h1
	KYXrAS+vJElqVQ8lG6OlZL8p2pMNgkRqxl1WVdUrtRdgwTR0w3NBb64TX9aBHc+yetx5H/rciZI
	pP4Pn5S0RjIDmL6pd1AQ4AnJ+j0SUCIXH8sevFN3Y84HqUcf+OSRBR/gjAKiz31kj+65Ug1HkQH
	NwG+IOZCLvOIu2f7NsxWtHeXCxiDJuGct7ZqHHDRRHsx5xpH1DUaF9u9zj8w1l7yybTG98CQlXH
	V3f3DLHXjVQ6zI3ZsFtu+BMklLqZ00mDxInvsoEWdXKQ/6QSRq
X-Received: by 2002:a05:620a:7085:b0:8b2:e70c:427a with SMTP id af79cd13be357-8caf0d3d77cmr1496196085a.44.1770624780939;
        Mon, 09 Feb 2026 00:13:00 -0800 (PST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf7aeed8bsm781447585a.20.2026.02.09.00.13.00
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 00:13:00 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-896fb37d1f0so15428156d6.2
        for <linux-i2c@vger.kernel.org>; Mon, 09 Feb 2026 00:13:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2lVGIzOwGTKHuX8EvcuhBAVMIbuSQ5CCSmXNEawlFvMp3zNrYMjujfP0RWRKGqlcIg4wE+sZM6aI=@vger.kernel.org
X-Received: by 2002:a05:6102:3747:b0:5f8:e2d3:c463 with SMTP id
 ada2fe7eead31-5fae8a3b31bmr2934943137.3.1770624379360; Mon, 09 Feb 2026
 00:06:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-3-024ea405863e@solid-run.com> <b7dcb374-b79c-4e9f-ac30-2f507127cfb3@solid-run.com>
In-Reply-To: <b7dcb374-b79c-4e9f-ac30-2f507127cfb3@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Feb 2026 09:06:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU01vwif4H6H-cYUfW0Y56fN6Anp9F4Ru7q3fveNqqoXA@mail.gmail.com>
X-Gm-Features: AZwV_QiiqRuDaFts73-z5beOOIXm-WRqeTDAQV4zcAAegTI5YGKcuRUZfqXMUrE
Message-ID: <CAMuHMdU01vwif4H6H-cYUfW0Y56fN6Anp9F4Ru7q3fveNqqoXA@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] mux: add help text for MULTIPLEXER config option
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
Content-Transfer-Encoding: quoted-printable

Hi Josua,

On Sun, 8 Feb 2026 at 16:16, Josua Mayer <josua@solid-run.com> wrote:
> On 03/02/2026 15:01, Josua Mayer wrote:
> > Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling this
> > option thorugh the kernel configuration without explicit "select" drive=
r
> > dependencies.
> >
> > Select it by default when COMPILE_TEST is set for better coverage.
> >
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > ---
> >   drivers/mux/Kconfig | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> > index c68132e38138..e31c46820bdf 100644
> > --- a/drivers/mux/Kconfig
> > +++ b/drivers/mux/Kconfig
> > @@ -4,7 +4,13 @@
> >   #
> >
> >   config MULTIPLEXER
> > -     tristate
> > +     tristate "Generic Multiplexer Support" if COMPILE_TEST
>
> This didn't do what I thought it would.
> It was my intention to allow enabling this through menuconfig / .config.
>
> With the syntax above menuconfig shows:
>
> =E2=94=82 Symbol: MULTIPLEXER [=3Dn]
> =E2=94=82 Type  : tristate
> =E2=94=82 Defined at drivers/mux/Kconfig:6
> =E2=94=82   Prompt: Generic Multiplexer Support
> =E2=94=82   Visible if: COMPILE_TEST [=3Dn]
>
> This means it cannot be selected.

Looks like you haven't enabled COMPILE_TEST first?

> Instead I (think I) should use
> default m if COMPILE_TEST

No, merely enabling COMPILE_TEST must not enable additional
functionality.

> Since my patch-set broke x86_64 allmodconfig and failed merge into
> linux-next,
> this presents an opportunity to change the above as well with v9.

Ulf has already applied this series to mmc/next.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
