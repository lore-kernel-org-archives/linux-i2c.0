From: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: imx: check busy bit when START/STOP
Date: Wed, 30 Sep 2009 07:21:57 +0800
Message-ID: <4e090d470909291621y533a12b7s533b7311fc098803@mail.gmail.com>
References: <4e090d470909290441i7016c4f4g9a929d78838f9b7@mail.gmail.com>
	 <20090929132505.GM27039@pengutronix.de>
	 <4e090d470909290654r6fb36cb4h505662c7cb84b1f8@mail.gmail.com>
	 <20090929140612.GN27039@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090929140612.GN27039-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 29, 2009 at 10:06 PM, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>=
 wrote:
> On Tue, Sep 29, 2009 at 09:54:05PM +0800, Richard Zhao wrote:
>> Thanks, Sacha. See comments inline.
>>
>> On Tue, Sep 29, 2009 at 9:25 PM, Sascha Hauer <s.hauer@pengutronix.d=
e> wrote:
>> > Hi Richard,
>> >
>> >
>> > On Tue, Sep 29, 2009 at 07:41:44PM +0800, Richard Zhao wrote:
>> >> After START, wait busy bit to be set and
>> >> after STOP, wait busy bit to be clear.
>> >>
>> >> Disable clock when it's possible to save power.
>> >>
>> >> Signed-off-by: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> >> ---
>> >> =A0drivers/i2c/busses/i2c-imx.c | =A0116 ++++++++++++++++++++++++=
++++++++----------
>> >> =A01 files changed, 88 insertions(+), 28 deletions(-)
>> >>
>> >> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2=
c-imx.c
>> >> index 4afba3e..59cde70 100644
>> >> --- a/drivers/i2c/busses/i2c-imx.c
>> >> +++ b/drivers/i2c/busses/i2c-imx.c
>> >> @@ -120,19 +120,40 @@ struct imx_i2c_struct {
>> >> =A0 =A0 =A0 wait_queue_head_t =A0 =A0 =A0 queue;
>> >> =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 i2csr;
>> >> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0disable_delay;
>> >> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0ifdr; /* IMX_I2C_IF=
DR */
>> >> =A0};
>> >>
>> >> =A0/** Functions for IMX I2C adapter driver
>> >> ***************************************
>> >> =A0**************************************************************=
*****************/
>> >>
>> >> -static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx)
>> >> +#ifdef CONFIG_I2C_DEBUG_BUS
>> >> +#define reg_dump(i2c_imx) \
>> >> +{ \
>> >> + =A0 =A0 printk(KERN_DEBUG "fun %s:%d ", __func__, __LINE__); \
>> >> + =A0 =A0 printk(KERN_DEBUG "IADR %02x IFDR %02x I2CR %02x I2SR %=
02x\n", \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c_imx->base + IMX_I2C_IADR), \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c_imx->base + IMX_I2C_IFDR), \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c_imx->base + IMX_I2C_I2CR), \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c_imx->base + IMX_I2C_I2SR)); \
>> >> +}
>> >> +#else
>> >> +#define reg_dump(i2c_imx)
>> >> +#endif
>> >> +
>> >
>> > Can you please remove this reg_dump? If we really need this it sho=
uld be
>> > in an extra patch and not clutter this one.
>> I think it's needed. It helps much to debug and don't effect
>> performance by default.
>> >
>> >> +static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int =
for_busy)
>> >> =A0{
>> >> =A0 =A0 =A0 unsigned long orig_jiffies =3D jiffies;
>> >> + =A0 =A0 unsigned int temp;
>> >>
>> >> =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>> >>
>> >> =A0 =A0 =A0 /* wait for bus not busy */
>> >
>> > This comment seems wrong now. This function waits for busy or not =
busy
>> > depending on for_busy.
>> Right. Thanks
>> >
>> >> - =A0 =A0 while (readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_IBB) =
{
>> >> + =A0 =A0 temp =3D readb(i2c_imx->base + IMX_I2C_I2SR);
>> >> + =A0 =A0 while (1) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (for_busy && (temp & I2SR_IBB))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (!for_busy && !(temp & I2SR_IBB))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (signal_pending(current)) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->ada=
pter.dev,
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<%s>=
 I2C Interrupted\n", __func__);
>> >> @@ -141,9 +162,11 @@ static int i2c_imx_bus_busy(struct imx_i2c_s=
truct *i2c_imx)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, orig_jiffies =
+ HZ / 1000)) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->ada=
pter.dev,
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<%s>=
 I2C bus is busy\n", __func__);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule();
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 temp =3D readb(i2c_imx->base + IMX_I2C_=
I2SR);
>> >> =A0 =A0 =A0 }
>> >>
>> >> =A0 =A0 =A0 return 0;
>> >> @@ -158,9 +181,11 @@ static int i2c_imx_trx_complete(struct
>> >> imx_i2c_struct *i2c_imx)
>> >>
>> >> =A0 =A0 =A0 if (unlikely(result < 0)) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s> =
result < 0\n", __func__);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return result;
>> >> =A0 =A0 =A0 } else if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s> =
Timeout\n", __func__);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> >> =A0 =A0 =A0 }
>> >> =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s> TRX complete\n",=
 __func__);
