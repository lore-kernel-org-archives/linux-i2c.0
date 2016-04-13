From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 01/19] i2c: octeon: Increase retry default and use
 fixed timeout value
Date: Wed, 13 Apr 2016 10:39:36 +0200
Message-ID: <20160413083936.GB1563@katana>
References: <cover.1460387640.git.jglauber@cavium.com>
 <912e7b105708740802cd6fc944d4d041a4939a35.1460387640.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34741 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754681AbcDMIjl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 13 Apr 2016 04:39:41 -0400
Content-Disposition: inline
In-Reply-To: <912e7b105708740802cd6fc944d4d041a4939a35.1460387640.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2016 at 05:28:32PM +0200, Jan Glauber wrote:
> Convert the adapter timeout to 2 ms independently of depending on CONFIG_=
HZ.
> CONFIG_HZ is 100 for MIPS Cavium-Octeon so the timeout value is not chang=
ed.
>=20
> Also set retries to 5 to improve robustness.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Applied to for-next, thanks!


--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXDgXIAAoJEBQN5MwUoCm2IL8QAIstzUMFGXhGfiEZv8sh3/9t
0R+GsGLajIWimZUGU5diMy1/xLj9WVCfZDtRU7igKw3A4W2YCixqbtIHKKmSSVLY
m0tqKfafGWj7M0CqHXNmQNh+progn67hwtixeadQc0aL07KkNHmRAWzv6n/jOduS
/+70ewUbk0s0HTSZxhFiUG0io95LeRmEh95yqZO6AO0eHYkdwE0eGBgJDF537VNO
IP7PVkiDfqSjqPnoNVdgd5F/lhn0yUBI/5ZFzLK3IlU6sCXPoPK+7XnZuH0/g6cZ
WN+x1IrDb4MicRgtI6PnlhSbWv/kxmYk0Or6j7tGVZ8V+efwmv51oZs7EVbu+pI3
/p255CaE1h55HZYfywYuOGOYFObX4xc3VuUG+Mn4YG3VEP3Nb0Cj3vs+vd9bVCaX
DcqsXCE6zBgOOlmP4KoIYnVrebRmfHqKip+7xP93X8oqB5wLqBGIudoP722G3Z68
isRyVXpbCUtp4Lt9H6ACGF085lnGJwPcKOeJArOg5C9fZgyYJbf4KkTeB7pctegJ
CiP9EU6vvp9jbyootwkrKLvFUkMPEoLq/1VlI2bMjGKqG3ajhh/FTpSi3W8XVrff
JwRDdfJ2bp2cQBSZJ98SxNpW3Nz2yEhSBEh9N7QrnYKfuqfkMXOtNN8EU9v+RCpb
tLFU6pXuGsEjbpguuCPc
=ef7Z
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
