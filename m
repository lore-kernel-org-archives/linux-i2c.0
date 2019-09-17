From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1 2/2] of: Let of_for_each_phandle fallback to
 non-negative cell_count
Date: Tue, 17 Sep 2019 14:52:31 +0200
Message-ID: <CAMuHMdXk5uSk-v4vYVR1YO46gQd0mRYy5eEM6wOHqgkRTfyn-g@mail.gmail.com>
References: <20190824132846.8589-1-u.kleine-koenig@pengutronix.de>
 <20190824132846.8589-2-u.kleine-koenig@pengutronix.de> <20190913215809.GA11833@bogus>
 <CAMuHMdV+pwoAA0zH_vQf2nKqzrgHP8rcMStyJbnuu2qviFC_qg@mail.gmail.com>
 <20190917101303.t5otztdus7y3ayau@pengutronix.de> <489c90fb-a135-4fd8-ecb9-46404bd3c234@axentia.se>
 <20190917122530.3xy7sut3xdvzlomj@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190917122530.3xy7sut3xdvzlomj@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, Frank Rowand <frowand.list@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,

On Tue, Sep 17, 2019 at 2:25 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Sep 17, 2019 at 11:25:46AM +0000, Peter Rosin wrote:
> > On 2019-09-17 12:13, Uwe Kleine-König wrote:
> > > On Tue, Sep 17, 2019 at 11:40:25AM +0200, Geert Uytterhoeven wrote:
> > >> On Fri, Sep 13, 2019 at 11:58 PM Rob Herring <robh@kernel.org> wrote:
> > >>> On Sat, 24 Aug 2019 15:28:46 +0200, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=          wrote:
> > >>>> Referencing device tree nodes from a property allows to pass arguments.
> > >>>> This is for example used for referencing gpios. This looks as follows:
> > >>>>
> > >>>>       gpio_ctrl: gpio-controller {
> > >>>>               #gpio-cells = <2>
> > >>>>               ...
> > >>>>       }
> > >>>>
> > >>>>       someothernode {
> > >>>>               gpios = <&gpio_ctrl 5 0 &gpio_ctrl 3 0>;
> > >>>>               ...
> > >>>>       }
> > >>>>
> > >>>> To know the number of arguments this must be either fixed, or the
> > >>>> referenced node is checked for a $cells_name (here: "#gpio-cells")
> > >>>> property and with this information the start of the second reference can
> > >>>> be determined.
> > >>>>
> > >>>> Currently regulators are referenced with no additional arguments. To
> > >>>> allow some optional arguments without having to change all referenced
> > >>>> nodes this change introduces a way to specify a default cell_count. So
> > >>>> when a phandle is parsed we check for the $cells_name property and use
> > >>>> it as before if present. If it is not present we fall back to
> > >>>> cells_count if non-negative and only fail if cells_count is smaller than
> > >>>> zero.
> > >>>>
> > >>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > >>
> > >> This is now commit e42ee61017f58cd9 ("of: Let of_for_each_phandle fallback
> > >> to non-negative cell_count") in robh/for-next, which causes a lock-up when
> > >> booting a shmobile_defconfig kernel on r8a7791/koelsch:
> > >>
> > >> rcu: INFO: rcu_sched self-detected stall on CPU

> Oh yeah, you're right. I'm a bit disappointed that I didn't spot this
> myself :-|
>
> Untested patch to fix this problem:
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 2f25d2dfecfa..26f7a21d7187 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1284,6 +1284,13 @@ int of_phandle_iterator_init(struct of_phandle_iterator *it,
>         const __be32 *list;
>         int size;
>
> +       /*
> +        * one of cell_count or cells_name must be provided to determine the
> +        * argument length.
> +        */
> +       if (cell_count < 0 && !cells_name)
> +               return -EINVAL;
> +
>         memset(it, 0, sizeof(*it));
>
>         list = of_get_property(np, list_name, &size);
> @@ -1765,6 +1772,18 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
>         struct of_phandle_iterator it;
>         int rc, cur_index = 0;
>
> +       /* If cells_name is NULL we assume an cell_count of 0 */

a cell count

> +       if (cells_name == NULL) {
> +               const __be32 *list;
> +               int size;
> +
> +               list = of_get_property(np, list_name, &size);
> +               if (!list)
> +                       return -ENOENT;
> +
> +               return size / sizeof(*list);
> +       }
> +
>         rc = of_phandle_iterator_init(&it, np, list_name, cells_name, -1);
>         if (rc)
>                 return rc;

Thanks, that fixes the boot for me!

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
