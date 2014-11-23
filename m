From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: slave-eeprom: add eeprom simulator driver
Date: Sun, 23 Nov 2014 19:52:00 +0100
Message-ID: <20141123185200.GD4431@pengutronix.de>
References: <1416326695-13083-1-git-send-email-wsa@the-dreams.de>
 <1416326695-13083-3-git-send-email-wsa@the-dreams.de>
 <20141121071941.GK27002@pengutronix.de>
 <20141121141624.GT27002@pengutronix.de>
 <20141122181406.GC9698@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141122181406.GC9698@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hallo Wolfram,

On Sat, Nov 22, 2014 at 07:14:06PM +0100, Wolfram Sang wrote:
> > > > +	case I2C_SLAVE_REQ_READ_END:
> > > > +		eeprom->buffer_idx++;
> > > You don't check here for buffer_idx >=3D ARRAY_SIZE(buffer)?
> > > Ditto in the I2C_SLAVE_REQ_WRITE_END case.
> > I just noticed that buffer_idx is an u8, so it overflows at 255+1. =
So
> > the probe routine should error out if size is bigger than 256.
>=20
> But size is currently fixed to 256, so all is fine. Yes, if we extend=
 it
> for bigger sizes, all that stuff needs to be taken care of, right.
yeah, it's well hidden, but true. So IMHO worth a comment.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
