From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c: rk3x: add Kconfig dependency on COMMON_CLK
Date: Mon, 24 Nov 2014 10:50:28 +0100
Message-ID: <20141124095028.GP4431@pengutronix.de>
References: <1433526.P5A9cIEu1z@typ>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433526.P5A9cIEu1z@typ>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 24, 2014 at 10:46:25AM +0100, Max Schwarz wrote:
> Fixes: 5a6f1566f6a0 ("i2c: rk3x: handle dynamic clock rate changes co=
rrectly")
This line usually goes into the S-o-B block below. So maybe:

Commit 5a6f1566f6a0 ("i2c: rk3x: handle dynamic clock rate changes
correctly") introduced a dependency ...

and then the Fixes line above your S-o-b.

>=20
> which introduced a dependency on clock rate notifiers. Now we get com=
piler
> errors if compiled without COMMON_CLK:
>=20
> drivers/i2c/busses/i2c-rk3x.c: In function 'rk3x_i2c_clk_notifier_cb'=
:
> drivers/i2c/busses/i2c-rk3x.c:634:7: error: 'PRE_RATE_CHANGE' undecla=
red (first use in this function)
> [...]
>=20
> But the driver has always depended on COMMON_CLK even if it compiled
>  - in fact it fails to probe without it. So add that as a Kconfig
> dependency.
>=20
> Signed-off-by: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
> ---
>=20
> Wolfram,
>=20
> here is a version with better commit msg in case you still want to ta=
ke that
> instead of my quick fix.
Thanks for your quick turn around.

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
