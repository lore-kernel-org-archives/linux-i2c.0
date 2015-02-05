From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/2] i2c: i2c-ocores: fix clock-frequency binding usage
Date: Thu, 5 Feb 2015 20:11:05 +0100
Message-ID: <20150205191105.GA15307@katana>
References: <1422890893-30989-1-git-send-email-jcmvbkbc@gmail.com>
 <1422890893-30989-2-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422890893-30989-2-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2015 at 06:28:12PM +0300, Max Filippov wrote:
> clock-frequency property is meant to control the bus frequency for i2c bus
> drivers, but it was incorrectly used to specify i2c controller input clock
> frequency.
> Introduce new attribute, opencores,ip-clock-frequency, that specifies i2c
> controller clock frequency and make clock-frequency attribute compatible
> with other i2c drivers. Maintain backwards compatibility in case
> opencores,ip-clock-frequency attribute is missing.
>=20
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Exactly what I had in mind. Thank you for making the effort to fix this
properly!

Applied to for-next!


--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU08BJAAoJEBQN5MwUoCm25XMQAKpvJByaORHBDE/Pt0eTOK63
4d00HAic0gSZRgicflawMgkBGNBTaov2z7C3D3HroWkIMccPaT3xyvTO8wR0XCE/
gxsf8TbuLLthzJDbOvfQWVUu2vC5SMp0bF/Xg5rHCmvPxjiZ06cea0p/tnYD41+P
eyLVLUNcf9/tPVCMbi72YEmZzWUloSQyg+XQ1hswdlSyaOcFwn5xcc8ghsMcbxBD
gcrEiLkwyHS7qoAT6xxgCdS1TMZg99W3eyVFatNU6wVrEuayhPHSdF6EvYZmeoo1
/Ajt0TI0nmbAx/W6RvByfbvWny/pISb7iVyNCjqw/wM2OW4Gwry8B5eh15FDBY1w
J/mcuQc85BDlwA1c+YBaOwrlwoIVwv9Lj/ijl4hMF+QqZ1rrXuCLXzCG7fhQqd3C
Bab28NjSgPaZXcGOqYaamxM2bMNrZSIAZPx3nGHMjWpLxsN+3K8xFcd33fOna8St
piWn3GbJMAabRmuDwhEDNzbHf/7xRN1+z0S84yWC3s5K+awU1MT2OnUoksr35MRd
/6KPMpNdkr7BgE5TYFohoHWn4FZaLDr9Rk/1K80e6/LIcXGG94FlSd3tc+QevC/g
qWZCWdnAXjhv07u85H8VjfLm9rRK2PP2WT/ecGlsjkMZSngMJ5KwV9NI7P1+hbYM
eEiig9AhXmw4V/LcEmPb
=QXNh
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
