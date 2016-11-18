From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: i2c: xlp9xx: ACPI support for I2C clients
Date: Fri, 18 Nov 2016 02:27:49 +0100
Message-ID: <20161118012749.GA8206@katana>
References: <1473967659-9000-1-git-send-email-tanmay.jagdale@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:56476 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751389AbcKRB1v (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Nov 2016 20:27:51 -0500
Content-Disposition: inline
In-Reply-To: <1473967659-9000-1-git-send-email-tanmay.jagdale@broadcom.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tanmay Jagdale <tanmay.jagdale@broadcom.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, jayachandran.chandrashekaran@broadcom.com


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 16, 2016 at 12:57:39AM +0530, Tanmay Jagdale wrote:
> The ACPI companion of the adapter has to be set for I2C controller
> code to read and attach the slave devices described in the ACPI table
> with the I2CSerialBus resource descriptor. Used ACPI_COMPANION_SET
> macro to set this.
>=20
> Signed-off-by: Tanmay Jagdale <tanmay.jagdale@broadcom.com>

Applied to for-next, but please fix review comments yourself next time.


--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYLlkVAAoJEBQN5MwUoCm2b3AP/1cpwKhC724RUC5NbGi5UZ7Q
7j/XPkncTbMlTt4ovW3OC0hUjACwjLK3DCAV/X5imFLcbZFNgQ0sjtPcSmV/mcZl
7pPaRZQ9vXQpl+xKpd5sK081c1p1uKkD3XO7XcaDF992bI3L80XhWxzENyAiaT6a
MR8NYkSrMMBNROO3CkzxOrB42y4Z3mratXxTA5ciVgz8afzYiPG8SIMBxPjJ4xUm
Y5On4IfT4vO76pEcLycGcItLYs5gima0ItUMkYiGPIiPlYsmwU/M8Qs6JrB3qiRN
ZRVNgq7SnOlRTCQ8kilgMhN5TCmrYZQC+/BncIPOgxHEG3LcpwtuNCy9gS6yQ/M7
MIs3a1ZkPXF0w/Bpl7OO767jTg4ZIrTEq60MP9bm8zifzJk2Fm8mTskU3PxI20p5
nu3psunX/OP0BhNoC/dtIz9j64qUN6SFJWCFBgYT95HANgAJhBV40dvzGpPGz3Ll
rFnHZDiVKaechYWY2iz1R24Z7vHSWjoiH6aecfSn08uc8fzAFNgRKaWtd1nxXei3
XB7rJuhLRaIGd4F8eKhglbkc7T2QBhHJn2O3FL+arhtAZFPtQRj3m6l+QiI8Hx0e
AtWmu1jg4psmkVTYk4KcFl7PXajiXRC2Q7gRT1wWc8ECRSHakPMi344xw1YYnxIJ
RwFLBWmxK3FQ2BLrOhtf
=yil0
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
