From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 4/4] i2c: arb-gpio-challenge: use
 of_get_i2c_adapter_by_node interface
Date: Thu, 6 Aug 2015 02:51:51 +0200
Message-ID: <20150806005151.GD1743@katana>
References: <1438007451-8553-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1438007451-8553-5-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438007451-8553-5-git-send-email-vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2015 at 05:30:51PM +0300, Vladimir Zapolskiy wrote:
> This change is needed to properly lock I2C parent bus driver.
>=20
> Prior to this change i2c_put_adapter() is misused, which may lead
> to an overflow over zero of I2C bus driver user counter.
>=20
> By the way added a missing of_node_put() to eliminate memory leak,
> if OF_DYNAMIC is enabled.
>=20
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
> Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Applied to for-next! However...

> +	of_node_put(parent_np);

I removed this line. Please resend this as a seperate patch since it
fixes a seperate issue.

Thanks,

   Wolfram


--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVwq+nAAoJEBQN5MwUoCm2G2MP/3xeGk8gfN0JHCUK4R1zSF/f
QjuajvDGd2aGdgN3hyrObmc+NY0sNaNX9QY05uH6rPqUEJdrvWz+LQAW7E1MNjJF
K+SYldIn6YHsezCMO2EAwp6GHofAaA8XJ0fKIODkrx0YNWKCekP2iJdGYSeUeKSF
SbtIKCd7xXc52xmvsey0K31uELKS3fN6MDkUG/HluXkb/qwXCedWRYvutflkan60
W7qGlUivMrng2tnSWriOl8uFrD5OZnXyH1JhuQwkkwSZ9B2UKIw/9AMXhGpjEN4K
wgQ7vPk3Q3RLHvp1SO9IiFDwRg8xqMff3tBofUCioGPAmNRWAmcYAwUekLvVMc2n
Rtdy5fLYNKJQ/AH1OYcibiQo5SBDc/oYE05oADEXoRelDEujFzrDOuveouuPAs6v
MCk6cYmmGH9ouHdYE3gIgrb0Ml+TdB3Aa5iDoDZi5zloqhlDM2eZ5KYCcZ/zVakG
sbl/s7RwHlVt/djAigypFFe6swIsQ+hBLSDG/mlj9Nm/5F4v6ZiJioMQQeL8rGyJ
dwIboulWK9XLktHpNCSDd3I9DMn/y62vhdPektxO+xM2wnO930khXk1MlD7unZ2j
AJ2yCr5BAIak/FGg56iLwvsrFnZIJnyhIJxUn6QGj+OCFHJL0wRehzb692rEG9sj
Fgdx5LC28iktUmjRXm92
=Xl/s
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
