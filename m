Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FBB35CBA9
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769768944; cv=pass; b=cszZFezHWkuGlKfhBLTd14USUPHapoIlrMvBurczYDYYxvhVTxzjQJ28P2ZAE0bWXDUqHChCWkZ5O2QhAYjqA9PKgCXJdUoHZw5S/Y65/HtlE5F9a35UUZ4v0hcgrOB5BfDRZGyjKsjxdLfsYdTo21Kz+Vg0/diC3Wf9WZ7DE5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769768944; c=relaxed/simple;
	bh=4IZOypoh2mxenIel1BEB+3XJOHnFitDgJDIz3Q5JdHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3KZZjAlxeU/wlYCaJGtagiR+Puo0AeuPcVF2xSUKoJSLOXHP8NExL9WoWS7DIp8pupTfPMzLOEI9hHbvo5+Xai3tLw7jE8a+SVVhdxJRj5Bx30xcAOOqMTGlct51HcMvq0P28ZndzNjwG6NnHJKAudpGCJ0bJs+D8DzcJAZAI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oln1L8NE; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oln1L8NE"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59b77f2e43aso3266340e87.1
        for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 02:29:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769768940; cv=none;
        d=google.com; s=arc-20240605;
        b=Ck7zm6izPZhHITPkHVjAahTo04hfklJtNG6qCn+ULfuVySwcySTc0utHNvaTy7jYuE
         c8W16CugJBNw6VmmuE6StbYhsVzJczO7FZ0kadaibrTaDl+gPusP2LggZDWKRMtRJY/6
         gZbOnjAN3R/bkjtUP3SdR7eatW7LBnO+0OxqAbvUyFl5HUwhmE8Qp9XnDUJ+upuwW7+6
         f1dzJmdd0XwjVWZ8Fkqktnq/jjPlg/MyX5RFW4hkU/ygNqOI/GSCA98x94YV6eKTcqyu
         s6ihqSNZDCqEWt0YIJBrUR3gnbRlFsVLSfEEXMrwEWl0DDBXqsqze6uPkr8hAF1gGPYo
         MXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UyyRc5JdnkROBEHu+xYdCyJ2Awi4tcsQvb7pPKheNS8=;
        fh=jJueK2DrDnK3tT4Rn5Mk5LFiZu2CReiReAL1bCN0A9c=;
        b=c4lWPENRIyUvFdifmFkHZQHcIibbGfaSHaRcgAug8fhaTXOb1M/zmQkrQlhcW8l711
         IW152GsTMmFnQ0EJ/822S0c9uKETRWxJNr3GoKdRHVLIVLFbdKGe4nMi8u51UavWkw7c
         YeNt4j279AqBbzgtNdM+ZEXTBL/Q1wx74/WyiuWMEinSEPIdUKqkjax98RtGreu3EV5z
         3kcqcrWIurWcc/XrQ5tXODnGi39F5mrvSWUhYWgGG8n+4W5vFJGpmJCRGiJFGSrqlN0O
         UyI+56JdkCg6qbwKUWyoPQ4AAlOIwh1X3y7i6X+LXmIqxjs4HEHQ+smRu/35sdEgqCq5
         oVkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769768940; x=1770373740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UyyRc5JdnkROBEHu+xYdCyJ2Awi4tcsQvb7pPKheNS8=;
        b=oln1L8NESX4rFb4aQJM6o8+hQcZgtNvlDrkk5mWrDRGAqBdlUxeNxMcw2eX8cve9/k
         /B/tgoSqfiLOIQ6n5A7FGYAnfj5EkEFL8G5PmeCNy5FvfcKTZeeYcb2oSeEK7SPS4D8e
         AveR4t8N/Rp88C06eoXuFV1HaAjukzyQGL78WB1q/NBX2S2iW4b37uTbndAiZcD8Y53S
         yszc4WtoiN/tvRc5QBRssoUdiZyxH0VsMZ2fxnhKCwbFVUuo7ahbde+gcZ+cU5/AhEdd
         giiAjMR47BZz/ObY0X3fCnsdeDveajpO1Ikp0KpWblJ/09ymDA34ELw6z8uXK7gTFL4x
         OZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769768940; x=1770373740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyyRc5JdnkROBEHu+xYdCyJ2Awi4tcsQvb7pPKheNS8=;
        b=nM2iSbgVIy+gdUtNhupY30Im/xQZhMNO0KiQE16JNckX9tyvo6sFh/3StYV62Er89t
         IuugetKwj9CbOatvgj6tkv2cD/v6/iwt94RAWazYfFkVa1bNRFxLqu/JHdMgg8CWclMv
         F1zD0Sgf4aLbmFHd7MLYP0k5ghO6o5hFmZrVa4SXma30NtpULSkomiwKCKGrKj2pFOdO
         oiGZU5vKaw5U7vsto+PLc5LfKC86ynW5530vHfb3hl3n13UJ+wkN3eej06Yod068f6i9
         ILsUU0gJcHFjy+8Z7rNXxIgymdMf0YCEMF86WBhKKvSFsKtVVFbp6Mo13McvTBudasFo
         BJbA==
