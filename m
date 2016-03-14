From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] i2c: i2c-core: do not use bus internal data
Date: Mon, 14 Mar 2016 10:27:54 +0100
Message-ID: <20160314092754.GB27975@ulmo>
References: <1457351357-13457-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20160314091819.GA27975@ulmo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35819 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbcCNJ15 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Mar 2016 05:27:57 -0400
Content-Disposition: inline
In-Reply-To: <20160314091819.GA27975@ulmo>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, gregkh@linuxfoundation.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 14, 2016 at 10:18:19AM +0100, Thierry Reding wrote:
> On Mon, Mar 07, 2016 at 05:19:17PM +0530, Sudip Mukherjee wrote:
> > The variable p is a data structure which is used by the driver core
> > internally and it is not expected that busses will be directly accessing
> > these driver core internal only data.
> >=20
> > Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> > ---
> >=20
> > Reference of Greg's comment about it at:
> > https://lkml.org/lkml/2016/3/5/171
> >=20
> >  drivers/i2c/i2c-core.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index 2949ab3..2f31fb5 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -73,6 +73,7 @@ static struct device_type i2c_client_type;
> >  static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *=
driver);
> > =20
> >  static struct static_key i2c_trace_msg =3D STATIC_KEY_INIT_FALSE;
> > +static bool is_registered;
> > =20
> >  void i2c_transfer_trace_reg(void)
> >  {
> > @@ -1529,7 +1530,7 @@ static int i2c_register_adapter(struct i2c_adapte=
r *adap)
> >  	int res =3D 0;
> > =20
> >  	/* Can't register until after driver model init */
> > -	if (unlikely(WARN_ON(!i2c_bus_type.p))) {
> > +	if (unlikely(WARN_ON(!is_registered))) {
> >  		res =3D -EAGAIN;
> >  		goto out_list;
> >  	}
> > @@ -1926,7 +1927,7 @@ int i2c_register_driver(struct module *owner, str=
uct i2c_driver *driver)
> >  	int res;
> > =20
> >  	/* Can't register until after driver model init */
> > -	if (unlikely(WARN_ON(!i2c_bus_type.p)))
> > +	if (unlikely(WARN_ON(!is_registered)))
> >  		return -EAGAIN;
> > =20
> >  	/* add the driver to the list of i2c drivers in the driver core */
> > @@ -2118,6 +2119,7 @@ static int __init i2c_init(void)
> >  	if (IS_ENABLED(CONFIG_OF_DYNAMIC))
> >  		WARN_ON(of_reconfig_notifier_register(&i2c_of_notifier));
> > =20
> > +	is_registered =3D true;
> >  	return 0;
> > =20
> >  class_err:
>=20
> This doesn't work. I see a number of these WARN_ON()s trigger and I
> think the reason is that i2c_init() always fails now. The cause seems to
> be that i2c_init() calls i2c_add_driver(&dummy_driver), which will now
> always fail, because is_register is set to true *after* that call. There
> is no way I see I2C working at all after this patch.

FWIW, the below on top of your patch seems to fix things for me.

Thierry

--- >8 ---
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index f4726cdbb06a..f8723a474e28 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2112,6 +2112,8 @@ static int __init i2c_init(void)
 		goto bus_err;
 	}
 #endif
+	is_registered =3D true;
+
 	retval =3D i2c_add_driver(&dummy_driver);
 	if (retval)
 		goto class_err;
@@ -2119,7 +2121,6 @@ static int __init i2c_init(void)
 	if (IS_ENABLED(CONFIG_OF_DYNAMIC))
 		WARN_ON(of_reconfig_notifier_register(&i2c_of_notifier));
=20
-	is_registered =3D true;
 	return 0;
=20
 class_err:

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW5oQZAAoJEN0jrNd/PrOhnXsQALbc2fDO86qOTGfIjvet5euC
86QS26XAD2xZ492c1HN1gISUT0F5J9N/7paV3xwFXBTbf9RrU/hCS6yKXK5jSkxJ
NLsvyWjXqbMP/EBZI5ZsX88vf3VLNBMCTIrk/VJ9XFaWl36GywDIUUUuQ0ZMX4+R
HtUBTZhEbAhGNJMD8jc/hClwLYyABKWgTKmGNNFjT5HRceyNemjEvdv9sZYG+iNM
95onJoYXNhil74yK8nNpPGKPJe6xUhDCqPHTZxHUxMvfDtJoJLRyC24mmKukbxs+
GkF4diveDh+Ui7mBfUxtQYgeIpRiar1GBXJmU6nFHR/+DuxzpMecXjrFl9g6F6qn
mU9+3qUzorBYlOMyUYlST4u2FsDTgKV8laMFdm92so66YsogrxsjMw2WWTId7K/7
s1dz/QD4KAQdiLDqcKi1O0VtcfQxGo/F5K6/4XpJZdRX2z59kcS6DYIwboxU5hK2
gjxgHdrMMiQqmex6uCKB81BltSWO6ndjIqEgv4JnLzkvrBQygIaGQPHA5ye7sy0O
EFQ9gjoLLiXQPDGldYGM/8Nh5oxeI4NzBRQjsDRICwbhejksy9AUFZSPTgwDLxsz
aWXBeQH32ivAGNgMyZt++rLMDiFH7PK0j2ZlhVmifEZD8pTFrWNc5UtXapeg0A/P
ngE3espDQIPnXOgQXdV7
=wAvX
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
