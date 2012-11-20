From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-s3c2410: Remove recently introduced performance overheads
Date: Tue, 20 Nov 2012 17:45:55 +0800
Message-ID: <CAGS+omAkOwq7m_zGCYjwgrFY_jjNfWqvFqS29F5b6GBPr62UFg@mail.gmail.com>
References: <1353391041-28943-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1353391041-28943-1-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 20, 2012 at 1:57 PM, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> The changes in "i2c-s3c2410: use exponential back off while polling for
> bus idle" remove the initial busy wait for I2C transfers to complete and
> replace it with usleep_range() calls which will schedule.
>
> Since for older SoCs I2C transfers would usually complete within an
> extremely small number of CPU cycles there is a win from not having to
> schedule.  This happens because on the older SoCs the cores run at a
> smaller multiple of the speeds that the I2C bus is operating at; on more
> modern SoCs the busy wait is less likely to be effective.
>
> Fix the issue by restoring the busy wait, reducing the number of spins
> from 20 to 3 which covers the overwhelming majority of I2C transfers on
> the SoCs where the busy wait is effective.
>
> Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-s3c2410.c |   21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index 31f802b..9050821 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -530,6 +530,7 @@ static void s3c24xx_i2c_wait_idle(struct s3c24xx_i2c *i2c)
>         unsigned long iicstat;
>         ktime_t start, now;
>         unsigned long delay;
> +       int spins;
>
>         /* ensure the stop has been through the bus */
>
> @@ -542,12 +543,22 @@ static void s3c24xx_i2c_wait_idle(struct s3c24xx_i2c *i2c)
>          * end of a transaction.  However, really slow i2c devices can stretch
>          * the clock, delaying STOP generation.
>          *
> -        * As a compromise between idle detection latency for the normal, fast
> -        * case, and system load in the slow device case, use an exponential
> -        * back off in the polling loop, up to 1/10th of the total timeout,
> -        * then continue to poll at a constant rate up to the timeout.
> +        * On slower SoCs this typically happens within a very small number of
> +        * instructions so busy wait briefly to avoid scheduling overhead.
> +        */
> +       spins = 3;
> +       do {
> +               cpu_relax();
> +               iicstat = readl(i2c->regs + S3C2410_IICSTAT);
> +       } while ((iicstat & S3C2410_IICSTAT_START) && --spins);

Can you avoid one cpu_relax() by reading IICSTAT first, and switch to
while { } instead of do { } while ()?

> +
> +       /*
> +        * If we do get an appreciable delay as a compromise between idle
> +        * detection latency for the normal, fast case, and system load in the
> +        * slow device case, use an exponential back off in the polling loop,
> +        * up to 1/10th of the total timeout, then continue to poll at a
> +        * constant rate up to the timeout.
>          */
> -       iicstat = readl(i2c->regs + S3C2410_IICSTAT);
>         delay = 1;
>         while ((iicstat & S3C2410_IICSTAT_START) &&
>                ktime_us_delta(now, start) < S3C2410_IDLE_TIMEOUT) {
> --
> 1.7.10.4
