From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] [ARM] i2c/pxa: remove unused macro
Date: Wed, 4 Nov 2009 10:00:59 +0100
Message-ID: <20091104090059.GB23889@pengutronix.de>
References: <1257275000-18866-1-git-send-email-u.kleine-koenig@pengutronix.de> <20091103210115.GA24955@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091103210115.GA24955-f404yB8NqCZvn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Tue, Nov 03, 2009 at 09:01:15PM +0000, Russell King wrote:
> On Tue, Nov 03, 2009 at 08:03:19PM +0100, Uwe Kleine-K=F6nig wrote:
> > Commit
> >=20
> > 	beea494 ([ARM] Remove EEPROM slave emulation from i2c-pxa driver.)
>=20
> Oh great.  Some people may remember the LX code that I submitted to
> the mailing list a while back.  Removing the slave emulation buggers
> that platform up.  I do intend to submit that once the issue of where
> the PCON support should be located is resolved - which is still
> pending.
>=20
> Please revert this change, thanks.
"this" means beea494 or my patch?  I'm unsure because you (Russell) are
the author of beea494.

The main reason for this series was the 2nd patch.  While creating it I
noticed that eedbg was unused.

=46or this second patch (only defining i2c_pxa_scream_blue_murder if DE=
BUG
is #defined) should I rebase it to beea494^ or should I revert beea494
and put it on top of the reverted beea494?

Thanks
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
