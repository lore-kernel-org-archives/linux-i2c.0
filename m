From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [MeeGo-Dev][PATCH] Topcliff: Update PCH_I2C driver to 2.6.35
Date: Wed, 1 Sep 2010 21:44:53 +0200
Message-ID: <AANLkTik5qxaGAj2-jBYfJjeP43XNep61fxwVXbfVA3J4@mail.gmail.com>
References: <4C7DB9CF.5000905@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C7DB9CF.5000905-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masayuki Ohtak <masa-korg-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Cc: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Wang Yong Y\"" <yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Wang Qi\"" <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Andrew\"" <andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Tomoya MORINAGA <morinaga526-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2010/9/1 Masayuki Ohtak <masa-korg-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>:

> I2C driver of Topcliff PCH
> (...)
> +++ b/drivers/i2c/busses/i2c-pch.c
> (...)
> +/**
> + * pch_wait_for_bus_idle() - check the status of bus.
> + * @adap: =A0 =A0 =A0Pointer to struct i2c_algo_pch_data.
> + * @timeout: =A0 waiting time counter (us).
> + */
> +static s32 pch_wait_for_bus_idle(struct i2c_algo_pch_data *adap,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s32 =
timeout)
> +{
> + =A0 =A0 =A0 void __iomem *p =3D adap->pch_base_address;
> +
> + =A0 =A0 =A0 /* MAX timeout value is timeout*1000*1000nsec */
> + =A0 =A0 =A0 ktime_t ns_val =3D ktime_add_ns(ktime_get(), timeout*10=
00*1000);
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ioread32(p + PCH_I2CSR) & I2CMBB_B=
IT) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(1);
> + =A0 =A0 =A0 } while (ktime_lt(ktime_get(), ns_val));
> +
> + =A0 =A0 =A0 dev_dbg(adap->pch_adapter.dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s : I2CSR =3D %x\n", =
__func__, ioread32(p + PCH_I2CSR));
> +
> + =A0 =A0 =A0 if (timeout =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(adap->pch_adapter.dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "%s :return%d\n", __func__, -ETIME);

Why not just return -ETIME; here?

> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(adap->pch_adapter.dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "%s : return %d\n", __func__, 0);
> + =A0 =A0 =A0 }

Delete this else clause, who is interested in return 0???

> + =A0 =A0 =A0 return ((timeout <=3D 0) ? (-ETIME) : (0));

return 0;

