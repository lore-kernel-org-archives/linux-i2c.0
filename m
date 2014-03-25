From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3] i2c: new bus driver for efm32
Date: Tue, 25 Mar 2014 07:01:54 -0700
Message-ID: <1395756114.3010.16.camel@joe-AO722>
References: <1395414236-22647-1-git-send-email-u.kleine-koenig@pengutronix.de>
	 <20140324170131.GB7524@katana> <20140325090700.GL23076@pengutronix.de>
	 <20140325091148.GA2570@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140325091148.GA2570@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Whitcroft <apw-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2014-03-25 at 10:11 +0100, Wolfram Sang wrote:
> On Tue, Mar 25, 2014 at 10:07:00AM +0100, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Mon, Mar 24, 2014 at 06:01:31PM +0100, Wolfram Sang wrote:
> > > And checkpatch said:
> > >=20
> > > WARNING: braces {} are not necessary for any arm of this statemen=
t
> > > #345: FILE: drivers/i2c/busses/i2c-efm32.c:239:
> > > +		if (cur_msg->flags & I2C_M_RD) {
> > > ...
> > hmm the whole block reads:
> >=20
> >         case REG_STATE_STATE_DATA:
> >                 if (cur_msg->flags & I2C_M_RD) {
> >                         efm32_i2c_recv_next_byte(ddata);
> >                 } else {
> >                         /* wait for Ack or Nack of slave */
> >                 }
> >                 break;
> >=20
> > so just removing the braces does the wrong thing. Is this a false
> > positive checkpatch warning? Andy? Joe?
> >=20
> > I can make it:
> >=20
> > 		if (cur_msg->flags & I2C_M_RD)
> > 			efm32_i2c_recv_next_byte(ddata);
> > 		/* in the write case wait for Ack or Nack of slave */
> >=20
> > but I consider the version above more readable.
>=20
> Well, OK, I let you decide.

A Semi-Positive I think.

I think your first block is more readable myself.

Adding a semicolon would shut checkpatch up and it's
debatable whether it might be better too.

	if (foo) {
		bar();
	} else {
		/* single line comment */
		;
	}

But please feel free to ignore any checkpatch warning
where your taste is better than its.

checkpatch is brainless, you're not.
