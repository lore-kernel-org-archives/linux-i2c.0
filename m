Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB03328E0
	for <linux-i2c@vger.kernel.org>; Thu, 29 Jan 2026 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769702811; cv=pass; b=OckMxXrKMn/jCozaxnQ+uPp0DnSp5Fq4hfHCR7IEh2PgiLJZIMEYtaHyDvZDW6t3MQKeuP7PWxuYMO+q/D+eDbCldSWe/2NV6eCt5dfEY8DHWKsIkMaBg/Nl+tSU847FH3SY8J28OIOG1q1GA6Tesy7BfWTIUT/2nWveFlsgz3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769702811; c=relaxed/simple;
	bh=07694nkibp+Ukt/3oCjWp5i0EIYQ4hrhXlidSnaNpN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4E+iRifq35fcuJQwlCB34h4myA3TiCAi4tq/Iw1aSfmw2qkoYGNuuEGKeM+NN4Udp0O+2D6nvsKiWdoS43ZRIyMhocrVb4kffCfFDwV97XDDXdkqfwQa6/C9SLrvCHeAIc64l+LZ8NR0nkxGc2UHfy+HeEnGc3d7x8Z7zM8smE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DXCleRDE; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXCleRDE"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-385c2f88618so10141581fa.2
        for <linux-i2c@vger.kernel.org>; Thu, 29 Jan 2026 08:06:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769702807; cv=none;
        d=google.com; s=arc-20240605;
        b=R+K6EGU9ZCZnKmNzXaFFwjwjTz4yFcgF2w3wLG8VeoxaRP++gDl+DvySRfIOU+PJEf
         qI4oiwERDoXXb2XwxLdjB6lc4MURfj3NKydnGdqbgkmC4hrrYbwFSB0H6zLHkXqooJpV
         TXYKNJh0/ww13MOjAZLRDtga3bCj08emUdkIwdKvOPdZi0V26PAEicxLREVl27J/pgEO
         aa1UA7JLvJpQIpynroqSHSzfQolUthg0WiFyxOLsynIobwGHtXKN8048CanmUdWPJfAk
         Ao4DZ7ngsc2r3X2Apgx5qKApQQMm9L/xMymrJGcmNOIGijWGik53HnvppbKfF8SX7ynz
         dH+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sjBE9CcEx3FGX02UcUqw+G+HOHlTgyZhIWMhdAQnoXg=;
        fh=3mSxqRKtytwHpFV9o+JYFkyQGht6d5mSQoglH57lAMw=;
        b=HilA8hz2o4uRqwwbNRcFqfnOoprG5SIm4zCWJNKlifArKMZG7moLZoYeHXaG+Rm/c5
         ocpxTkXssZf3m4Ehg/YbYw7VYpYQjDYFsKVjWEwNsgDczZlYd4o+puyWrjVRzYUt4i2y
         mPeV2gzU1J+MZyOuCRyNoQmirYDfCa0pzLU0zaSncOGU/ILIgW6XzmK7fiGc2OgZuPsl
         4Jo7/9ySjV05OCtiB0b86/shBoD/icIK7yoKMymG3FGKojWk6fqjenxBR4X7JPj0he99
         /4Wa6Rn1hOkq740elunfrik6Rct8LH0Qj8NtMksyoUC0n0rdisX6ZBqgtJSWykAip/02
         ZxXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769702807; x=1770307607; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sjBE9CcEx3FGX02UcUqw+G+HOHlTgyZhIWMhdAQnoXg=;
        b=DXCleRDExChl/h8Dg365AhW/r2JRAOHymIXupLWJFbwgmikGA4eODDcSKgC+rsAUw8
         Gbtqv3xam1Iq2YgyRShLO6ZY+gE7W1cb5FSqCtwdFbAFpfZ20B5S5hBZ0c5QfL/Y3kp3
         0fkeMTyY4dpHbo68v70VVRELvZymtLFJBdr7P83S9290IfRJ6mvImZdqKzYo+DOYNRmM
         GRRF70fAKQBP5txyVS77t55eFa3cu8f7N8k6hKVThxV31rX3xacnejRqFHLA+NyG464d
         jCbjC3xPS0kQM2aoDQNfidex/DN41SePdLmegi0BMnL9PuGWZirC8TW/c64TVnhi0LnV
         9fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769702807; x=1770307607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjBE9CcEx3FGX02UcUqw+G+HOHlTgyZhIWMhdAQnoXg=;
        b=nX5YCA0V23Qi3NguARY/7hRo3JebSm9o0ArD1+7tpUnZavalO+BUcCl0uRvkcW5cNo
         TsgLLRO3TVw/MCbAMaS2DX/PaIRl+6Q4u+rtTPFC1134T2kLtWh/c67XPzVQJk3q7SbI
         gKFDNFjkCUQQ/o7BBUSuYvMM5+ySi3DOwRyRS1H8GwFnFzsjJSwTn8PqVkSDm9DUiqKW
         q618c1j8+XdfsdDOi69G7+IjHysEtHLsxl1EGKOuElfMhDVxCYWHYXBoFGaSwFLK+6Yq
         dl+mK+0+52MzumTjN3HdHkeLrWsumEEMa3DDNadYyH5H+k45KkrnsLplDlH+JKpIAgtL
         veIg==
