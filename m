Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E57500966
	for <linux-i2c@vger.kernel.org>; Tue, 20 Jan 2026 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932295; cv=none; b=Z5nRPi03aSVuXiajUEqEp2sw1i/0m5ANh1jO7qys57Ul7s7MKa5d9gMV/NZtjREqv1T5U7mRkBQ01eywk585ZKbjJ62pmT2F3kK5+o2j/+Rjbx/YIPyy1k9G0Kup8CvtTtSQUfeg/KrYoQDqeXJroj/dGcVE24/CGMwJNHZ2a+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932295; c=relaxed/simple;
	bh=3/JP3tCIvtYedAAyMYL0a51zMnc14SZU20ikWY9BXqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOGq5QoPXENGBKP3ABl+DU2VJhPpKFZCfsCdsEiOXNU/UBnUndgFHU3AIshUt74xpE0jS+4hLWo97K9X0LWfuPWl4QZn+q3TaLsjHjRgR8+SYhiQY5rAJnmXrn88wzBP9vWCvuyYO2AcBzcVbTugpJCz/orugXvAbwYT++5mF7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40438a46d7cso3360507fac.2
        for <linux-i2c@vger.kernel.org>; Tue, 20 Jan 2026 10:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932293; x=1769537093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcPNSr1vco6+E9e0XJi5xyBPxmbRiBl/7/yDisLqrnI=;
        b=GafvRqAJELauJsMaY4v2Z/uLkMrRtKGOHxhl3isDUAZtxtV14LFRVZfdJOlzF8/8Ix
         dq8Q5OAkOrH+pP3wPr/inbo6+uFmKDzmJ2h+mDxlBf1Qd+INb9ZVCJE3rF0EAQJ0wNw5
         +K9p8X/JkP1EBCRdnKPbkahVt8lpPHIF/xa0ATjiyVMDHyhNFix4yT3CAEeI1T2fJAzh
         meLkZiSdT2h29nbi/SiHeu3tNmRIYQ0ptVb5wO/zZoSQjOYfCDbJAQuuG0RreMloXCGR
         e5cXF/GGpDnO7p6gh4Yj1GZm0RIRmbuVgfjxBFdcg9qfmPLK2FcHL1fJu37EbP2VpCZv
         0gZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPypXPgEZrHj1THKDnAiLHOw3YmgPoO3NnttLuqCFY5zaiQfnzh9fGKdP3NhTLr8TJ8la2lAIBN2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+4UTYbCu+TRcbDQO7aBNiw5WY6g3/8Kybq1cU3xPKZ6nfnK8A
	HlFzABjF2c+uHJGtfP/QhCfYHp0NW4+5Kvhm4PnuCjaNIZ7tD5ctnfjWMV0vDPVz
X-Gm-Gg: AY/fxX6be3oQMYA1/kXDzHp8S2bKs8hvbV7UF5V3NVcjDmY/zwhZNSjMI1aG0j6JKqB
	xMERzKzNpVI1heflFSo5IoxfDB7vYUJ773LSWdcUmmrECP6HcvQyueFdx9C9lB3aAsbHcKWaHFz
	ZnoceOez8UXPLqIQKKWKD8LrUpJjqNNyC+VlZFm5/o0BLEY19z4pgdJFmzcB5hqiioF+B0QPweG
	I96gWRUu9PQCT6LFHdiJBivSwJ1CNkINFlFfiZzLeW3oo1MX2GwYcrd9ZD2Q8MIejJ8mkNRdf47
	LI9bIlplobAXypMjuDbKUF1FnsSbZi/msQ76/CYKeXH4UdgbrkGA0tBD+aFa0BDLHbyEC7aduOz
	qReTuec9hSN8r0XO7zYnvCPgT/HpRvxxwDFATH/bvhslkJ/HYU/+IkQXvmChNcYWWjLIdg4kbHT
	7sAEOdH2PhjGK9YGqz0qMBsjOhAoA1gyQOmng6tlvORbcy3jUHNHijxCJhvQ==
