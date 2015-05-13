From: Michael Lawnick <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: axxia: Add bus recovery functionality
Date: Wed, 13 May 2015 09:20:48 +0200
Message-ID: <5552FB50.4000409@nokia.com>
References: <553F7B11.5000204@nokia.com> <20150512191211.GC4449@schokonusskuchen.bad> <5552ED0F.7000200@gmx.de> <20150513065549.GG28888@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150513065549.GG28888-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?windows-1252?Q?ext_Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wilshire Jay <jay.wilshire.ext-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Am 13.05.2015 um 08:55 schrieb ext Uwe Kleine-K=F6nig:
> On Wed, May 13, 2015 at 08:19:59AM +0200, Michael Lawnick wrote:
>> Am 12.05.2015 um 21:12 schrieb Wolfram Sang:
>>> Doesn't look right. -EAGAIN means arbitration lost which is not a
>>> condition to reset the bus in a multi-master setup.
>>
>> IMHO in multi-master scenario bus recovery is never save. There is
>> need of higher level synchronization to find out whether any master
>> is active.
> Right. But you might be lucky and it's ok when done on error conditio=
ns
> like "sda is low since 300 ms". But on arbitration loss it's definite=
ly
> wrong. Consider two masters where one resets the bus while the other
> does a transfer. That results in a arbitration loss for the latter. S=
o
> the latter resets the bus and in the meantime the first one does a tr=
ansfer
> now that the bus should be free. You see the loop?

Of course.
The question is: do/can controllers properly distinguish between=20
arbitration loss and permanent SDL low? I always worked with single=20
master assumption in last 10 years and /feel/ /to/ /remember/ to have=20
observed situations were bus lock was signaled as arbitration loss.

I'm simply in doubt that multi master can be handled at driver level at=
=20
all. This might mean in consequence that unlocking the bus should not b=
e=20
done automatically, but by an extra I2C method triggered by application=
=20
level.
--=20
JM2C
Michael
