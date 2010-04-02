From: jassi brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-s3c2410: Remove unconditional 1ms delay on each
	transfer
Date: Fri, 2 Apr 2010 22:00:52 +0900
Message-ID: <p2q1b68c6791004020600g283db571gacd0f8b7e4ddaf6@mail.gmail.com>
References: <1270211946-25103-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1270211946-25103-1-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 2, 2010 at 9:39 PM, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> The S3C I2C controller indicates completion of I2C transfers before
> the bus has a stop condition on it. In order to ensure that we do not
> attempt to start a new transfer before the bus is idle the driver
> currently inserts a 1ms delay. This is vastly larger than is generall=
y
> required and has a visible effect on performance under load, such as
> when bringing up audio CODECs or reading back status information with
> non-bulk I2C reads.
>
> Replace the sleep with a spin on the IIC status register for up to 1m=
s.
> This will busy wait but testing on my SMDK6410 system indicates that
> the overwhelming majority of transactions complete on the first spin,
> with maximum latencies of less than 10 spins so the absolute overhead
> of busy waiting should be at worst comprable to msleep(), and the
> overall system performance is dramatically improved.
>
> The main risk is poor interaction with multimaster systems where
> we may miss the bus going idle before the next transaction. Defend
> against this by falling back to the original 1ms delay after 20 spins=
=2E
>
> The overall effect in my testing is an approximately 20% improvement
> in kernel startup time.
>
> Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> ---
> =C2=A0drivers/i2c/busses/i2c-s3c2410.c | =C2=A0 20 ++++++++++++++++++=
--
> =C2=A01 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2=
c-s3c2410.c
> index d27072b..ba52543 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -482,7 +482,8 @@ static int s3c24xx_i2c_set_master(struct s3c24xx_=
i2c *i2c)
> =C2=A0static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct i2c_msg *msgs, int num)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 unsigned long timeout;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long iicstat, timeout;
> + =C2=A0 =C2=A0 =C2=A0 int spins =3D 20;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (i2c->suspended)
> @@ -521,7 +522,22 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c=
 *i2c,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* ensure the stop has been through the bu=
s */
>
> - =C2=A0 =C2=A0 =C2=A0 msleep(1);
> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(i2c->dev, "waiting for bus idle\n");
> +
> + =C2=A0 =C2=A0 =C2=A0 /* first, try busy waiting briefly */
> + =C2=A0 =C2=A0 =C2=A0 spins =3D 0;
          ^^^^^^^^^^^^ ?
> + =C2=A0 =C2=A0 =C2=A0 do {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iicstat =3D readl(=
i2c->regs + S3C2410_IICSTAT);
> + =C2=A0 =C2=A0 =C2=A0 } while ((iicstat & S3C2410_IICSTAT_START) && =
--spins);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* if that timed out sleep */
> + =C2=A0 =C2=A0 =C2=A0 if (!spins) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msleep(1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iicstat =3D readl(=
i2c->regs + S3C2410_IICSTAT);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (iicstat & S3C2410_IICSTAT_START)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_warn(i2c->dev,=
 "timeout waiting for bus idle\n");
