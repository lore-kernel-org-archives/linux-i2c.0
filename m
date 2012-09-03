From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: nomadik: Add Device Tree support to the Nomadik
 I2C driver
Date: Mon, 3 Sep 2012 13:07:24 +0200
Message-ID: <CACRpkdb8owKBxawAv4LVVYx5kUgZ9cUSiQ=BV0f3Pf3bHtknuQ@mail.gmail.com>
References: <1345734087-21803-1-git-send-email-lee.jones@linaro.org>
	<1345734087-21803-3-git-send-email-lee.jones@linaro.org>
	<20120831112258.GA2624@pengutronix.de>
	<20120831122323.GC5962@gmail.com>
	<CACRpkdZ=C1EV4WO2b=1YLHPNhsDsQdq7Kfnpzm8i7uGRtVjJuQ@mail.gmail.com>
	<20120903094448.GB11780@pengutronix.de>
	<20120903100656.GC5782@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120903100656.GC5782-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 3, 2012 at 12:07 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

(...)
> +       if (np) {
> +               if (!pdata) {
> +                       pdata = devm_kzalloc(&adev->dev, sizeof(*pdata), GFP_KERNEL);
> +                       if (!pdata) {
> +                               ret = -ENOMEM;
> +                               goto err_no_mem;
> +                       }
> +               }
> +               /* Provide the default configuration as a base. */
> +               memcpy(pdata, &u8500_i2c, sizeof(struct nmk_i2c_controller));

Here you blank out any pdata passed from say a board file or
whatever if pdata != NULL.

> +
> +               nmk_i2c_of_probe(np, pdata);
> +       }
> +
>         if (!pdata)
>                 /* No i2c configuration found, using the default. */
>                 pdata = &u8500_i2c;

So this is still wrong, if pdata is passed to the driver it will
not override the DT, you have the semantics the other way
around, DT overrides pdata.

Look at the switch statement in my previous comment,
just add the allocations and a memcpy() and it still holds:

if (!pdata) {
    if (np) {
              pdata = devm_kzalloc(&adev->dev, sizeof(*pdata), GFP_KERNEL);
                      if (!pdata) {
                              ret = -ENOMEM;
                              goto err_no_mem;
                      }
              }
              /* Provide the default configuration as a base. */
              memcpy(pdata, &u8500_i2c, sizeof(struct nmk_i2c_controller));
              nmk_i2c_of_probe(np, pdata);
    } else
         /* Just use the static pdata */
         pdata = &u8500_i2c;
}

Yours,
Linus Walleij
