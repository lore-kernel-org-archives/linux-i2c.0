Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8AF36F8E8
	for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835291; cv=none; b=WAPBA+kSRMHd8UTMGO3k3NWNJ/EEenjO0oZlwUXpOG88vXIXuGqei/HkVEh23KFgI4fmvp1/T71aPNSrDReWu6Hd3nKKqHrEaN7eMHUv7+5R+BwsYVJ/az9o3WPeh9fDDLTsIQKmnGiiShJw8yTtKS3I56MJIFNUbGezCkDQGFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835291; c=relaxed/simple;
	bh=y9uuZkEeJae++MbeR+TNLsbet2X1rPdv40pKLNu47dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8QysPvsqmTaDsQvxwv/n33n5ny5/ypU6MWLqTdsYOxSWBOYmhjSCXKQkO7k98iVq6HQKKjyRsAB2XOkjUe+G9r++jy8r/IX/SUqCIU2ER5i4X9jcpqPj098ONdHPoykkwDeqUdJPJDZN5T6nOvTejgkIsXmloGswWdHYvpBHnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bdd0779366so37879e0c.1
        for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 09:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835285; x=1783440085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqnNDF5VKQ+E0vRBcJ/LtO+JWbWwBxQUs2IGvWvjH/Q=;
        b=BrPqGiTjQ42MMMZPFxnsrgIBHyfeJq7g84MtFY5JJPnTSpLr5/kRaTteuX0mGnJIHh
         3JiRbfO3o9dxahwvgwCx78JWp2quq/eGzh3gZpmQFAUNq82IaEKSnk5YnzIylgORUV9y
         Jy5868kd12atZoFlqhnxOQRXQ9z/Wd5vcYM3RHEmJzwAZt/asgUL3C/QSmj2cSWILlEq
         7umBrHERvTqBqPkBqWfwJ6cgX84+MChvTJGJnPJ70oS7XxTmWEo5IA1aSvccNZvxA9XR
         BpypeFCc2P9VvMB0mkFvqrYUcIyhzwFw+WZ5O8imK20c+hkRTy6EBVzWYXcJlyX66qZb
         hy9g==
X-Forwarded-Encrypted: i=1; AHgh+RqQ4hzDsh3kMzVoJX3Kho0UpLDqGfqwHNamIyhl5ArLBOJ79+f90LyOSsnUcZXxfBZIxHah5WhTOAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRGTUyBb+kdcEqjJMBjcHmIiJHMC7W+Fc7Entq12ijigvEWorf
	76J3I3W+4PtkuQvaKhKUUm4X3JE0UjwgLdaAv6utpDEDSOsZec84/v+rF40PKC0rVN4=
X-Gm-Gg: AfdE7cmnFdSEkRdVmTnXb9HZo9Wl4RJP2cS4cTAgaUX2+jE7+qUzK1Yr4+MtH0n+VG5
	IPixEcQBKXDCageDvGX/9fKD7s0ZQwwCEJnnHtfGFfcnO3F5aJW2mKGz6b36hZDXAC9bjGBQK0M
	3U2kX2QKhe2bqiSmyK4TH/vij2lczvgNpfLjN4yr3JYrFYYhd9RnOLh+NoFe9hGdfI6OYM/aPIY
	1Tzo252G94UWameTWPAU9gkW3ObPbFLf5AhO1BeQFWZkSWnRUMgm2f+2EEFB01ZYo1eJZAOYNOq
	TGTVt+Zod5tkup4qD0pMnQeZ5rF1jQTS8rcjTe93ek6KPAvj2PFpVNWhl0WZBZEVtz8SosfNqF1
	crsQFUguZkiz/2IRkHiUnR/whamCOh0vpUzeRS+QH92B+QG+UU4dV+zWNVPW+KjTxizP+T4Oto9
	SRoFyVdPfM1pCGsD7JkaTyGNq7TNB4FHAUHuc7ob9VrqUDfCGsWA==
