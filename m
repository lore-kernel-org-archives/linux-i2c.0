Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3CA42EEA7
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746986; cv=none; b=Y2xWJDGfDXmPqeyBlQw1osUgZJRqrmsTohZyPuzrCCVGn61PHbmF1NI05JRHStO9UMXjUsPi6ZGyjgrOmL8aigV5VDFErFZ/dtvAc5N3nMc4Jr8JUEffr5NPlHjNaBtoqAWWccedI5Od8nunR4kr9ER7qrPbGDKxFOXGAxBOO4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746986; c=relaxed/simple;
	bh=BODU8nH72xA0ScZ+HzwpHMr8UOUoOL0Z1xiarATGzqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dy8C6ixE7DG9Jt1XBu+bNp5PArNll4FFRvqPwRAjOBfF5GlvCkfoesZC/HnEp9lHcn10+RcvMSrPp+4YR51ce1eBCSYG47Wy+UFQZjf9KBUT/3oJ/M7mpH+Xx90log18BMQji75vdBakWglFA/XboekDpPn2N6LM93wmlP4BFq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c12758e75afso109655766b.1
        for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 08:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782746980; x=1783351780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PSkrSvBcOj2Vfr1tOG9HdESUGrp+uU5X3MHl1xNqsM=;
        b=SZKyHM+Yb4w/VB/+bEc/uvV8lODDgaFLJO4CJ8TKDOHW7WH1ee7fTdJdUw/qLSJWvY
         hzNICnOMZMAGIpl1n55uQFx9w0u47E2qtPobeu2Iogae5DxoyclyhxQw0PQYMnS4IQ3C
         qroKyVKbelg95jIKIDLFGtVFoJZnL9pVBRrpaxYiY4ZqTqNJIgvLTKFskEA28HMnDSo5
         SiFRb5qlg+DEnqXTJS9GlxD4HJgOcKzaYJoRwuQRRRszKnMhMPQI0r8rEFacGat2pPdt
         yWJTrmArmdG8NaxdanaQeag7wVpMbgS2AuJCS+A9RybgPMH8qLghTw1oBXccxnVMmzRi
         UnHw==
X-Forwarded-Encrypted: i=1; AHgh+Rp9fqrSydKEwNt+puLxgqRuwfUzbnUlr9HkR6vn2xKvh7W2639fIHgf3L6/RmXpYVfw/zHP0DMNjk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygHP4zsrgfQAyvS1ABE9ysLfIdA3FXUAWRKfCnDp3ZFwnWFNZ4
	AgPtD26ObBo2nrZbv0Ebs5gZU4taq0h2NFQaQ2+QRKmZgcJ+JzgYVOm24dn0/0vGr84=
X-Gm-Gg: AfdE7cn4qHNn9k2AQdu4bskVq3TvkdzzNkzlxKimB/nJNg4S/PiEVSPyhpC5b0IUvKY
	YtYP3qOzRrJFUsNLvH23w9zhhLrIWae74VpE5CjRG27pQvMSrm8inOwMfo/8f61pVuH9oK+iQR3
	ymW4Cn1BE/L41hqdkYUgZkSP0p+KFbkmLfJ2501ypmQ5vJ8zp6vWaXB3jL8tq2Pv6GOMTrBCBe2
	WfzIMVc2NnpODIwQ93awAt5Xcmfj6KHfmq4YQHQmUuV7cTLpcRVQHnMfl79aosOTJof2mwQC1Mq
	gnVvGZeT2m+d6gbzNEqj3pOpSLYseig48zTxy5xQaurU51QRp86wmjoCHr8V69Gk7AL8L/eWjdH
	rFrPXFf2ETON1ZZsPNdBectqlZ7RXqOHzQURblhX0lV89fZt0X0M/8nT89cUFQBHKolil7fUwQR
	kO4d2ocrv0pn8EKchY1mhMNoZ8mIhcFqK3uuzjuJX1BDAY/4i+GQ==
X-Received: by 2002:a17:907:806:b0:c08:695:8819 with SMTP id a640c23a62f3a-c1205b33896mr975270666b.0.1782746980354;
        Mon, 29 Jun 2026 08:29:40 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12823fd38asm45214866b.50.2026.06.29.08.29.38
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 08:29:38 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69857dc1d5eso2726923a12.3
        for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 08:29:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro1gXn8tXQBJtz6Npeh0uxAL2udUJUPMFsoP655mXIYULL0a+vUPupeMOedhRMoaY5jmlci2/K1gf4=@vger.kernel.org
X-Received: by 2002:a17:907:3c8b:b0:c12:f84:85d4 with SMTP id
 a640c23a62f3a-c120f8487bamr796791266b.24.1782746977928; Mon, 29 Jun 2026
 08:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629135917.1308621-1-arnd@kernel.org>
In-Reply-To: <20260629135917.1308621-1-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jun 2026 17:29:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
X-Gm-Features: AVVi8CfSSg4DcoB7CGCYddSfqoWpUaOwYUjpkorP-3LR7U8E7vJ9ucbePhiZLD8
Message-ID: <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Marcel Holtmann <marcel@holtmann.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Andy Shevchenko <andy@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Mon, 29 Jun 2026 at 15:59, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Most remaining users of desc_to_gpio() only call it for printing debug
> information.
>
> Replace this with a new gpiod_name() helper that returns the
> gpio_desc->name string after checking the gpio_desc pointer.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> Not sure if this the way we want to take this, or if the gpio name is
> an appropriate replacement in debug printk.
>
> Since most of the callers of desc_to_gpio() and gpio_to_desc() are
> otherwise in drivers that already depend on CONFIG_GPIOLIB_LEGACY and
> include linux/gpio/legacy.h, only a handful of instances remain that
> are otherwise in files that otherwise only use the descriptor interfaces:

> --- a/drivers/gpio/gpio-aggregator.c
> +++ b/drivers/gpio/gpio-aggregator.c
> @@ -758,8 +758,8 @@ int gpiochip_fwd_desc_add(struct gpiochip_fwd *fwd, struct gpio_desc *desc,
>
>         fwd->descs[offset] = desc;
>
> -       dev_dbg(chip->parent, "%u => gpio %d irq %d\n", offset,
> -               desc_to_gpio(desc), gpiod_to_irq(desc));
> +       dev_dbg(chip->parent, "%u => gpio %s irq %d\n", offset,
> +               gpiod_name(desc), gpiod_to_irq(desc));
>
>         return 0;
>  }

Before, this printed:

    gpio-aggregator gpio-aggregator.1: 0 => gpio 589 irq 188
    gpio-aggregator gpio-aggregator.1: 1 => gpio 590 irq 189

After, this prints:

    gpio-aggregator gpio-aggregator.1: 0 => gpio (null) irq 188
    gpio-aggregator gpio-aggregator.1: 1 => gpio (null) irq 189

Same results for instantiation using sysfs or configfs[1], although
the latter does have optional support for specifying the name.

[1] Documentation/admin-guide/gpio/gpio-aggregator.rst

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
