From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: How should dev_[gs]et_drvdata be used?
Date: Fri, 28 Nov 2014 14:48:13 +0100
Message-ID: <20141128144813.3e6fd8d9@endymion.delvare>
References: <20130123174204.00463f98@endymion.delvare>
	<2690400.fFjCFlrrIR@al>
	<1387820241.30327.105.camel@bling.home>
	<1716344.EUMSGCAAKK@al>
	<20140108142849.3993341c@endymion.delvare>
	<20141125211432.GA6008@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141125211432.GA6008-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Peter Wu <lekensteyn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Martin Mokrejs <mmokrejs-08dBlVkRsZWoiTQjSSYKZesEoJ4y9sgM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,

On Tue, 25 Nov 2014 22:14:32 +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Jan 08, 2014 at 02:28:49PM +0100, Jean Delvare wrote:
> > Having looked at the code in deeper detail, I think I understand wh=
at
> > is going on. The problem is with:
> >=20
> > 	i2c_set_adapdata(&priv->adapter, priv);
> >=20
> > at the beginning of i801_probe(). It triggers the allocation of dev=
->p
> > by the driver core. If we bail out at any point before i2c_add_adap=
ter
> > (and subsequently device_register) is called, then that memory is n=
ever
> > freed.
> >=20
> > Unfortunately it is not possible to move the i2c_set_adapdata() cal=
l
> > after i2c_add_adapter(), because the data pointer is needed by code
> > which runs as part of i2c_add_adapter().
> >=20
> > We could move it right before the call to i2c_add_adapter(), to mak=
e
> > the problem window smaller, but this wouldn't solve the problem
> > completely, as i2c_add_adapter() itself can fail before
> > device_register() is called.
> >=20
> > The only solution I can think of at this point is to stop using
> > i2c_set_adapdata() altogether, and use i2c_adapter.algo_data instea=
d:
> >=20
> > From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Subject: i2c-i801: Use i2c_adapter.algo_data
> >=20
> > Use i2c_adapter.algo_data instead of i2c_set/get_adapdata(). The
> > latter makes use of the driver core's private data mechanism, which
> > allocates memory. That memory is never released if an error happens
> > between the call to i2c_set_adapdata() and the actual i2c_adapter
> > registration.
>
> Since commit 1bb6c08abfb6 (which makes the driver core use a pointer =
in
> struct device again for dev_set_drvdata; went into v3.16-rc1) this pa=
tch
> is obsolete, right?

Correct. It was never applied upstream anyway, which is good as I never
liked it.

> (Still there might be the opportunity for a few patches converting al=
l
> driver to i2c_set_adapdata and then drop adapter.algo_data.)

That's at least 35 bus drivers that would have to be converted then.
But you should first check if it is possible to get rid of
i2c_adapter.algo_data without breaking i2c-algo-bit and i2c-mux. If not
then converting the bus drivers would really only be a minor cleanup
with no real benefit (not saying it's not worth it though.)

> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Cc: Peter Wu <lekensteyn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-i801.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > --- a/drivers/i2c/busses/i2c-i801.c
> > +++ b/drivers/i2c/busses/i2c-i801.c
> > @@ -671,7 +671,7 @@ static s32 i801_access(struct i2c_adapte
> >  	int hwpec;
> >  	int block =3D 0;
> >  	int ret, xact =3D 0;
> > -	struct i801_priv *priv =3D i2c_get_adapdata(adap);
> > +	struct i801_priv *priv =3D adap->algo_data;
> > =20
> >  	hwpec =3D (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CL=
IENT_PEC)
> >  		&& size !=3D I2C_SMBUS_QUICK
> > @@ -774,7 +774,7 @@ static s32 i801_access(struct i2c_adapte
> > =20
> >  static u32 i801_func(struct i2c_adapter *adapter)
> >  {
> > -	struct i801_priv *priv =3D i2c_get_adapdata(adapter);
> > +	struct i801_priv *priv =3D adapter->algo_data;
> > =20
> >  	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
> >  	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
> > @@ -1117,7 +1117,7 @@ static int i801_probe(struct pci_dev *de
> >  	if (!priv)
> >  		return -ENOMEM;
> > =20
> > -	i2c_set_adapdata(&priv->adapter, priv);
> > +	priv->adapter.algo_data =3D priv;
> >  	priv->adapter.owner =3D THIS_MODULE;
> >  	priv->adapter.class =3D i801_get_adapter_class(priv);
> >  	priv->adapter.algo =3D &smbus_algorithm;
> >=20
> > I can't think of any drawback, other than the feeling that switchin=
g
> > from a generic implementation to a specific one is a move in the wr=
ong
> > direction.
> >=20
> > If the above is the proper fix then we may consider just changing t=
he
> > implementation of i2c_set/get_adapdata to use adapter.algo_data ins=
tead
> > of calling dev_set/get_drvdata(). This would let us fix all the dri=
vers
> > at once.
> >=20
> > I'll bring the topic upstream for discussion.

--=20
Jean Delvare
SUSE L3 Support
