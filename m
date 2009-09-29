From: Richard Zhao <linuxzsc@gmail.com>
Subject: Re: [PATCH] i2c: imx: check busy bit when START/STOP
Date: Tue, 29 Sep 2009 21:54:05 +0800
Message-ID: <4e090d470909290654r6fb36cb4h505662c7cb84b1f8@mail.gmail.com>
References: <4e090d470909290441i7016c4f4g9a929d78838f9b7@mail.gmail.com>
	<20090929132505.GM27039@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20090929132505.GM27039@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Thanks, Sacha. See comments inline.

On Tue, Sep 29, 2009 at 9:25 PM, Sascha Hauer <s.hauer@pengutronix.de> wrot=
e:
> Hi Richard,
>
>
> On Tue, Sep 29, 2009 at 07:41:44PM +0800, Richard Zhao wrote:
>> After START, wait busy bit to be set and
>> after STOP, wait busy bit to be clear.
>>
>> Disable clock when it's possible to save power.
>>
>> Signed-off-by: Richard Zhao <linuxzsc@gmail.com>
>> ---
>> =A0drivers/i2c/busses/i2c-imx.c | =A0116 +++++++++++++++++++++++++++++++=
+----------
>> =A01 files changed, 88 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
>> index 4afba3e..59cde70 100644
>> --- a/drivers/i2c/busses/i2c-imx.c
>> +++ b/drivers/i2c/busses/i2c-imx.c
>> @@ -120,19 +120,40 @@ struct imx_i2c_struct {
>> =A0 =A0 =A0 wait_queue_head_t =A0 =A0 =A0 queue;
>> =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 i2csr;
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0disable_delay;
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0ifdr; /* IMX_I2C_IFDR */
>> =A0};
>>
>> =A0/** Functions for IMX I2C adapter driver
>> ***************************************
>> =A0*********************************************************************=
**********/
>>
>> -static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx)
>> +#ifdef CONFIG_I2C_DEBUG_BUS
>> +#define reg_dump(i2c_imx) \
>> +{ \
>> + =A0 =A0 printk(KERN_DEBUG "fun %s:%d ", __func__, __LINE__); \
>> + =A0 =A0 printk(KERN_DEBUG "IADR %02x IFDR %02x I2CR %02x I2SR %02x\n",=
 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c_imx->base + IMX_I2C_IADR), \
>> + =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c_imx->base + IMX_I2C_IFDR), \
>> + =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c_imx->base + IMX_I2C_I2CR), \
>> + =A0 =A0 =A0 =A0 =A0 =A0 readb(i2c_imx->base + IMX_I2C_I2SR)); \
>> +}
>> +#else
>> +#define reg_dump(i2c_imx)
>> +#endif
>> +
>
> Can you please remove this reg_dump? If we really need this it should be
> in an extra patch and not clutter this one.
I think it's needed. It helps much to debug and don't effect
performance by default.
>
>> +static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_bus=
y)
>> =A0{
>> =A0 =A0 =A0 unsigned long orig_jiffies =3D jiffies;
>> + =A0 =A0 unsigned int temp;
>>
>> =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>>
>> =A0 =A0 =A0 /* wait for bus not busy */
>
> This comment seems wrong now. This function waits for busy or not busy
> depending on for_busy.
Right. Thanks
>
>> - =A0 =A0 while (readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_IBB) {
>> + =A0 =A0 temp =3D readb(i2c_imx->base + IMX_I2C_I2SR);
>> + =A0 =A0 while (1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (for_busy && (temp & I2SR_IBB))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!for_busy && !(temp & I2SR_IBB))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (signal_pending(current)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.de=
v,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<%s> I2C In=
terrupted\n", __func__);
>> @@ -141,9 +162,11 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *=
i2c_imx)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, orig_jiffies + HZ / =
1000)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.de=
v,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<%s> I2C bu=
s is busy\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule();
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp =3D readb(i2c_imx->base + IMX_I2C_I2SR);
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 return 0;
>> @@ -158,9 +181,11 @@ static int i2c_imx_trx_complete(struct
>> imx_i2c_struct *i2c_imx)
>>
>> =A0 =A0 =A0 if (unlikely(result < 0)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s> result =
< 0\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return result;
>> =A0 =A0 =A0 } else if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout=
\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s> TRX complete\n", __func=
__);
>> @@ -172,6 +197,7 @@ static int i2c_imx_acked(struct imx_i2c_struct *i2c_=
imx)
>> =A0{
>> =A0 =A0 =A0 if (readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_RXAK) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s> No ACK\=
n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO; =A0/* No ACK */
>> =A0 =A0 =A0 }
>>
>> @@ -179,20 +205,37 @@ static int i2c_imx_acked(struct imx_i2c_struct *i2=
c_imx)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> -static void i2c_imx_start(struct imx_i2c_struct *i2c_imx)
>> +static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
>> =A0{
>> =A0 =A0 =A0 unsigned int temp =3D 0;
>> + =A0 =A0 int result;
>>
>> =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>>
>> + =A0 =A0 clk_enable(i2c_imx->clk);
>> + =A0 =A0 writeb(i2c_imx->ifdr, i2c_imx->base + IMX_I2C_IFDR);
>> =A0 =A0 =A0 /* Enable I2C controller */
>> + =A0 =A0 writeb(0, i2c_imx->base + IMX_I2C_I2SR);
>> =A0 =A0 =A0 writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
>> +
>> + =A0 =A0 result =3D i2c_imx_bus_busy(i2c_imx, 0);
>> + =A0 =A0 if (result) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return result;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 /* Start I2C transaction */
>> =A0 =A0 =A0 temp =3D readb(i2c_imx->base + IMX_I2C_I2CR);
>> =A0 =A0 =A0 temp |=3D I2CR_MSTA;
>> =A0 =A0 =A0 writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>> + =A0 =A0 result =3D i2c_imx_bus_busy(i2c_imx, 1);
>> + =A0 =A0 if (result) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return result;
>> + =A0 =A0 }
>> =A0 =A0 =A0 temp |=3D I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
>> =A0 =A0 =A0 writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>> + =A0 =A0 return result;
>> =A0}
>>
>> =A0static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
>> @@ -202,18 +245,21 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2=
c_imx)
>> =A0 =A0 =A0 /* Stop I2C transaction */
>> =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>> =A0 =A0 =A0 temp =3D readb(i2c_imx->base + IMX_I2C_I2CR);
>> - =A0 =A0 temp &=3D ~I2CR_MSTA;
>> + =A0 =A0 temp &=3D ~(I2CR_MSTA | I2CR_MTX);
>
> This change seems unrelated. Is it necessary?
Yes. It's about STOP. It's better clear MTX. We must generate STOP
before read the last byte of Data register. If not, there will be an
extra 9bit clock.
>
>> =A0 =A0 =A0 writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>> - =A0 =A0 /* setup chip registers to defaults */
>> - =A0 =A0 writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
>> - =A0 =A0 writeb(0, i2c_imx->base + IMX_I2C_I2SR);
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* This delay caused by an i.MXL hardware bug.
>> =A0 =A0 =A0 =A0* If no (or too short) delay, no "STOP" bit will be gener=
ated.
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 udelay(i2c_imx->disable_delay);
>> +
>> +
>
> double blank line
Right.
>
>> + =A0 =A0 if (i2c_imx_bus_busy(i2c_imx, 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_imx);
>> +
>> =A0 =A0 =A0 /* Disable I2C controller */
>> =A0 =A0 =A0 writeb(0, i2c_imx->base + IMX_I2C_I2CR);
>> + =A0 =A0 clk_disable(i2c_imx->clk);
>> =A0}
>>
>> =A0static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
>> @@ -233,17 +279,19 @@ static void __init i2c_imx_set_clk(struct
>> imx_i2c_struct *i2c_imx,
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i2c_clk_div[i][0] < div; i++);
>>
>> - =A0 =A0 /* Write divider value to register */
>> - =A0 =A0 writeb(i2c_clk_div[i][1], i2c_imx->base + IMX_I2C_IFDR);
>
> Why can't we write this value directly anymore...
clock will be enable/disable in start/stop
>
>> -
>> - =A0 =A0 /*
>> - =A0 =A0 =A0* There dummy delay is calculated.
>> - =A0 =A0 =A0* It should be about one I2C clock period long.
>> - =A0 =A0 =A0* This delay is used in I2C bus disable function
>> - =A0 =A0 =A0* to fix chip hardware bug.
>> - =A0 =A0 =A0*/
>> - =A0 =A0 i2c_imx->disable_delay =3D (500000U * i2c_clk_div[i][0]
>> - =A0 =A0 =A0 =A0 =A0 =A0 + (i2c_clk_rate / 2) - 1) / (i2c_clk_rate / 2);
>> + =A0 =A0 /* Store divider value */
>> + =A0 =A0 i2c_imx->ifdr =3D i2c_clk_div[i][1];
>
> ...but have to store it in a variable instead?
To save power, because i2c is not aways be accessed, and it's very low
speed bus.
>
>> +
>> + =A0 =A0 if (cpu_is_mx1()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* There dummy delay is calculated.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* It should be about one I2C clock period l=
ong.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* This delay is used in I2C bus disable fun=
ction
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* to fix chip hardware bug.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 i2c_imx->disable_delay =3D (500000U * i2c_clk_=
div[i][0]
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + (i2c_clk_rate / 2) - 1) / (i=
2c_clk_rate / 2);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 /* dev_dbg() can't be used, because adapter is not yet regis=
tered */
>> =A0#ifdef CONFIG_I2C_DEBUG_BUS
>> @@ -344,7 +392,7 @@ static int i2c_imx_read(struct imx_i2c_struct
>> *i2c_imx, struct i2c_msg *msgs)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.de=
v,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<%s> clear =
MSTA\n", __func__);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D readb(i2c_imx->base=
 + IMX_I2C_I2CR);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~I2CR_MSTA;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~(I2CR_MSTA | I2CR_M=
TX);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(temp, i2c_imx->base +=
 IMX_I2C_I2CR);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (i =3D=3D (msgs->len - 2)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.de=
v,
>> @@ -369,14 +417,24 @@ static int i2c_imx_xfer(struct i2c_adapter *adapte=
r,
>> =A0 =A0 =A0 struct imx_i2c_struct *i2c_imx =3D i2c_get_adapdata(adapter);
>>
>> =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>> -
>> +#ifdef CONFIG_I2C_DEBUG_BUS
>> + =A0 =A0 for (i =3D 0; i < num; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "msg%d addr %02x RD %d cnt %=
d d:", i,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msgs[i].addr, msgs[i].flags & =
I2C_M_RD, msgs[i].len);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(msgs[i].flags & I2C_M_RD)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int j;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < msgs[i].len;=
 j++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("%02x "=
, msgs[i].buf[j]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk("\n");
>> + =A0 =A0 }
>> +#endif
>> =A0 =A0 =A0 /* Check if i2c bus is not busy */
>> - =A0 =A0 result =3D i2c_imx_bus_busy(i2c_imx);
>> - =A0 =A0 if (result)
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto fail0;
>
> When removing the code you should also remove the comment.
Right
>
>>
>> =A0 =A0 =A0 /* Start I2C transfer */
>> - =A0 =A0 i2c_imx_start(i2c_imx);
>> + =A0 =A0 result =3D i2c_imx_start(i2c_imx);
>> + =A0 =A0 if (result)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail0;
>>
>> =A0 =A0 =A0 /* read/write data */
>> =A0 =A0 =A0 for (i =3D 0; i < num; i++) {
>> @@ -386,6 +444,11 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D readb(i2c_imx->base=
 + IMX_I2C_I2CR);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D I2CR_RSTA;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(temp, i2c_imx->base +=
 IMX_I2C_I2CR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D =A0i2c_imx_bus_busy=
(i2c_imx, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_dump(i2c_i=
mx);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<%s> transfer message: %d\n=
", __func__, i);
>> @@ -442,7 +505,7 @@ static int __init i2c_imx_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 int irq;
>> =A0 =A0 =A0 int ret;
>>
>> - =A0 =A0 dev_dbg(&pdev->dev, "<%s>\n", __func__);
>> + =A0 =A0 dev_info(&pdev->dev, "<%s>\n", __func__);
>
> no
Why? I even don't know how many i2c controllers we have, if I didn't
get sysfs working. And it only print once.
>
>>
>> =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> =A0 =A0 =A0 if (!res) {
>> @@ -500,7 +563,6 @@ static int __init i2c_imx_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "can't get I2C clock\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail3;
>> =A0 =A0 =A0 }
>> - =A0 =A0 clk_enable(i2c_imx->clk);
>
> I think it's generally a good idea to start/stop the clocks when needed
> as you do here. It should be an extra patch though.
You think I should split the patch to three: IBB, reg_dump, clk dis/en ?
The idea is good, more easy to revert. but sometimes, I think it make
small things too complex.
Anyway, I'll follow your suggestion.

>
>>
>> =A0 =A0 =A0 /* Request IRQ */
>> =A0 =A0 =A0 ret =3D request_irq(i2c_imx->irq, i2c_imx_isr, 0, pdev->name=
, i2c_imx);
>> @@ -549,7 +611,6 @@ static int __init i2c_imx_probe(struct
>> platform_device *pdev)
>> =A0fail5:
>> =A0 =A0 =A0 free_irq(i2c_imx->irq, i2c_imx);
>> =A0fail4:
>> - =A0 =A0 clk_disable(i2c_imx->clk);
>> =A0 =A0 =A0 clk_put(i2c_imx->clk);
>> =A0fail3:
>> =A0 =A0 =A0 release_mem_region(i2c_imx->res->start, resource_size(res));
>> @@ -587,7 +648,6 @@ static int __exit i2c_imx_remove(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->exit(&pdev->dev);
>>
>> =A0 =A0 =A0 /* Disable I2C clock */
>> - =A0 =A0 clk_disable(i2c_imx->clk);
>> =A0 =A0 =A0 clk_put(i2c_imx->clk);
>>
>> =A0 =A0 =A0 release_mem_region(i2c_imx->res->start, resource_size(i2c_im=
x->res));
>> --
>> 1.6.0.4
>>
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/ =A0|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 =A0=
 =A0|
> Amtsgericht Hildesheim, HRA 2686 =A0 =A0 =A0 =A0 =A0 | Fax: =A0 +49-5121-=
206917-5555 |
>
