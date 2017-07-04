From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: acpi: Do not create i2c-clients for LNXVIDEO ACPI
 devices
Date: Tue, 4 Jul 2017 14:49:27 +0200
Message-ID: <20170704124927.GB5057@katana>
References: <20170704124613.14591-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:44270 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752241AbdGDMtf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 4 Jul 2017 08:49:35 -0400
Content-Disposition: inline
In-Reply-To: <20170704124613.14591-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	static const struct acpi_device_id video_device_ids[] = {

What about naming the array 'ignored_device_ids' to be more generic?


--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllbjtcACgkQFA3kzBSg
KbbTWQ//QMAjeutVWdS3u7AjOKINpb6o62gaS+cRMGcAakef6M/WDtnNh2FiFwX/
gcTTvGmnzfh3XKyU8ubl7IFRSAYwDhgGCTTNSAej2b7CH6nWUmojjaib/CZNv2vi
VM8KUqGVRk+1EP4Vq2q895GCUZ8ySTxfAUAXrCO7+hjOxvTBpu1MBvHZXO1Mb0Nl
RzDWMR9bzgiFsDPeAL/usjRXBxc9GORNJSJq62gka+Qnoqag/K8bk/DTgTXBolOA
TbZwwlhvumLnpJTGm1mKwJhJzkFXQVezIq3K8SmgRewRkMymPvRr1q5HpN1rIqkZ
pBaT7/9e8jk9GKVpnKCJVkuBHpD0lDT17W/efpFd4btXpVqLkIzHf8Ja+6JlUCYU
J4j7/ipxXFNfD6Pr2YTegMo/T2ibDzbSswdY4fi49j3P8iUbyUglPV4ZpZKq0iEJ
NeLQutYn+8cxjFBggPeufYo0LdQrDuM1PbNYtDNUXp/23Ti/uwag9ahTxGt/PuyX
v3bPtNQiZcppZrWBuNkUjR5LK9522sGXIO35d2a8ZTlxT2zYf6XX87D3JGpqIIg/
OpIiRnQ6EeIQw63CwWCLah7LAwYeZEUGESfRGM+KXCEwPA5HrCpPwYHl+zqr7uHd
r+XQyTSg8T8SmRquuRGRVh2G1ZdWiYRDaZA+jdcIYHeRmOnzjyA=
=xObO
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
