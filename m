From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 2/3] hwmon/ltc2990: Generalise DT to fwnode support
Date: Fri, 16 Aug 2019 09:32:46 +0200
Message-ID: <CAMuHMdUYpkkmhxwTu7MGm6NiMfYs9SqjLKRPazuSEjRgpRavyg@mail.gmail.com>
References: <20190815125802.16500-1-max@enpas.org> <20190815125802.16500-2-max@enpas.org>
 <6920f2da-3139-6fc8-b02c-3678cc17912e@enpas.org> <20190815224341.GA12420@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815224341.GA12420@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Max Staudt <max@enpas.org>, Linux I2C <linux-i2c@vger.kernel.org>, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 16, 2019 at 1:50 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On Fri, Aug 16, 2019 at 12:19:42AM +0200, Max Staudt wrote:
> > On 08/15/2019 02:58 PM, Max Staudt wrote:
> > > -   if (of_node) {
> > > -           ret = of_property_read_u32_array(of_node, "lltc,meas-mode",
> > > -                                            data->mode, 2);
> > > +   if (i2c->dev.of_node || i2c->dev.fwnode) {

I was just going to comment on this check...

> > One more idea, would it be better here to do the following?
> >
> >       if (device_property_present(i2c->dev, "lltc,meas-mode")) {
> >               ret = of_property_read_u32_array(of_node, "lltc,meas-mode",
> >                                                data->mode, 2);
> >       }
> >
> > I'm happy to prepare a patch if you wish to have this in - just let me know whether it should be on top of the last one, or instead of it.
>
> That would be semantically different. The property is currently mandatory.
> The above code would make it optional. This might work:
>
>         if (dev_fwnode(&i2c->dev)) {
>                 ret = device_property_read_u32_array(...);
>                 ...
>         }

Much better, thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
