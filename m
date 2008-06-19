From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: virtual i2c adapter support.
Date: Thu, 19 Jun 2008 14:25:49 +0200
Message-ID: <20080619122549.GN10695@enneenne.com>
References: <1213794365-8089-1-git-send-email-giometti@linux.it>
	<20080618190008.GK10351@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7093094635847460358=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080618190008.GK10351-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
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
Cc: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--===============7093094635847460358==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ukW6Wv09KNCUAh1u"
Content-Disposition: inline


--ukW6Wv09KNCUAh1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2008 at 08:00:08PM +0100, Ben Dooks wrote:

> > +static int i2c_virt_master_xfer(struct i2c_adapter *adap,
> > +				struct i2c_msg msgs[], int num)
> > +{
> > +	struct i2c_virt_priv *priv =3D adap->algo_data;
> > +	struct i2c_adapter *parent =3D priv->parent_adap;
> > +	int ret;
> > +
> > +	/* Grab the lock for the parent adapter. We already hold the lock for
> > +	 * the virtual adapter. Then select the right mux port and perform
> > +	 * the transfer.
> > +	 */
> > +
> > +	mutex_lock(&parent->bus_lock);
> > +
> > +	ret =3D priv->select(parent, priv->client, priv->id);
> > +	if (ret >=3D 0)
> > +		ret =3D parent->algo->master_xfer(parent, msgs, num);
> > +	priv->deselect(parent, priv->client, priv->id);
> > +
> > +	mutex_unlock(&parent->bus_lock);
> > +
> > +	return ret;
> > +}
>=20
> Out of interest, is it going to be better to hide the parent
> away completely from the system? I suppose if clients have
> already bound to it then we're probably going to just have to
> live with it being available.

I'm sorry but I don't understand what you mean. =3D:-o

The parent is strictly connected with the children virtual adapter, how
can I hide it?

> > +struct i2c_adapter *i2c_add_virt_adapter(struct i2c_adapter *parent,
> > +				struct i2c_client *client,
> > +				u32 force_nr, u32 mux_val,
> > +				int (*select_cb) (struct i2c_adapter *,
> > +						struct i2c_client *, u32),
> > +				int (*deselect_cb) (struct i2c_adapter *,
> > +						struct i2c_client *, u32))
> > +{
> > +	struct i2c_adapter *adap;
> > +	struct i2c_virt_priv *priv;
> > +	struct i2c_algorithm *algo;
> > +	int ret;
> > +
> > +	adap =3D kzalloc(sizeof(struct i2c_adapter)
> > +			+ sizeof(struct i2c_virt_priv)
> > +			+ sizeof(struct i2c_algorithm), GFP_KERNEL);
> > +	if (!adap)
> > +		return NULL;
> > +
> > +	priv =3D (struct i2c_virt_priv *)(adap + 1);
> > +	algo =3D (struct i2c_algorithm *)(priv + 1);
>=20
> you shouldn't need force-typecast here.
>=20
> you could always make your i2c_virt_priv data contain the i2c_adapter
> and i2c_algorithm structure so you can easily go between them.

Ok.

> > +	/* Set up private adapter data */
> > +	priv->parent_adap =3D parent;
> > +	priv->client =3D client;
> > +	priv->id =3D mux_val;
> > +	priv->select =3D select_cb;
> > +	priv->deselect =3D deselect_cb;
> > +
> > +	/* Need to do algo dynamically because we don't know ahead
> > +	 * of time what sort of physical adapter we'll be dealing with.
> > +	 */
> > +	algo->master_xfer =3D (parent->algo->master_xfer
> > +					? i2c_virt_master_xfer : NULL);
> > +	algo->smbus_xfer =3D (parent->algo->smbus_xfer
> > +					? i2c_virt_smbus_xfer : NULL);
> > +	algo->functionality =3D i2c_virt_functionality;
>=20
> you're using kzalloc, so this boils down to the neater:
>=20
> 	if (parent->algo->master_xfer)
> 		algo->master_xfer =3D i2c_virt_master_xfer;
> etc.

Ok.

> > +	/* Now fill out new adapter structure */
> > +	snprintf(adap->name, sizeof(adap->name),
> > +			"i2c-%d-virt (mux %02x:%02x)",
> > +			i2c_adapter_id(parent), client->addr, mux_val);
> > +	adap->id =3D I2C_HW_VIRT | i2c_adapter_id(parent);
> > +	adap->algo =3D algo;
> > +	adap->algo_data =3D priv;
> > +	adap->timeout =3D VIRT_TIMEOUT;
> > +	adap->retries =3D VIRT_RETRIES;
> > +	adap->dev.parent =3D &parent->dev;
>=20
> How about creating a struct with the callbacks in, and the data
> for timeout, retries and any other data that would be needed?

There are few assignments... :)

> > +	if (force_nr) {
> > +		adap->nr =3D force_nr;
> > +		ret =3D i2c_add_numbered_adapter(adap);
> > +	} else
> > +		ret =3D i2c_add_adapter(adap);
> > +	if (ret < 0) {
> > +		kfree(adap);
> > +		return NULL;
> > +	}
> > +
> > +	dev_info(&parent->dev, "i2c-virt-%d: Virtual I2C bus - "
> > +		"physical bus i2c-%d, multiplexer 0x%02x port %d\n",
> > +		i2c_adapter_id(adap), i2c_adapter_id(parent),
> > +		client->addr, mux_val);
> > +
> > +	return adap;
> > +}
> > +EXPORT_SYMBOL_GPL(i2c_add_virt_adapter);
> > +
> > +int i2c_del_virt_adapter(struct i2c_adapter *adap)
> > +{
> > +	int ret;
> > +
> > +	ret =3D i2c_del_adapter(adap);
> > +	if (ret < 0)
> > +		return ret;
> > +	kfree(adap);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(i2c_del_virt_adapter);
> > +
> > +MODULE_AUTHOR("Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org, " \
> > +		"Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>");
> > +MODULE_DESCRIPTION("Virtual I2C driver for multiplexed I2C busses");
> > +MODULE_LICENSE("GPL");
>=20
> "GPL v2" is the definition you probably want here.

Ok.

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

--ukW6Wv09KNCUAh1u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIWlBNQaTCYNJaVjMRAhcRAJ9DRA4vnKmNYIwhawTnDRjbu2AfowCgjZqG
ESgO4uUtT8q92EvEm+zVpuU=
=C2L+
-----END PGP SIGNATURE-----

--ukW6Wv09KNCUAh1u--


--===============7093094635847460358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============7093094635847460358==--
