From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c: qup: use address helper function in read transfer
Date: Sat, 18 Jun 2016 18:31:24 +0200
Message-ID: <20160618163124.GF3017@tetsubishi>
References: <1462473197-28393-1-git-send-email-nkaje@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462473197-28393-1-git-send-email-nkaje@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Naveen Kaje <nkaje@codeaurora.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 05, 2016 at 12:33:17PM -0600, Naveen Kaje wrote:
> qup_i2c_issue_read() derives the address from i2c_msg.
> This called in the read path when I2C_M_RD flag is set.
> Therefore, use the 8 bit address helper function.
>=20
> Signed-off-by: Naveen Kaje <nkaje@codeaurora.org>

Applied to for-next, thanks!


--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZXdbAAoJEBQN5MwUoCm284QP/0hLvqZDb5bzqL5a1PtTWwlz
WcGT1VjqyeqWVGHrV4oo78m9De/LnVarIZxc37W+PGDmuN9A8yXWKyc3GXx9VZ56
5pYEdJMJuHhBsGokGSkVXDkROEqRIB+PtAEK7D3toFfbIdaV2t9DUlQjLySqvfmj
ue+DBXRop3TIaaLSIVJixkDMvlOZGExpcxj9hxyGmLFPKNzoAm/ccQEp+ztOGt4A
NHZPDH4Zw+l3rtgm7/5EwNr9YSn/pZG4Y6rtZ5TyD9gFvjK9Aty9G6rSPlUudd+l
GqokOp6Z+CTVh0NTlhBF8dzJqoCW/sZiewGtaHTRGK8ZHCaYzOEtfKrbXzqefyHR
3Taf6xCPaqMqWDhv4d4iaanhhnQJwIVwE0cJTcljZWbj8DlSHEMnHP2K3+zVcXax
mEvgE20ZWFm6dajhF+SabJq65xTyo6HVExmEu36IZRr1ua5MddSAXMeMGSBSqa0b
mT4Q0V7AWa4Ceo6mq6/fvBsRnsTLzPm2paNk1yD/uNRM8cjhZoWJeYvgiNVPYtpj
YzE8kG0pvRdOEwQFFI+HiE6zEelMUU+ydQG13zvBd4gGEmUDULqzBQuvWIlziQV/
mZQoIknxrmkvNt8PSvC3nFl8e76MM216aMqomDMbojzYDbPtkGj24nL4hwQdb5+P
oDm6MZxox0vI6GTJPhKy
=TMC1
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
