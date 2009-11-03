From: Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 1/2] [ARM] i2c/pxa: remove unused macro
Date: Tue, 3 Nov 2009 21:01:15 +0000
Message-ID: <20091103210115.GA24955@flint.arm.linux.org.uk>
References: <1257275000-18866-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1257275000-18866-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 03, 2009 at 08:03:19PM +0100, Uwe Kleine-K=F6nig wrote:
> Commit
>=20
> 	beea494 ([ARM] Remove EEPROM slave emulation from i2c-pxa driver.)

Oh great.  Some people may remember the LX code that I submitted to
the mailing list a while back.  Removing the slave emulation buggers
that platform up.  I do intend to submit that once the issue of where
the PCON support should be located is resolved - which is still
pending.

Please revert this change, thanks.

--=20
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
