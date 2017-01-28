From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [v3] i2c: i2c-cros-ec-tunnel: Reduce logging noise
Date: Sat, 28 Jan 2017 22:18:29 +0100
Message-ID: <20170128211829.ojuqhllgqjmkgkui@ninjato>
References: <1469572441-25026-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ckcqt5zx34l7v2d"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60166 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1752145AbdA1VUK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 28 Jan 2017 16:20:10 -0500
Content-Disposition: inline
In-Reply-To: <1469572441-25026-1-git-send-email-linux@roeck-us.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: dianders@chromium.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--3ckcqt5zx34l7v2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 26, 2016 at 03:34:01PM -0700, Guenter Roeck wrote:
> If an i2c access through i2c-cros-ec-tunnel returns an error, the followi=
ng
> log message is seen on the console.
>=20
> cros-ec-i2c-tunnel ff200000.spi:ec@0:i2c-tunnel:
> 			Error parsing EC i2c message -121
>=20
> This can happen a lot if, for example, the i2c-detect command is executed.
>=20
> Since it is perfectly normal for an i2c controller to report an error,
> drop the message. Also, report -ENXIO instead of -EREMOTEIO if the access
> error is due to NAK from the device, and return -EIO instead of -EREMOTEIO
> for other errors, as suggested in Documentation/i2c/fault-codes.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Applied to for-next, thanks!


--3ckcqt5zx34l7v2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliNCqUACgkQFA3kzBSg
KbZ60g//XRfQGkWC9UU/IRZpp7zlW29+I3f6ohMyP9ttTmnmq0moze8lPOTxgC19
41BHs+t1LfdpqCMGoyGeE2ymgBtqh9yPzaUooddRVYf0IIMH43AChnIe4cXzDBpS
U+u9G8HPzL/1oP34jkKWv5cz050pDjUqj0sr2+EZcTk8cW7SlYUJrSVSXy5GJUzd
7O/Y2rIK65kLCjqOmQZCkvgnd2nU08y82iWIoi4TmR5EwlXaeYDVpyCTImTqyo7k
zSltka23sG+iiGVVaO2J9SmAPHpKWpHHzT7kksU1rwG8JTCQC8vysVa9Xx9nyqyI
4oWZxYo2nRY0bS4qn5tcqhg4lmcyv7Gr5/8/z8KoyejNUK5iZDY/aMqpYoGHivcv
Dm4vxmIBk05Rn90N3G4pUFET51Z+fPb8gIdfHOEVtdDXE+5tPdh6HM4Qb2MqMNQQ
MMpGV8PplnkKqeS2Pf2rUl128GFfcfdU5NMGCTwIUv+RoubO6kQ1HkFhhA3OualD
j7/0kZLwuYV8p4Ax8nCJYckzNFKp4Li0j2Q5d0oecVWDsSFnocWC2JWo+RkdXXgb
9kEjglITBgAIvFuKzZnAShJnm/VzQwWSBmLrChf26mL/OGVoNdHA1W3v3pk/qnhZ
pgv5CaVgQ+QAxvAR7AwjcqJDdu6hfTzk6F8eVZLa+N4SvVOfvs0=
=wel8
-----END PGP SIGNATURE-----

--3ckcqt5zx34l7v2d--
