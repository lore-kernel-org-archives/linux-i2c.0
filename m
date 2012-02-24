From: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c: Add Device Tree support to versatile-i2c
 driver
Date: Fri, 24 Feb 2012 14:52:43 +0000
Message-ID: <1330095163.2579.2.camel@hornet.cambridge.arm.com>
References: <1330021041-29782-1-git-send-email-pawel.moll@arm.com>
	 <20120224105804.GA2479@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120224105804.GA2479-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 2012-02-24 at 10:58 +0000, Wolfram Sang wrote:
> > +static struct of_device_id i2c_versatile_match[] =3D {
> > +	{ .compatible =3D "arm,versatile-i2c", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, i2c_versatile_match);
>=20
> const here, but I fixed it up already.

Sure thing, thanks!

Pawe=C5=82