X-Received: by 2002:a17:902:e74c:b0:2a7:8088:3718 with SMTP id d9443c01a7336-2a780883820mr10839285ad.30.1768924992202;
        Tue, 20 Jan 2026 08:03:12 -0800 (PST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com. [74.125.82.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190aa328sm126422995ad.1.2026.01.20.08.03.11
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 08:03:11 -0800 (PST)
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-124566b6693so7736327c88.0
        for <linux-i2c@vger.kernel.org>; Tue, 20 Jan 2026 08:03:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX05e58QTLXY9eNeWBRZ2+s6ny/kmbJxmd3V1620YwpADGwQ7C9u3UERK6t9aedGdmGvgCHXnsEQnI=@vger.kernel.org
X-Received: by 2002:a05:6102:b15:b0:5df:c094:628d with SMTP id
 ada2fe7eead31-5f1a6fa3ca2mr4116825137.3.1768924652088; Tue, 20 Jan 2026
 07:57:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com> <20260118-rz-sdio-mux-v5-2-3c37e8872683@solid-run.com>
In-Reply-To: <20260118-rz-sdio-mux-v5-2-3c37e8872683@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Jan 2026 16:57:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU=wDmDJFYvtzxptAkkOQ8r7sPGUxp9u71e64ikY85+Zw@mail.gmail.com>
X-Gm-Features: AZwV_QgiDRrYV1BByFjO2lg9vbxQpf_lMefb8OE6E5E-nZ3iF4svsU32o-Zkiz4
Message-ID: <CAMuHMdU=wDmDJFYvtzxptAkkOQ8r7sPGUxp9u71e64ikY85+Zw@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] mux: Add helper functions for getting optional and
 selected mux-state
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

On Sun, 18 Jan 2026 at 11:29, Josua Mayer <josua@solid-run.com> wrote:
> In-tree phy-can-transceiver driver has already implemented a local
> version of devm_mux_state_get_optional.
>
> The omap-i2c driver gets and selects an optional mux in its probe
> function without using any helper.
>
> Add new helper functions covering both aforementioned use-cases:
>
> - mux_control_get_optional:
>   Get a mux-control if specified in dt, return NULL otherwise.
> - devm_mux_state_get_optional:
>   Get a mux-state if specified in dt, return NULL otherwise.
> - devm_mux_state_get_selected:
>   Get and select a mux-state specified in dt, return error otherwise.
> - devm_mux_state_get_optional_selected:
>   Get and select a mux-state if specified in dt, return error or NULL.
>
> Existing mux_get helper function is changed to take an extra argument
> indicating whether the mux is optional.
> In this case no error is printed, and NULL returned in case of ENOENT.
>
> Calling code is adapted to handle NULL return case, and to pass optional
> argument as required.
>
> To support automatic deselect for _selected helper, a new structure is
> created storing an exit pointer similar to clock core which is called on
> release.
>
> To facilitate code sharing between optional/mandatory/selected helpers,
> a new internal helper function is added to handle quiet (optional) and
> verbose (mandatory) errors, as well as storing the correct callback for
> devm release: __devm_mux_state_get
>
> Due to this structure devm_mux_state_get_*_selected can no longer print
> a useful error message when select fails. Instead callers should print
> errors where needed.
>
> Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
> property presence check") noted that "mux_get() always prints an error
> message in case of an error, including when the property is not present,
> confusing the user."
>
> The first error message covers the case that a mux name is not matched
> in dt. The second error message is based on of_parse_phandle_with_args
> return value.
>
> In optional case no error is printed and NULL is returned.
> This ensures that the new helper functions will not confuse the user
> either.
>
> With the addition of optional helper functions it became clear that
> drivers should compile and link even if CONFIG_MULTIPLEXER was not enabled.
> Add stubs for all symbols exported by mux core.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Thanks for your patch!

> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c
> @@ -46,6 +46,16 @@ static const struct class mux_class = {
>         .name = "mux",
>  };
>
> +/*
> + * struct devm_mux_state_state -       Tracks managed resources for mux-state objects.

Please run scripts/checkpatch.pl:

    WARNING: please, no space before tabs
    #80: FILE: drivers/mux/core.c:50:
    + * struct devm_mux_state_state - ^ITracks managed resources for
mux-state objects.$

> + * @mux:                               Pointer to a mux state.
> + * @exit:                              An optional callback to execte before free.
> + */
> +struct devm_mux_state_state {
> +       struct mux_state *mstate;
> +       int (*exit)(struct mux_state *mstate);
> +};
> +
>  static DEFINE_IDA(mux_ida);
>
>  static int __init mux_init(void)

> --- a/include/linux/mux/consumer.h
> +++ b/include/linux/mux/consumer.h

> +static inline void mux_control_put(struct mux_control *mux)
> +{
> +       return;
> +}

    WARNING: void function return statements are not generally useful
    #441: FILE: include/linux/mux/consumer.h:139:
    + return;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
