From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-mxs: fixed PIO NACK error instead of timeout
Date: Mon, 8 Sep 2014 20:33:58 +0200
Message-ID: <201409082033.58959.marex@denx.de>
References: <540DEFA6.9030600@elproma.com.pl> <540DF014.5000508@elproma.com.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <540DF014.5000508-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Janusz =?utf-8?q?U=C5=BCycki?= <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Monday, September 08, 2014 at 08:06:12 PM, Janusz U=C5=BCycki wrote:
> Subject: [PATCH 2/2] i2c-mxs: fixed PIO NACK error instead of timeout
>   (1000ms)
>=20
> i2cdetect scanned i2c bus very slow if address was not occupied by an=
y
> device.

Shouldn't this check be used only after the 'SELECT' command ?

> Signed-off-by: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
> ---
>   linux-3.14.17/drivers/i2c/busses/i2c-mxs.c | 3 +++
>   1 file changed, 3 insertions(+)
>=20
> diff --git a/linux-3.14.17/drivers/i2c/busses/i2c-mxs.c
> b/linux-3.14.17/drivers/i2c/busses/i2c-mxs.c
> index 87ee72d..b498708 100644
> --- a/linux-3.14.17/drivers/i2c/busses/i2c-mxs.c
> +++ b/linux-3.14.17/drivers/i2c/busses/i2c-mxs.c
> @@ -307,6 +307,9 @@ static int mxs_i2c_pio_wait_xfer_end(struct
> mxs_i2c_dev *i2c)
>          unsigned long timeout =3D jiffies + msecs_to_jiffies(1000);
>=20
>          while (readl(i2c->regs + MXS_I2C_CTRL0) & MXS_I2C_CTRL0_RUN)=
 {
> +               /*int ret =3D mxs_i2c_pio_check_error_state(i2c);*/
> +               if (readl(i2c->regs + MXS_I2C_CTRL1) &
> MXS_I2C_CTRL1_NO_SLAVE_ACK_IRQ)
> +                       return -ENXIO;
>                  if (time_after(jiffies, timeout))
>                          return -ETIMEDOUT;
>                  cond_resched();
> --
> 1.7.11.3

Best regards,
Marek Vasut
