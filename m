From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v1 02/10] i2c: core: Have clients point to their firmware
 nodes
Date: Fri, 31 Jul 2015 12:36:24 +0200
Message-ID: <20150731103624.GB1522@katana>
References: <1435676108-20590-1-git-send-email-tomeu.vizoso@collabora.com>
 <1435676108-20590-3-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435676108-20590-3-git-send-email-tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2015 at 04:55:00PM +0200, Tomeu Vizoso wrote:
> This is needed by platform-independent code that needs to do something
> with devices based on the data provided by the firmware.
>=20
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>

Dunno the status of this series, but the i2c change is trivial enough.
So in case, the rest is accepted:

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>


--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVu0+oAAoJEBQN5MwUoCm2zJoP+gLonf7safvROTXI6CFFQcgh
B8jEs+SIEXkk/Lv2B/5BBwrEZh9lj09ICRiHplHf08ghpfM0cXG7RWDa8Q+S6eCx
2J7Kpb5UNQRlInzPXxsNTJFesPMzarhhH86GiRmplf8ZDu9Yqh/LOwJZCttVNBA4
p/wy55N5wv97UX4p87WySvlLmYLFGDitpMGtgxVK/jsJkdRNPCgZ34P9785HubBj
anMeWCjoNR+e2QExHWhVWF19tzEup7FzTrvS+S2VXMAxpW7IuTSt9S/UeksjkXGq
1XRoUYZtAY3F6Ja3w4uyBMn4ac8GdYPXnC3Wizxa8lAw19F574PS2BbW+hFW/QBr
fDHVXrf7eCU4HBOdHgPfNhxOw84IQ1qH0V9kdeLiqNAaNgxs/6ntA5wcrX07sWhU
3tx4KpJuuclIA12nhjZ25q+GDDdgLhT35X48Yx6i3h+7JTuKErS/QJlkquqpZkus
tJamPvHdABi0RTmZXsoT9MDkL2RX9Rru54VRAA3HNog/w/3Uml1ywu9KJKztL6Uj
8y2GPD7XcLMgl1xBU2rCkN/c5wGIdcxYOVVpbDaenDUBe90zfnMfq2PXhpjpCWf8
RpIolsQCT4WBL4HBlBCfe9XjqaJlkeiA+CnQf3e9owUmBl06CbUNjQOocK7wJyYS
6OnOAPoA9HqPPenj/sV3
=+jS6
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
