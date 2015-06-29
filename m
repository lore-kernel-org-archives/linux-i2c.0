From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC PATCH 1/1] i2c: core: add of_get_i2c_adapter_by_node
Date: Mon, 29 Jun 2015 10:17:18 +0200
Message-ID: <20150629081717.GA1586@katana>
References: <5590E763.3090703@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5590E763.3090703-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Frkuska, Joshua" <joshua_frkuska-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2015 at 03:36:19PM +0900, Frkuska, Joshua wrote:
> This adds of_get_i2c_adapter_by_node which both finds and properly
> increments the adapter reference count.
>=20
> This is different from of_find_i2c_device_by_node which does not
> increment the adapter reference counter.
>=20
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Joshua Frkuska <joshua_frkuska-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>

What is your use case? Which code will be using this function?


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVkP8NAAoJEBQN5MwUoCm21QgQAKpfLQbNTLMArxy4wj870Dr6
Jl9ENYM7G6RwSFNEhaECQN3hLQO/QGDQsO8rRRwcwpEX7OFjbezwsIHy+11CgN4t
hA6EdBQH1S6AJqhZuDLDIUVI6ia213O54PdWNwz86t1uSrdyqIVl/B4S/xx99Ur/
4vKa3DKdf9zIvz8O7JMgvjHqsXeeWtbBciYLOdwNgUXlxegrtuwtmdsdmbcnFU+s
frRXie3uBnTAXIOtGFVZVwM9uG4cYyNeiV47lphKpA5iezBZ4qO/8ELd0IbTT1jS
e00OS8w0VPeUmOsnvMoGjVlNCU9pqgwQbrq8EQCEnMB42vIgvCQuWFHhhwOyGVjz
/6A0WUQq5tZoTgCynVlCZLprO8qlttkFabtGmU9gUhoqPymUk93tM87By+mqXyRn
g5du4ZXKw0u6xUiOCQ+AddUn5/UuFPpKdDNTDdhCqos57LPHiZw2Xraa70sGczwT
6ups5hxOdD8R08r9iZYAijljHUUmC9DjzILSffbaQnqlPf+XeuonOJxRx+HNcXp4
pgvZYTABUWRvcvDFIbwunjqK4TXFQFDSXJXGeOCJ37yxgUHsicg3mpGyp+lb5a9w
+Jypf61u7OWHQR4/tLON0+atLvI2/SDjVkqbVB+lfK7xMBoblSlH0Sdh8zx+ZPGQ
+PC12ZxIf86PgsJA6a8J
=BE1b
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
