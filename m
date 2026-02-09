Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7FA36680E
	for <linux-i2c@vger.kernel.org>; Mon,  9 Feb 2026 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632578; cv=none; b=I9t5NURDapoamXA1JaT59nuoX2lgcaKWQEsEUEsBrP6GGJL6gignDSGKKwQvNCKdydW/1gKzfPhWYiiJl+5Jxk7Lw6u/vuCGXnhFoeq+etwf9apClK1Kf4CyUUErrh6u0ViU2Yoo2RrKcjPHrOFlUnILfyV5RRbt5Il5JRoyubA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632578; c=relaxed/simple;
	bh=J73vKAZhiN3K6G/5fpGigw+8duj0Td3xLp2ybYYDes8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRLzUo49y50MAg3sYG9kPBZpDPELMVn7r1ZA1G5pAk4GOCIP1MAmYBmdjN1w27mXk3z/QJPS6Mhu/UTtRCz/Xpj92LrXLxkIOiG3RqGlWeLW/vnZXMeuHqVRCMpkqtJFuy6z/93sTJ0tyM1d2VP0eF9YebgevASPsflX3wmKsd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89505dd3e24so52866826d6.1
        for <linux-i2c@vger.kernel.org>; Mon, 09 Feb 2026 02:22:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770632577; x=1771237377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=55b+49cOY521wvVXvsz0WcOQjNDu8cxcjrZIHfMxzy4=;
        b=R1PldceBeMB2BCQ6t9bZnMlQT4So105CXzPTuYGuLvo3bl68GtE7Za96K4afS2ZOHL
         Uk4NVEk31JmbGg0eIP2vvHwXuDS7ogXQwlPWYRB6OnuD/NQTpSgZX5JHnUx/Tzur7G/B
         53NfxwC8wj3WlHzK7aXzwlP8JO2pLwTRGPxe8REpd4A/0Hx0npQ41L0wwq2je2gjIfn+
         bYuuOqLh7A8nXT2hzH8bhN/tTkyu/bfuwYlas7ofJNrhuuRcWfVQ33ky2tJ5yvUynd8Y
         KyXv1FtJ3OvB2CxFyZ953dZhlzj1EWOWHT9OZVou5ditK19WD1nllEWoEWA/jntjZ8c7
         pyfw==
X-Forwarded-Encrypted: i=1; AJvYcCUgH1VGkFQ3/bTFhoO8s7yhoU51YEwfQAojvuKVtqpeC1s6is7tAuaoabCZaEPF17Rs3XrgteIxego=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw58kbaepCl0JBoIh6NmaxTqcPemyFvW5obvLpvjumon5k9R64t
	QLNYrm77jzNu3BoFhSPbAKfVyWmnxlpJ9x8sRdtvI/2CtLTDaz5j4Wv0jSk1m8l5
X-Gm-Gg: AZuq6aJ50D0kUiAiYS76PIMt29hbETWt8gjM7bSSyIOXLFzzm3bat7Ar/4PtUDWAyTT
	hAFkY+w536FrXDtLHiQlxJnjqtZVo+XhVowQ7g4seGisuAWkzH/jNcF6hqlLQbmYM7vaErH2ayY
	AqeN2LZHxoJIJeTKKlltsa4ayQ6zXVkkaEO3Okqf5MdIi+peNd27kXCA1QWcsQt10TvvKO2nR10
	BBsNmtVTPBaagUNqBf3bO32S5H8XUifxBByMAl0W46M49SC0qTE47nMpb4qsjTT9ZkcYXGcyiUR
	ExEWGlwXvaPuaG8kfjPimtck8cgN5qnKGrBqpQRcCZQT9G2cSnvYCpz0GdAOQSGXBOHYqvvv0V5
	sLprZKRFlGki3Up8pGdup7p6Nizgqq3tKTvEBqmKN6bFyBTv2V2NSFTSNSjRH/B5254F6XzeSRj
	RGvfiJ7MJS7g0klHaACEC0WmHQ59/47x4sAudDv72hYCwrkUvVDv8I
