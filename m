From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c/pxa: only define 'blue_murder'-function if
	DEBUG is #defined
Date: Sun, 18 Apr 2010 14:45:02 +0100
Message-ID: <20100418134502.GA15452@n2100.arm.linux.org.uk>
References: <20100224110044.GB15181@pengutronix.de> <1267009306-17227-2-git-send-email-u.kleine-koenig@pengutronix.de> <20100228155502.GB16745@n2100.arm.linux.org.uk> <20100418132251.GB21364@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100418132251.GB21364-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Apr 18, 2010 at 03:22:51PM +0200, Wolfram Sang wrote:
>=20
> Sorry to bump this old thread, it dropped off my todo-list :(
>=20
> On Sun, Feb 28, 2010 at 03:55:02PM +0000, Russell King - ARM Linux wr=
ote:
> > On Wed, Feb 24, 2010 at 12:01:45PM +0100, Uwe Kleine-K=F6nig wrote:
> > > From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > >=20
> > > This talkative function is also called on timeouts. As timeouts c=
an
> > > happen on regular writes to EEPROMs (no error case), this creates=
 false
> > > positives.  Giving lots of details is interesting only for develo=
pers
> > > anyhow, so just use the function if DEBUG is #defined.
> >=20
> > Are you sure this is safe?  If you time out the write before it com=
pletes,
> > how do you know if the write was successful?
> >=20
> > I don't think this is "no error code" nor "false positive".  If the=
 timeout
> > is too short for your EEPROMs, then the timeout needs to be increas=
ed.
>=20
> I am sure this is safe because we have retries. The eeprom driver fir=
st tries
> to write data without a delay, because EEPROMs often have buffers. On=
ce the
> buffers are full, the chip will not answer to the next write request =
which will
> result in a timeout for this write request. This is expected, so it w=
ill be
> retried after some delay. Something like -EBUSY. Only if another "out=
er"
> timeout passed after some retries, then we have a problem and this sh=
ould be
> user visible. But the timeout for the write request is nothing except=
ional and
> the user doesn't need to be informed about it, especially not in this=
 detail.
> This is what the patch is addressing.

And what if it's not an EEPROM that you're talking to?
