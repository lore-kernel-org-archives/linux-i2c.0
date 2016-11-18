From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [-next] i2c: digicolor: use clk_disable_unprepare instead of
 clk_unprepare
Date: Fri, 18 Nov 2016 01:48:47 +0100
Message-ID: <20161118004847.GA9905@katana>
References: <1477758677-7831-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:39244 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753040AbcKRAsu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Nov 2016 19:48:50 -0500
Content-Disposition: inline
In-Reply-To: <1477758677-7831-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Baruch Siach <baruch@tkos.co.il>, Wei Yongjun <weiyongjun1@huawei.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 29, 2016 at 04:31:17PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>=20
> since clk_prepare_enable() is used to get i2c->clk, we should
> use clk_disable_unprepare() to release it for the error path.
>=20
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Acked-by: Baruch Siach <baruch@tkos.co.il>

Applied to for-current, thanks!


--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYLk/vAAoJEBQN5MwUoCm2vh0P/1hsIog2TRlipLDc/vpZAit9
xlNxY28aHZUpEOufD6FU4ne6bY7Kx8mU7z4SbgJ35mwlpk1fAY8/EABoCm6fWIEF
2ABz/mfuVzZM/zewDoRBJNOt57woH0OBMcep5MBjUwG3KA+OpXGI9n4qvNdV7C4k
5r4tMyML5eP7Y1wzZIhOQVCfuGMUXIFM2kzpsVdor4ncQOcTJ/Tytbcd3yAtp0d1
AujG29mmSz2izzuY8iCWtRg4RBZ4fhPuJCKurN/9JSmZoRq4t97MBRRQVLtjmxoA
oyQT6xpHy9hE8j4+IbaoGfg+7VYIIJqDxp1Y+cXcibp9b64Japo90dWB56DHZ/40
vgFDeBTPrbKq1OHHFFkVckAk+I/gD1gDYmkAsqBJSMMUN9UZ4JUZZ/0Be8NVa2Wl
Z/NiAnyH/zsw3dc0Pl9wAkdkXXge6+Fc9p5P8OWR6NPcieujYVWDwyDedY28qpZz
M5679tZ86Gr6ms/VheF++suHQZJojp7q/36mg17MH3TPsiiYXHHJkiNj91Zr/vvm
hmT/h1wlyr89QCP5ao2tMiu8M6m391VepN+zqlcr3E+IJ3HBw6+9npDl9jLaAgeB
z6p8Od5TEg5MOi/ASOgmE2nuXjCjphuSlz26fjVaGAF7oX02QKUWTx/4a+c/6W44
wzF/hFMZMRWPgptQM/8J
=iFVt
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