X-Forwarded-Encrypted: i=1; AJvYcCXimyRZe34woG2+fBPYalh7jckvx2+r26hN8lQbg+r1AALtP7nfE3MEMjZy8SOLRP/x9ZPIbqeM5fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpCc/HZ+90fw+Chfyg/XK4XDvSw0Gz4yA4llQUA37UJUmYKzO1
	KUCTEh/gaQN2Ehi5RqvPu2Tr1CQY0dmiy2JlmVPdTA0BRSDo0ppBiUN+6C6KooNA4QwMp3vdD8W
	cZb/A2LAqVenjTnd4E+sDRUAsHWvge5L86B0a2Z3Xpw==
X-Gm-Gg: AZuq6aLtWTkMjmaTIS1jMDCfk7GdutPJiia6IJNdb+Rjz1LYVRVQx7f/lmzgNIrVuHS
	2UkWmyyWIE9qW5ckpfk7f7HwuOY+vcbfTn9LhN3Eup4C0qE8uEF6lZK/KqEK4w0JWYp7x9ALfVL
	1ZrQZoXxuwX7YyfFWU3Uhyohql7U8KXpTIxRCQd9sMQL9lbePYm+wxDRb8beTAfccAg12JYc/Kb
	eKvE/lY3xwE8vuc7NLSSRpCRlxDc/Nq02FjweWR36hkk+V5XkggOonhfp6PDLf7P49G2GGX
X-Received: by 2002:a05:6512:234e:b0:59d:d799:b7a0 with SMTP id
 2adb3069b0e04-59e040299admr4006653e87.36.1769702806877; Thu, 29 Jan 2026
 08:06:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com> <20260128-rz-sdio-mux-v7-2-92ebb6da0df8@solid-run.com>
In-Reply-To: <20260128-rz-sdio-mux-v7-2-92ebb6da0df8@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 29 Jan 2026 17:06:10 +0100
X-Gm-Features: AZwV_QhXWgEPoSG5cEeDEK7X9sYP3SyTXeMqEgA9rOrQCY9Is43DwQw7rMGTcAc
Message-ID: <CAPDyKFrBuL+747QUJJUejtcvjm0V7Lt=vHwjvcMdCt_h4=sFwg@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] mux: Add helper functions for getting optional and
 selected mux-state
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
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Jan 2026 at 15:46, Josua Mayer <josua@solid-run.com> wrote:
>
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
> ---
>  drivers/mux/core.c           | 178 ++++++++++++++++++++++++++++++++++++-------
>  include/linux/mux/consumer.h | 108 +++++++++++++++++++++++++-
>  2 files changed, 253 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> index a3840fe0995f..b01ec126caaf 100644
> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c

[...]

>  static void devm_mux_state_release(struct device *dev, void *res)
>  {
> -       struct mux_state *mstate = *(struct mux_state **)res;
> +       struct devm_mux_state_state *devm_state = res;
>
> -       mux_state_put(mstate);
> +       if (devm_state->exit)
> +               devm_state->exit(devm_state->mstate);
> +
> +       mux_state_put(devm_state->mstate);
>  }
>
>  /**
> - * devm_mux_state_get() - Get the mux-state for a device, with resource
> - *                       management.
> - * @dev: The device that needs a mux-control.
> - * @mux_name: The name identifying the mux-control.
> + * __devm_mux_state_get() - Get the optional mux-state for a device,
> + *                         with resource management.
> + * @dev: The device that needs a mux-state.
> + * @mux_name: The name identifying the mux-state.
> + * @optional: Whether to return NULL and silence errors when mux doesn't exist.
> + * @init: Optional function pointer for mux-state object initialisation.
> + * @exit: Optional function pointer for mux-state object cleanup on release.
>   *
>   * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
>   */
> -struct mux_state *devm_mux_state_get(struct device *dev,
> -                                    const char *mux_name)
> +static struct mux_state *__devm_mux_state_get(struct device *dev, const char *mux_name,
> +                                             bool optional,
> +                                             int (*init)(struct mux_state *mstate),
> +                                             int (*exit)(struct mux_state *mstate))
>  {
> -       struct mux_state **ptr, *mstate;
> +       struct devm_mux_state_state *devm_state;
> +       struct mux_state *mstate;
> +       int ret;
>
> -       ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
> -       if (!ptr)
> +       devm_state = devres_alloc(devm_mux_state_release, sizeof(*devm_state), GFP_KERNEL);
> +       if (!devm_state)
>                 return ERR_PTR(-ENOMEM);
>
> -       mstate = mux_state_get(dev, mux_name);
> -       if (IS_ERR(mstate)) {
> -               devres_free(ptr);
> -               return mstate;
> +       mstate = mux_state_get(dev, mux_name, optional);
> +       if (IS_ERR_OR_NULL(mstate)) {
> +               ret = PTR_ERR(mstate);

Should this be PTR_ERR_OR_ZERO?

> +               goto err_mux_state_get;
>         }
>
> -       *ptr = mstate;
> -       devres_add(dev, ptr);
> +       if (init) {
> +               ret = init(mstate);
> +               if (ret)
> +                       goto err_mux_state_init;
> +       }
> +
> +       devm_state->mstate = mstate;
> +       devm_state->exit = exit;
> +       devres_add(dev, devm_state);
>
>         return mstate;
> +
> +err_mux_state_init:
> +       mux_state_put(mstate);
> +err_mux_state_get:
> +       devres_free(devm_state);
> +       return ERR_PTR(ret);

If PTR_ERR_OR_ZERO is used above as I suggested, ret may be 0 here.

Then it is probably clearer to add a check if (!ret) and return NULL
explicitly for that case, I think.

[...]

Kind regards
Uffe