X-Forwarded-Encrypted: i=1; AJvYcCU4iYldifI9owuRoONTVnr3x9I3lc0wPn+dzorKhgHXjbLwy3q6qr1KP4l65stJOvgux0fNAZ+0qHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZlPtYsPeE1k2PIVU+jN88nZv3rEWKT3fGL4dFP+Hy8sS1J9yF
	8IgHaMeplGpxvhbdrZ7EL8d7YXzl8n56ov1DEd6/mmS57royd5vcijKUe5YfoswGiDISsbhv4x/
	ylbMv9KDg8N5Gra0I7u4PmisGOWQfc1/emmznnGCVZg==
X-Gm-Gg: AZuq6aKhe7nM7KGkemmbmQR/PWRg/k1MIz1txbmFrk5ijy+i9MhoAw7PWACR0ITuXqI
	q+QxgSaZ0AK/kinWNoxRVZQEj8y/SkezhLeXllEogi0ucS3zFfCG+X0jzZ0wTPRkFo+MuNGHwse
	DgOaLKkx0oOUktN6etIhI1/nG2H1qZv+FfQN3l3f88RPBAqWN/g/czykUobEHLQw613HC7L2GA/
	u1rviSzpb2DHsiewj5ty/MBajAu6NOVw+ySPctxymeCiJ3e94usSjUXm+SpEYFZuF4zpjH2
X-Received: by 2002:a05:6512:3090:b0:59e:19f8:e7e5 with SMTP id
 2adb3069b0e04-59e19f8e879mr389940e87.10.1769768940222; Fri, 30 Jan 2026
 02:29:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
 <20260128-rz-sdio-mux-v7-2-92ebb6da0df8@solid-run.com> <CAPDyKFrBuL+747QUJJUejtcvjm0V7Lt=vHwjvcMdCt_h4=sFwg@mail.gmail.com>
 <CAMuHMdXgLR9yeLa5JKNdAOtNEirJ8263bmn1zRNAnKnmf8F-Sg@mail.gmail.com>
In-Reply-To: <CAMuHMdXgLR9yeLa5JKNdAOtNEirJ8263bmn1zRNAnKnmf8F-Sg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 30 Jan 2026 11:28:24 +0100
X-Gm-Features: AZwV_QjKt-7WVZ6iCRSlLFm6WIvZGroCu2x79LzMFz95tWuDMfGW172v0QkfhHE
Message-ID: <CAPDyKFrvSp6tmhP=2=9kca1d3+b6MezvxJWwMOW=Gv6D8TKrgA@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] mux: Add helper functions for getting optional and
 selected mux-state
To: Geert Uytterhoeven <geert@linux-m68k.org>
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

