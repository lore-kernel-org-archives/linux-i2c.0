From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/11] ASoC: fsl: add sgtl5000 clock
 support for imx-sgtl5000
Date: Fri, 27 Apr 2012 18:44:58 +0100
Message-ID: <20120427174457.GO18260@opensource.wolfsonmicro.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
	<1335510185-7906-4-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8311003011852362744=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1335510185-7906-4-git-send-email-richard.zhao@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, w.sang@pengutronix.de, Richard Zhao <richard.zhao@linaro.org>, linux-i2c@vger.kernel.org, kernel@pengutronix.de, dan.j.williams@intel.com, shawn.guo@linaro.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============8311003011852362744==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E+IgQzR66AIOcbjA"
Content-Disposition: inline


--E+IgQzR66AIOcbjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 27, 2012 at 03:02:57PM +0800, Richard Zhao wrote:
> From: Richard Zhao <richard.zhao@linaro.org>
>=20
> It tries to clk_get the clock. And if it failed, it assumes the clock
> by default enabled.

Applied, thanks.

--E+IgQzR66AIOcbjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmtsEAAoJEBus8iNuMP3d0I4P/2QGr3LdS2HVRqsCVpjZWb62
3l9hSCPW/B15tVlFikBqsi5UBKCmiRNARhy1IaUyUIa906aKYLokA8Q5CZbok13B
kjkFxWGcYX1Wt+HfqVk2hZm2ydoBzALZGG6/H6RFBH+z+V6vcaH4nfKT0n3/90WG
Mvnsb9uUwNjRS2HBtZKyYP1OzFtcihDQLVTKveZpFc4VydycqaNK6DLBbLhyYmFq
GAGh9/cTrNEEBRN4MbdaVc0PcdmV6fsY+vCCWK3eAf4odVmepqnT/Z3+Ib7J+ucn
srueSLtZmVEb7Ou81Ygg0bXd/xhIicMtLzyT9TGR8sDdHsyt3YL9yT8fxedHF27k
+iT6SgBkXSnaP0nbagBrR/ZtBUDORqzshG0cLnpZEDZ/85xrbiRpJPUCfoJ9HBFe
gM34KaNVlcBEPLF20+fgaFOYr4gCpRbu/ozOfhePZfW3bS/vMjKX9jULg35UOlGL
xIZZuWhxPNC08xzQ/mdNkqadgOMo2M8fSyAEMIBhjk/Z+rHP3ez0LgO6PtC0FMe9
XZ6b7aygJ6b4X0GPs8xofBte66WLgW2efNMKVJ0ZRH/mfTde0F7IN16CI6Fqwkf5
DAz7c+dn6Afi4fZqk5yaEIx0i1/7+e5tJew65Nhoz0oyrV34AAJfsFQX+ztVs2Vc
q8pjCI+AvHnZfE3n3yCy
=/4JG
-----END PGP SIGNATURE-----

--E+IgQzR66AIOcbjA--

--===============8311003011852362744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8311003011852362744==--
