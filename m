From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Get selected speed mode sda-hold-time
 via ACPI
Date: Wed, 19 Apr 2017 20:57:07 +0200
Message-ID: <20170419185707.ufjpumkpydze2ats@ninjato>
References: <1490690882-11623-1-git-send-email-chin.yew.tan@intel.com>
 <1490690882-11623-2-git-send-email-chin.yew.tan@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lzqkibetosh46os5"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44501 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967011AbdDSS5J (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 19 Apr 2017 14:57:09 -0400
Content-Disposition: inline
In-Reply-To: <1490690882-11623-2-git-send-email-chin.yew.tan@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tan Chin Yew <chin.yew.tan@intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--lzqkibetosh46os5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 04:48:02PM +0800, Tan Chin Yew wrote:
> Sda-hold-time is an important parameter for tuning i2c to meet the
> electrical specification especially for high speed. I2C with incorrect
> sda-hold-time may cause lost arbitration error. Instead of loading all
> speed mode settings, only selected speed mode settings are loaded.
>=20
> Signed-off-by: Tan Chin Yew <chin.yew.tan@intel.com>

Applied to for-next, thanks!


--lzqkibetosh46os5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlj3swIACgkQFA3kzBSg
KbaFnBAApzmysQkn+B/7kDh2p/e6xCHCzQQexd+GNO0T2KzFVOfe40HCEAD/+3p1
mc/dJ/ynj1Q0o73ga8L5atVe21V8HZdnoq87MZ/wHsawkYN+oo27NAn+EVnk62Fi
wfNuFbMflRT8N2KmQ0JrXm1fCsOwYXgQYRP3tiymTtEZ9CN68m7nWEkzo3RNR5Z+
tJtT8YhkFLgTQatTF7beuz+VBFj/YoVZLd+H1Qkf7xKenLNWn88CLUQ0HwJIY6JI
wZYCLVQKPc5rngVFJY8pltaOQSKwHbl4bdTGegF5x0WLjEUKDqGsAwO3w5DMqBC9
bdebbE7bQSmh8ufHO/REViYTdnVNOzkAjQFvm3n/aZaUwoNecMisoPETE4KHtVb3
uzV6hSoqhw3GN6exWM1Him8MbPG6QZvMeb/8bqvm7twfkVJfaKKmmi6RfpCploAp
tjLKHmg3M262e0ESPoOjGwByogfZ8au1W0HuOLEE0uUPEwYw/gBQtxrfd0uTLLvd
Fq6UCFel46130gakK8vfowZieX7T4KKq92LRaJeJgIH1/pm2Zu1b/Ew/R3o1EM/u
Rl5MldibfH/yGZ1ioviTNTsM0Z+hWv5tmx2foFtcjo2Se+zs9MrJLVMRQBQfy9Kr
c9b2+m9oVdYEFf/m0lI1YPzJCT4GDhf0Q615nQJFpU00+/HmUMs=
=HeG/
-----END PGP SIGNATURE-----

--lzqkibetosh46os5--