>> >> @@ -172,6 +197,7 @@ static int i2c_imx_acked(struct imx_i2c_struc=
t *i2c_imx)
>> >> =A0{
>> >> =A0 =A0 =A0 if (readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_RXAK) =
{
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s> =
No ACK\n", __func__);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO; =A0/* No ACK */
>> >> =A0 =A0 =A0 }
>> >>
>> >> @@ -179,20 +205,37 @@ static int i2c_imx_acked(struct imx_i2c_str=
uct *i2c_imx)
>> >> =A0 =A0 =A0 return 0;
>> >> =A0}
>> >>
>> >> -static void i2c_imx_start(struct imx_i2c_struct *i2c_imx)
>> >> +static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
>> >> =A0{
>> >> =A0 =A0 =A0 unsigned int temp =3D 0;
>> >> + =A0 =A0 int result;
>> >>
>> >> =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>> >>
>> >> + =A0 =A0 clk_enable(i2c_imx->clk);
>> >> + =A0 =A0 writeb(i2c_imx->ifdr, i2c_imx->base + IMX_I2C_IFDR);
>> >> =A0 =A0 =A0 /* Enable I2C controller */
>> >> + =A0 =A0 writeb(0, i2c_imx->base + IMX_I2C_I2SR);
>> >> =A0 =A0 =A0 writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
>> >> +
>> >> + =A0 =A0 result =3D i2c_imx_bus_busy(i2c_imx, 0);
>> >> + =A0 =A0 if (result) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return result;
>> >> + =A0 =A0 }
>> >> +
>> >> =A0 =A0 =A0 /* Start I2C transaction */
>> >> =A0 =A0 =A0 temp =3D readb(i2c_imx->base + IMX_I2C_I2CR);
>> >> =A0 =A0 =A0 temp |=3D I2CR_MSTA;
>> >> =A0 =A0 =A0 writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>> >> + =A0 =A0 result =3D i2c_imx_bus_busy(i2c_imx, 1);
>> >> + =A0 =A0 if (result) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return result;
>> >> + =A0 =A0 }
>> >> =A0 =A0 =A0 temp |=3D I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
>> >> =A0 =A0 =A0 writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>> >> + =A0 =A0 return result;
>> >> =A0}
>> >>
>> >> =A0static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
>> >> @@ -202,18 +245,21 @@ static void i2c_imx_stop(struct imx_i2c_str=
uct *i2c_imx)
>> >> =A0 =A0 =A0 /* Stop I2C transaction */
>> >> =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>> >> =A0 =A0 =A0 temp =3D readb(i2c_imx->base + IMX_I2C_I2CR);
>> >> - =A0 =A0 temp &=3D ~I2CR_MSTA;
>> >> + =A0 =A0 temp &=3D ~(I2CR_MSTA | I2CR_MTX);
>> >
>> > This change seems unrelated. Is it necessary?
>> Yes. It's about STOP. It's better clear MTX. We must generate STOP
>> before read the last byte of Data register. If not, there will be an
>> extra 9bit clock.
>> >
>> >> =A0 =A0 =A0 writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>> >> - =A0 =A0 /* setup chip registers to defaults */
>> >> - =A0 =A0 writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
>> >> - =A0 =A0 writeb(0, i2c_imx->base + IMX_I2C_I2SR);
>> >> =A0 =A0 =A0 /*
>> >> =A0 =A0 =A0 =A0* This delay caused by an i.MXL hardware bug.
>> >> =A0 =A0 =A0 =A0* If no (or too short) delay, no "STOP" bit will b=
e generated.
>> >> =A0 =A0 =A0 =A0*/
>> >> =A0 =A0 =A0 udelay(i2c_imx->disable_delay);
>> >> +
>> >> +
>> >
>> > double blank line
>> Right.
>> >
>> >> + =A0 =A0 if (i2c_imx_bus_busy(i2c_imx, 0))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> >> +
>> >> =A0 =A0 =A0 /* Disable I2C controller */
>> >> =A0 =A0 =A0 writeb(0, i2c_imx->base + IMX_I2C_I2CR);
>> >> + =A0 =A0 clk_disable(i2c_imx->clk);
>> >> =A0}
>> >>
>> >> =A0static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_=
imx,
>> >> @@ -233,17 +279,19 @@ static void __init i2c_imx_set_clk(struct
>> >> imx_i2c_struct *i2c_imx,
>> >> =A0 =A0 =A0 else
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i2c_clk_div[i][0] < div=
; i++);
>> >>
>> >> - =A0 =A0 /* Write divider value to register */
>> >> - =A0 =A0 writeb(i2c_clk_div[i][1], i2c_imx->base + IMX_I2C_IFDR)=
;
>> >
>> > Why can't we write this value directly anymore...
>> clock will be enable/disable in start/stop
>> >
>> >> -
>> >> - =A0 =A0 /*
>> >> - =A0 =A0 =A0* There dummy delay is calculated.
>> >> - =A0 =A0 =A0* It should be about one I2C clock period long.
>> >> - =A0 =A0 =A0* This delay is used in I2C bus disable function
>> >> - =A0 =A0 =A0* to fix chip hardware bug.
>> >> - =A0 =A0 =A0*/
>> >> - =A0 =A0 i2c_imx->disable_delay =3D (500000U * i2c_clk_div[i][0]
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 + (i2c_clk_rate / 2) - 1) / (i2c_clk_ra=
te / 2);
>> >> + =A0 =A0 /* Store divider value */
>> >> + =A0 =A0 i2c_imx->ifdr =3D i2c_clk_div[i][1];
>> >
>> > ...but have to store it in a variable instead?
>> To save power, because i2c is not aways be accessed, and it's very l=
ow
>> speed bus.
>> >
>> >> +
>> >> + =A0 =A0 if (cpu_is_mx1()) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* There dummy delay is calculated.
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* It should be about one I2C clock p=
eriod long.
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* This delay is used in I2C bus disa=
ble function
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* to fix chip hardware bug.
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 i2c_imx->disable_delay =3D (500000U * i=
2c_clk_div[i][0]
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + (i2c_clk_rate / 2) - =
1) / (i2c_clk_rate / 2);
>> >> + =A0 =A0 }
>> >>
>> >> =A0 =A0 =A0 /* dev_dbg() can't be used, because adapter is not ye=
t registered */
>> >> =A0#ifdef CONFIG_I2C_DEBUG_BUS
>> >> @@ -344,7 +392,7 @@ static int i2c_imx_read(struct imx_i2c_struct
>> >> *i2c_imx, struct i2c_msg *msgs)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->ada=
pter.dev,
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<%s>=
 clear MSTA\n", __func__);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D readb(i2c_im=
