Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0057D427F93
	for <linux-i2c@vger.kernel.org>; Thu,  6 Aug 2026 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007387; cv=none; b=BbIMIEb6eRf2dZR0IJ7poRC3uJ4mo8GO+awgAGeq0WgccpWD2YiHUtPkkCsd/TkWeziekO60LBodkGkswunmv8PvfHNW0UObeHxSItgfhvyr1HUgaTtqU+tjD317Su/6ErXcREAUtbCj8Yt+HsTiu9xh+1Ua8MAHbqR7NSdW2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007387; c=relaxed/simple;
	bh=yRsqTV1QL2Bf6HopHK3fdF0m7nRaOON7jOnBK7A+mx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gza4eyZSXny38x5QO8Kpyk2611pFKSLpGWrz4yehv0Oq05mfLXS7YbNKetZ3ocwYNAq6reF8DnjPxXnaoK/kfXOhPJQLw+/GVgznwMYJ0tLf64F1RqsRMEX3DTQaQbOoiTj7Bx4qfvvzJYHeF6GmcldSs86lSH0UjjMeX34AWkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5bf9466867cso563258e0c.2
        for <linux-i2c@vger.kernel.org>; Thu, 06 Aug 2026 02:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786007384; x=1786612184;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2FUetJXqO1p3tmVv7CkN5c0Zpu+ozO7iF0g+MEobkvw=;
        b=CrcgbE54iGpDdyQ8DB3tDy/9JqQ9XAKBpfxkupC0FRoBGpdjC76NPhnXibWIVYdE3t
         mZrrSaVnKW+UQAZqHfI9EhlUDQdRDoaGJ0ugXsTWCSON4MBJsPtLJH3z/YYrWkPGyih3
         9MR2dehwfDv2d5/mHU/MS7SY9pCTkTBOyElJGfOUxJj1AlaKiIq79Bq7kNj46VwWiJMS
         dX1/P1zN9tVHhiyqD6ERXB0ZtxkzySroImrm7brIiUlTowvKpAXSTnybmWfVCCVBfSJd
         LGHHVNhH8z2T+WwrmGotzUPAJBXt08Sg+62EJ50TL+hOpeudsBhIxKtcv4jmIJHeOM7l
         Bx9A==
X-Forwarded-Encrypted: i=1; AHgh+RqdUiBgAwVgQA7Q/vEB13EPCwYpdkA3SeUcIyhfOLhO35X6vO2Df+IdWjMxBJEzs4Tazu07g2vKmkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziGokw0Xbaqt21xREhv3e74wJbhA2LN5Ovw+EeQXMekTrA/gJu
	8QCYXVozjUffjrXQw66ftxbDXUlqfQp3sxyAPAP8OqVNWq+iAqMwwfGxQwZnrH3v
X-Gm-Gg: AR+sD11BW67J3glRjWw0lKV8u6sbabKIHo8LIX4ENBaDQVSkzEn+UK8mCWIae4vZy9s
	9wKK1aGiaDB8i5s+kR9jA3eYNUTyJX6QeLgiA0oVZGBxpUUUQStJNICBYdtLdPbQWkrvC+zFtgZ
	9VbcSwt9YUAl4oOYny6KkRSqGElxPNNJfQRkbA4t+ZPBVrSTXxyMCiZk/VjtwefHT13rWT1blRJ
	LDVBmax+iatVfCyg4rvnlfuq13kIoCS3L9SeOviOtIllN1Lnm4WMJby5W3RBskbKsTeNaOPV/BJ
	zA5VWwyDT2wtdBa+P2F/qGLMinv4otTuSzrA931wqvGbPp31XnPpKmaA4Ghi6YG2AFAHhn9Klqu
	KR0WAHSLFR5EAI/MZZ/lfOc0h+WtfLIWt1/OJik6qPuxzS97Z/UgtbwPfHa00oSJJ55Hk3kE3kn
	wdu5TMgIl7v7+XEI/BLOxZAmGFByhrnjA7SQahzPIwF+y2oHVBSzwpa3mre2Zlp/NlWMk6Ec1/N
	cPkYMfp67baMenDb6YOENLIdH0=
