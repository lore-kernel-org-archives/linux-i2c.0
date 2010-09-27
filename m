From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] i2c-nomadik: support smbus emulation
Date: Mon, 27 Sep 2010 11:00:41 +0200
Message-ID: <AANLkTimUWdKcMAA_1TrXNL4YDYJ7dUhVh9LLYQ_48NLh@mail.gmail.com>
References: <1285225443-1036-1-git-send-email-linus.walleij@stericsson.com>
	<4C9C1F43.4080105@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C9C1F43.4080105-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2010/9/24 Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>:
> On 9/23/2010 4:04 PM, Linus Walleij wrote:
>> We can do smbus emulation so flag this and drop the duplicate
>> flags implied from smbus emulation.
>
>> @@ -803,10 +803,7 @@ static irqreturn_t i2c_irq_handler(int irq, voi=
d *arg)
>>
>> =A0static unsigned int nmk_i2c_functionality(struct i2c_adapter *ada=
p)
>> =A0{
>> - =A0 =A0 return I2C_FUNC_I2C
>> - =A0 =A0 =A0 =A0 =A0 =A0 | I2C_FUNC_SMBUS_BYTE_DATA
>> - =A0 =A0 =A0 =A0 =A0 =A0 | I2C_FUNC_SMBUS_WORD_DATA
>> - =A0 =A0 =A0 =A0 =A0 =A0 | I2C_FUNC_SMBUS_I2C_BLOCK;
>> + =A0 =A0 return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>> =A0}
>>
>> =A0static const struct i2c_algorithm nmk_i2c_algo =3D {
>
> (failed to figure out from the driver, so would like to make sure)
> Is this I2C core capable of I2C_FUNC_SMBUS_QUICK? =A0Unless it's capa=
ble
> of full SMBus emulation, it would be better to turn off relevant flag=
s
> for safety. =A0I'm not objecting to the patch, but just wondered.

I have verified with the hardware engineer that this block is indeed
capable of SMBUS_QUICK.

Yours,
Linus Walleij