X-Received: by 2002:a05:6122:50a:b0:5bd:b2e1:e1f5 with SMTP id 71dfb90a1353d-5bdbec5fc02mr1783356e0c.2.1782835282552;
        Tue, 30 Jun 2026 09:01:22 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bdc189bfc0sm1629595e0c.7.2026.06.30.09.01.20
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 09:01:20 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9696369925aso444116241.0
        for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 09:01:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpnbS0RLx44tZu0wbECe5Kr0ZT/IercN+Um0E1GB88P0ENgwJBpPw4HzL7CZiH4Pdyb75LRH9NIQds=@vger.kernel.org
X-Received: by 2002:a05:6102:598c:b0:738:9dd5:9b03 with SMTP id
 ada2fe7eead31-73a38838db6mr1792608137.20.1782835280090; Tue, 30 Jun 2026
 09:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629135917.1308621-1-arnd@kernel.org> <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
 <ff4d7043-1929-4fa1-ba5e-f28403ad6fcc@app.fastmail.com>
In-Reply-To: <ff4d7043-1929-4fa1-ba5e-f28403ad6fcc@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jun 2026 18:01:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWhv8i6tkmOJU_ee9LAV7mMcQHe9FXgqTHCjGiEMWvn8Q@mail.gmail.com>
X-Gm-Features: AVVi8Cc-rLKbwzFvmIKs2_rpHMNLxVULzvudUQINxHMw-KOr8IArAqRSnLCM1D8
Message-ID: <CAMuHMdWhv8i6tkmOJU_ee9LAV7mMcQHe9FXgqTHCjGiEMWvn8Q@mail.gmail.com>
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Andy Shevchenko <andy@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Mon, 29 Jun 2026 at 19:54, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jun 29, 2026, at 17:29, Geert Uytterhoeven wrote:
> > On Mon, 29 Jun 2026 at 15:59, Arnd Bergmann <arnd@kernel.org> wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Most remaining users of desc_to_gpio() only call it for printing debug
> >> information.
> >>
> >> Replace this with a new gpiod_name() helper that returns the
> >> gpio_desc->name string after checking the gpio_desc pointer.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

> >> --- a/drivers/gpio/gpio-aggregator.c
> >> +++ b/drivers/gpio/gpio-aggregator.c
> >> @@ -758,8 +758,8 @@ int gpiochip_fwd_desc_add(struct gpiochip_fwd *fwd, struct gpio_desc *desc,
> >>
> >>         fwd->descs[offset] = desc;
> >>
> >> -       dev_dbg(chip->parent, "%u => gpio %d irq %d\n", offset,
> >> -               desc_to_gpio(desc), gpiod_to_irq(desc));
> >> +       dev_dbg(chip->parent, "%u => gpio %s irq %d\n", offset,
> >> +               gpiod_name(desc), gpiod_to_irq(desc));
> >>
> >>         return 0;
> >>  }
> >
> > Before, this printed:
> >
> >     gpio-aggregator gpio-aggregator.1: 0 => gpio 589 irq 188
> >     gpio-aggregator gpio-aggregator.1: 1 => gpio 590 irq 189
> >
> > After, this prints:
> >
> >     gpio-aggregator gpio-aggregator.1: 0 => gpio (null) irq 188
> >     gpio-aggregator gpio-aggregator.1: 1 => gpio (null) irq 189
> >
> > Same results for instantiation using sysfs or configfs[1], although
> > the latter does have optional support for specifying the name.
>
> I wonder how many of the other instances have the same problem
> then. Would it be appropriate for gpiochip_fwd_desc_add() to set
> a name itself to address this one?

I don't think it would be appropriate for the GPIO aggregator to set
that name.  What we want to print here (for debugging) is the physical
GPIO that an aggregator's GPIO is mapped to, not some consumer or line
name (which is not guaranteed to be unique).
E.g. "<chip-name>.<offset>" would be fine.  As gpiod_name() can only
return a fixed string or an existing string, it can't return such a
formatted string, though. And consumers don't have access to chip info?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
