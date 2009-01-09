From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: SMBus quick command problem
Date: Fri, 9 Jan 2009 16:12:22 +0100
Message-ID: <20090109161222.4c75ffda@hyperion.delvare>
References: <ce62e9d00901080101ocfa0388g91698776eb9704cb@mail.gmail.com>
	<20090109152752.29b3c5de@hyperion.delvare>
	<ce62e9d00901090703y5af1ba4diedf37d30da5d158a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ce62e9d00901090703y5af1ba4diedf37d30da5d158a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabien Marteau <lepingouin.tux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 9 Jan 2009 16:03:11 +0100, Fabien Marteau wrote:
> Thanks Jean,
>=20
> In fact I'm using the i2c-ocore (opencore) controller, and the =ABSMB=
us
> Quick Command=BB block the bus with the Linux standard driver
> (drivers/i2c/busses/i2c-ocores.c):
> http://www.opencores.org/forums.cgi/cores/2008/10/003391
>=20
> Then to solve this problem I'm re-writing the driver to support each
> SMBus commands separately, following the linux documentation.
> If writing '1' on quick command block the bus, I will skip this test.

I don't get where you're going with rewriting the driver. You'll end up
with a larger driver doing exactly the same, without taking benefit of
the SMBus emulation layer from i2c-core. If the hardware has a problem
with Quick commands, rewriting the driver won't solve that. Better
intercept that case in the current driver and return an error.

Not that it really matters though, as I have yet to see any real-world
use case for the Quick command with data bit =3D 1. So what problem are
you trying to solve exactly?

--=20
Jean Delvare