X-Received: by 2002:a05:6214:260a:b0:890:19d1:532c with SMTP id 6a1803df08f44-8953cd8b9e8mr144826196d6.34.1770632577290;
        Mon, 09 Feb 2026 02:22:57 -0800 (PST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8963ac2ab29sm41196816d6.3.2026.02.09.02.22.57
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 02:22:57 -0800 (PST)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c6aaf3cd62so427112885a.3
        for <linux-i2c@vger.kernel.org>; Mon, 09 Feb 2026 02:22:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW44073XS7F4L/BU0YcrFFO8/mgXfvhX+tz1ZgLXrew+Dgp/CW2oVEcSIsWIaq635pnHrkm/7X+B+Y=@vger.kernel.org
X-Received: by 2002:a05:6122:3c54:b0:566:3d03:8e1d with SMTP id
 71dfb90a1353d-56705febb0fmr2935090e0c.17.1770632257982; Mon, 09 Feb 2026
 02:17:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-3-024ea405863e@solid-run.com> <b7dcb374-b79c-4e9f-ac30-2f507127cfb3@solid-run.com>
 <CAMuHMdU01vwif4H6H-cYUfW0Y56fN6Anp9F4Ru7q3fveNqqoXA@mail.gmail.com> <39f3891c-c05a-4e10-9ad4-ab3cbc6fa70e@solid-run.com>
In-Reply-To: <39f3891c-c05a-4e10-9ad4-ab3cbc6fa70e@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Feb 2026 11:17:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVbi=2puhk84k+FCDXqkQ9jFsy0rsseQiFCF8i=KsR1OQ@mail.gmail.com>
X-Gm-Features: AZwV_QizeLChl5bqEs0QtuubG3nlVKZbEpUJtWLc1m5RmCDOEU_VrUSeQPEZi-k
Message-ID: <CAMuHMdVbi=2puhk84k+FCDXqkQ9jFsy0rsseQiFCF8i=KsR1OQ@mail.gmail.com>
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

On Mon, 9 Feb 2026 at 11:12, Josua Mayer <josua@solid-run.com> wrote:
> On 09/02/2026 10:06, Geert Uytterhoeven wrote:
> > On Sun, 8 Feb 2026 at 16:16, Josua Mayer <josua@solid-run.com> wrote:
> >> On 03/02/2026 15:01, Josua Mayer wrote:
> >>> Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling thi=
s
> >>> option thorugh the kernel configuration without explicit "select" dri=
ver
> >>> dependencies.
> >>>
> >>> Select it by default when COMPILE_TEST is set for better coverage.
> >>>
> >>> Signed-off-by: Josua Mayer <josua@solid-run.com>
> >>> ---
> >>>    drivers/mux/Kconfig | 8 +++++++-
> >>>    1 file changed, 7 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> >>> index c68132e38138..e31c46820bdf 100644
> >>> --- a/drivers/mux/Kconfig
> >>> +++ b/drivers/mux/Kconfig
> >>> @@ -4,7 +4,13 @@
> >>>    #
> >>>
> >>>    config MULTIPLEXER
> >>> -     tristate
> >>> +     tristate "Generic Multiplexer Support" if COMPILE_TEST
> >> This didn't do what I thought it would.
> >> It was my intention to allow enabling this through menuconfig / .confi=
g.
> >>
> >> With the syntax above menuconfig shows:
> >>
> >> =E2=94=82 Symbol: MULTIPLEXER [=3Dn]
> >> =E2=94=82 Type  : tristate
> >> =E2=94=82 Defined at drivers/mux/Kconfig:6
> >> =E2=94=82   Prompt: Generic Multiplexer Support
> >> =E2=94=82   Visible if: COMPILE_TEST [=3Dn]
> >>
> >> This means it cannot be selected.
> > Looks like you haven't enabled COMPILE_TEST first?
> Correct.
> But CONFIG_MULTIPLEXER should be visible always,
> not just when COMPILE_TEST is set.

Why should it always be visible? All users select it?

> >> Instead I (think I) should use
> >> default m if COMPILE_TEST
> > No, merely enabling COMPILE_TEST must not enable additional
> > functionality.
> >
> >> Since my patch-set broke x86_64 allmodconfig and failed merge into
> >> linux-next,
> >> this presents an opportunity to change the above as well with v9.
> > Ulf has already applied this series to mmc/next.
> What would be the process to fix the build error for x86_64 allmodconfig
> now?

Incremental patches, cfr. Ulf's response to [PATCH v9 0/7].

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
