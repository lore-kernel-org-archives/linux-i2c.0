From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: at91: change log when dma configuration fails
Date: Thu, 26 May 2016 20:57:29 +0200
Message-ID: <20160526185729.GE1614@katana>
References: <1463745991-26257-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43782 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754758AbcEZS5e (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 26 May 2016 14:57:34 -0400
Content-Disposition: inline
In-Reply-To: <1463745991-26257-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, dgilbert@interlog.com, nicolas.ferre@atmel.com


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 20, 2016 at 02:06:31PM +0200, Ludovic Desroches wrote:
> When the DMA configuration fails, there is a log reporting that we can't
> use DMA and indicating the error number. When booting the kernel, it is
> annoying to see this error number. Moreover, people can think something
> is going wrong. It is not the case, it means that DMA can't be used but
> it doesn't prevent to use i2c.
>=20
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Applied to for-next, thanks!


--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXR0cYAAoJEBQN5MwUoCm2lCEQAICF8pS1IclInMjgJ/gkeoh+
Gy5ByMXhSShEbWvWcjA3nWs7hvYBh/sPeiyH0fNSudZbNNC2e+CYZOei7kr4oXMC
Q7/EZVhIihGOfzYyYHZnquKxJj48FY+5vEBnWTZQFiv7JIjExez2QD/GX1iNgsm5
eS06fmmMqkLjLbFMqL4VMsGkBaEW5Z32ZnBT3WsMHuZe3OHC3WUnRbMe4RoLxaYo
cLB//XyMrNuCXmO5EK/fUxPz6uZx9oLRLjwY4ppIv13aS7QhnubntwiNdGeHoUbg
OT+FRF9GS4ST3/wXQd1LKSnHJ53/crt2gvPJGF5Ck9JtCruvYpPmy0cWm/VI5+0i
qEgLMg+4G3pK57gaWHmwtafmHLdQJ8pXfm/b0Xy36cIisC36l952cG8wphVRaJ1/
v9rQp000F68KdYxAMt3cC5BncwSatXeFyx+UTL6Ep1vMELFEI4lFTjaj2xQ4/k43
F6RaePVn6rvNk+FqqOt6XfaMA0w90b12GFytdLM7cjQuYIzb/eu9R2ynhOsWp6wK
tJJc46/GOlmqcU/h+GSPzgXNGk6+ZrWpj6Y8vvi0SVKNRVt6zsmSVKlRzeYp+9Yr
AUIaybpnDLJROxqrblnEizdhJKVKcKGiPyZ3V1JEoywfkgyFRAk2yhdPfGqeBwkE
2/NF6m9Ht+L6glVo0rRY
=q3jV
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
