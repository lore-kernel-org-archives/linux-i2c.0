From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: Remove unnecessary call to irq_find_mapping
Date: Sun, 28 Oct 2018 22:30:41 +0000
Message-ID: <20181028223041.GI1882@kunai>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N8NGGaQn1mzfvaPg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org


--N8NGGaQn1mzfvaPg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2018 at 09:59:57AM +0100, Charles Keepax wrote:
> irq_create_mapping calls irq_find_mapping internally and will use the
> found mapping if one exists, so there is no need to manually call this
> from i2c_smbus_host_notify_to_irq.
>=20
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Adding Benjamin to recipients. He wrote that code.

> ---
>  drivers/i2c/i2c-core-base.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index dc78aa7369def..656f0a6fe3adf 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -306,10 +306,7 @@ static int i2c_smbus_host_notify_to_irq(const struct=
 i2c_client *client)
>  	if (client->flags & I2C_CLIENT_TEN)
>  		return -EINVAL;
> =20
> -	irq =3D irq_find_mapping(adap->host_notify_domain, client->addr);
> -	if (!irq)
> -		irq =3D irq_create_mapping(adap->host_notify_domain,
> -					 client->addr);
> +	irq =3D irq_create_mapping(adap->host_notify_domain, client->addr);
> =20
>  	return irq > 0 ? irq : -ENXIO;
>  }
> --=20
> 2.11.0
>=20

--N8NGGaQn1mzfvaPg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvWOJEACgkQFA3kzBSg
KbagOhAAsm8E83F7oPrDcOxo+n00svnBOyKabHf018H1ul/LfQZy1auyduSu5Y3H
aC1cPdkvU8uzCPwhWVz7iZ0MHvsGZMR5lZ6NRHnWA5fAmV1kezMqSJBNzw71mmhh
3+6qoCLMZHsKn64GeYsujiXpf6GtcgAhBtBgAsHh2iAgdZ8rr52C6jccy8KqQOVC
osPOsFHnq0RHobiVKjb2vfMpIy80JxHJGz/nx5RnOxvGNLP7fVw3jsY2YKE2JFnH
/xSa4MWxVb6K1fDoCe8fvsauCKZk5YVPNtxMbnjA+kbKhWYAgAu7tEBC+4KDOwbP
gVh4O858N6LyP3Mq0G0ZkUC66OfCIIQ1X6ceItu2SV/kSJyDaWi2aqOeBr6dF/nl
4zsqTo3EZ6JO0Ub09KViU9WYtbFbLiR/rfSpfF62d6j4LqjAVYan3epXB38QRwUk
NzVNssUBWaOMgZtJFVWIkxLy5ci3rGbx3s5VyamY/T3W4XhNW5l/Nud3vs8+OFav
HLfwdc5NXk1uaBic7KL54rJXT0eqXFTFCAvZw2orhmB12GRaN42NvCSfEhtwr6p8
tkcSWSgVOO2EuVDckPWuT8pGD3cbzVkG5x2IOOVWp+rgzb8EgDEvVz+pqSVr73M9
pf0F+6/f8pmMdIFpppmV+RwoRr3Ao56QhK6p198FKX4Wf5qnJbQ=
=d8BD
-----END PGP SIGNATURE-----

--N8NGGaQn1mzfvaPg--
