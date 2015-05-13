From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: axxia: Add bus recovery functionality
Date: Wed, 13 May 2015 08:55:49 +0200
Message-ID: <20150513065549.GG28888@pengutronix.de>
References: <553F7B11.5000204@nokia.com>
 <20150512191211.GC4449@schokonusskuchen.bad>
 <5552ED0F.7000200@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5552ED0F.7000200-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wilshire Jay <jay.wilshire.ext-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Lawnick Michael <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 13, 2015 at 08:19:59AM +0200, Michael Lawnick wrote:
> Am 12.05.2015 um 21:12 schrieb Wolfram Sang:
> >Doesn't look right. -EAGAIN means arbitration lost which is not a
> >condition to reset the bus in a multi-master setup.
>=20
> IMHO in multi-master scenario bus recovery is never save. There is
> need of higher level synchronization to find out whether any master
> is active.
Right. But you might be lucky and it's ok when done on error conditions
like "sda is low since 300 ms". But on arbitration loss it's definitely
wrong. Consider two masters where one resets the bus while the other
does a transfer. That results in a arbitration loss for the latter. So
the latter resets the bus and in the meantime the first one does a tran=
sfer
now that the bus should be free. You see the loop?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
