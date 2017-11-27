From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: core: decrease reference count of device node in
 i2c_unregister_device
Date: Mon, 27 Nov 2017 19:21:45 +0100
Message-ID: <20171127182145.q4tju5ikw56nygki@ninjato>
References: <1511766415-3732-1-git-send-email-alan.1.wang@nokia-sbell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oowcfhab7gakra5h"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47953 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752430AbdK0SVr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Nov 2017 13:21:47 -0500
Content-Disposition: inline
In-Reply-To: <1511766415-3732-1-git-send-email-alan.1.wang@nokia-sbell.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lixin Wang <alan.1.wang@nokia-sbell.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--oowcfhab7gakra5h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2017 at 03:06:55PM +0800, Lixin Wang wrote:
> Reference count of device node was increased in of_i2c_register_device,
> but without decreasing it in i2c_unregister_device.=20

Huh, there is an of_node_put(bus) in of_i2c_register_device?

> Then the dynamically
> added device node will never be released.

Strange. Can you provide your test case, please?


--oowcfhab7gakra5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlocV6gACgkQFA3kzBSg
KbYzdQ//VjWtwBItISZqjr0FoAG4utxMTrA9d6sLjQgwP8HmKOohx3fkKZyw6LqC
3LpnS/sVCgbKi6xiK6ValRN70VyLsZukBiC//312BFNRUpDkk2k4s+xRI1HvMiaX
faoOVMSl1bFw+nN5fgowzlCcudQA5ic0TPq7H74cMnXQZFU1X4cjhdfisDiZcK9+
lZlShFIvvM8EThvyp+Vg/EeyIki7MH+NHMJbVNfwxiQ9WT2+fuMxmCiCznqvqAgd
MwaCajgK4m6EUAu3eg8PM6shW2ZjPxIjRfa303RJ6D7eh5TluRNg3vodO25Ut1cv
eF4VCZXL4BTKouetUlfFpAWildiguGENaYU9uce3KxVIjDKpdKh796+PgmzqIixI
bcUl73X1uYDDb2e8Vv3ooPkAOYIrxgLfct1ogolXuyw+Ns4PrvltINfckcZxCJp1
2yRr6xEQzZZKrySo0UBfoQEz/Xb4StDbgZ0HkR2vgjoMh8KNdjUYhCZw8MOjgbKf
0an/1a8gXTsERSbuqZpZ1Y+ETseQkdrmXzFcGvoK0E+jf2HIGZM8LZqqUKm2cuYW
EmryXgKScCxAiY+A9OmbOWxpbIjF5/6McIiAxq5/OjiX6B3ntNeBrer7shYGMofE
zOgf/m2yadPV19nawYA5c3V/1fUYD0fLNwWbZZs8bw0WN9E9XCs=
=A+7S
-----END PGP SIGNATURE-----

--oowcfhab7gakra5h--
