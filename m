From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c: davinci: Avoid sending to own address
Date: Wed, 10 Jun 2015 22:13:50 +0900
Message-ID: <20150610131349.GH1592@katana>
References: <55534B7A.8070105@nokia.com>
 <5576C992.3060604@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Gk0KcsbyUMelFU1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5576C992.3060604-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Lawnick Michael 61283229 <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Mastalski Bartosz <bartosz.mastalski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--/Gk0KcsbyUMelFU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2015 at 01:10:10PM +0200, Alexander Sverdlin wrote:
> Sending a message to own address locks the controller up in very bizarre =
state,
> it behaves as slave even if MDR register clearly states master. The contr=
oller
> remains in this state until reset. To avoid unnecessary timeouts simply a=
void
> sending to own address. The controller cannot do this any way. Also, do n=
ot
> enable AAS IRQ, as the slave mode is not supported by the driver and the =
only
> possibility to trigger this IRQ is to send to own address.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks!

Please don't send new patch versions as replies to old versions!


--/Gk0KcsbyUMelFU1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVeDgNAAoJEBQN5MwUoCm25Y8QAIuQhQMkSNNaZj8xEjA8uuJS
opRCcqyOprvMnf6HBYhx5UwJDgPBjslgQGDnPmYfdYGAgmd9o4jdJDDk9kRVnDSM
N3+IPz7TTysCc0p43gyUCHYgLZDb0tslxoy1T4xtTOD4tXcnR29USREZ0ZqT2qQP
62ox622oSS2Tnsm/GYoxA8f5hQv+BbAWmmJiPZsgcM0gErL+TvZouogHEQotANjZ
pSe2iAPCG3+JGgnb4nFT8AhWo1nhz67RgJ2c4ngPccv44z7DBGMFiBKd3+fWEbV8
HVsB/X3fn6K46HHFcSyrI+RR7d7//cZurwQpfKK1E3bAVg70J4hgHuHG23yEmBEy
mirV+qEQ8LbwG7A/T5g8U4s9WWSJCCNHKRZglgGBd8xjoZSSN4r2Ql6NqiYNod54
ZoRkPu155u9ykLRjJI8m8S7+61ENewmgPr1DTGLMKFH7Zp08hZwYRuSqFSqjW49Y
KWO2TUQsjmWohymCinw+GmE5jxjPvD/GX5cgWQvlR8Uz1rWtbObp2UMJJjhqWgCW
e7YdmQWdM6JbCsSsKOG094Lzpy2FLC6njpSamoq4tCwAFIssyWGy5HFO+G6KAIxF
+BfXUA7InYFSDL6uYVeaI3tLjt2Bc0qnk+JXWNS7bsgKHiQ9yQYmQ3vSNLM7TuuD
oZysdYmC/sT+CzuTOIPQ
=b4yU
-----END PGP SIGNATURE-----

--/Gk0KcsbyUMelFU1--
