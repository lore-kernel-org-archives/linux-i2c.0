Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDE23559E7
	for <linux-i2c@vger.kernel.org>; Thu, 29 Jan 2026 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769709411; cv=none; b=Lv5sZjm2JJAsK3ccdPRdv4nzc2ZFZgakLZeTo+eWzgN1KDk30xL1qy9hLBjIoSaaBJc5woOg3Y3SxJe5E1rCX4kgVE3TJ2aRwyOVjjz4CDk/gIMkJAv8RLnPhN3Kr4w/SAhb44gG5/PfavdLGvofmdZmcZdXd+yy5rQnivXS5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769709411; c=relaxed/simple;
	bh=BmaXlCZ6264fsqvXXrjSoDhWiC9g1X99D6Z7+wsR+aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyWzYRlcf+Ao0e2QTjf/XwbgPQoeDydzS9GzG0UxpytsoaNQWPpJnpdyAIXKQVd9s1FRFXinsxPhP1dbOfOyoPc/RPA5qnN+JKEDCKr8b1OuX1yRYFLsF8z+1myod+ux8dO+h0mlLNCoDvvR2KRwsOKibDQBRptj89VeHHM9Cd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56637565faaso1049231e0c.1
        for <linux-i2c@vger.kernel.org>; Thu, 29 Jan 2026 09:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769709409; x=1770314209;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/B1720oxlP4NMLZCxNr6vg90MXZvyAsBr77z/rjaXw=;
        b=jmU82SEa4X5G3e/z1MInOmQrT58rWQ4cF6q500ZiGFsb7fGOMjry9diTfqpB6JMKiq
         aoA1ZCpniwIjamXKS/Nh9DzWMifDnrnWNJUNBDjODDZc4ucYJqLnrhcPZ0XpskroBaKI
         w3KL4XYGDj+liMsbYzxzWoKQnwU+BX86iRWeNPeXV+m6lCTDxxnD5CiNyoyhK2uhiqzt
         Q24v9/0/en5FV2Lu6Cr9K5ISao7BAJsZx22MDrcvmIQRIRTxIjpPjsUSR6T/UepjyVCE
         M8L11+6FWMM2tQGbl4Ic6hDaKf4cZjFQSv8tmZcxSUd5cjK8Ar/IRBRongAd77/J95qi
         MMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgbdL/aYZjdCm6bZIfPNc+bq5jWIukBGykolv7CGEzvffPXP9GygwtusL6GmBgQKV6/mt8zrvKM2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYJZg4QbQBW9hgBG8Gg0twjiS6n/cTMUGLCHf1mxEV6X5fFXBJ
	MDa8S5KaKmujeKs+i7R5NTKFAGmwil5grZA7t9m9cf1OjHUZjdTXmW81xOuzHj7b
X-Gm-Gg: AZuq6aKzxKfESaTVx6Z+cYHWitwdv13kHufCZBL3ipvtrzPhpXpmpxOth9N77diOQ1W
	6p6uXdtYiOsyQieIgwZNbjh7P2vLarHjQhCEM6IKBridSq3az2z0EzcRrRXO/eqEfRz2lTCO+Ut
	PxK2JRmqgvHku4AInzmdZUij+aTt4D19rRf2gTav+gspK6qKmHBk2A/9RBkoBIgJxBjHMkL6y88
	OZ6EZD9kXJBv/pZpt2B9iAH51Rl9DFpoXyWcQfngSmpzfX5+8DpxHKAGg1cV2/e9+QUIOIn1NAI
	LATf2+Ra0Csc8NGuv0Oq11V3HslSw6CpWVT83ZVdaLJosv8a/AvYoYhlz9d96nGE0BhtDYYBiqt
	/9KJlOGCP94X+iH6chKp8CRlFoJ3mRIlud9ItJluU1atISTON7/cXKGiSHz9Msdf5DfmjmYciiP
	yqYbr/ShCPcTzuCZm1OL+d2SKd5m1i692PVlZR8Vl1EIpXMQl4
X-Received: by 2002:a05:6102:1606:b0:5f5:7724:3498 with SMTP id ada2fe7eead31-5f8e24bc35dmr8476137.10.1769703582545;
        Thu, 29 Jan 2026 08:19:42 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948724fbae3sm1163378241.14.2026.01.29.08.19.42
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 08:19:42 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94124140e02so658285241.1
        for <linux-i2c@vger.kernel.org>; Thu, 29 Jan 2026 08:19:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+BMBBkFKOtb/WsgmLGKjMwD4tEBq8OYS+mVe2RVfb1OYltVQljhT6/kXgcTFIOY9CrGHAxq4cTiM=@vger.kernel.org
