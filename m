From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 1/1] Remove suspend/resume functionality, add dynamic
	clocking
Date: Thu, 26 Nov 2009 10:41:07 +0000
Message-ID: <20091126104107.GA2393@n2100.arm.linux.org.uk>
References: <083DF309106F364B939360100EC290F804F55C9225@eu1rdcrdc1wx030.exi.nxp.com> <20091126090252.GB12179@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091126090252.GB12179-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 26, 2009 at 10:02:52AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> can you please add something like "i2c-pnx: " to the subject?
> (Actually it's a great strategy *not* to put it into the Subject.  Th=
is
> way it attracts far more attention :-)
>=20
> > Remove suspend/resume functionality, I2C driver gates clock on
> > only when an I2C transaction is in progress
> What happens when the machine suspends while a transfer is in progres=
s?
> (This might be a problem that already existed before.)  If this is
> really a problem the easiest "fix" is to let the suspend callback ret=
urn
> -EBUSY in this case.

If it's a short-lived event (i2c transfers tend to be) the best thing i=
s
to wait for the event to complete before continuing.  Most of the suspe=
nd
callbacks (except the noirq versions) are called in process context and
can sleep.

Returning -EBUSY means you abort the suspend entirely and it has to be
started again from the beginning.  Too bad if the suspend request was
because your battery was just ab............
