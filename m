From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: i2c: Documentation: upgrading clients HOWTO
Date: Wed, 16 Jul 2008 12:21:25 +0200
Message-ID: <20080716102125.GB4249@pengutronix.de>
References: <20080715202623.506943107@fluff.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5890507135898595804=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080715202623.506943107-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
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


--===============5890507135898595804==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

(Ben, sorry for double-post, I accidently dropped the CC)

On Tue, Jul 15, 2008 at 09:26:23PM +0100, Ben Dooks wrote:

The two typos I mentioned before are still here.

[...]
> +Update the detatch method, by changing the name to _remove and

Typo: detach

> +to delete the i2c_detach_client call.
> +
> +- static int __devexit example_detach(struct i2c_client *client)
> ++ static int __devexit example_remove(struct i2c_client *client)
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

ret is unused now. This could be mentioned. If you disagree, please
leave a short comment, so I know it was not overlooked.

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

All the best,

   Wolfram


--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIfculD27XaX1/VRsRAmytAJwIn7X9ITbc7XjtNVauGvp8nfzGVACdFa6C
KtSEQ2VZDho5wpZdbdwt1uQ=
=HCTb
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--


--===============5890507135898595804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============5890507135898595804==--