X-Received: by 2002:a05:6102:32d2:b0:5f1:50d0:3797 with SMTP id
 ada2fe7eead31-5f723937ba5mr3352368137.43.1769703201568; Thu, 29 Jan 2026
 08:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
 <20260128-rz-sdio-mux-v7-2-92ebb6da0df8@solid-run.com> <CAPDyKFrBuL+747QUJJUejtcvjm0V7Lt=vHwjvcMdCt_h4=sFwg@mail.gmail.com>
In-Reply-To: <CAPDyKFrBuL+747QUJJUejtcvjm0V7Lt=vHwjvcMdCt_h4=sFwg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Jan 2026 17:13:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXgLR9yeLa5JKNdAOtNEirJ8263bmn1zRNAnKnmf8F-Sg@mail.gmail.com>
X-Gm-Features: AZwV_Qhgryuc7jjty9iqHy9zUzs2cyLGoonPOo05F0vrabMAU0UMySZvEVLbN1w
Message-ID: <CAMuHMdXgLR9yeLa5JKNdAOtNEirJ8263bmn1zRNAnKnmf8F-Sg@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] mux: Add helper functions for getting optional and
 selected mux-state
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Jan 2026 at 17:06, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Wed, 28 Jan 2026 at 15:46, Josua Mayer <josua@solid-run.com> wrote:
> >
> > In-tree phy-can-transceiver driver has already implemented a local
> > version of devm_mux_state_get_optional.
> >
> > The omap-i2c driver gets and selects an optional mux in its probe
> > function without using any helper.
> >
> > Add new helper functions covering both aforementioned use-cases:
> >
> > - mux_control_get_optional:
> >   Get a mux-control if specified in dt, return NULL otherwise.
> > - devm_mux_state_get_optional:
> >   Get a mux-state if specified in dt, return NULL otherwise.
> > - devm_mux_state_get_selected:
> >   Get and select a mux-state specified in dt, return error otherwise.
> > - devm_mux_state_get_optional_selected:
> >   Get and select a mux-state if specified in dt, return error or NULL.
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
> >  drivers/mux/core.c           | 178 ++++++++++++++++++++++++++++++++++++-------
> >  include/linux/mux/consumer.h | 108 +++++++++++++++++++++++++-
> >  2 files changed, 253 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> > index a3840fe0995f..b01ec126caaf 100644
> > --- a/drivers/mux/core.c
> > +++ b/drivers/mux/core.c
>
> [...]
>
> >  static void devm_mux_state_release(struct device *dev, void *res)
> >  {
> > -       struct mux_state *mstate = *(struct mux_state **)res;
> > +       struct devm_mux_state_state *devm_state = res;
> >
> > -       mux_state_put(mstate);
> > +       if (devm_state->exit)
> > +               devm_state->exit(devm_state->mstate);
> > +
> > +       mux_state_put(devm_state->mstate);
> >  }
> >
> >  /**
> > - * devm_mux_state_get() - Get the mux-state for a device, with resource
> > - *                       management.
> > - * @dev: The device that needs a mux-control.
> > - * @mux_name: The name identifying the mux-control.
> > + * __devm_mux_state_get() - Get the optional mux-state for a device,
> > + *                         with resource management.
> > + * @dev: The device that needs a mux-state.
> > + * @mux_name: The name identifying the mux-state.
> > + * @optional: Whether to return NULL and silence errors when mux doesn't exist.
> > + * @init: Optional function pointer for mux-state object initialisation.
> > + * @exit: Optional function pointer for mux-state object cleanup on release.
> >   *
> >   * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
> >   */
> > -struct mux_state *devm_mux_state_get(struct device *dev,
> > -                                    const char *mux_name)
> > +static struct mux_state *__devm_mux_state_get(struct device *dev, const char *mux_name,
> > +                                             bool optional,
> > +                                             int (*init)(struct mux_state *mstate),
> > +                                             int (*exit)(struct mux_state *mstate))
> >  {
> > -       struct mux_state **ptr, *mstate;
> > +       struct devm_mux_state_state *devm_state;
> > +       struct mux_state *mstate;
> > +       int ret;
> >
> > -       ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
> > -       if (!ptr)
> > +       devm_state = devres_alloc(devm_mux_state_release, sizeof(*devm_state), GFP_KERNEL);
> > +       if (!devm_state)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       mstate = mux_state_get(dev, mux_name);
> > -       if (IS_ERR(mstate)) {
> > -               devres_free(ptr);
> > -               return mstate;
> > +       mstate = mux_state_get(dev, mux_name, optional);
> > +       if (IS_ERR_OR_NULL(mstate)) {
> > +               ret = PTR_ERR(mstate);
>
> Should this be PTR_ERR_OR_ZERO?

"mux_state_get() never returns NULL"
https://lore.kernel.org/202601221036.J0kR78Uw-lkp@intel.com

>
> > +               goto err_mux_state_get;
> >         }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
