From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH RFT] i2c: au1550: Convert to devm_kzalloc and
 devm_ioremap_resource
Date: Fri, 23 Oct 2015 23:32:28 +0200
Message-ID: <20151023213228.GM1520@katana>
References: <1433836369.27915.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7vLGWvOrvbSM0Ba8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37025 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbbJWVcd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 23 Oct 2015 17:32:33 -0400
Content-Disposition: inline
In-Reply-To: <1433836369.27915.1.camel@ingics.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Domen Puncer <domen.puncer@ultra.si>, Ralf Baechle <ralf@linux-mips.org>, Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org


--7vLGWvOrvbSM0Ba8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2015 at 03:52:49PM +0800, Axel Lin wrote:
> Use devm_* APIs to simplify the code.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied to for-next with Manuel's Tested-by, thanks!


--7vLGWvOrvbSM0Ba8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKqdsAAoJEBQN5MwUoCm2vtUQAKot99jxDw2AKhwq/YYREuL5
g0PunxrpsUbs9/7vDErSGxsD+dSGoVkBTCZ16sLLO9TiUKNstaMuFWP5tZYV8bYt
C35VViLEwcsnzDij3pma04KZycsyaNXMw8Fsg6QHaOsK3pJ8HEAIkhbhD9FFmAYR
yqNGp7n+tL+OV8Zwp759FUddiIU4Oey8SQ620M4CRI9gY0cGzPSSAGLfqbQd5Uin
63FU6eX+teL9KxTHKiWZ72Ran/vDTKzr1Higrho1gIiAE0CWj00excO+faFgQRL/
lFs5Kf8lZA8uQ3SkxVlo9dm7/ErFeP+BZzSKurdFjvRlkvCOz9pl8u/7TmhGDYup
nv1UQ/18nJCuPSpbUzzWs7wIzCveL9pQfLRm6QGkvxrMOsP6okPpYuyuMSivNxUV
t2YXBVMzWIoXHsPatIx/4zeem6WLAejaT0MWrJiEnmyfRv/MOysX7XY5qXY1Cgx1
5T0XnoWGqbuEhY5ho85y9ziecnrHUeijw6QtZ0lGEgmKzASqdhmyeuWPcN/Bvvhw
tK2l3cxXbK9wV6foAYHXBzVff3y2MnTfiDBtSEO1hJt2FhdW+iPvJ3yYQVNlUTRc
rulzz2GaifKiGG8DB0X/l2hM2CDBuz8fZRWW0Q72YaS0cezB09tmheXAu1C8EeTe
WStCpJB2W0LLx2PBxg/S
=8P2T
-----END PGP SIGNATURE-----

--7vLGWvOrvbSM0Ba8--