x->base + IMX_I2C_I2CR);
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~I2CR_MSTA;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~(I2CR_MSTA |=
 I2CR_MTX);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(temp, i2c_imx-=
>base + IMX_I2C_I2CR);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (i =3D=3D (msgs->len - 2)) =
{
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->ada=
pter.dev,
>> >> @@ -369,14 +417,24 @@ static int i2c_imx_xfer(struct i2c_adapter =
*adapter,
>> >> =A0 =A0 =A0 struct imx_i2c_struct *i2c_imx =3D i2c_get_adapdata(a=
dapter);
>> >>
>> >> =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>> >> -
>> >> +#ifdef CONFIG_I2C_DEBUG_BUS
>> >> + =A0 =A0 for (i =3D 0; i < num; i++) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "msg%d addr %02x RD %=
d cnt %d d:", i,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msgs[i].addr, msgs[i].f=
lags & I2C_M_RD, msgs[i].len);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(msgs[i].flags & I2C_M_RD)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int j;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < msgs[=
i].len; j++)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(=
"%02x ", msgs[i].buf[j]);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 printk("\n");
>> >> + =A0 =A0 }
>> >> +#endif
>> >> =A0 =A0 =A0 /* Check if i2c bus is not busy */
>> >> - =A0 =A0 result =3D i2c_imx_bus_busy(i2c_imx);
>> >> - =A0 =A0 if (result)
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 goto fail0;
>> >
>> > When removing the code you should also remove the comment.
>> Right
>> >
>> >>
>> >> =A0 =A0 =A0 /* Start I2C transfer */
>> >> - =A0 =A0 i2c_imx_start(i2c_imx);
>> >> + =A0 =A0 result =3D i2c_imx_start(i2c_imx);
>> >> + =A0 =A0 if (result)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail0;
>> >>
>> >> =A0 =A0 =A0 /* read/write data */
>> >> =A0 =A0 =A0 for (i =3D 0; i < num; i++) {
>> >> @@ -386,6 +444,11 @@ static int i2c_imx_xfer(struct i2c_adapter *=
adapter,
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D readb(i2c_im=
x->base + IMX_I2C_I2CR);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D I2CR_RSTA;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(temp, i2c_imx-=
>base + IMX_I2C_I2CR);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D =A0i2c_imx_b=
us_busy(i2c_imx, 1);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_dum=
p(i2c_imx);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fa=
il0;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev,
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<%s> transfer messag=
e: %d\n", __func__, i);
>> >> @@ -442,7 +505,7 @@ static int __init i2c_imx_probe(struct
>> >> platform_device *pdev)
>> >> =A0 =A0 =A0 int irq;
>> >> =A0 =A0 =A0 int ret;
>> >>
>> >> - =A0 =A0 dev_dbg(&pdev->dev, "<%s>\n", __func__);
>> >> + =A0 =A0 dev_info(&pdev->dev, "<%s>\n", __func__);
>> >
>> > no
>> Why? I even don't know how many i2c controllers we have, if I didn't
>> get sysfs working. And it only print once.
>> >
>> >>
>> >> =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0=
);
>> >> =A0 =A0 =A0 if (!res) {
>> >> @@ -500,7 +563,6 @@ static int __init i2c_imx_probe(struct
>> >> platform_device *pdev)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "can't get I2C cl=
ock\n");
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail3;
>> >> =A0 =A0 =A0 }
>> >> - =A0 =A0 clk_enable(i2c_imx->clk);
>> >
>> > I think it's generally a good idea to start/stop the clocks when n=
eeded
>> > as you do here. It should be an extra patch though.
>> You think I should split the patch to three: IBB, reg_dump, clk dis/=
en ?
>> The idea is good, more easy to revert. but sometimes, I think it mak=
e
>> small things too complex.
>> Anyway, I'll follow your suggestion.
>
> In case of regressions everybody will thank you for doing it.
>
> Sascha
>
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
Hi Sascha,

Do you agree with my other comments?

Thanks
Richard
