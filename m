From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/6] i2c: add 'set_sda' to bus_recovery_info
Date: Tue, 5 Dec 2017 11:32:24 +0100
Message-ID: <20171205103224.up4m6mse7dfztykb@ninjato>
References: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
 <20171204123640.3382-4-wsa+renesas@sang-engineering.com>
 <CACRpkdZzwo9UhT08VDHXg6=eXdK80Pt1omZ4Xda_HFwguyNpaw@mail.gmail.com>
 <53d5696c-6f0d-1717-5c9e-4facf397f284@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l2qins7dhwbzeb5p"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47955 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753120AbdLEKcZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 5 Dec 2017 05:32:25 -0500
Content-Disposition: inline
In-Reply-To: <53d5696c-6f0d-1717-5c9e-4facf397f284@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Andrzej Hajda <a.hajda@samsung.com>


--l2qins7dhwbzeb5p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Perhaps the docs need updating?
> as of 4.15-rc2 it says
>  * Return GPIOF_DIR_IN or GPIOF_DIR_OUT, or an error code in case of erro=
r.
>=20
> I can submit something if you wish.

They surely need updating. I was relying on exactly this information.


--l2qins7dhwbzeb5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlomdbgACgkQFA3kzBSg
KbbivA//X9BWsLUzv51igv49yHjLf7475VGO/iqIXvQ0A7/H4GrTWwzGdKVb5rNa
gJOo+pH0M6TL18sbZBDVgLIBZ7jSwb8eVkvXYzfBoJttJM5ZYh4RnXulcd+O5Osh
XTmiow4/sTHBR6zXeYnhouP43+PQXHCcB8c6DfU+ipQU8589GI8U5JBq+KtNYIE/
lGqGj6DubCW9Xut0QxZaOlR8npXIdh7gOpX1wc2oVilJdiydAqFQNgKqsnVzlPWW
mlg8TO6+DcxR02u1OGyedZIg0GQio2p/5SU8WWyfjOX8w6EpuC054zFlj7wKwQDC
SUvc0K/WUH6JixJzHguSFJb2Gp1gN53/tLy6LsxQiQdhzRZzLC6KUBhvZ4RSuGX0
CdC2B7vcaYs6UXZsyDx48FOizfjp7e+tkaZwQrDeYDKShnQ7xxYtzhs1+5qrHbbv
lf5foVaedjs2aHzr0fl46gd2wvEGvOSTuay/ioUVhwRa2AsGl8Hub2DPpzDlH9aP
Ab5gQmQIzdxRLubSy4OSnr7ShHx4SCoJRXxNHTLqBri3s8jWuSuwXD2y7O7ayKs2
zGcsb4CTqPkrf0XIf1t/OZCiBBZ1RnPuUB4u32NTMRUJLHhUxb4SY0oFdsLF0W3+
cJiNyXI5cHczADoQMEDJQ36ScMDTXxhP8rff9Dkig/rGWGzCQOo=
=uLo1
-----END PGP SIGNATURE-----

--l2qins7dhwbzeb5p--
