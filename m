From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: Add bus driver for for OSIF USB i2c device.
Date: Mon, 13 Jan 2014 13:56:15 +0100
Message-ID: <20140113125615.GF2586@katana>
References: <20140109214930.GC3866@katana>
 <1389396239-21026-1-git-send-email-andrew@lunn.ch>
 <1389396239-21026-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389396239-21026-2-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Emmanuel Deloget <logout-GANU6spQydw@public.gmane.org>, Barry Carter <barry.carter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2014 at 12:23:59AM +0100, Andrew Lunn wrote:
> OSIF, Open Source InterFace, is a USB based i2c bus master.  The
> origional design was based on i2c-tiny-usb, but more modern versions
> of the firmware running on the MegaAVR microcontroller use a different
> protocol over the USB. This code is based on Barry Carter
> <barry.carter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> driver.
>=20
> Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>

Applied both to for-next, thanks!


--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS0+JvAAoJEBQN5MwUoCm2R70QAK2+DlQsiq4zOUSh6njaoPzo
U60qxsCXJNgwQVmgGuwk7zZ2deLCrPVMl5asyskGA0DYoS00+IqCH0VU1fHayoCJ
9VWSSy1Y40Cj0IlndzCeQDLHy2w3ks6iUmA67ticxiNmDuAmA/0cnAxDGAxAOeP8
W21N7MgXqjohhMNTHVLJxdpQShKA6lhIIeNn8d/qmGDDREaaaGSdkXhtYi4/XSRu
ak3Pr9b4gU9CteO0tBKPyk6E+yBW9nqJSkdWGcUDsTyEpwqpMuUhVeCF5lG0anez
sqKoG8ycQODvaaSJ2+TYnnB3KZ8pdcOxEO1tolAbuQkNZn7HjO+qvMdMTdLcCRQA
qDFziCyYSkWHRp/mvnzguux/DcKl62dfdFGSEJvV27YtCbDH3kx1jh6LPhj7QS5M
yg4BczKVhfRTJW6qzXePnPEIWY6S5uhaI8yETW/IpYRG/IGUOqbkl+FSZmuOvJE1
ekQD0+JnHqWBxKiezNxkwOm48WkHLsCH8pviObGXJYYjKHRiSPUhlGz3lqclv8gO
gKsAMTGtNJkx8YElJW1gvQw455tQ7rOkmaQ5SK8P/cvVLOhZ6sauAnBDkjOgj840
AX/sLsOLBT2sj5vStq/XsLD2ORT5XiSsyb93T35Uy/y/lIfaf1omvEDR67yLLkug
rdGNacoj2iOY2RHWhN3r
=3vJL
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
