From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: bcm2835: Don't complain on -EPROBE_DEFER from
 getting our clock
Date: Fri, 22 Jul 2016 09:28:01 +0200
Message-ID: <20160722072801.GH1605@katana>
References: <1455844375-15019-1-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wayzTnRSUXKNfBqd"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50941 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270AbcGVH2G (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 22 Jul 2016 03:28:06 -0400
Content-Disposition: inline
In-Reply-To: <1455844375-15019-1-git-send-email-eric@anholt.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Eric Anholt <eric@anholt.net>
Cc: linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-i2c@vger.kernel.org


--wayzTnRSUXKNfBqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 18, 2016 at 05:12:55PM -0800, Eric Anholt wrote:
> Fixes dmesg spam when we just need to wait a moment for the clock
> driver to probe.
>=20
> Signed-off-by: Eric Anholt <eric@anholt.net>

Applied to for-next, thanks!


--wayzTnRSUXKNfBqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkcsBAAoJEBQN5MwUoCm2yFEQAIiYdbIzD0rRyLM19aD9iImE
Ude9PRJ2ZVX5LfQe6WhHgLRjqrETdxU1Ocvsjr7OMP62VQr4e5X0ti/y1HzSOb5D
OCDHcy6TTLZYdRx8g6RgvUxuHth723Rp5XdwOuoFfj2Rk7Mu8OcFPohI9/wxkzbW
gBqVu/TprZJgfWDC5EbH9zcmfkUc5QdUVUNEQKCO3Be4XSat5EldmFo5nWDHRdSW
/NjsMUmTEWV9uHmXj33ESwV6lA+CgHdPHUfbBjXgb6LpLZJM40f1jdIlwEgpXue8
VNXlfPbn65nzfG8JGL9Mf58AYdBYlr8LGXRhPOPBNHcHfG9Ut5v+0M+0Lu6aAHL9
SZZWSfke1Vvr7irTiTm/JAQPd7yfh6c0NTi/XjqQ4pGmvSNbY6XDacD40Lc6m4SA
h55yw6E/JuXNda0vDSS0TvC7uuJDX9wum4cR6VxzI6tT9dr78RGDMxNRBoycjvn4
1diuy/JIE18idld7QK9P2s5WhleGP3lhn3XABym71ZscIJZ8qftOk/90kb4p6Ybe
udtgImN7nGvbnStfr8I8rS8lZHnrVbqbqGQx0s9lh0YKvMg+N66613VkUk7U5usn
rJdfP309X8cTr2YE4tpyJO749cfGvk+dIzcIa50HCNaRAeNPmNfL4RwxubA09dLL
HawEU9+x2dWguZvN47Au
=/Xmp
-----END PGP SIGNATURE-----

--wayzTnRSUXKNfBqd--
