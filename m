From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] i2c: Not all adapters have a parent
Date: Thu, 10 Oct 2013 09:45:04 +0200
Message-ID: <1381391104.4352.90.camel@chaos.site>
References: <20131010080406.3e0fd78e@endymion.delvare>
	 <20131010073529.GA2638@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131010073529.GA2638@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram, Mika,

Le Thursday 10 October 2013 =C3=A0 09:35 +0200, Wolfram Sang a =C3=A9cr=
it :
> On Thu, Oct 10, 2013 at 08:04:06AM +0200, Jean Delvare wrote:
> > The code in acpi_i2c_register_devices() assumes that all i2c adapte=
rs
> > have a parent. This is not necessarily the case, for example the
> > i2c-stub driver instantiate a virtual i2c adapter without a parent.
> > Check for this to avoid a NULL pointer deference.
> >=20
> > Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
>=20
> Applied to for-current with stable tag, thanks!

I don't hit the bug on 3.11. Looking at the code, before it was moved i=
n
3.12-rc1, acpi_i2c_register_devices() was only called explicitly from
i2c-designware. So the fix doesn't actually need to go to stable.

--=20
Jean Delvare
Suse L3 Support
