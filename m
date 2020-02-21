From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [RFC PATCH 3/7] i2c: allow DT nodes without 'compatible'
Date: Fri, 21 Feb 2020 10:48:27 +0100
Message-ID: <CAMuHMdXGvRRJUU7fOszPuKcvHA2ttpLTvQ5=9h3vVWPYFUbjaQ@mail.gmail.com>
References: <20200220172403.26062-1-wsa+renesas@sang-engineering.com>
 <20200220172403.26062-4-wsa+renesas@sang-engineering.com> <CAMuHMdWaPfc050dZiRr+gAFzsdjSo9Vo70ztWgrMGPJxLUqupw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdWaPfc050dZiRr+gAFzsdjSo9Vo70ztWgrMGPJxLUqupw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i3c-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kieran Bingham <kieran-7hKh/agyDeatmTQ+vhA3Yw@public.gmane.org>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>, Luca Ceresoli <luca-ep08DiM7hqZH3+C6az13tg@public.gmane.org>, Jacopo Mondi <jacopo-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 21, 2020 at 10:45 AM Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> On Thu, Feb 20, 2020 at 6:26 PM Wolfram Sang
> <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org> wrote:
> > Sometimes, we have unknown devices in a system and still want to block
> > their address. For that, we allow DT nodes with only a 'reg' property.
> > These devices will be bound to the "dummy" driver but with the name
> > "reserved". That way, we can distinguish them and even hand them over to
> > the "dummy" driver later when they are really requested using
> > i2c_new_ancillary_device().
> >
> > Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
>
> Thanks for your patch!
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

FTR, depending on the extra dummy removed.

> but one question below.
>
> > --- a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> > @@ -50,7 +50,6 @@ Examples:
> >                 reg-io-width = <1>;     /* 8 bit read/write */
> >
> >                 dummy@60 {
> > -                       compatible = "dummy";
> >                         reg = <0x60>;
> >                 };
> >         };
>
> There's a second instance to remove 18 lines below.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
