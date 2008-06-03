From: Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
Subject: Re: RFC: Add documentation on upgrading clients
Date: Tue, 3 Jun 2008 13:29:06 +0200
Message-ID: <200806031329.10290.laurentp@cse-semaphore.com>
References: <20080603111922.GA11500@fluff.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5248959047815252557=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080603111922.GA11500-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--===============5248959047815252557==
Content-Type: multipart/signed; boundary="nextPart8543439.rlvfVuqHGk";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart8543439.rlvfVuqHGk
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Ben,

just a few comments.

On Tuesday 03 June 2008 13:19, Ben Dooks wrote:
> I would like to get people's opinions on adding
> the following as Documentation/i2c/upgrading-clients.
>=20
>=20
> Upgrading I2C Drivers to the new 2.6 Driver Model
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>=20
> Introduction
> ------------
>=20
> This guide outlines how to alter existing Linux 2.6 client drivers from
> the old to the new new binding methods.
>=20
>=20
> Example old-style driver
> ------------------------
>=20
> =20
> struct example_state {
> 	struct i2c_client	client;
> 	....
> };
>=20
> static struct i2c_driver example_driver;
>=20
> static unsigned short ignore[] =3D { I2C_CLIENT_END };
> static unsigned short normal_addr[] =3D { OUR_ADDR, I2C_CLIENT_END };
>=20
> static struct i2c_client_address_data addr_data =3D {
> 	.normal_i2c		=3D normal_addr,
> 	.probe			=3D ignore,
> 	.ignore			=3D ignore,
> };
>=20
> static int example_attach(struct i2c_adapter *adap, int addr, int kind)
> {
> 	struct example_state *state;
> 	struct device *dev =3D &adap->dev;
> 	int ret;
>=20
> 	state =3D kzalloc(sizeof(struct example_state), GFP_KERNEL);
> 	if (state =3D=3D NULL) {
> 		dev_err(dev, "failed to create our state\n");
> 		return -ENOMEM;
> 	}
>=20
> 	example->i2c_client.addr    =3D addr;
> 	example->i2c_client.flags   =3D 0;
> 	example->i2c_client.adapter =3D adap;
>=20
> 	i2c_set_clientdata(&state->i2c_client, state);
> 	strlcpy(client->i2c_client.name, example_driver.driver.name,
> 		I2C_NAME_SIZE);
> =09
> 	ret =3D i2c_attach_client(&state->i2c_client);
> 	if (ret < 0) {
> 		dev_err(dev, "failed to attach client\n");
> 		kfree(state);
> 		return ret;
> 	}
>=20
> 	dev =3D &state->i2c_client.dev;
>=20
> 	/* rest of the initialisation goes here. */
>=20
> 	return 0;
> }
>=20
> static int example_remove(struct i2c_client *client)
> {
> 	struct example_state *state =3D i2c_get_clientdata(client);
>=20
> 	i2c_detach_client(client);
> 	kfree(state);
> 	return 0;
> }
>=20
> static int example_attach_adapter(struct i2c_adapter *adap)
> {
> 	return i2c_probe(adap, &addr_data, example_attach);
> }
>=20
> static struct i2c_driver example_driver =3D {
>  	.driver		=3D {
> 		.owner		=3D THIS_MODULE,
> 		.name		=3D "example",
> 	},
> 	.attach_adapter =3D example_attach_adapter,
> 	.detach_client	=3D example_detach,
> 	.suspend	=3D example_suspend,
> 	.resume		=3D example_resume,
> };
>=20
>=20
> Updating the client
> -------------------
>=20
> The new style binding model will check against a list of
> supported devices and their associated address supplied by
> the code registering the busses. This means that the driver
> .attach_adapter and .detach_adapter methods can be removed,
> along with the addr_data, as follows
>=20
> - static struct i2c_driver example_driver;
>=20
> - static unsigned short ignore[] =3D { I2C_CLIENT_END };
> - static unsigned short normal_addr[] =3D { OUR_ADDR, I2C_CLIENT_END };
>=20
> - static struct i2c_client_address_data addr_data =3D {
> -	.normal_i2c		=3D normal_addr,
> -	.probe			=3D ignore,
> - 	.ignore			=3D ignore,
> - };
>=20
> - static int example_attach_adapter(struct i2c_adapter *adap)
> - {
> - 	return i2c_probe(adap, &addr_data, example_attach);
> - }
>=20
>  static struct i2c_driver example_driver =3D {
> -	.attach_adapter =3D example_attach_adapter,
> -	.detach_client	=3D example_detach,
>  }
>=20
> Add the probe and remove methods to the i2c_driver, as so:
>=20
>  static struct i2c_driver example_driver =3D {
> +	.probe		=3D simtec_pmu_probe,
> +	.remove		=3D simtec_pmu_remove,
>  }

This should be example_probe and example_remove.

> Change the example_attach method to accept the new parameters
> which include the i2c_client that it will be working with:
>=20
> - static int example_attach(struct i2c_adapter *adap, int addr, int kind)
> + static int example_probe(struct i2c_client *i2c_client,
> +			   const struct i2c_device_id *id)
>=20
> Note, we change the name of example_attach to example_probe to
> align it with the i2c_driver entry names. The rest of the probe routine
> will now need to be changed as the i2c_client has already been setup
> for use.
>=20
> Remove the  setting of address and adapter, they are now not needed.
>=20
> -	example->i2c_client.addr    =3D addr;
> -	example->i2c_client.flags   =3D 0;
> -	example->i2c_client.adapter =3D adap;
>=20
> Also remove the strlcpy, as the i2c_client's name is already filled
> in by the caller.
>=20
> -	strlcpy(client->i2c_client.name, example_driver.driver.name,
> -		I2C_NAME_SIZE);
>=20
> The call to i2c_attach_client is no longer needed, if the probe
> routine exits succssfully,

"successfully"

> then the driver has been attached. Change=20

"will be attached" sounds better.

> the probe routine as so:
>=20
> -	ret =3D i2c_attach_client(&state->i2c_client);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to attach client\n");
> -		kfree(state);
> -		return ret;
> -	}
>=20
>=20
> Remove the storage of  'struct i2c_client' from the 'struct example_state'
> as we are provided with the i2c_client in our example_probe. Instead we
> store a pointer to it for when it is needed.
>=20
> struct example_state {
> -	struct i2c_client	client;
> +	struct i2c_client	*client;
>=20
> In the probe routine, ensure that the new state has the client stored
> in it.
>=20
> static int example_probe(struct i2c_client *i2c_client,
> 			 const struct i2c_device_id *id)
> {
> 	struct example_state *state;
> 	struct device *dev =3D &adap->dev;
> 	int ret;
>=20
> 	state =3D kzalloc(sizeof(struct example_state), GFP_KERNEL);
> 	if (state =3D=3D NULL) {
> 		dev_err(dev, "failed to create our state\n");
> 		return -ENOMEM;
> 	}
>=20
> +	state->client =3D i2c_client;
>=20
> Update the remove method to delete the i2c_detach_client call.
>=20
> static int example_remove(struct i2c_client *client)
> {
> 	struct example_state *state =3D i2c_get_clientdata(client);
>=20
> -	i2c_detach_client(client);

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart8543439.rlvfVuqHGk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIRSsG8y9gWxC9vpcRAh0/AKCj3JBPJJL/4IWVVu18wX8zHL8hPQCfU5Tp
XrfVmPcxY1bt3w/6FlVeCkY=
=4MRj
-----END PGP SIGNATURE-----

--nextPart8543439.rlvfVuqHGk--


--===============5248959047815252557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============5248959047815252557==--
