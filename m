Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8DE410D1E
	for <linux-i2c@vger.kernel.org>; Wed,  4 Feb 2026 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214913; cv=pass; b=bkM3lNLKLQlzu8LQJHAWjRgaNTeYxB+TEHGoESzVItKqyhmw6c5a9tPXPEjfNYMR563VOh62SjZdBDHBoyxQLaZqcl/K7Gq+RTUgUGFWZ2ygReuibLjJ91PxVAKXm2xJUwxKcMSE4ztojQeQo8+Xn8qm0sdysrlRC37XOR8AbQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214913; c=relaxed/simple;
	bh=psGZzOZbMuFzaU3jqsxMK4GjCf6+fMfPrTbP+wqu1kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4CNURGF0i+RmX/gLCIrZoFHRZghBERC7emqwZlatUIsNHP7e5NQM9DeShI3X/CcRlY8OhlzNuQBrqsxeuO96UrQh3TRBbOGF435Wktmgo2OEQBBtoCTHy66eLp2RZ3zuKLn6Y3BircuR9lmRTOnZE6HYexBaqd49cwt0k+d+W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hLboUYL5; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hLboUYL5"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59ddf02b00aso1088768e87.0
        for <linux-i2c@vger.kernel.org>; Wed, 04 Feb 2026 06:21:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770214912; cv=none;
        d=google.com; s=arc-20240605;
        b=ZwhVInt01ItfUTSOg/g3ImbPA9n/XjmWCiWNiiPSoI2GOs1aKUTId2qqwQccQ9bmwp
         z9lgLu5MP8hfK+/X3AMwBIJEFGd+j8HuPmR6377z8WMFMO77aju/8AsLrEhqSPcvjqNz
         h44ABHybtzDr1hYlUL1iO9qjO2FXAvHJNtvJwlPaAJbra0Ul5qmgacqf79kNJRinsw8u
         v0eRSfY16aBmA5iXKYheqvjb3AVJCwKz1ys/cWWkm1rDCf+wp1jrk1jq9Buq+vWrjBqO
         Y8s/wxopiskkJeaoayHHmeiCuT1PGuR2x/TgTtvG9li54loT/YFcdPuMajJTUPXM4XZZ
         9Tbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=c5qbJkJQB6xAL7Tc+McFdVmhrNTCwyZzzlaLu/NQwoo=;
        fh=4bOmA252/3K54Poy9Ufry2XCbuPjASIke6IzbNoT76Y=;
        b=ejLYeFiRqk90XaIei854ehXJUTJaUvAZZPMaT6pjJH3wj2SzfDKYPM5vCLudXLbGYf
         MrFEkDcEZPINxHYhNf0TtMGfpZCKxsZEKdfPYWoxAv5DFLBW+hLHVxuCmNt3HdUBCpSQ
         YagHhdNnpp/EfpCke6yCCee5b+jImp/vMaW3NMcTGPrwX9n3cjM4zjlS+v9+HejNNZm7
         dWVKYwwV++DFnPil++95aT/q+EMVnYhXBK0JBFejMYb1QGKxjfkwoEYjPMZiqekoO4io
         rVppy3jCBjzhVe9901huGVVI1LtRxXgLDkRZS6DAeIFJNZhlCS4F8WOtAUt40GJlxCi0
         xMbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770214912; x=1770819712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c5qbJkJQB6xAL7Tc+McFdVmhrNTCwyZzzlaLu/NQwoo=;
        b=hLboUYL5Ua61Nf4kndNvuPEV+ZY+gLxKPPSkqjLGy2erqtK0Wuo9fXDCIKg5ay0jzZ
         GYcOau1MoTGdkvLD3C3d8Z6u3qTYWR8drR3TJbiwXUtfmmzYJnfRg83fCF2PPGsOsH6R
         quIJWBHWMWFskCMyX6vUXCCaM6Dpu2lSePvEEtfItZ7L9vA671UpANNyczP6OVGMOerm
         uyBQtwSAj+HI/NF0Boe7yuJmKasMU5AVLcW+TeD1wLBQqbrAuSqVL5QeAHPip1sOAzbE
         JqZqVOqtodGHVeD4Byf8lcz1YvqNE7fbrbajMIwMUdk1Qdg4ToIlwv9ZkeTp6H2tT5p2
         axhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214912; x=1770819712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5qbJkJQB6xAL7Tc+McFdVmhrNTCwyZzzlaLu/NQwoo=;
        b=o7+mn0ftvksydosl4aYxxqQPMHP1FhHjVnKmP9RcwwJtqC9hzy+4Aixx5YEWWeq+ib
         TVNMFvGuf/MoYH6iu8bb1kr69l5QzJvHAQ/6khB1L++53mCkU1F5Te+LqJqyrKGfhKln
         XfWH9W3K0CVNUSPa0rNEVLO9LD2NT5w09HhOvsuRT7kkZPrZBwUa80EcJ9/MKpL+FiIw
         lbbsscyA9syb8ohunZt2BORncOO1o2ELUAK8LE17gCF9Mcn3uiS6IU6o63OrKyJUSPBw
         rAG3VPLbqJZnvLGJ4771Z9WTx6JEk3UvvpO/g6dh/kDfJmpxGxCZvEzcDQyGzokAWBhi
         Molw==
