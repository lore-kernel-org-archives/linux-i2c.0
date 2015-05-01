From: rajeev kumar <rajeevkumar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-bcm2708: fixes cdiv uneven number
Date: Fri, 1 May 2015 10:54:48 +0530
Message-ID: <CAA7nrtjAvO4n3zL51jfN5h=2koDTObk7e8R+MNzyfRDFC3+OLw@mail.gmail.com>
References: <1430417266-14900-1-git-send-email-linux_wi@tinag.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430417266-14900-1-git-send-email-linux_wi-ADq4ffItWIY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Apr 30, 2015 at 11:37 PM, Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org> wrote:
> Prevents that cdiv can be an uneven number as per datasheet cdiv is
> always rounded down to an even number.
>
> Datasheet at page 34 on
> http://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
>
> Signed-off-by: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-bcm2708.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-bcm2708.c b/drivers/i2c/busses/i2c-bcm2708.c
> index 81e9374..454ab48 100644
> --- a/drivers/i2c/busses/i2c-bcm2708.c
> +++ b/drivers/i2c/busses/i2c-bcm2708.c
> @@ -441,9 +441,15 @@ static int bcm2708_i2c_probe(struct platform_device *pdev)
>
>         bus_hz = clk_get_rate(bi->clk);
>         cdiv = bus_hz / baudrate;
> -       if (cdiv > 0xffff) {
> -               cdiv = 0xffff;
> +       /* as per datasheet cdiv is always rounded down to an even number */
> +       if (cdiv > 0xfffe) {
> +               cdiv = 0xfffe;

Use #define

~Rajeev

>                 baudrate = bus_hz / cdiv;
> +       } else {
> +               if ((cdiv & 0xfffe) != cdiv) {
> +                       cdiv &= 0xfffe;
> +                       baudrate = bus_hz / cdiv;
> +               }
>         }
>         bi->cdiv = cdiv;
>
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
