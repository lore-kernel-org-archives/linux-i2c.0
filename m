Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB22FBE12
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768993702; cv=none; b=T7hPKnvNYNbph4rUzygYqFDpk9u/mBkqCdBKWZVuS8vhwEU8PxhMl0UpkXhkANIftwNmR0nMhbnpcoJ029wjdCdPPdBnyi7sFClCY/dt+7/lHnspkxJBEPYs/gRyhmt08YbX/NZ6MJSjy+nPOBq9kDh2r4YBqjI27MGsD3DnU4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768993702; c=relaxed/simple;
	bh=cysOwS5g5dZRSxtVrJ3zv/VB5w+D2iLkyCuaPMhXFP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vj4bmzkJ+gm/zXoF65FI4gVM2DSJSrKga8H0Vam3XTKqNfcUxdVgZiP5VeET8EBlu20bgH+pWR1pybyM/5fYBA8vbqtoAQBcEJhwTIb0gsxrAPYpwOi82S+Rl5KESM1LRWKSzBdoP46CMAz3CRql/Icu2u/0+6i3+razdYyQ63c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5013c912f9fso72945061cf.2
        for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 03:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768993700; x=1769598500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSYJm8i9wWqRvGvRTZz6VIsl7/oMewZT8tw/+hAgWzw=;
        b=LWiS2QXwDUmJBTjolSUDvmO7McfMioPJ4tS8RumxdhTKwy4S9C0Ot+TwRuHWk+BLT5
         A2FoCgh4kmsLMyGRfRA/tewyAVPfm7/BRHIfqpvdIHRcOqpS8ePTiG+24ZOZiy4h7kBB
         ZI4S1tGxYSB+9/kh9nWdZgS1SJ8uqAbTDrwTa3DNlYlna1q+HQnpt0m5E7YxWcelOMqE
         FOU9j8p+l6YIoOjIjoJy2/v6E8qQ2scS9APe3af6iovCeUQiztT7H9SOpGYe6joucSbt
         JXPHQJoJGeQNLRygaO3RjLiLEvFeBO90RIQGHrHoWtLw5/N8Y2z6+xB2xMNBYL+XpdrO
         6RJg==
X-Forwarded-Encrypted: i=1; AJvYcCVRwZTLIMYD4X96RxkZN6bwRvUz+vr+VgBj5Ha9T3iy2kfhl6D71A0JgUy3rijCVziLPw5iB58gG2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj+PgbensfWY50TT0OlqjW+BDPIPJG62RN6KEy4TpyX9oSXh6j
	tS/TmT7kwxmRD+pGjh0OC3soakxQoFJfzuxyWWNO9kM3QKtoP0KMguFjprJO/A+p
X-Gm-Gg: AZuq6aKmA/94qPdu3pEZsQWnpxCWyqVSqZZGVfiMNtImSn+zyK/ziv4cF16Ow4mO3I4
	cAUjaUvywahsepNRqldLFjV82dAoGaX4YgDVgVWJ+s/xtaYom61KR3Bi5SvqRqckrP8uWpZZfaR
	5VrkR/FUTRCqa0N0wA7eMW3ImSV3NtY+ghxpdFAFxokmNhuZRzGQNmJZOYGNsCYUBSMyAuLPMMI
	fNDlkhgxIGkLy/suwIFg6LxVyknaUWRbR+n9EvqC5tO9LfkbhyI5mDy+DO8mzSYXFthAKz76UKB
	KHASYtLHGL8RYUpdUmp4KZjmUABOAFlSVaDAf6ib54uVWeiRpuCN/ts24ExoqG1CoW0eWsRpaWR
	rZHTC2qjaGLsTw8VVz8FCESENPR4KlCmhELMrpnPAmWSXm4CPImw8bIJysAFA0PYKxBa7rfzE5b
	9WCrz/Yi1V7SWllb4oCkf4wbM0/jiOrsjV/bJJ6AUmTBEvOoMWRdIP
X-Received: by 2002:ac8:7d96:0:b0:4ee:4128:beb7 with SMTP id d75a77b69052e-502a1f99513mr224083191cf.69.1768993699810;
        Wed, 21 Jan 2026 03:08:19 -0800 (PST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d9f296sm118242891cf.12.2026.01.21.03.08.19
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 03:08:19 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5013c912f9fso72944991cf.2
        for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 03:08:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU19be3TaD2FBQwOP76oyEx49f+DrQylE07J+8zzjktiQ3ywgxg4lNwN7tzJs7dNfs/n6yd1NrQ/wk=@vger.kernel.org
X-Received: by 2002:a05:6102:2ad6:b0:5ef:248b:d533 with SMTP id
 ada2fe7eead31-5f1a716fcbcmr6150752137.31.1768993204250; Wed, 21 Jan 2026
 03:00:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com> <20260121-rz-sdio-mux-v6-3-38aa39527928@solid-run.com>
In-Reply-To: <20260121-rz-sdio-mux-v6-3-38aa39527928@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Jan 2026 11:59:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX_rKgfusHP5qVny8OZufU6VAiA6sqg1LP3T2jikSz7yQ@mail.gmail.com>
X-Gm-Features: AZwV_QifTISU05sQ0lYySqx5XyPjAzUqa1H8fmOUOfLhWhGN7rzCzfM2UGq26-s
Message-ID: <CAMuHMdX_rKgfusHP5qVny8OZufU6VAiA6sqg1LP3T2jikSz7yQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] mux: add help text for MULTIPLEXER config option
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
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Josua,

On Wed, 21 Jan 2026 at 11:02, Josua Mayer <josua@solid-run.com> wrote:
> Add help text for CONFIG_MULTIPLEXER to allow enabling this option
> through the kernel configuration without explicit "select" driver
> dependencies.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Thanks for your patch!

> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -5,6 +5,14 @@
>
>  config MULTIPLEXER
>         tristate
> +       help
> +         Generic Multiplexer Support.
> +
> +         This framework is designed to abstract multiplexer handling for
> +         devices via various GPIO-, MMIO/Regmap or specific multiplexer
> +         controller chips.
> +
> +         If unsure, say no.
>
>  menu "Multiplexer drivers"
>         depends on MULTIPLEXER
>

Unfortunately it doesn't work like that. As the tristate has no prompt
specified, the user will never be asked about this.
You should use something like below:

--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -4,10 +4,8 @@
 #

 config MULTIPLEXER
-       tristate
+       tristate "Generic Multiplexer Support" if COMPILE_TEST
        help
-         Generic Multiplexer Support.
-
          This framework is designed to abstract multiplexer handling for
          devices via various GPIO-, MMIO/Regmap or specific multiplexer
          controller chips.

Sorry for not noticing before.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