X-Received: by 2002:a05:6122:3390:b0:56d:b639:5c0d with SMTP id 71dfb90a1353d-5c3d93aaff5mr1688385e0c.13.1786007384467;
        Thu, 06 Aug 2026 02:09:44 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d0916f25sm2787325e0c.16.2026.08.06.02.09.43
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 02:09:43 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9667ea2fc22so527909241.2
        for <linux-i2c@vger.kernel.org>; Thu, 06 Aug 2026 02:09:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrBsFYqGa0fdqyvhgLaOvPEBZ3OFhqJVcgt4raxMuMm9T6POgWyu0DeDBsXiPGJ5dHD/4o2gJreRsI=@vger.kernel.org
X-Received: by 2002:a05:6102:3e8d:b0:737:783d:1916 with SMTP id
 ada2fe7eead31-760ec96060fmr3082364137.11.1786007383268; Thu, 06 Aug 2026
 02:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727122546.4232-4-wsa+renesas@sang-engineering.com>
 <20260727122546.4232-6-wsa+renesas@sang-engineering.com> <CAMuHMdVAgjguscFMKd7u1XPuZEkB7mH9-G-Y8nYfXqbzJ2hH9Q@mail.gmail.com>
 <80a94424da18d5003265c5e8bf5ecb5a90499b59.camel@pengutronix.de>
In-Reply-To: <80a94424da18d5003265c5e8bf5ecb5a90499b59.camel@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Aug 2026 11:09:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWVtfizYD4vKzsQrVpzr4ekmFQRtDZ4QpOhVHMh6K7JjQ@mail.gmail.com>
X-Gm-Features: AUfX_mx9R642ojyV8nVvuxrlu7BuXMyh8-3ZSJ2-Ejt5syD2K45GL-3-zFxCdxM
Message-ID: <CAMuHMdWVtfizYD4vKzsQrVpzr4ekmFQRtDZ4QpOhVHMh6K7JjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] i2c: rcar: add R-Car Gen5 support
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, 
	Andi Shyti <andi.shyti@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Philipp,

On Thu, 6 Aug 2026 at 10:18, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Mo, 2026-08-03 at 15:14 +0200, Geert Uytterhoeven wrote:
> > On Mon, 27 Jul 2026 at 14:26, Wolfram Sang
> > <wsa+renesas@sang-engineering.com> wrote:
> > > To support the next generation of R-Car SoCs, we need to skip polling
> > > the reset status. SCMI doesn't support it and the firmware must take
> > > care of this anyhow. Other than that, the driver works fine as-is.
> > >
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > Thanks for your patch, which is now commit 87e713f200481106 ("i2c:
> > rcar: add R-Car Gen5 support") in i2c/i2c/i2c-next.
> >
> > > --- a/drivers/i2c/busses/i2c-rcar.c
> > > +++ b/drivers/i2c/busses/i2c-rcar.c
> >
> > > @@ -900,8 +901,12 @@ static int rcar_i2c_do_reset(struct rcar_i2c_priv *priv)
> > >         if (ret)
> > >                 return ret;
> > >
> > > -       return read_poll_timeout_atomic(reset_control_status, ret, ret == 0, 1,
> > > -                                       100, false, priv->rstc);
> > > +       /* SCMI based resets don't need to poll for success */
> > > +       if (priv->devtype < I2C_RCAR_GEN5)
> > > +               return read_poll_timeout_atomic(reset_control_status, ret, ret == 0,
> > > +                                               1, 100, false, priv->rstc);
> >
> > How to differentiate between using SCMI and running on bare metal?
> > The latter still needs polling.
> >
> > I think you should call reset_control_status() first, and check for
> > -ENOTSUPP, which would indicate that reset status is not available.
>
> Ah, I suppose this driver is what you need .reset and .status for in
> the R-Car X5H MDLC driver?
>
> Seeing this, I wonder: could the status poll be moved into the reset
> controller driver(s)? That would leave this driver with a simple,
> unconditional reset_control_reset().

This could indeed be moved into the reset driver. However, that
means the reset driver needs to become aware of the peculiarities
of the various target devices on the various SoCs.  We already have
something similar for module stop delays on RZ/V2H, though.
And it means more dependencies to track when adding driver support.

Then there's still the user in the PCIe driver[2], which can't be
handled like that.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/commit/?h=renesas-clk-for-v7.3-tag1&id=0a6643b1a5ee72f76ed0c606c1b34c7cf632cbfb
[2] https://elixir.bootlin.com/linux/v7.1.5/source/drivers/pci/controller/dwc/pcie-rcar-gen4.c#L185

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
