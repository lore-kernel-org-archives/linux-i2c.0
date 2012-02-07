From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
Date: Tue, 7 Feb 2012 16:47:40 +0800
Message-ID: <CAGsJ_4yJOg8XNfD=tgwPU_57BroBOBGvA428tG6_eUnYX2v8OQ@mail.gmail.com>
References: <1327846668-3053-1-git-send-email-21cnbao@gmail.com>
 <20120205223757.GA10680@nekote.pengutronix.de> <CAGsJ_4yHn1M3s6CPezaW_jwOcsX6NuaZRHcNWX0qnSfhx30AHQ@mail.gmail.com>
 <20120206224714.GB25703@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120206224714.GB25703-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <ninja-8EAEigeeuNG034pCzgS/Qg7AFbiQbgqx@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>, Yuping Luo <Yuping.Luo-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

hi Wolfram,

2012/2/7 Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
>
>> > Thanks for your contribution! Is there a free datasheet for this c=
ontroller
>> > available?
>>
>> sorry. not available to public yet.
>
> :( Can you cite what "SIRFSOC_I2C_NACK" does?

if ACK is not received, an interrupt will be got and related register
status can show this error. that is just a common feature in almost
all i2c controllers? so the naming is confused. i just copied it from
the spec.

>>
>> >> +struct sirfsoc_i2c {
>> >> + =C2=A0 =C2=A0 void __iomem *base;
>> >> + =C2=A0 =C2=A0 struct clk *clk;
>> >> + =C2=A0 =C2=A0 unsigned long speed; =C2=A0 =C2=A0/* I2C SCL freq=
uency */
>> >> + =C2=A0 =C2=A0 int irq;
>> >
>> > Do you really need those two?
>>
>> irq can be deleted. speed is not really needed if you don't like.
>
> It is not about "like". It is not needed, or?

it is not needed.

>
>> >> +static void i2c_sirfsoc_queue_cmd(struct sirfsoc_i2c *siic)
>> >> +{
>> >> + =C2=A0 =C2=A0 u32 regval;
>> >> + =C2=A0 =C2=A0 int i =3D 0;
>> >> +
>> >> + =C2=A0 =C2=A0 if (siic->msg_read) {
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (((siic->finish=
ed_len + i) < siic->msg_len)
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 && (siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX)) {
>> >
>> > Either use a different indentation for the above line or add a new=
line below.
>> > It is hard to see where the while() ends and the code block starts=
=2E
>>
>> i just want to make sure what you want is:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (((siic->finis=
hed_len + i) < siic->msg_len)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&&(siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0) {
>> ?
>> or something else?
>
> I thought of (which is simpler IMO):
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (((siic->finis=
hed_len + i) < siic->msg_len)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&&(siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX)) {
>>
>> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 regval =3D SIRFSOC_I2C_READ | SIRFSOC_I2C_CMD_RP(0);
>
>
> The other solution would be (not sure if it fits the line length):
>
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (((siic->finish=
ed_len + i) < siic->msg_len)
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 && (siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF=
_MAX)) {
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 regval =3D SIRFSOC_I2C_READ | SIRFSOC_I2C_CMD_RP(0);
>
> The idea is to make it easier (visually) what is the while-condition =
and where
> is the code of the while-block. I thought that was difficult in origi=
nal version.

the mail webpages and clients really fails to show the difference. i
guess you mean:
 while (((siic->finished_len + i) < siic->msg_len)
 [ tab ][ tab ]&& (siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX)) {
?

or can you describle the indentation by something like [space][space][t=
ab][tab]?

>
>> >> +static int i2c_sirfsoc_xfer_msg(struct sirfsoc_i2c *siic, struct=
 i2c_msg *msg)
>> >> +{
>> >> + =C2=A0 =C2=A0 u32 regval =3D readl(siic->base + SIRFSOC_I2C_CTR=
L);
>> >> + =C2=A0 =C2=A0 int timeout =3D (msg->len + 1) * 50;
>> >
>> > That looks broken. What is 50 here?
>>
>> just multiple of xfer bytes for defining a timeout. i might have a c=
omment here.
>
> That probably won't help. I'd think you want a *_to_jiffies() here to=
 define a
> proper timeout value in usecs/msecs?

ok. make sense.

>
>> >> + =C2=A0 =C2=A0 siic->irq =3D platform_get_irq(pdev, 0);
>> >> + =C2=A0 =C2=A0 if (siic->irq < 0) {
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EINVAL;
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> >> + =C2=A0 =C2=A0 }
>> >
>> > return the error code here?
>>
>> out lable will free resources and return error code.
>
> Sorry, I meant the error code you received which is in siic->irq.

ok. err =3D -ENXIO

>
> Regards,
>
> =C2=A0 Wolfram

-barry
