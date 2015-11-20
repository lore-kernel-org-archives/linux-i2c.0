From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv8 1/5] i2c: imx: fix a compiling error
Date: Fri, 20 Nov 2015 15:59:13 +0100
Message-ID: <20151120145913.GB1752@katana>
References: <1447754002-40555-1-git-send-email-Zhiqiang.Hou@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1027109964180110760=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1447754002-40555-1-git-send-email-Zhiqiang.Hou@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhiqiang Hou <Zhiqiang.Hou@freescale.com>
Cc: mark.rutland@arm.com, corbet@lwn.net, sboyd@codeaurora.org, B48286@freescale.com, linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org, bhupesh.sharma@freescale.com, catalin.marinas@arm.com, mturquette@baylibre.com, linux@roeck-us.net, will.deacon@arm.com, wim@iguana.be, linux-i2c@vger.kernel.org, Wenbin.Song@freescale.com, scottwood@freescale.com, Mingkai.Hu@freescale.com, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shaohui.Xie@freescale.com
List-Id: linux-i2c@vger.kernel.org


--===============1027109964180110760==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2015 at 05:53:18PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@freescale.com>
>=20
> drivers/i2c/busses/i2c-imx.c:978:2: error: implicit declaration of
> function =E2=80=98pinctrl_select_state=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]
>   pinctrl_select_state(i2c_imx->pinctrl, i2c_imx->pinctrl_pins_gpio);
>   ^
>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@freescale.com>

Applied to for-current, thanks!


--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWTzVBAAoJEBQN5MwUoCm2y8UP/0gfMsczqO2iwBCCPslkIE4m
8ABnrXW3RsbF+ox1EAEtpY/d4Sc9PNpRqqh5Zf3VNm8UU36rbn/2DP3yNqNwybv4
mK+uQWOUI3pIbMaxWj61smKp2tG4ZorPqOlMeD7fdalEHk/HAIsKLqmxFgF2wRIH
23JjjQxXDrlNeS4whSD/RZpgjnoon812OfGQM3qbMaZpylVGDByqCXdXOcAM0T6W
XbYK4BAnpK9bYQCpT/aL0YnBroq1a5ojaj0rVAJQSoAi1bIYHKdSrHxT11aqzGlQ
ZlHPgUV2BEmyOJarQ6DOytuwIjt1qaFgdBHq533+9udvGc5s+oaMtWN///PMlyKo
u9RQZXLSJJKHpgNa38qhGNkoYqLroS6cc3Vyxlzief6Qrobvq87LZZWkQpyU6St1
SYaK4W/3NpLgj2ZZvyW5FyMQWNHw8BC95VvImK//UTzUrl5kjdg6RjOE/b+1gGCQ
Sl9jm1sMrOdrGGd9pxqyW9PQIbKm/KykcI12+SUcwmD0UMs3cW3FLIul9Zut4/vD
uUiGU42wdtUiJZOcWeNHRV5pN+lJwaaQBc+OydOJF8XTW+OJNNbf+0TWxWuAFXZg
gLWbojrPBgRP9MfRVbD3QMg4j/RYH3ZutKay7cZ31KREM7izS/GlAAO1dH3k/hhP
UZH3iDoESnT9U92Bwa2R
=vItH
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--


--===============1027109964180110760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1027109964180110760==--
