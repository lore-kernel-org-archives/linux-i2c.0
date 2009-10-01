From: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] i2c: imx: add macros and printk to make debug easy
Date: Thu, 1 Oct 2009 16:01:50 +0800
Message-ID: <4e090d470910010101r6839cc9ax4fe84f04a1afbb00@mail.gmail.com>
References: <1254359613-21210-1-git-send-email-linuxzsc@gmail.com>
	 <1254359613-21210-2-git-send-email-linuxzsc@gmail.com>
	 <1254359613-21210-3-git-send-email-linuxzsc@gmail.com>
	 <20091001072934.GX27039@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091001072934.GX27039-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 1, 2009 at 3:29 PM, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> w=
rote:
> On Thu, Oct 01, 2009 at 09:13:32AM +0800, Richard Zhao wrote:
>> When CONFIG_I2C_DEBUG_BUS is enabled, it helps dump registers at ope=
ration
>> fail condition, and print i2c_msg to xfer.
>>
>> Signed-off-by: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Honestly I don't think we need this. It makes the driver too verbose =
for
> my taste.
>
> Sascha
>
>
>>
>> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-i=
mx.c
>> index c1e541c..87faea4 100644
>> --- a/drivers/i2c/busses/i2c-imx.c
>> +++ b/drivers/i2c/busses/i2c-imx.c
>> @@ -125,6 +125,20 @@ struct imx_i2c_struct {
>> =A0/** Functions for IMX I2C adapter driver ************************=
***************
>> =A0*****************************************************************=
**************/
>>
>> +#ifdef CONFIG_I2C_DEBUG_BUS
>> +#define reg_dump(i2c_imx) \
>> +{ \
>> + =A0 =A0 printk(KERN_DEBUG "fun %s:%d ", __func__, __LINE__); \
>> + =A0 =A0 printk(KERN_DEBUG "IADR %02x IFDR %02x I2CR %02x I2SR %02x=
\n", \
>> + =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c_imx->base + IMX_I2C_IADR), \
>> + =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c_imx->base + IMX_I2C_IFDR), \
>> + =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c_imx->base + IMX_I2C_I2CR), \
>> + =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c_imx->base + IMX_I2C_I2SR)); \
>> +}
>> +#else
>> +#define reg_dump(i2c_imx)
>> +#endif
>> +
>> =A0static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int f=
or_busy)
>> =A0{
>> =A0 =A0 =A0 unsigned long orig_jiffies =3D jiffies;
>> @@ -146,6 +160,7 @@ static int i2c_imx_bus_busy(struct imx_i2c_struc=
t *i2c_imx, int for_busy)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, orig_jiffies + H=
Z / 1000)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->adapte=
r.dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<%s> I2=
C bus is busy\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule();
>> @@ -164,9 +179,11 @@ static int i2c_imx_trx_complete(struct imx_i2c_=
struct *i2c_imx)
>>
>> =A0 =A0 =A0 if (unlikely(result < 0)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s> res=
ult < 0\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return result;
>> =A0 =A0 =A0 } else if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s> Tim=
eout\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s> TRX complete\n", __=
func__);
>> @@ -178,6 +195,7 @@ static int i2c_imx_acked(struct imx_i2c_struct *=
i2c_imx)
>> =A0{
>> =A0 =A0 =A0 if (readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_RXAK) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s> No =
ACK\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO; =A0/* No ACK */
>> =A0 =A0 =A0 }
>>
>> @@ -197,17 +215,20 @@ static int i2c_imx_start(struct imx_i2c_struct=
 *i2c_imx)
>> =A0 =A0 =A0 writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
>>
>> =A0 =A0 =A0 result =3D i2c_imx_bus_busy(i2c_imx, 0);
>> - =A0 =A0 if (result)
>> + =A0 =A0 if (result) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return result;
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 /* Start I2C transaction */
>> =A0 =A0 =A0 temp =3D readb(i2c_imx->base + IMX_I2C_I2CR);
>> =A0 =A0 =A0 temp |=3D I2CR_MSTA;
>> =A0 =A0 =A0 writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>> =A0 =A0 =A0 result =3D i2c_imx_bus_busy(i2c_imx, 1);
>> - =A0 =A0 if (result)
>> + =A0 =A0 if (result) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return result;
>> -
>> + =A0 =A0 }
>> =A0 =A0 =A0 temp |=3D I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
>> =A0 =A0 =A0 writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>> =A0 =A0 =A0 return result;
>> @@ -228,7 +249,8 @@ static void i2c_imx_stop(struct imx_i2c_struct *=
i2c_imx)
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 udelay(i2c_imx->disable_delay);
>>
>> - =A0 =A0 i2c_imx_bus_busy(i2c_imx, 0);
>> + =A0 =A0 if (i2c_imx_bus_busy(i2c_imx, 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>>
>> =A0 =A0 =A0 /* Disable I2C controller */
>> =A0 =A0 =A0 writeb(0, i2c_imx->base + IMX_I2C_I2CR);
>> @@ -389,7 +411,18 @@ static int i2c_imx_xfer(struct i2c_adapter *ada=
pter,
>> =A0 =A0 =A0 struct imx_i2c_struct *i2c_imx =3D i2c_get_adapdata(adap=
ter);
>>
>> =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>> -
>> +#ifdef CONFIG_I2C_DEBUG_BUS
>> + =A0 =A0 for (i =3D 0; i < num; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "msg%d addr %02x RD %d c=
nt %d d:", i,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msgs[i].addr, msgs[i].flag=
s & I2C_M_RD, msgs[i].len);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(msgs[i].flags & I2C_M_RD)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int j;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < msgs[i].=
len; j++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("%0=
2x ", msgs[i].buf[j]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk("\n");
>> + =A0 =A0 }
>> +#endif
>> =A0 =A0 =A0 /* Start I2C transfer */
>> =A0 =A0 =A0 result =3D i2c_imx_start(i2c_imx);
>> =A0 =A0 =A0 if (result)
>> @@ -404,8 +437,10 @@ static int i2c_imx_xfer(struct i2c_adapter *ada=
pter,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D I2CR_RSTA;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(temp, i2c_imx->ba=
se + IMX_I2C_I2CR);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D =A0i2c_imx_bu=
s_busy(i2c_imx, 1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i=
2c_imx);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fai=
l0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<%s> transfer message: =
%d\n", __func__, i);
>> @@ -562,7 +597,7 @@ static int __init i2c_imx_probe(struct platform_=
device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 res_size, i2c_imx->res->start);
>> =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_imx->adapter.name);
>> - =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "IMX I2C adapter registered=
\n");
>> + =A0 =A0 dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registere=
d\n");
>>
>> =A0 =A0 =A0 return 0; =A0 /* Return OK */
>>
>> --
>> 1.6.0.4
>>
>>
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0=
 =A0 =A0|
> Amtsgericht Hildesheim, HRA 2686 =A0 =A0 =A0 =A0 =A0 | Fax: =A0 +49-5=
121-206917-5555 |
>

1. i2c is more important bus in embedded system than PC. Many PMICs
are connected to cpu via i2c. Before system boot up, we depend much on
printk message.
2. When we add a new i2c device, it's easy to have problems. Maybe
it's hw issue, one device fails, all ones in the same bus fails. In
such condition, debug message is very helpfull.

Thanks
Richard
