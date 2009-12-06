From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/1] Remove suspend/resume functionality, add dynamic
	clocking
Date: Sun, 6 Dec 2009 22:02:25 +0100
Message-ID: <20091206210225.GA20887@pengutronix.de>
References: <083DF309106F364B939360100EC290F804F55C9225@eu1rdcrdc1wx030.exi.nxp.com> <20091126090252.GB12179@pengutronix.de> <083DF309106F364B939360100EC290F804F5659CFF@eu1rdcrdc1wx030.exi.nxp.com> <20091206084731.GE2766@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091206084731.GE2766-+ZI9xUNit7I@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Sun, Dec 06, 2009 at 09:47:31AM +0100, Pavel Machek wrote:
> Hi!
>=20
> > > Subject: Re: [PATCH 1/1] Remove suspend/resume functionality, add=
 dynamic
> > > clocking
> > >=20
> > > Hello,
> > >=20
> > > can you please add something like "i2c-pnx: " to the subject?
> > > (Actually it's a great strategy *not* to put it into the Subject.=
  This
> > > way it attracts far more attention :-)
> > >=20
> >=20
> > Good point!
> >=20
> > > > Remove suspend/resume functionality, I2C driver gates clock on
> > > > only when an I2C transaction is in progress
> > > What happens when the machine suspends while a transfer is in pro=
gress?
> > > (This might be a problem that already existed before.)  If this i=
s
> > > really a problem the easiest "fix" is to let the suspend callback=
 return
> > > -EBUSY in this case.
> >=20
> > The suspend callback is now removed. It's actually not needed with =
this
> > change. The I2C clocks will turn on prior to a transaction and then=
 turn
> > off at the completion.
>=20
> Are you sure its unneeded? What if someone attempts to suspend the
> system when a transaction is running?
That's exactly my question.  I think the machine will suspend and the
transaction fail.  So no suspend callback isn't optimal, but maybe OK?!

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
