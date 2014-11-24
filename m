From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: rk3x: add Kconfig dependency on COMMON_CLK
Date: Mon, 24 Nov 2014 10:38:23 +0100
Message-ID: <20141124093823.GN4431@pengutronix.de>
References: <1499103.qTrcqP28lh@typ>
 <20141124080509.GK4431@pengutronix.de>
 <20141124093116.GB3733@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141124093116.GB3733@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hey Wolfram,

On Mon, Nov 24, 2014 at 10:31:16AM +0100, Wolfram Sang wrote:
> On Mon, Nov 24, 2014 at 09:05:09AM +0100, Uwe Kleine-K=F6nig wrote:
> > Hello Max,
> >=20
> > On Mon, Nov 24, 2014 at 01:32:27AM +0100, Max Schwarz wrote:
> > > Now that we are using the clk notifier framework we get compile e=
rrors
> > > without COMMON_CLK. But the driver fails to probe without COMMON_=
CLK
> > > anyways, so just add that as a Kconfig dependency.
> > Hmm, I wonder how a kernel that fails to compile can even start pro=
bing
> > ... :-)
> >=20
> > Anyhow, it would be nice to quote the compiler error you fix here a=
nd
> > point out the patch that failed to add the needed dependency.
>=20
> Yes, that would be perfect. But for fixing the breakage in linux-next=
 we
> created, this is good enough for me.
>=20
> Applied to for-next, thanks!
Just for me to learn: is your for-next stable once pushed?

As you didn't push out yet, it's

=46ixes: 5a6f1566f6a0 ("i2c: rk3x: handle dynamic clock rate changes co=
rrectly")

party on,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
