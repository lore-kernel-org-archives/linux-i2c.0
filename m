From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: rk3x: add Kconfig dependency on COMMON_CLK
Date: Mon, 24 Nov 2014 10:59:55 +0100
Message-ID: <20141124095954.GR4431@pengutronix.de>
References: <1499103.qTrcqP28lh@typ>
 <20141124080509.GK4431@pengutronix.de>
 <20141124093116.GB3733@katana>
 <20141124093823.GN4431@pengutronix.de>
 <20141124095800.GE3733@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141124095800.GE3733@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 24, 2014 at 10:58:00AM +0100, Wolfram Sang wrote:
>=20
> > > Applied to for-next, thanks!
> > Just for me to learn: is your for-next stable once pushed?
>=20
> Nope, I push manually when I feel comfortable. That might change,
> though.
>=20
> > As you didn't push out yet, it's
> >=20
> > Fixes: 5a6f1566f6a0 ("i2c: rk3x: handle dynamic clock rate changes =
correctly")
>=20
> Actually, it is 249051f49907. I rebased my internal i2c/for-3.19 tree=
 to
> fix an authorship and merged that into i2c/for-next. For those reason=
s,
> my current policy is to use "Fixes:" only for commits which hit the
> linus-tree. I probably shouldn't do such things, but as long as I was
> working on my own, this worked pretty well ;)
If it's not stable you can even squash in the fix. In this case the
commit log drill was superfluous for this commit, but (hopefully) still
useful for the future.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
