From: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH 1/1] Remove suspend/resume functionality, add dynamic
	clocking
Date: Mon, 30 Nov 2009 18:02:04 +0100
Message-ID: <083DF309106F364B939360100EC290F804F5659CFF@eu1rdcrdc1wx030.exi.nxp.com>
References: <083DF309106F364B939360100EC290F804F55C9225@eu1rdcrdc1wx030.exi.nxp.com>
 <20091126090252.GB12179@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091126090252.GB12179-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



> Subject: Re: [PATCH 1/1] Remove suspend/resume functionality, add dyn=
amic
> clocking
>=20
> Hello,
>=20
> can you please add something like "i2c-pnx: " to the subject?
> (Actually it's a great strategy *not* to put it into the Subject.  Th=
is
> way it attracts far more attention :-)
>=20

Good point!

> > Remove suspend/resume functionality, I2C driver gates clock on
> > only when an I2C transaction is in progress
> What happens when the machine suspends while a transfer is in progres=
s?
> (This might be a problem that already existed before.)  If this is
> really a problem the easiest "fix" is to let the suspend callback ret=
urn
> -EBUSY in this case.

The suspend callback is now removed. It's actually not needed with this
change. The I2C clocks will turn on prior to a transaction and then tur=
n
off at the completion.

>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                              | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                    | http://www.pengutroni=
x.de/
> |
