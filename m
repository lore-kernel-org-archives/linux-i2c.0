From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c: add FUNC flag for slave capabilities
Date: Sat, 16 May 2015 11:27:31 +0200
Message-ID: <20150516092731.GU28888@pengutronix.de>
References: <1431607205-2316-1-git-send-email-wsa@the-dreams.de>
 <1431607205-2316-2-git-send-email-wsa@the-dreams.de>
 <20150515113744.GS28888@pengutronix.de>
 <20150516082216.GA4014@schokonusskuchen.bad>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150516082216.GA4014-oo5tB6JMkjKRinMKxDlMNPwbnWRJjS81@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

On Sat, May 16, 2015 at 10:22:16AM +0200, Wolfram Sang wrote:
> On Fri, May 15, 2015 at 01:37:44PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Thu, May 14, 2015 at 02:40:02PM +0200, Wolfram Sang wrote:
> > > From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
> > >=20
> > > So users can check in advance if there is slave support.
> > I wonder if the core should check if .{,un}reg_slave is !=3D NULL a=
nd
> > automatically set this bit accordingly.
>=20
> I thought about this, too, but decided against it. Maybe some driver
> doesn't want to make its slave interface public because it is
> specialized for one use-case only (thinking ECs here)? Also, doing it
Hmm, I'd not say this is a valid reason. Sounds like policy in the
kernel?!

Does the framework check for the slave support flag before binding a
slave to the controler? I assume that not, but wonder if it should.

> would be a little inconsistent, since we could do the same for
> I2C_FUNC_I2C when master_xfer is populated. So, let's start simple I'=
d
> say.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
