From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: i2c: Documentation: upgrading clients HOWTO
Date: Tue, 15 Jul 2008 20:35:43 +0200
Message-ID: <20080715183543.GA5158@pengutronix.de>
References: <20080715155144.136915800@fluff.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9098878071822675230=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080715155144.136915800-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============9098878071822675230==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

some minor remarks...

On Tue, Jul 15, 2008 at 04:51:44PM +0100, Ben Dooks wrote:
> Add a document describing how i2c clients on Linux 2.6 can be
> moved from the old to the new driver model.
>=20
> Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>=20
> Index: linux-2.6.26-quilt2/Documentation/i2c/upgrading-clients
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.26-quilt2/Documentation/i2c/upgrading-clients	2008-07-15 16=
:51:11.000000000 +0100
> @@ -0,0 +1,280 @@
> +Upgrading I2C Drivers to the new 2.6 Driver Model
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> +
> +Introduction
> +------------
> +
> +This guide outlines how to alter existing Linux 2.6 client drivers from
> +the old to the new new binding methods.
> +
> +
> +Example old-style driver
> +------------------------
> +
> +
> +struct example_state {
> +	struct i2c_client	client;
> +	....
> +};
> +
> +static struct i2c_driver example_driver;
> +
> +static unsigned short ignore[] =3D { I2C_CLIENT_END };
> +static unsigned short normal_addr[] =3D { OUR_ADDR, I2C_CLIENT_END };
> +
> +I2C_CLIENT_INSMOD;
> +
> +static int example_attach(struct i2c_adapter *adap, int addr, int kind)
> +{
> +	struct example_state *state;
> +	struct device *dev =3D &adap->dev;  /* to use for dev_ reports */
> +	int ret;
> +
> +	state =3D kzalloc(sizeof(struct example_state), GFP_KERNEL);
> +	if (state =3D=3D NULL) {
> +		dev_err(dev, "failed to create our state\n");
> +		return -ENOMEM;
> +	}
> +
> +	example->client.addr    =3D addr;
> +	example->client.flags   =3D 0;
> +	example->client.adapter =3D adap;
> +
> +	i2c_set_clientdata(&state->i2c_client, state);
> +	strlcpy(client->i2c_client.name, "example", I2C_NAME_SIZE);
> +
> +	ret =3D i2c_attach_client(&state->i2c_client);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to attach client\n");
> +		kfree(state);
> +		return ret;
> +	}
> +
> +	dev =3D &state->i2c_client.dev;
> +
> +	/* rest of the initialisation goes here. */
> +
> +	dev_info(dev, "example client created\n");
> +
> +	return 0;
> +}
> +
> +static int example_detach(struct i2c_client *client)
> +{
> +	struct example_state *state =3D i2c_get_clientdata(client);
> +
> +	i2c_detach_client(client);
> +	kfree(state);
> +	return 0;
> +}
> +
> +static int example_attach_adapter(struct i2c_adapter *adap)
> +{
> +	return i2c_probe(adap, &addr_data, example_attach);
> +}
> +
> +static struct i2c_driver example_driver =3D {
> + 	.driver		=3D {
> +		.owner		=3D THIS_MODULE,
> +		.name		=3D "example",
> +	},
> +	.attach_adapter =3D example_attach_adapter,
> +	.detach_client	=3D example_detach,
> +	.suspend	=3D example_suspend,
> +	.resume		=3D example_resume,
> +};
> +
> +
> +Updating the client
> +-------------------
> +
> +The new style binding model will check against a list of supported
> +devices and their associated address supplied by the code registering
> +the busses. This means that the driver .attach_adapter and
> +.detach_adapter methods can be removed, along with the addr_data,
> +as follows:
> +
> +- static struct i2c_driver example_driver;
> +
> +- static unsigned short ignore[] =3D { I2C_CLIENT_END };
> +- static unsigned short normal_addr[] =3D { OUR_ADDR, I2C_CLIENT_END };
> +
> +- I2C_CLIENT_INSMOD;
> +
> +- static int example_attach_adapter(struct i2c_adapter *adap)
> +- {
> +- 	return i2c_probe(adap, &addr_data, example_attach);
> +- }
> +
> + static struct i2c_driver example_driver =3D {
> +-	.attach_adapter =3D example_attach_adapter,
> +-	.detach_client	=3D example_detach,
> + }
> +
> +Add the probe and remove methods to the i2c_driver, as so:
> +
> + static struct i2c_driver example_driver =3D {
> ++	.probe		=3D example_probe,
> ++	.remove		=3D example_remove,
> + }
> +
> +Change the example_attach method to accept the new parameters
> +which include the i2c_client that it will be working with:
> +
> +- static int example_attach(struct i2c_adapter *adap, int addr, int kind)
> ++ static int example_probe(struct i2c_client *client,
> ++			   const struct i2c_device_id *id)
> +
> +Change the name of example_attach to example_probe to align it with the
> +i2c_driver entry names. The rest of the probe routine will now need to be
> +changed as the i2c_client has already been setup for use.
> +
> +The necessary client fields have already been setup before
> +the probe function is called, so the following client setup
> +can be removed:
> +
> +-	example->client.addr    =3D addr;
> +-	example->client.flags   =3D 0;
> +-	example->client.adapter =3D adap;
> +-
> +-	strlcpy(client->i2c_client.name, "example", I2C_NAME_SIZE);
> +
> +The i2c_set_clientdata is now:
> +
> +-	i2c_set_clientdata(&state->client, state);
> ++	i2c_set_clientdata(client, state);
> +
> +The call to i2c_attach_client is no longer needed, if the probe
> +routine exits successfully, then the driver will be automatically
> +attached by the core. Change the probe routine as so:
> +
> +-	ret =3D i2c_attach_client(&state->i2c_client);
> +-	if (ret < 0) {
> +-		dev_err(dev, "failed to attach client\n");
> +-		kfree(state);
> +-		return ret;
> +-	}
> +
> +
> +Remove the storage of 'struct i2c_client' from the 'struct example_state'
> +as we are provided with the i2c_client in our example_probe. Instead we
> +store a pointer to it for when it is needed.
> +
> +struct example_state {
> +-	struct i2c_client	client;
> ++	struct i2c_client	*client;
> +
> +the new i2c client as so:
> +
> +-	struct device *dev =3D &adap->dev;  /* to use for dev_ reports */
> ++ 	struct device *dev =3D &i2c_client->dev;  /* to use for dev_ reports =
*/
> +
> +And remove the change after our client is attached, as the driver no
> +longer needs to register a new client structure with the core:
> +
> +-	dev =3D &state->i2c_client.dev;
> +
> +In the probe routine, ensure that the new state has the client stored
> +in it:
> +
> +static int example_probe(struct i2c_client *i2c_client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct example_state *state;
> + 	struct device *dev =3D &i2c_client->dev;
> +	int ret;
> +
> +	state =3D kzalloc(sizeof(struct example_state), GFP_KERNEL);
> +	if (state =3D=3D NULL) {
> +		dev_err(dev, "failed to create our state\n");
> +		return -ENOMEM;
> +	}
> +
> ++	state->client =3D i2c_client;
> +
> +Update the detatch method, by changing the name to _remove and
Typo: detach

> +to delete the i2c_detach_client call.
> +
> +- static int example_detach(struct i2c_client *client)
> ++ static int example_remove(struct i2c_client *client)
> +{
> +	struct example_state *state =3D i2c_get_clientdata(client);
> +
> +-	i2c_detach_client(client);
> +
> +And finally ensure that we have the correct ID table for the i2c-core
> +and other utilties:
Typo: utilities

> +
> ++ struct i2c_device_id example_idtable[] =3D {
> ++       { "example", 0 },
> ++       { }
> ++};
> ++
> ++MODULE_DEVICE_TABLE(i2c, example_idtable);
> +
> +static struct i2c_driver example_driver =3D {
> + 	.driver		=3D {
> +		.owner		=3D THIS_MODULE,
> +		.name		=3D "example",
> +	},
> ++	.id_table	=3D example_ids,
> +
> +
> +Our driver should now look like this:
> +
> +struct example_state {
> +	struct i2c_client	*client;
> +	....
> +};
> +
> +static int example_probe(struct i2c_client *client,
> +		         const struct i2c_device_id *id)
> +{
> +	struct example_state *state;
> +	struct device *dev =3D &client->dev;
> +	int ret;
ret is not needed in the updated example. Maybe mention that it could
also be removed?

> +
> +	state =3D kzalloc(sizeof(struct example_state), GFP_KERNEL);
> +	if (state =3D=3D NULL) {
> +		dev_err(dev, "failed to create our state\n");
> +		return -ENOMEM;
> +	}
> +
> +	state->client =3D client;
> +	i2c_set_clientdata(client, state);
> +
> +	/* rest of the initialisation goes here. */
> +
> +	dev_info(dev, "example client created\n");
> +
> +	return 0;
> +}
> +
> +static int example_remove(struct i2c_client *client)
__devexit

> +{
> +	struct example_state *state =3D i2c_get_clientdata(client);
> +
> +	kfree(state);
> +	return 0;
> +}
> +
> +static struct i2c_device_id example_idtable[] =3D {
> +	{ "example", 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, example_idtable);
> +
> +static struct i2c_driver example_driver =3D {
> + 	.driver		=3D {
> +		.owner		=3D THIS_MODULE,
> +		.name		=3D "example",
> +	},
> +	.id_table	=3D example_idtable,
> +	.probe		=3D example_probe,
> +	.remove		=3D example_remove,
__devexit_p

> +	.suspend	=3D example_suspend,
> +	.resume		=3D example_resume,
> +};
>=20
> --=20
> Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)
>=20
>   'a smiley only costs 4 bytes'
>=20
> _______________________________________________
> i2c mailing list
> i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
> http://lists.lm-sensors.org/mailman/listinfo/i2c

Thanks for this work!

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIfO3/D27XaX1/VRsRAlKKAJ0YgSB4Lye0GzoEYG9lmiOJL9LEdQCfW+je
KtevyQV3zKRmDwhUqNC2+FA=
=x3Up
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--


--===============9098878071822675230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============9098878071822675230==--