X-Forwarded-Encrypted: i=1; AJvYcCUu9pEy+iG82iPkF5vpWiHuf5EDygYTziXkXSLPG5Hl0at19ZQze89IUqgVshjS1cLcyivaFE+kv28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyijz2sc8aKe1he/IFD5/aJMOH0iQQhx5AJXkhdSnUQzFdFaoJY
	LhqhbKfl/xnbTe3bzUdBgRWv9AvBomZ6hjHt2mHa7+xDYACI4GQs84V9oKTh7qJLmf5zfM8MVUf
	z9FTbMFolP4RTqGQ7DcnglG6+borZ1dKkPhKHy71ZYf4JPyTRhWefpDY=
X-Gm-Gg: AZuq6aJZCP3TxGd1b8Kactf0ZUOzQoeWyRsx87sBgyue9u/reBJwcHJyW7zWcCDbhP8
	sYZORfJi8iyR9ac31VE8huwzs7siPRecAaGILhkVamJHZ4T0KEwQi6duUh9rIk1xTSVxhP4GrDR
	N0qh5scIRWia414B/IWEfNz6kl7u5007kbt/qnazQk1iIWhA7SCNFngNsJ2ZbSJMIpPVTFyOa+d
	PTqaf+EzNBDgLYEL5vpk0y2NDucYsgZXOZytR6ru+2mcD8NPSLt77JiPKewIAZfbKT545bY
X-Received: by 2002:a05:6512:110d:b0:59e:39af:a70f with SMTP id
 2adb3069b0e04-59e39afa7aamr832564e87.35.1770214911328; Wed, 04 Feb 2026
 06:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-2-024ea405863e@solid-run.com> <e6bccab9-79ce-4b9b-942e-01c504228d7b@solid-run.com>
In-Reply-To: <e6bccab9-79ce-4b9b-942e-01c504228d7b@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Feb 2026 15:21:15 +0100
X-Gm-Features: AZwV_QgpPJOpHagM8bEfHl9m5X84cdk3L263aQ80RGFzSepSmlUAi0xxl4raAF8
Message-ID: <CAPDyKFqONKvPbtLRXKbF6x5RdNpJDCB1R0-7j-Epksva16Y_-Q@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] mux: Add helper functions for getting optional and
 selected mux-state
