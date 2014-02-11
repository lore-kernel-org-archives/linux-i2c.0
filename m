From: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 06/17] i2c: i2c-bfin-twi: deprecate class based instantiation
Date: Tue, 11 Feb 2014 17:02:58 +0800
Message-ID: <CAJxxZ0NWWfDOsK36_5oHD2-Ujdz1Wjhaqg0m9wbqACx6WfeTJQ@mail.gmail.com>
References: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
	<1392026654-5343-7-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392026654-5343-7-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Acked-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

On Mon, Feb 10, 2014 at 6:04 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> Warn users that class based instantiation is going away soon in favour
> of more robust probing and faster bootup times.
>
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> ---
>
> This patch is a suggestion. Looking for an ack by someone who actually uses
> the driver.
>
>  drivers/i2c/busses/i2c-bfin-twi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
> index 3b9bd9a..c75f0e9 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> @@ -669,7 +669,7 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
>         strlcpy(p_adap->name, pdev->name, sizeof(p_adap->name));
>         p_adap->algo = &bfin_twi_algorithm;
>         p_adap->algo_data = iface;
> -       p_adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
> +       p_adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD | I2C_CLASS_DEPRECATED;
>         p_adap->dev.parent = &pdev->dev;
>         p_adap->timeout = 5 * HZ;
>         p_adap->retries = 3;
> --
> 1.8.5.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
