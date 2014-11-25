From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: How should dev_[gs]et_drvdata be used?
Date: Tue, 25 Nov 2014 22:14:32 +0100
Message-ID: <20141125211432.GA6008@pengutronix.de>
References: <20130123174204.00463f98@endymion.delvare>
 <2690400.fFjCFlrrIR@al>
 <1387820241.30327.105.camel@bling.home>
 <1716344.EUMSGCAAKK@al>
 <20140108142849.3993341c@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140108142849.3993341c-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Peter Wu <lekensteyn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Martin Mokrejs <mmokrejs-08dBlVkRsZWoiTQjSSYKZesEoJ4y9sgM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Jean,

[not stripping the quotes as the thread is already old]

On Wed, Jan 08, 2014 at 02:28:49PM +0100, Jean Delvare wrote:
> On Tue, 24 Dec 2013 01:18:03 +0100, Peter Wu wrote:
> > On Monday 23 December 2013 10:37:21 Alex Williamson wrote:
> > > On Mon, 2013-12-23 at 16:49 +0100, Peter Wu wrote:
> > [..]
> > > >=20
> > > > There is still one thing I do not fully understand, how should
> > > > dev_set_drvdata and dev_get_drvdata be used? For the devices pa=
ssed
> > > > to probe functions, the core takes care of setting to NULL on e=
rror.
> > > > Then device_unregister frees the memory, right?
> > > >=20
> > > > Now, what if the dev_set_drvdata (or aliases such as pci_set_dr=
vdata,
> > > > i2c_set_adapinfo, etc.) are manually called outside probe funct=
ions?
>=20
> FWIW I don't think this is supposed to happen.
>=20
> > > > Or inside the probe function, but not for the device that is be=
ing
> > > > probed (such as is the case with the i801 i2c driver)?
>=20
> This OTOH does happen. Is suspect any driver which instantiates class
> devices will do exactly that. It's nothing i2c specific. For example
> media drivers call video_set_drvdata() in their probe functions.
>=20
> > (...)
> > Clear examples of how to use dev_{s,g}et_drvdata correctly in i2c i=
s
> > still wanted. I stepped in it yesterday, i2c seems to have its own
> > way to register new devices.
>=20
> What makes you think so? It's as standard as I can imagine.
>=20
> > More specifically, how can the memory
> > associated with dev_set_drvdata be free'd on error paths if the
> > device is not registered with device_register (as is done in the
> > probe function of the i801 i2c driver)?
>=20
> There are two pieces of data to consider here. The data structure whi=
ch
> is pointed to by dev_get_drvdata (or i2c_get_adapdata) is allocated
> explicitly by the driver and must be freed explicitly by the driver
> (unless devm_kzalloc is used, in which case the cleanup is automatic)=
=2E
>=20
> The data structure used internally by the driver core (dev->p) is
> allocated transparently and is thus the core's responsibility to free=
=2E
> I remember looking into this some time ago after someone reported a
> possible memleak to me, and was not fully convinced that the core was
> properly releasing dev->p in all cases. This may be the same problem
> you are looking at right now.
>=20
> I do not understand your claim that i2c_adapter class devices are not
> registered with device_register. I2c bus drivers such as i2c-i801 cal=
l
> i2c_add_adapter(), which calls i2c_register_adapter(), which calls
> device_register().
>=20
> Having looked at the code in deeper detail, I think I understand what
> is going on. The problem is with:
>=20
> 	i2c_set_adapdata(&priv->adapter, priv);
>=20
> at the beginning of i801_probe(). It triggers the allocation of dev->=
p
> by the driver core. If we bail out at any point before i2c_add_adapte=
r
> (and subsequently device_register) is called, then that memory is nev=
er
> freed.
>=20
> Unfortunately it is not possible to move the i2c_set_adapdata() call
> after i2c_add_adapter(), because the data pointer is needed by code
> which runs as part of i2c_add_adapter().
>=20
> We could move it right before the call to i2c_add_adapter(), to make
> the problem window smaller, but this wouldn't solve the problem
> completely, as i2c_add_adapter() itself can fail before
> device_register() is called.
>=20
> The only solution I can think of at this point is to stop using
> i2c_set_adapdata() altogether, and use i2c_adapter.algo_data instead:
>=20
> From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Subject: i2c-i801: Use i2c_adapter.algo_data
>=20
> Use i2c_adapter.algo_data instead of i2c_set/get_adapdata(). The
> latter makes use of the driver core's private data mechanism, which
> allocates memory. That memory is never released if an error happens
> between the call to i2c_set_adapdata() and the actual i2c_adapter
> registration.
Since commit 1bb6c08abfb6 (which makes the driver core use a pointer in
struct device again for dev_set_drvdata; went into v3.16-rc1) this patc=
h
is obsolete, right?

(Still there might be the opportunity for a few patches converting all
driver to i2c_set_adapdata and then drop adapter.algo_data.)

Best regards
Uwe

> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Peter Wu <lekensteyn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-i801.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -671,7 +671,7 @@ static s32 i801_access(struct i2c_adapte
>  	int hwpec;
>  	int block =3D 0;
>  	int ret, xact =3D 0;
> -	struct i801_priv *priv =3D i2c_get_adapdata(adap);
> +	struct i801_priv *priv =3D adap->algo_data;
> =20
>  	hwpec =3D (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIE=
NT_PEC)
>  		&& size !=3D I2C_SMBUS_QUICK
> @@ -774,7 +774,7 @@ static s32 i801_access(struct i2c_adapte
> =20
>  static u32 i801_func(struct i2c_adapter *adapter)
>  {
> -	struct i801_priv *priv =3D i2c_get_adapdata(adapter);
> +	struct i801_priv *priv =3D adapter->algo_data;
> =20
>  	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
>  	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
> @@ -1117,7 +1117,7 @@ static int i801_probe(struct pci_dev *de
>  	if (!priv)
>  		return -ENOMEM;
> =20
> -	i2c_set_adapdata(&priv->adapter, priv);
> +	priv->adapter.algo_data =3D priv;
>  	priv->adapter.owner =3D THIS_MODULE;
>  	priv->adapter.class =3D i801_get_adapter_class(priv);
>  	priv->adapter.algo =3D &smbus_algorithm;
>=20
> I can't think of any drawback, other than the feeling that switching
> from a generic implementation to a specific one is a move in the wron=
g
> direction.
>=20
> If the above is the proper fix then we may consider just changing the
> implementation of i2c_set/get_adapdata to use adapter.algo_data inste=
ad
> of calling dev_set/get_drvdata(). This would let us fix all the drive=
rs
> at once.
>=20
> I'll bring the topic upstream for discussion.
>=20
> --=20
> Jean Delvare

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
