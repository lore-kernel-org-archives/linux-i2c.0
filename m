From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c/pxa: only define 'blue_murder'-function if
	DEBUG is #defined
Date: Mon, 22 Mar 2010 22:02:04 +0100
Message-ID: <20100322210204.GB10157@pengutronix.de>
References: <20100224110044.GB15181@pengutronix.de> <1267009306-17227-2-git-send-email-u.kleine-koenig@pengutronix.de> <20100228155502.GB16745@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100228155502.GB16745-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Sun, Feb 28, 2010 at 03:55:02PM +0000, Russell King - ARM Linux wrot=
e:
> On Wed, Feb 24, 2010 at 12:01:45PM +0100, Uwe Kleine-K=F6nig wrote:
> > From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> >=20
> > This talkative function is also called on timeouts. As timeouts can
> > happen on regular writes to EEPROMs (no error case), this creates f=
alse
> > positives.  Giving lots of details is interesting only for develope=
rs
> > anyhow, so just use the function if DEBUG is #defined.
>=20
> Are you sure this is safe?  If you time out the write before it compl=
etes,
> how do you know if the write was successful?
>=20
> I don't think this is "no error code" nor "false positive".  If the t=
imeout
> is too short for your EEPROMs, then the timeout needs to be increased=
=2E
any thoughts about this by you?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
