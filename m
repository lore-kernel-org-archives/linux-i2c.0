From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: How should dev_[gs]et_drvdata be used?
Date: Fri, 28 Nov 2014 15:04:01 +0100
Message-ID: <20141128140401.GD4431@pengutronix.de>
References: <20130123174204.00463f98@endymion.delvare>
 <2690400.fFjCFlrrIR@al>
 <1387820241.30327.105.camel@bling.home>
 <1716344.EUMSGCAAKK@al>
 <20140108142849.3993341c@endymion.delvare>
 <20141125211432.GA6008@pengutronix.de>
 <20141128144813.3e6fd8d9@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141128144813.3e6fd8d9-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Peter Wu <lekensteyn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Martin Mokrejs <mmokrejs-08dBlVkRsZWoiTQjSSYKZesEoJ4y9sgM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Fri, Nov 28, 2014 at 02:48:13PM +0100, Jean Delvare wrote:
> On Tue, 25 Nov 2014 22:14:32 +0100, Uwe Kleine-K=F6nig wrote:
> > On Wed, Jan 08, 2014 at 02:28:49PM +0100, Jean Delvare wrote:
> > > Having looked at the code in deeper detail, I think I understand =
what
> > > is going on. The problem is with:
> > >=20
> > > 	i2c_set_adapdata(&priv->adapter, priv);
> > >=20
> > > at the beginning of i801_probe(). It triggers the allocation of d=
ev->p
> > > by the driver core. If we bail out at any point before i2c_add_ad=
apter
> > > (and subsequently device_register) is called, then that memory is=
 never
> > > freed.
> > >=20
> > > Unfortunately it is not possible to move the i2c_set_adapdata() c=
all
> > > after i2c_add_adapter(), because the data pointer is needed by co=
de
> > > which runs as part of i2c_add_adapter().
> > >=20
> > > We could move it right before the call to i2c_add_adapter(), to m=
ake
> > > the problem window smaller, but this wouldn't solve the problem
> > > completely, as i2c_add_adapter() itself can fail before
> > > device_register() is called.
> > >=20
> > > The only solution I can think of at this point is to stop using
> > > i2c_set_adapdata() altogether, and use i2c_adapter.algo_data inst=
ead:
> > >=20
> > > From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > > Subject: i2c-i801: Use i2c_adapter.algo_data
> > >=20
> > > Use i2c_adapter.algo_data instead of i2c_set/get_adapdata(). The
> > > latter makes use of the driver core's private data mechanism, whi=
ch
> > > allocates memory. That memory is never released if an error happe=
ns
> > > between the call to i2c_set_adapdata() and the actual i2c_adapter
> > > registration.
> >
> > Since commit 1bb6c08abfb6 (which makes the driver core use a pointe=
r in
> > struct device again for dev_set_drvdata; went into v3.16-rc1) this =
patch
> > is obsolete, right?
>=20
> Correct. It was never applied upstream anyway, which is good as I nev=
er
> liked it.
I came back to it as it was still in the linux-i2c patchwork queue.
It is set to be superseeded now.

> > (Still there might be the opportunity for a few patches converting =
all
> > driver to i2c_set_adapdata and then drop adapter.algo_data.)
>=20
> That's at least 35 bus drivers that would have to be converted then.
> But you should first check if it is possible to get rid of
> i2c_adapter.algo_data without breaking i2c-algo-bit and i2c-mux. If n=
ot
> then converting the bus drivers would really only be a minor cleanup
> with no real benefit (not saying it's not worth it though.)
Yeah. I'm not sure I will address this cleanup, but will keep your hint
on my radar.

Best regards and thanks for your reply,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
