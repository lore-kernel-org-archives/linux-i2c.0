From: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: imx: add macros and printk to make debug easy
Date: Wed, 30 Sep 2009 13:49:36 +0800
Message-ID: <4e090d470909292249x4d06ed83l687e28fb36ed8eab@mail.gmail.com>
References: <1254289682-29056-1-git-send-email-linuxzsc@gmail.com>
	 <1254289682-29056-2-git-send-email-linuxzsc@gmail.com>
	 <1254289682-29056-3-git-send-email-linuxzsc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1254289682-29056-3-git-send-email-linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 30, 2009 at 1:48 PM, Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrot=
e:
> When CONFIG_I2C_DEBUG_BUS is enabled, it helps dump registers at oper=
ation
> fail condition, and print i2c_msg to xfer.
>
> Signed-off-by: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> =A0drivers/i2c/busses/i2c-imx.c | =A0 49 ++++++++++++++++++++++++++++=
++++++++------
> =A01 files changed, 42 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-im=
x.c
> index c1e541c..87faea4 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -125,6 +125,20 @@ struct imx_i2c_struct {
> =A0/** Functions for IMX I2C adapter driver *************************=
**************
> =A0******************************************************************=
*************/
>
> +#ifdef CONFIG_I2C_DEBUG_BUS
> +#define reg_dump(i2c_imx) \
> +{ \
> + =A0 =A0 =A0 printk(KERN_DEBUG "fun %s:%d ", __func__, __LINE__); \
> + =A0 =A0 =A0 printk(KERN_DEBUG "IADR %02x IFDR %02x I2CR %02x I2SR %=
02x\n", \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c_imx->base + IMX_I2C_IADR), \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c_imx->base + IMX_I2C_IFDR), \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c_imx->base + IMX_I2C_I2CR), \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c_imx->base + IMX_I2C_I2SR)); \
> +}
> +#else
> +#define reg_dump(i2c_imx)
> +#endif
> +
> =A0static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int fo=
r_busy)
> =A0{
> =A0 =A0 =A0 =A0unsigned long orig_jiffies =3D jiffies;
> @@ -146,6 +160,7 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct=
 *i2c_imx, int for_busy)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (time_after(jiffies, orig_jiffies +=
 HZ / 1000)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adap=
ter.dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"<%s> =
I2C bus is busy\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EIO;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0schedule();
> @@ -164,9 +179,11 @@ static int i2c_imx_trx_complete(struct imx_i2c_s=
truct *i2c_imx)
>
> =A0 =A0 =A0 =A0if (unlikely(result < 0)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "<%s> r=
esult < 0\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return result;
> =A0 =A0 =A0 =A0} else if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "<%s> T=
imeout\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ETIMEDOUT;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "<%s> TRX complete\n", =
__func__);
> @@ -178,6 +195,7 @@ static int i2c_imx_acked(struct imx_i2c_struct *i=
2c_imx)
> =A0{
> =A0 =A0 =A0 =A0if (readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_RXAK) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "<%s> N=
o ACK\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EIO; =A0/* No ACK */
> =A0 =A0 =A0 =A0}
>
> @@ -197,17 +215,20 @@ static int i2c_imx_start(struct imx_i2c_struct =
*i2c_imx)
> =A0 =A0 =A0 =A0writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
>
> =A0 =A0 =A0 =A0result =3D i2c_imx_bus_busy(i2c_imx, 0);
> - =A0 =A0 =A0 if (result)
> + =A0 =A0 =A0 if (result) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return result;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* Start I2C transaction */
> =A0 =A0 =A0 =A0temp =3D readb(i2c_imx->base + IMX_I2C_I2CR);
> =A0 =A0 =A0 =A0temp |=3D I2CR_MSTA;
> =A0 =A0 =A0 =A0writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> =A0 =A0 =A0 =A0result =3D i2c_imx_bus_busy(i2c_imx, 1);
> - =A0 =A0 =A0 if (result)
> + =A0 =A0 =A0 if (result) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return result;
> -
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0temp |=3D I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
> =A0 =A0 =A0 =A0writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> =A0 =A0 =A0 =A0return result;
> @@ -228,7 +249,8 @@ static void i2c_imx_stop(struct imx_i2c_struct *i=
2c_imx)
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0udelay(i2c_imx->disable_delay);
>
> - =A0 =A0 =A0 i2c_imx_bus_busy(i2c_imx, 0);
> + =A0 =A0 =A0 if (i2c_imx_bus_busy(i2c_imx, 0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>
> =A0 =A0 =A0 =A0/* Disable I2C controller */
> =A0 =A0 =A0 =A0writeb(0, i2c_imx->base + IMX_I2C_I2CR);
> @@ -389,7 +411,18 @@ static int i2c_imx_xfer(struct i2c_adapter *adap=
ter,
> =A0 =A0 =A0 =A0struct imx_i2c_struct *i2c_imx =3D i2c_get_adapdata(ad=
apter);
>
> =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> -
> +#ifdef CONFIG_I2C_DEBUG_BUS
> + =A0 =A0 =A0 for (i =3D 0; i < num; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "msg%d addr %02x RD %=
d cnt %d d:", i,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msgs[i].addr, msgs[i].f=
lags & I2C_M_RD, msgs[i].len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(msgs[i].flags & I2C_M_RD)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int j;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < msgs[=
i].len; j++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(=
"%02x ", msgs[i].buf[j]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("\n");
> + =A0 =A0 =A0 }
> +#endif
> =A0 =A0 =A0 =A0/* Start I2C transfer */
> =A0 =A0 =A0 =A0result =3D i2c_imx_start(i2c_imx);
> =A0 =A0 =A0 =A0if (result)
> @@ -404,8 +437,10 @@ static int i2c_imx_xfer(struct i2c_adapter *adap=
ter,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0temp |=3D I2CR_RSTA;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writeb(temp, i2c_imx->=
base + IMX_I2C_I2CR);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D =A0i2c_imx_=
bus_busy(i2c_imx, 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_dum=
p(i2c_imx);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto f=
ail0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"<%s> transfer message=
: %d\n", __func__, i);
> @@ -562,7 +597,7 @@ static int __init i2c_imx_probe(struct platform_d=
evice *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res_size, i2c_imx->res->start);
> =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n=
",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c_imx->adapter.name);
> - =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "IMX I2C adapter registe=
red\n");
> + =A0 =A0 =A0 dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter regist=
ered\n");
>
> =A0 =A0 =A0 =A0return 0; =A0 /* Return OK */
>
> --
> 1.6.0.4
>
>

Sorry, I forgot to add patch NO. Please ignore theses patch.
 Richard
