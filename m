From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 08/11] ARM: dts: imx6q-sabrelite: add
 sound device imx6q-sabrelite-sgtl5000
Date: Thu, 10 May 2012 10:45:08 +0100
Message-ID: <20120510094508.GN3908@opensource.wolfsonmicro.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
	<1336563190-19974-9-git-send-email-richard.zhao@freescale.com>
	<20120510064816.GC17875@S2101-09.ap.freescale.net>
	<20120510093444.GI2982@b20223-02.ap.freescale.net>
	<20120510094113.GG17875@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0138696157441284565=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120510094113.GG17875@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, vinod.koul@intel.com, w.sang@pengutronix.de, timur@freescale.com, Richard Zhao <richard.zhao@freescale.com>, linux-i2c@vger.kernel.org, kernel@pengutronix.de, dan.j.williams@intel.com, dong.aisheng@linaro.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============0138696157441284565==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2+jOUFLb7N+7fooZ"
Content-Disposition: inline


--2+jOUFLb7N+7fooZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 10, 2012 at 05:41:15PM +0800, Shawn Guo wrote:

> The "Mic Bias" here is really a SGTL5000 internal supply.

If it is then what's providing the bias to the mic?  It's common for
chips to have a micbias supply which comes out of the chip and is used
by mics, this is my understanding of what this circuit is.

--2+jOUFLb7N+7fooZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPq44dAAoJEBus8iNuMP3dnJUP/RMY9Px3dNOwkBkUKZQ5K571
oMXj1mYt58XstyO261dgH9IY0H8IimuhIL0BJF7MZ7mMiZnnrT0hs2V1/IbaPkId
Enwn9nIAlFrInJpFXHjp97mlhLbS69RgmgNdx4E4Y47YmzalbCiZ5h/i6i0K9J2h
REb9TbRzqXyzvNGmJCQZ7yTq/dSZqc0j1byROvDSkUxGQwmXImRKjdr9NtgXwyqJ
hZT1OW79ipgB9ITwll+VA1q//tzskr74bliCXKtW4DOlujXzbm6CFx8A9IxseN4S
hD1sDrx7EC40S8NOZrO3KpIMQqLbsr2+80LTCguQVqGxeoeFvq1c0b2zciyTKZMu
WKMNmFBpVP/RWWhXZRmVMoJ2uMYgcBaEZJk2g3oH4HZneS2DUklltS53zDFPBl+o
/4U8m4vqXMm/g2Mc/oOOAoBsLnFmUrX1L8caPanNRI5ZGy4BbrB01RA9MAbutwDV
3OCX52JfvUTIl4nOzpnaUOb/N25JQPVSipaPU5f9K1+dwI8KmHqp6U+fs1VcHE5w
z7Hh5iTJVKqE70MMpCXZXvi1gI8Xc3QkKyXGqWxE2QatUuAxnaOL1g0TgcHNTDwa
4DMHeeLEmmAKZMT29VadShsiYJDQ6B3RJb+HU4berzZvpOFXIaESGMWFK8uLN/Ar
gex62XpbeIdBL3No1Xpq
=tJAG
-----END PGP SIGNATURE-----

--2+jOUFLb7N+7fooZ--

--===============0138696157441284565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0138696157441284565==--