To: Josua Mayer <josua@solid-run.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Feb 2026 at 16:35, Josua Mayer <josua@solid-run.com> wrote:
>
> On 03/02/2026 15:01, Josua Mayer wrote:
> > In-tree phy-can-transceiver driver has already implemented a local
> > version of devm_mux_state_get_optional.
> >
> > The omap-i2c driver gets and selects an optional mux in its probe
> > function without using any helper.
> >
> > Add new helper functions covering both aforementioned use-cases:
> >
> > - mux_control_get_optional:
> >    Get a mux-control if specified in dt, return NULL otherwise.
> > - devm_mux_state_get_optional:
> >    Get a mux-state if specified in dt, return NULL otherwise.
> > - devm_mux_state_get_selected:
> >    Get and select a mux-state specified in dt, return error otherwise.
> > - devm_mux_state_get_optional_selected:
> >    Get and select a mux-state if specified in dt, return error or NULL.
> >
> > Existing mux_get helper function is changed to take an extra argument
> > indicating whether the mux is optional.
> > In this case no error is printed, and NULL returned in case of ENOENT.
> >
> > Calling code is adapted to handle NULL return case, and to pass optional
> > argument as required.
> >
> > To support automatic deselect for _selected helper, a new structure is
> > created storing an exit pointer similar to clock core which is called on
> > release.
> >
> > To facilitate code sharing between optional/mandatory/selected helpers,
> > a new internal helper function is added to handle quiet (optional) and
> > verbose (mandatory) errors, as well as storing the correct callback for
> > devm release: __devm_mux_state_get
> >
> > Due to this structure devm_mux_state_get_*_selected can no longer print
> > a useful error message when select fails. Instead callers should print
> > errors where needed.
> >
> > Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
> > property presence check") noted that "mux_get() always prints an error
> > message in case of an error, including when the property is not present,
> > confusing the user."
> >
> > The first error message covers the case that a mux name is not matched
> > in dt. The second error message is based on of_parse_phandle_with_args
> > return value.
> >
> > In optional case no error is printed and NULL is returned.
> > This ensures that the new helper functions will not confuse the user
> > either.
> >
> > With the addition of optional helper functions it became clear that
> > drivers should compile and link even if CONFIG_MULTIPLEXER was not enabled.
> > Add stubs for all symbols exported by mux core.
> >
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > ---
> >   drivers/mux/core.c           | 205 ++++++++++++++++++++++++++++++++++++-------
> >   include/linux/mux/consumer.h | 108 ++++++++++++++++++++++-
> >   2 files changed, 278 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> > index a3840fe0995f..2e8295e3aabe 100644
> > --- a/drivers/mux/core.c
> > +++ b/drivers/mux/core.c
> > @@ -46,6 +46,16 @@ static const struct class mux_class = {
> >       .name = "mux",
> >   };
> >
> > +/**
> > + * struct devm_mux_state_state -     Tracks managed resources for mux-state objects.
> > + * @mstate:                          Pointer to a mux state.
> > + * @exit:                            An optional callback to execute before free.
> > + */
> > +struct devm_mux_state_state {
> > +     struct mux_state *mstate;
> > +     int (*exit)(struct mux_state *mstate);
> > +};
> > +
> >   static DEFINE_IDA(mux_ida);
> >
> >   static int __init mux_init(void)
> > @@ -516,17 +526,19 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
> >       return dev ? to_mux_chip(dev) : NULL;
> >   }
> >
> > -/*
> > +/**
> >    * mux_get() - Get the mux-control for a device.
> >    * @dev: The device that needs a mux-control.
> >    * @mux_name: The name identifying the mux-control.
> >    * @state: Pointer to where the requested state is returned, or NULL when
> >    *         the required multiplexer states are handled by other means.
> > + * @optional: Whether to return NULL and silence errors when mux doesn't exist.
> >    *
> > - * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
> > + * Return: Pointer to the mux-control on success, an ERR_PTR with a negative errno on error,
> > + * or NULL if optional is true and mux doesn't exist.
> >    */
> >   static struct mux_control *mux_get(struct device *dev, const char *mux_name,
> > -                                unsigned int *state)
> > +                                unsigned int *state, bool optional)
> >   {
> >       struct device_node *np = dev->of_node;
> >       struct of_phandle_args args;
> > @@ -542,7 +554,9 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
> >               else
> >                       index = of_property_match_string(np, "mux-control-names",
> >                                                        mux_name);
> > -             if (index < 0) {
> > +             if (index < 0 && optional) {
> > +                     return NULL;
> > +             } else if (index < 0) {
> >                       dev_err(dev, "mux controller '%s' not found\n",
> >                               mux_name);
> >                       return ERR_PTR(index);
> > @@ -558,8 +572,12 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
> >                                                "mux-controls", "#mux-control-cells",
> >                                                index, &args);
> >       if (ret) {
> > +             if (optional && ret == -ENOENT)
> > +                     return NULL;
> > +
> >               dev_err(dev, "%pOF: failed to get mux-%s %s(%i)\n",
> > -                     np, state ? "state" : "control", mux_name ?: "", index);
> > +                     np, state ? "state" : "control",
> > +                     mux_name ?: "", index);
> >               return ERR_PTR(ret);
> >       }
> >
> > @@ -617,10 +635,28 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
> >    */
> >   struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
> >   {
> > -     return mux_get(dev, mux_name, NULL);
> > +     struct mux_control *mux = mux_get(dev, mux_name, NULL, false);
> > +
> > +     if (!mux)
> > +             return ERR_PTR(-ENOENT);
> > +
> > +     return mux;
> >   }
> >   EXPORT_SYMBOL_GPL(mux_control_get);
> >
> > +/**
> > + * mux_control_get_optional() - Get the optional mux-control for a device.
> > + * @dev: The device that needs a mux-control.
> > + * @mux_name: The name identifying the mux-control.
> > + *
> > + * Return: A pointer to the mux-control, an ERR_PTR with a negative errno.
>   * Return: Pointer to the mux-state on success, an ERR_PTR with a
> negative errno on error,
>   * or NULL if mux doesn't exist.
>
> If there will be v9, I shall change this to be more precise similar to
> other functions.

The series looks good to me!

I can queue the series for v7.0 via my mmc tree and amend the change
according to above when applying, but I need the ack from Wolfram on
the i2c patch (patch5) first.

If this doesn't make it for v7.0, I suggest you re-spin a v9 after the
merge window.

Kind regards
Uffe



> > + */
> > +struct mux_control *mux_control_get_optional(struct device *dev, const char *mux_name)
> > +{
> > +     return mux_get(dev, mux_name, NULL, true);
> > +}
> > +EXPORT_SYMBOL_GPL(mux_control_get_optional);
> > +
> >   /**
> >    * mux_control_put() - Put away the mux-control for good.
> >    * @mux: The mux-control to put away.
> > @@ -657,10 +693,13 @@ struct mux_control *devm_mux_control_get(struct device *dev,
> >       if (!ptr)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     mux = mux_control_get(dev, mux_name);
> > +     mux = mux_get(dev, mux_name, NULL, false);
> >       if (IS_ERR(mux)) {
> >               devres_free(ptr);
> >               return mux;
> > +     } else if (!mux) {
> > +             devres_free(ptr);
> > +             return ERR_PTR(-ENOENT);
> >       }
> >
> >       *ptr = mux;
> > @@ -670,14 +709,16 @@ struct mux_control *devm_mux_control_get(struct device *dev,
> >   }
> >   EXPORT_SYMBOL_GPL(devm_mux_control_get);
> >
> > -/*
> > +/**
> >    * mux_state_get() - Get the mux-state for a device.
> >    * @dev: The device that needs a mux-state.
> >    * @mux_name: The name identifying the mux-state.
> > + * @optional: Whether to return NULL and silence errors when mux doesn't exist.
> >    *
> > - * Return: A pointer to the mux-state, or an ERR_PTR with a negative errno.
> > + * Return: Pointer to the mux-state on success, an ERR_PTR with a negative errno on error,
> > + * or NULL if optional is true and mux doesn't exist.
> >    */
> > -static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
> > +static struct mux_state *mux_state_get(struct device *dev, const char *mux_name, bool optional)
> >   {
> >       struct mux_state *mstate;
> >
> ...
