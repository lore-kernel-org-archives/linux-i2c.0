From: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2] mach-pxa/viper: Fix timeout usage for I2C
Date: Tue, 20 Apr 2010 10:40:00 +0200
Message-ID: <201004201040.00739.marek.vasut@gmail.com>
References: <20100412213235.1688dda8@hyperion.delvare> <1271591309-22567-1-git-send-email-w.sang@pengutronix.de> <8d2bff4f5c4178f89e410edc702cd18f@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8d2bff4f5c4178f89e410edc702cd18f@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Paul Shen <paul.shen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dne =DAt 20. dubna 2010 10:27:00 Marc Zyngier napsal(a):
> On Sun, 18 Apr 2010 13:48:29 +0200, Wolfram Sang <w.sang@pengutronix.=
de>
>=20
> wrote:
> > The timeout value is in jiffies, so it should be using HZ, not a pl=
ain
> > number. Assume with HZ=3D100 '100' means 1s here and adapt accordin=
gly.
> >=20
> > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> > Cc: Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>
> > Cc: Paul Shen <paul.shen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> > Cc: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> > Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>=20
> Acked-by: Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>
>=20
> Eric, can you merge this directly via your -devel branch?
>=20
> Thanks,
>=20
>         M.

And possibly updating your git tree? There are a few patches in -next t=
hat will=20
need it's arm counterpart.

Cheers
