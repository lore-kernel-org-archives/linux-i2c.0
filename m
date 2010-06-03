From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Registering I2C devices on X86
Date: Thu, 3 Jun 2010 08:21:03 +0200
Message-ID: <20100603082103.4bdccd85@hyperion.delvare>
References: <4C062E70.3090409@pelagicore.com>
	<20100602103650.GA4876@pengutronix.de>
	<20100602130408.1e732a0a@hyperion.delvare>
	<4C0640A0.9070103@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C0640A0.9070103-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard =?UTF-8?B?UsO2amZvcnM=?= <richard.rojfors.lists-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 02 Jun 2010 13:29:36 +0200, Richard R=C3=B6jfors wrote:
> On 06/02/2010 01:04 PM, Jean Delvare wrote:
> > Richard, look at drivers/i2c/busses/i2c-i801.c, function i801_probe=
():
> > you'll see an example of per-platform I2C device instantiation on x=
86.
> > I'm not claiming it is elegant, but it works.
>=20
> The "problem" I see is that the CPU and the chipset + I2C chip will b=
e populated on several=20
> different boards. It would mean that the I2C bus driver would need kn=
owledge of all the boards where=20
> it is used. And the bus driver itself can not really detect which boa=
rd it's running on.
>=20
> That is why I kept the I2C device setup in a separate driver. So each=
 board would have a separate=20
> "setup" driver. Isn't that the most clean solution right now?

I have to admit I don't clearly understand what you are doing. It
should become clearer when I see your code.

--=20
Jean Delvare
