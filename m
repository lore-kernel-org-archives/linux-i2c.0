From: Andrey Gusev <ronne-cmBhpYW9OiY@public.gmane.org>
Subject: Re: Error ' I2C transfer at 0x48 failed' on 2.6.33
Date: Sun, 28 Feb 2010 16:00:02 +0300
Message-ID: <20100228160002.14783f4a@power-debian>
References: <20100227004953.13369fcd@power-debian>
	<20100227100420.1016e0c1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100227100420.1016e0c1-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=D0=92 Sat, 27 Feb 2010 10:04:20 +0100
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> Hi Andrey,
>=20
> On Sat, 27 Feb 2010 00:49:53 +0300, Andrey Gusev wrote:
> > Hello all!
> >=20
> > Thera are errors in dmeg on 2.6.33:
> >=20
> ....
> ....
> I have good news for you: the error messages are harmless and can be
> safely ignored. I presume you did not notice any functional problem. =
I
> made the i2c-powermac driver more verbose for debugging purposes and
> it appears I've made it a little too verbose in the non-debugging
> case. Sorry about that.
>=20
> The patch below should fix it, if you have the chance to give it a
> try:
>=20

Hi!

I didn't noted ant functional problem, but this looked like regression
and I decided to report about it. I'll try patch.

Thanks,
Andrey