> (...)
> +/**
> + * pch_wait_for_xfer_complete() - initiates a wait for the tx comple=
te event
> + * @adap: =A0 =A0 =A0Pointer to struct i2c_algo_pch_data.
> + */
> +static s32 pch_wait_for_xfer_complete(struct i2c_algo_pch_data *adap=
)
> +{
> + =A0 =A0 =A0 s32 ret;
> + =A0 =A0 =A0 ret =3D wait_event_interruptible_timeout(pch_event,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (adap->pch_event_flag !=
=3D 0), msecs_to_jiffies(50));
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;

The goto construction is unnecessary, just

return ret;

> +
> + =A0 =A0 =A0 if (ret =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ETIMEDOUT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;

return -ETIMEDOUT;

> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (adap->pch_event_flag & I2C_ERROR_MASK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(adap->pch_adapter.dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "error =
bits set: %x\n", adap->pch_event_flag);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;

Skip ret assignment
return -EIO;

> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 adap->pch_event_flag =3D 0;
> + =A0 =A0 =A0 ret =3D 0;

Skip this

> +out:
> + =A0 =A0 =A0 return ret;

return 0;

> +}
> (...)
> +/**
> + * pch_getack() - to confirm ACK/NACK
> + * @adap: =A0 =A0 =A0Pointer to struct i2c_algo_pch_data.
> + */
> +static s32 pch_getack(struct i2c_algo_pch_data *adap)
> +{
> + =A0 =A0 =A0 u32 reg_val;
> + =A0 =A0 =A0 void __iomem *p =3D adap->pch_base_address;
> + =A0 =A0 =A0 reg_val =3D ioread32(p + PCH_I2CSR) & PCH_GETACK;
> +
> + =A0 =A0 =A0 if (reg_val =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(adap->pch_adapter.dev.parent, "=
%s : return 0\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(adap->pch_adapter.dev.parent, "=
%s : return%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, -EPROTO);
> +
> + =A0 =A0 =A0 return (((reg_val) =3D=3D 0) ? (0) : (-EPROTO));

Refactor this like the other function, no weirdo debug prints
return 0;

> +}
> (...)
> +/**
> + * pch_writebytes() - write data to I2C bus in normal mode
> + * @i2c_adap: =A0Pointer to the struct i2c_adapter.
> + * @last: =A0 =A0 =A0specifies whether last message or not.
> + * =A0 =A0 =A0 =A0 =A0 =A0 In the case of compound mode it will be 1=
 for last message,
> + * =A0 =A0 =A0 =A0 =A0 =A0 otherwise 0.
> + * @first: =A0 =A0 specifies whether first message or not.
> + * =A0 =A0 =A0 =A0 =A0 =A0 1 for first message otherwise 0.
> + */
> +static s32 pch_writebytes(struct i2c_adapter *i2c_adap, struct i2c_m=
sg *msgs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 last, u32 first=
)
> +{
> + =A0 =A0 =A0 struct i2c_algo_pch_data *adap =3D i2c_adap->algo_data;
> + =A0 =A0 =A0 u8 *buf;
> + =A0 =A0 =A0 u32 length;
> + =A0 =A0 =A0 u32 addr;
> + =A0 =A0 =A0 u32 addr_2_msb;
> + =A0 =A0 =A0 u32 addr_8_lsb;
> + =A0 =A0 =A0 s32 wrcount;

You don't assign anything to wrcount...

> + =A0 =A0 =A0 void __iomem *p =3D adap->pch_base_address;
> + =A0 =A0 =A0 length =3D msgs->len;
> + =A0 =A0 =A0 buf =3D msgs->buf;
> + =A0 =A0 =A0 addr =3D msgs->addr;
> + =A0 =A0 =A0 /* enable master tx */
> + =A0 =A0 =A0 pch_setbit((adap->pch_base_address), PCH_I2CCTL, I2C_TX=
_MODE);
> +
> + =A0 =A0 =A0 dev_dbg(adap->pch_adapter.dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s : I2CCTL =3D %x msgs->len =3D %d\n"=
, __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioread32(p + PCH_I2CCTL), length);
> +
> + =A0 =A0 =A0 if (first) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pch_wait_for_bus_idle(adap, BUS_IDL=
E_TIMEOUT) =3D=3D -ETIME)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIME;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (msgs->flags & I2C_M_TEN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr_2_msb =3D ((addr & I2C_MSB_2B_MSK)=
 >> 7);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(addr_2_msb | TEN_BIT_ADDR_MAS=
K, p + PCH_I2CDR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (first)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pch_start(adap);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((pch_wait_for_xfer_complete(adap) =3D=
=3D 0) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pch_getack(adap) =3D=3D 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr_8_lsb =3D (addr & =
I2C_ADDR_MSK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(addr_8_lsb, p=
 + PCH_I2CDR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pch_stop(adap);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIME;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set 7 bit slave address and R/W bit =
as 0 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(addr << 1, p + PCH_I2CDR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (first)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pch_start(adap);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if ((pch_wait_for_xfer_complete(adap) =3D=3D 0) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (pch_getack(adap) =3D=3D 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (wrcount =3D 0; wrcount < length; +=
+wrcount) {

=2E..but it is only conditionally used here...

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* write buffer value t=
o I2C data register */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(buf[wrcount],=
 p + PCH_I2CDR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(adap->pch_adapt=
er.dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s : w=
riting %x to Data register\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func_=
_, buf[wrcount]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pch_wait_for_xfer_c=
omplete(adap) !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wrcount=
 =3D -ETIME;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(adap->pch_adapt=
er.dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "%s return %d", __func__, 0);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pch_getack(adap)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wrcount=
 =3D -ETIME;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check if this is the last message */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (last)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pch_stop(adap);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pch_repstart(adap);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pch_stop(adap);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_dbg(adap->pch_adapter.dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "%s return=3D%d\n", __func__, wrcount);
> +
> + =A0 =A0 =A0 return wrcount;

=2E..and then you return it, leading to a possibly unassigned state.

> +}
> (...)
> +/**
> + * pch_readbytes() - read data =A0from I2C bus in normal mode.
> + * @i2c_adap: =A0Pointer to the struct i2c_adapter.
> + * @msgs: =A0 =A0 =A0Pointer to i2c_msg structure.
> + * @last: =A0 =A0 =A0specifies whether last message or not.
> + * @first: =A0 =A0 specifies whether first message or not.
> + */
> +s32 pch_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 last, u32 first)
> +{
> + =A0 =A0 =A0 struct i2c_algo_pch_data *adap =3D i2c_adap->algo_data;
> +
> + =A0 =A0 =A0 u8 *buf;
> + =A0 =A0 =A0 u32 count;

Same problem here. Initialize to 0.

> + =A0 =A0 =A0 u32 length;
> + =A0 =A0 =A0 u32 addr;
> + =A0 =A0 =A0 u32 addr_2_msb;
> + =A0 =A0 =A0 void __iomem *p =3D adap->pch_base_address;
> + =A0 =A0 =A0 length =3D msgs->len;
> + =A0 =A0 =A0 buf =3D msgs->buf;
> + =A0 =A0 =A0 addr =3D msgs->addr;
> +
> + =A0 =A0 =A0 /* enable master reception */
> + =A0 =A0 =A0 pch_clrbit((adap->pch_base_address), PCH_I2CCTL, I2C_TX=
_MODE);
> +
> + =A0 =A0 =A0 if (first) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pch_wait_for_bus_idle(adap, BUS_IDL=
E_TIMEOUT) =3D=3D -ETIME)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIME;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (msgs->flags & I2C_M_TEN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr_2_msb =3D (((addr & I2C_MSB_2B_MSK=
) >> 7) | (I2C_RD));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(addr_2_msb | TEN_BIT_ADDR_MAS=
K, p + PCH_I2CDR);
> +
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* 7 address bits + R/W bit */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D (((addr) << 1) | (I2C_RD));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(addr, p + PCH_I2CDR);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* check if it is the first message */
> + =A0 =A0 =A0 if (first)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pch_start(adap);
> +
> + =A0 =A0 =A0 if ((pch_wait_for_xfer_complete(adap) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 && (pch_getack(adap) =3D=3D 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(adap->pch_adapter.dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "%s return %d", __func__, 0);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (length =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pch_stop(adap);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioread32(p + PCH_I2CDR)=
; /* Dummy read needs */
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D length;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int read_index;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int loop;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pch_sendack(adap);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Dummy read */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (loop =3D 1, read_i=
ndex =3D 0; loop < length; loop++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[rea=
d_index] =3D ioread32(p + PCH_I2CDR);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (loo=
p !=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 read_index++;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pch=
_wait_for_xfer_complete(adap) !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 pch_stop(adap);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 return -ETIME;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } =A0 =A0 =A0 /* end fo=
r */
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pch_sendnack(adap);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[read_index] =3D ior=
ead32(p + PCH_I2CDR);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (length !=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_in=
dex++;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pch_wait_for_xfer_c=
omplete(adap) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (las=
t)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 pch_stop(adap);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 pch_repstart(adap);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[rea=
d_index++] =3D ioread32(p + PCH_I2CDR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D=
 read_index;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D=
 -ETIME;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -ETIME;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pch_stop(adap);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return count;
> +}

> (...)
> +/**
> + * pch_handler_ch0() - interrupt handler for the PCH I2C controller
> + * @irq: =A0 =A0 =A0 irq number.
> + * @pData: =A0 =A0 cookie passed back to the handler function.
> + */
> +static irqreturn_t pch_handler_ch0(int irq, void *pData)
> +{
> + =A0 =A0 =A0 s32 reg_val;
> +
> + =A0 =A0 =A0 struct i2c_algo_pch_data *adap_data =3D (struct i2c_alg=
o_pch_data *)pData;
> + =A0 =A0 =A0 void __iomem *p =3D adap_data->pch_base_address;
> + =A0 =A0 =A0 u32 mode =3D ioread32(p + PCH_I2CMOD) & (BUFFER_MODE | =
EEPROM_SR_MODE);
> +
> + =A0 =A0 =A0 if (mode =3D=3D NORMAL_MODE) {

No.

if (mode !=3D NORMAL_MODE) {
  dev_err(...)
  return IRQ_NONE;
}

Then de-indent the rest and remove the else clause.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D ioread32(p + PCH_I2CSR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (reg_val & (I2CMAL_BIT | I2CMCF_BIT =
| I2CMIF_BIT))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pch_cb_ch0(adap_data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(adap_data->pch_adapter.dev.pare=
nt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s I2C mode is not sup=
ported\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +
> +err_out:
> + =A0 =A0 =A0 return IRQ_NONE;
> +}

> (...)
> +/**
> + * pch_xfer() - Reading adnd writing data through I2C bus
> + * @i2c_adap: =A0Pointer to the struct i2c_adapter.
> + * @msgs: =A0 =A0 =A0Pointer to i2c_msg structure.
> + * @num: =A0 =A0 =A0 number of messages.
> + */
> +static s32 pch_xfer(struct i2c_adapter *i2c_adap,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct i2c_msg *msgs, s32 num)
> +{
> + =A0 =A0 =A0 struct i2c_msg *pmsg;
> + =A0 =A0 =A0 u32 i;
> + =A0 =A0 =A0 u32 status;
> + =A0 =A0 =A0 u32 msglen;
> + =A0 =A0 =A0 u32 subaddrlen;
> + =A0 =A0 =A0 s32 ret;
> +
> + =A0 =A0 =A0 struct i2c_algo_pch_data *adap =3D i2c_adap->algo_data;
> +
> + =A0 =A0 =A0 ret =3D mutex_lock_interruptible(&pch_mutex);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ERESTARTSYS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto return_err_nomutex;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (adap->p_adapter_info->pch_suspended =3D=3D false) {

No.

if (adap->p_adapter_info->pch_suspended) {
   mutex_unlock(&pch_nomutex);
   return -EBUSY;
}

De-indent the rest and remove the else clause.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(adap->pch_adapter.dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s adap->p_adapter_inf=
o->pch_suspended is %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, adap->p_adapt=
er_info->pch_suspended);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* transfer not completed */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 adap->pch_xfer_in_progress =3D true;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < num; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pmsg =3D &msgs[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pmsg->flags |=3D adap->=
pch_buff_mode_en;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D pmsg->flags;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(adap->pch_adapt=
er.dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "After =
invoking I2C_MODE_SEL :flag=3D 0x%x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* calculate sub addres=
s length and message length */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* these are applicable=
 only for buffer mode */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 subaddrlen =3D pmsg->bu=
f[0];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* calculate actual mes=
sage length excluding
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the sub address fi=
elds */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msglen =3D (pmsg->len) =
- (subaddrlen + 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & (I2C_M_RD)=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg=
(adap->pch_adapter.dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "%s invoking pch_readbytes\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D=
 pch_readbytes(i2c_adap, pmsg,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (i + 1 =3D=3D num),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (i =3D=3D 0));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg=
(adap->pch_adapter.dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "%s invoking pch_writebytes\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D=
 pch_writebytes(i2c_adap, pmsg,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(i + 1 =3D=3D num),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(i =3D=3D 0));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 adap->pch_xfer_in_progress =3D false; =A0=
 =A0 /* transfer completed */
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(adap->pch_adapter.dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "adap->pch_xfer_in_progress is %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 adap->pch_xfer_in_progress);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mutex_unlock(&pch_mutex);
> +return_err_nomutex:
> + =A0 =A0 =A0 dev_dbg(adap->pch_adapter.dev.parent, "%s return:%d\n\n=
\n\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, ret)=
;
> + =A0 =A0 =A0 return ret;
> +}

> (...)
> +static int __devinit pch_probe(struct pci_dev *pdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const st=
ruct pci_device_id *id)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 void __iomem *base_addr;
> + =A0 =A0 =A0 s32 ret;
> + =A0 =A0 =A0 struct adapter_info *adap_info =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kzalloc((sizeof(struct =
adapter_info)), GFP_KERNEL);
> +
> + =A0 =A0 =A0 dev_dbg(&pdev->dev, "Enterred in %s\n", __func__);
> +
> + =A0 =A0 =A0 if (adap_info =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Memory allocation =
failed FAILED");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto return_err;

Just
return -ENOMEM;

Goto construction unnecessary here.

> (...)
> +#ifdef CONFIG_PM
> +static int pch_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 struct adapter_info *adap_info =3D pci_get_drvdata(pdev=
);
> + =A0 =A0 =A0 void __iomem *p =3D adap_info->pch_data[0].pch_base_add=
ress;
> +
> + =A0 =A0 =A0 adap_info->pch_suspended =3D true;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < PCH_MAX_CHN; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while ((adap_info->pch_data[i].pch_xfer=
_in_progress)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* It is assumed that a=
ny pending transfer will
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* be completed after=
 the delay
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

The comment seems to be a lie. It is not assumed that it will
be completed at all, because you're sleeping repeatedly until all
transfers are completed.

What you are doing is you are waiting for channel zero to
complete transfers, then channel 1 etc up to channel PCH_MAX_CHN.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable the i2c interrupts */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pch_disbl_int(&adap_info->pch_data[i]);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_dbg(&pdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "I2CSR =3D %x I2CBUFSTA =3D %x I2CESRST=
A =3D %x "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "invoked function pch_disbl_int success=
fully\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioread32(p + 0x08),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioread32(p + 0x30),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioread32(p + 0x44));
> +
> + =A0 =A0 =A0 ret =3D pci_save_state(pdev);
> +
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "pci_save_state fai=
led\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pci_enable_wake(pdev, PCI_D3hot, 0);
> + =A0 =A0 =A0 pci_disable_device(pdev);
> + =A0 =A0 =A0 pci_set_power_state(pdev, pci_choose_state(pdev, state)=
);
> +
> + =A0 =A0 =A0 return 0;
> +}


Yours,
Linus Walleij
