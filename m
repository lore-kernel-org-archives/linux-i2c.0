From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/2] i2c: uniphier_f: add UniPhier FIFO-builtin I2C
 driver
Date: Fri, 23 Oct 2015 13:49:15 +0200
Message-ID: <20151023114915.GJ13380@katana>
References: <1445597520-6299-1-git-send-email-yamada.masahiro@socionext.com>
 <1445597520-6299-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcccYpVZDxQ8hzPO"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34881 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629AbbJWLtU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 23 Oct 2015 07:49:20 -0400
Content-Disposition: inline
In-Reply-To: <1445597520-6299-3-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-i2c@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Kamal Dasu <kdasu.kdev@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Ray Jui <rjui@broadcom.com>, David Box <david.e.box@linux.intel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Pawel Moll <pawel.moll@arm.com>, devicetree@vger.kernel.org, Beniamino Galvani <b.galvani@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Max Schwarz <max.schwarz@online.de>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Andrew Bresticker <abrestic@chromium.org>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Subhendu Sekhar Behera <sbehera@broadcom.com>


--HcccYpVZDxQ8hzPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2015 at 07:52:00PM +0900, Masahiro Yamada wrote:
> Add support for on-chip I2C controller used on newer UniPhier SoCs
> such as PH1-Pro4, PH1-Pro5, etc.  This adapter is equipped with
> 8-depth TX/RX FIFOs.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-next, thanks!


--HcccYpVZDxQ8hzPO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKh67AAoJEBQN5MwUoCm2AcEQAK1G4AiCdmua6Sk2+r2hsQHH
7/yHqS58TOzUItJ4FwP0zvMVf6UuNabOivF35eiwPJgVOGqNAI2Q3Twg2Yltrz3G
Fua38ArehrJiL7qOMa22bHFmGYjq8DlCpNyQsAdkmf0FK/gNd660McF6BXrmOJ7k
l76MOvOz+4cjB4pA0k/xwgqmY4ibOMAwlsX+Yd/iSnXwj64u9emxcBR8nYR5DRRL
OsnAHuqecmN0GVQAuSqcsalONdRrDe9rXzexe5wOUF80KXmtR4ESPQP3m8OpC5Tw
QDqK3IC/IbNu0FpAk0GP1eGyZtrCqj7FO6imNBmH47YSc9HA0HepLo+Zf9CRh3Io
16j3iTVuolYQqDbipxgnT1fGqpUvNlk/9yL8Us5WjPWO5DfI2RZuSlxJjqqFi7g+
CkqIm/SVOX689uFYsR+saZ3gNTTWdnloI28PxR1nZNqathLWXw0RYLmKKNErp7H2
HaUrfaqUMWWB/KuepDxFiDwSVBDy6gc3N6VLCxHg1/3WQMgaMqO4HdZYJbo0DaM9
OC1ttuo2Hx1sdicA52lBLW3zefUGxINs8/jpu+MUWhXsj6wH06MDHJ+3xmvcNFAa
lUIaTse/yPj2tiI8M5BhaIaH9KuWDszGGijqZdkcgdkU/Hgn99ysxXyUUClmUGYM
iIWk/GJXToqRyRaB0cat
=tzko
-----END PGP SIGNATURE-----

--HcccYpVZDxQ8hzPO--
