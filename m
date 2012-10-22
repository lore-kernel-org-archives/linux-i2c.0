From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2 RESEND] i2c-nomadik: Fixup clock handling
Date: Mon, 22 Oct 2012 15:12:12 +0200
Message-ID: <CAPDyKFo+i=8bD0qwzHWUY4gpxL9=VyMr6Day47iPGEY3xpG5MQ@mail.gmail.com>
References: <1349866946-10650-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1349866946-10650-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anmar Oueja <anmar.oueja-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philippe Begnic <philippe.begnic-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Thanks for resending this patch. This patch is needed for me to be
able to add clock lookups for the i2c devices for ux500, unless the
boot will be broken.

Kind regards
Ulf Hansson

On 10 October 2012 13:02, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org> wrote:
> From: Philippe Begnic <philippe.begnic-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
>
> Make sure to clk_prepare as well as clk_enable.
>
> Signed-off-by: Philippe Begnic <philippe.begnic-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-nomadik.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
> index 1b898b6..3eeae52 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -642,7 +642,11 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
>
>         pm_runtime_get_sync(&dev->adev->dev);
>
> -       clk_enable(dev->clk);
> +       status = clk_prepare_enable(dev->clk);
> +       if (status) {
> +               dev_err(&dev->adev->dev, "can't prepare_enable clock\n");
> +               goto out_clk;
> +       }
>
>         status = init_hw(dev);
>         if (status)
> @@ -669,7 +673,8 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
>         }
>
>  out:
> -       clk_disable(dev->clk);
> +       clk_disable_unprepare(dev->clk);
> +out_clk:
>         pm_runtime_put_sync(&dev->adev->dev);
>
>         dev->busy = false;
> --
> 1.7.11.3
>
