From: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Subject: Re: [PATCH v4 2/5] nvmem: add support for the write-protect pin
Date: Mon, 17 Feb 2020 15:34:34 +0100
Message-ID: <CAMRc=Mf0-gQJH8Se4sFBCkRNE=b4ww=SWges-7GPD2jsivrv1Q@mail.gmail.com>
References: <20200107092922.18408-1-ktouil@baylibre.com> <20200107092922.18408-3-ktouil@baylibre.com>
 <CAMuHMdVv+FRnf6fvjEeu50W5PB-Gh2V8Th1h__vt6guMwk2xNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdVv+FRnf6fvjEeu50W5PB-Gh2V8Th1h__vt6guMwk2xNQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Khouloud Touil <ktouil-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, baylibre-upstreaming-GWfripvEmMdhl2p70BpVqQ@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

czw., 30 sty 2020 o 09:06 Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> napisa=
=C5=82(a):
>
> Hi Khouloud,
>
> On Tue, Jan 7, 2020 at 10:30 AM Khouloud Touil <ktouil-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrot=
e:
> > The write-protect pin handling looks like a standard property that
> > could benefit other users if available in the core nvmem framework.
> >
> > Instead of modifying all the memory drivers to check this pin, make
> > the NVMEM subsystem check if the write-protect GPIO being passed
> > through the nvmem_config or defined in the device tree and pull it
> > low whenever writing to the memory.
> >
> > There was a suggestion for introducing the gpiodesc from pdata, but
> > as pdata is already removed it could be replaced by adding it to
> > nvmem_config.
> >
> > Reference: https://lists.96boards.org/pipermail/dev/2018-August/001056.=
html
> >
> > Signed-off-by: Khouloud Touil <ktouil-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> > Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Acked-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Thanks for your patch!
>
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/module.h>
> >  #include <linux/nvmem-consumer.h>
> >  #include <linux/nvmem-provider.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/of.h>
> >  #include <linux/slab.h>
> >  #include "nvmem.h"
> > @@ -54,8 +55,14 @@ static int nvmem_reg_read(struct nvmem_device *nvmem=
, unsigned int offset,
> >  static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int of=
fset,
> >                            void *val, size_t bytes)
> >  {
> > -       if (nvmem->reg_write)
> > -               return nvmem->reg_write(nvmem->priv, offset, val, bytes=
);
> > +       int ret;
> > +
> > +       if (nvmem->reg_write) {
> > +               gpiod_set_value_cansleep(nvmem->wp_gpio, 0);
> > +               ret =3D nvmem->reg_write(nvmem->priv, offset, val, byte=
s);
> > +               gpiod_set_value_cansleep(nvmem->wp_gpio, 1);
> > +               return ret;
> > +       }
> >
> >         return -EINVAL;
> >  }
> > @@ -338,6 +345,14 @@ struct nvmem_device *nvmem_register(const struct n=
vmem_config *config)
> >                 kfree(nvmem);
> >                 return ERR_PTR(rval);
> >         }
> > +       if (config->wp_gpio)
> > +               nvmem->wp_gpio =3D config->wp_gpio;
> > +       else
> > +               nvmem->wp_gpio =3D gpiod_get_optional(config->dev, "wp"=
,
> > +                                                   GPIOD_OUT_HIGH);
>
> Shouldn't this GPIO be released in nvmem_release(), by calling gpiod_put(=
)?
>

Hi Geert,

Khouloud already sent out a patch but I think it still doesn't fix all
the problems.

While we should call gpiod_put() for the descs we request - we must
not do it for the desc we get over the config structure. Unless... we
make descs reference counted with kref and add gpiod_ref() helper.
That way we could increase the reference counter in the upper branch
of the if and not do it in the lower. Calling gpiod_put() would
internally call kref_put(). Does it make sense? I think that a
function that's called gpiod_put() but doesn't really use reference
counting is misleading anyway.

> Once that's implemented, I assume it will be auto-released on registratio=
n
> failure by the call to put_device()?

No, I think this is another leak - why would put_device() lead to
freeing any resources? Am I missing something?

Bart