On Thu, 29 Jan 2026 at 18:46, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Thu, 29 Jan 2026 at 17:06, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Wed, 28 Jan 2026 at 15:46, Josua Mayer <josua@solid-run.com> wrote:
> > >
> > > In-tree phy-can-transceiver driver has already implemented a local
> > > version of devm_mux_state_get_optional.
> > >
> > > The omap-i2c driver gets and selects an optional mux in its probe
> > > function without using any helper.
> > >
> > > Add new helper functions covering both aforementioned use-cases:
> > >
> > > - mux_control_get_optional:
> > >   Get a mux-control if specified in dt, return NULL otherwise.
> > > - devm_mux_state_get_optional:
> > >   Get a mux-state if specified in dt, return NULL otherwise.
> > > - devm_mux_state_get_selected:
> > >   Get and select a mux-state specified in dt, return error otherwise.
> > > - devm_mux_state_get_optional_selected:
> > >   Get and select a mux-state if specified in dt, return error or NULL.
> > >
> > > Existing mux_get helper function is changed to take an extra argument
> > > indicating whether the mux is optional.
> > > In this case no error is printed, and NULL returned in case of ENOENT.
> > >
> > > Calling code is adapted to handle NULL return case, and to pass optional
> > > argument as required.
> > >
> > > To support automatic deselect for _selected helper, a new structure is
> > > created storing an exit pointer similar to clock core which is called on
> > > release.
> > >
> > > To facilitate code sharing between optional/mandatory/selected helpers,
> > > a new internal helper function is added to handle quiet (optional) and
> > > verbose (mandatory) errors, as well as storing the correct callback for
> > > devm release: __devm_mux_state_get
> > >
> > > Due to this structure devm_mux_state_get_*_selected can no longer print
> > > a useful error message when select fails. Instead callers should print
> > > errors where needed.
> > >
> > > Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
> > > property presence check") noted that "mux_get() always prints an error
> > > message in case of an error, including when the property is not present,
> > > confusing the user."
> > >
> > > The first error message covers the case that a mux name is not matched
> > > in dt. The second error message is based on of_parse_phandle_with_args
> > > return value.
> > >
> > > In optional case no error is printed and NULL is returned.
> > > This ensures that the new helper functions will not confuse the user
> > > either.
> > >
> > > With the addition of optional helper functions it became clear that
> > > drivers should compile and link even if CONFIG_MULTIPLEXER was not enabled.
> > > Add stubs for all symbols exported by mux core.
> > >
> > > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > > ---
> > >  drivers/mux/core.c           | 178 ++++++++++++++++++++++++++++++++++++-------
> > >  include/linux/mux/consumer.h | 108 +++++++++++++++++++++++++-
> > >  2 files changed, 253 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> > > index a3840fe0995f..b01ec126caaf 100644
> > > --- a/drivers/mux/core.c
> > > +++ b/drivers/mux/core.c
> >
> > [...]
> >
> > >  static void devm_mux_state_release(struct device *dev, void *res)
> > >  {
> > > -       struct mux_state *mstate = *(struct mux_state **)res;
> > > +       struct devm_mux_state_state *devm_state = res;
> > >
> > > -       mux_state_put(mstate);
> > > +       if (devm_state->exit)
> > > +               devm_state->exit(devm_state->mstate);
> > > +
> > > +       mux_state_put(devm_state->mstate);
> > >  }
> > >
> > >  /**
> > > - * devm_mux_state_get() - Get the mux-state for a device, with resource
> > > - *                       management.
> > > - * @dev: The device that needs a mux-control.
> > > - * @mux_name: The name identifying the mux-control.
> > > + * __devm_mux_state_get() - Get the optional mux-state for a device,
> > > + *                         with resource management.
> > > + * @dev: The device that needs a mux-state.
> > > + * @mux_name: The name identifying the mux-state.
> > > + * @optional: Whether to return NULL and silence errors when mux doesn't exist.
> > > + * @init: Optional function pointer for mux-state object initialisation.
> > > + * @exit: Optional function pointer for mux-state object cleanup on release.
> > >   *
> > >   * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
> > >   */
> > > -struct mux_state *devm_mux_state_get(struct device *dev,
> > > -                                    const char *mux_name)
> > > +static struct mux_state *__devm_mux_state_get(struct device *dev, const char *mux_name,
> > > +                                             bool optional,
> > > +                                             int (*init)(struct mux_state *mstate),
> > > +                                             int (*exit)(struct mux_state *mstate))
> > >  {
> > > -       struct mux_state **ptr, *mstate;
> > > +       struct devm_mux_state_state *devm_state;
> > > +       struct mux_state *mstate;
> > > +       int ret;
> > >
> > > -       ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
> > > -       if (!ptr)
> > > +       devm_state = devres_alloc(devm_mux_state_release, sizeof(*devm_state), GFP_KERNEL);
> > > +       if (!devm_state)
> > >                 return ERR_PTR(-ENOMEM);
> > >
> > > -       mstate = mux_state_get(dev, mux_name);
> > > -       if (IS_ERR(mstate)) {
> > > -               devres_free(ptr);
> > > -               return mstate;
> > > +       mstate = mux_state_get(dev, mux_name, optional);
> > > +       if (IS_ERR_OR_NULL(mstate)) {
> > > +               ret = PTR_ERR(mstate);
> >
> > Should this be PTR_ERR_OR_ZERO?
>
> "mux_state_get() never returns NULL"
> https://lore.kernel.org/202601221036.J0kR78Uw-lkp@intel.com

By looking at the code in mux_state_get() and mux_get() that $subject
patch changes, it intends to add a "bool optional" as in-parameter. If
it's set, it looks like the intent is to allow returning NULL, which
makes sense to me.

Anyway, there seems to be some additional smatch warnings to fix
before this is ready to go.

[...]

Kind regards
Uffe
