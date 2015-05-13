From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: axxia: Add bus recovery functionality
Date: Wed, 13 May 2015 09:54:52 +0200
Message-ID: <20150513075452.GJ28888@pengutronix.de>
References: <553F7B11.5000204@nokia.com>
 <20150512191211.GC4449@schokonusskuchen.bad>
 <5552ED0F.7000200@gmx.de>
 <20150513065549.GG28888@pengutronix.de>
 <5552FB50.4000409@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5552FB50.4000409-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wilshire Jay <jay.wilshire.ext-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Wed, May 13, 2015 at 09:20:48AM +0200, Michael Lawnick wrote:
> Am 13.05.2015 um 08:55 schrieb ext Uwe Kleine-K=F6nig:
> >On Wed, May 13, 2015 at 08:19:59AM +0200, Michael Lawnick wrote:
> >>Am 12.05.2015 um 21:12 schrieb Wolfram Sang:
> >>>Doesn't look right. -EAGAIN means arbitration lost which is not a
> >>>condition to reset the bus in a multi-master setup.
> >>
> >>IMHO in multi-master scenario bus recovery is never save. There is
> >>need of higher level synchronization to find out whether any master
> >>is active.
> >Right. But you might be lucky and it's ok when done on error conditi=
ons
> >like "sda is low since 300 ms". But on arbitration loss it's definit=
ely
> >wrong. Consider two masters where one resets the bus while the other
> >does a transfer. That results in a arbitration loss for the latter. =
So
> >the latter resets the bus and in the meantime the first one does a t=
ransfer
> >now that the bus should be free. You see the loop?
>=20
> Of course.
> The question is: do/can controllers properly distinguish between
> arbitration loss and permanent SDL low? I always worked with single
> master assumption in last 10 years and /feel/ /to/ /remember/ to
> have observed situations were bus lock was signaled as arbitration
> loss.
yeah, that might be true for some (or even most) controllers. Still fro=
m
a high-level view "arbitration lost" means the controller started the
transfer and in the middle observed a low SDA while it doesn't pull it
low. If SDA is stuck low instead the controller cannot even put a start
condition on the bus.

> I'm simply in doubt that multi master can be handled at driver level
> at all. This might mean in consequence that unlocking the bus should
> not be done automatically, but by an extra I2C method triggered by
> application level.
At least it should not automatically triggered on error conditions that
might result from another master on the bus. IMHO doing it once at prob=
e
time and then only when SDA is stuck low for say 1s should be fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
