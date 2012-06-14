From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: Add Device Tree support to the Nomadik I2C driver
Date: Thu, 14 Jun 2012 19:12:14 +0200
Message-ID: <CACRpkdZFi34nChnMEo6yik67zk9owZLk-6zcdP7mmOXyLz8uqQ@mail.gmail.com>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
	<1339428307-3850-10-git-send-email-lee.jones@linaro.org>
	<CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
	<4FD8BAD2.50703@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FD8BAD2.50703-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 13, 2012 at 6:07 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote=
:

> Here we apply the bindings required for successful Device Tree
> probing of the i2c-nomadik driver. We also apply a fall-back
> configuration in case either one is not provided, or a required
> element is missing from the one supplied.
>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This looks more like I'd expect it, good job! :-D

> +static int __devinit
> +nmk_i2c_of_probe(struct device_node *np, struct nmk_i2c_controller *=
pdata)
> +{
> + =A0 =A0 =A0 of_property_read_u32(np, "clock-frequency", (u32*)&pdat=
a->clk_freq);
> + =A0 =A0 =A0 if (!pdata->clk_freq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("%s: Clock frequency not found\=
n", np->full_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 of_property_read_u32(np, "stericsson,slsu", (u32*)&pdat=
a->slsu);
> + =A0 =A0 =A0 if (!pdata->slsu) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("%s: Data line delay not found\=
n", np->full_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 of_property_read_u32(np, "stericsson,tft", (u32*)&pdata=
->tft);
> + =A0 =A0 =A0 if (!pdata->tft) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("%s: Tx FIFO threshold not foun=
d\n", np->full_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 of_property_read_u32(np, "stericsson,rft", (u32*)&pdata=
->rft);
> + =A0 =A0 =A0 if (!pdata->rft) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("%s: Rx FIFO threshold not foun=
d\n", np->full_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 of_property_read_u32(np, "stericsson,timeout", (u32*)&p=
data->timeout);
> + =A0 =A0 =A0 if (!pdata->timeout) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("%s: Timeout not found\n", np->=
full_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (of_get_property(np, "stericsson,i2c_freq_mode_fast"=
, NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->sm =3D I2C_FREQ_MODE_FAST;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->sm =3D I2C_FREQ_MODE_STANDARD;
> +
> + =A0 =A0 =A0 return 0;
> +}

Will this compile fine if CONFIG_OF is not selected?

> =A0 =A0 =A0 =A0/* fetch the controller configuration from machine */
> =A0 =A0 =A0 =A0dev->cfg.clk_freq =3D pdata->clk_freq;
> - =A0 =A0 =A0 dev->cfg.slsu =A0 =3D pdata->slsu;
> - =A0 =A0 =A0 dev->cfg.tft =A0 =A0=3D pdata->tft;
> - =A0 =A0 =A0 dev->cfg.rft =A0 =A0=3D pdata->rft;
> - =A0 =A0 =A0 dev->cfg.sm =A0 =A0 =3D pdata->sm;
> -
> - =A0 =A0 =A0 i2c_set_adapdata(adap, dev);
> + =A0 =A0 =A0 dev->cfg.slsu =A0 =A0 =3D pdata->slsu;
> + =A0 =A0 =A0 dev->cfg.tft =A0 =A0 =A0=3D pdata->tft;
> + =A0 =A0 =A0 dev->cfg.rft =A0 =A0 =A0=3D pdata->rft;
> + =A0 =A0 =A0 dev->cfg.sm =A0 =A0 =A0 =3D pdata->sm; =A0i2c_set_adapd=
ata(adap, dev);

This looks like an unrelated whitespace fix, but OK...

Yours,
Linus Walleij
