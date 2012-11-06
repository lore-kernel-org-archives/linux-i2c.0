From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: s3c2410: Add fix for i2c suspend/resume
Date: Tue, 6 Nov 2012 11:42:04 +0530
Message-ID: <CAM=Q2ctBMmg32-Dd6V5pwEEzxCnATs1se4RD_+zgLLOGohgSzw@mail.gmail.com>
References: <1352182259-28903-1-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352182259-28903-1-git-send-email-a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 6, 2012 at 11:40 AM, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> The I2C driver makes a gpio_request during initialization. This request
> happens again on resume

Do you know why request and free is needed across the suspend and resume?

> and fails due to the earlier successful request.
> Modify the suspend code to free the earlier requested gpios.
>
> Errors on resume without this:
> [   16.020000] s3c-i2c s3c2440-i2c.0: gpio [42] request failed
> [   16.020000] s3c-i2c s3c2440-i2c.1: gpio [44] request failed
> [   16.020000] s3c-i2c s3c2440-i2c.2: gpio [6] request failed
>
> Signed-off-by: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-s3c2410.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index 3e0335f..9bec49e 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -806,6 +806,7 @@ static int s3c24xx_i2c_parse_dt_gpio(struct s3c24xx_i2c *i2c)
>                         dev_err(i2c->dev, "invalid gpio[%d]: %d\n", idx, gpio);
>                         goto free_gpio;
>                 }
> +               i2c->gpios[idx] = gpio;
>
>                 ret = gpio_request(gpio, "i2c-bus");
>                 if (ret) {
> @@ -1125,6 +1126,7 @@ static int s3c24xx_i2c_suspend_noirq(struct device *dev)
>         struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
>
>         i2c->suspended = 1;
> +       s3c24xx_i2c_dt_gpio_free(i2c);
>
>         return 0;
>  }
> --
> 1.6.6.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
