From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c: core: decrease reference count of device node in
 i2c_unregister_device
Date: Tue, 16 Jan 2018 00:02:09 +0100
Message-ID: <20180115230209.6atseekh5r7a2zd6@ninjato>
References: <1511766415-3732-1-git-send-email-alan.1.wang@nokia-sbell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jzd7at6szcexiiki"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:42246 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbeAOXCM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 Jan 2018 18:02:12 -0500
Content-Disposition: inline
In-Reply-To: <1511766415-3732-1-git-send-email-alan.1.wang@nokia-sbell.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lixin Wang <alan.1.wang@nokia-sbell.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--jzd7at6szcexiiki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2017 at 03:06:55PM +0800, Lixin Wang wrote:
> Reference count of device node was increased in of_i2c_register_device,
> but without decreasing it in i2c_unregister_device. Then the dynamically
> added device node will never be released.
> Fix this by adding the of_node_put.
>=20
> Signed-off-by: Lixin Wang <alan.1.wang@nokia-sbell.com>

Yes you are right! In my previous review, I mixed up
of_i2c_register_devices (with plural 's') with of_i2c_register_device
(without plural 's'). I could now verify your findings by rebinding an
adapter which had DT bindings for clients attached. With every rebind
cycle, the refcount for the client increased.

I did some rebasing, because your patch didn't apply to a v4.15
codebase. Now, applied to for-current, thanks!


--jzd7at6szcexiiki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpdMu0ACgkQFA3kzBSg
KbYkUg//Xqj7oM/qBV+0s0ancLA6qbuI5hxhCpHqGxKKtl/8lN8WHyn1ACNt7B5g
edFqOwHrJy2AZEnO1JExn+KLAvD8ZPz7bu4KeaWBWbjZYOVCTsfhC+AArbCccqte
I+bPhCWizEXQGvub336G4uWbtn78CRvwHs/xn0LrKrt+kd7XPVm89Xk+pP0ulrx0
43ITgD3Iao8f76KKBwx/GIS0PwjZBKoxNgEHjwk6jSJ50abZt/Rr4amp7d0mdKGW
/ianubfZzHEgGmaApQPtvyt1DcY6YX6UblsbUF+cqWxEFB4sGDKtyv3CpoLUotUx
Vn9QspmI9HHrHFNGvN3AI79XfWPmrnHzuI/v076Ptxjg0xl0vAGX6J+pS0gszDRh
OH6J6JoVb8bu7dYl6TXGyJYZi9IZ7fHgGtTUXKkdTNSfqYzNSbrqEgQTcPnSpWy3
L51C/AN+u8D3uUYmh0mYzOy+QmIEOJx6M3irg3CuokfQ4jGt37L3WlhlFS8dsFRG
gP4fQM23teGO8Mt58XVgpLmsE6o22FtL49SIZH+ZJ6YOch2jUluhOBmQsDA2ysMl
dWvV7QrfPdH3VS8MKfSadpEEcq47G8k6z9+s5JkIoJUvlc760nLtxwUdJ/iwaR+g
/9n4/qXOiqwKeVxy/P2FVVCabzoyf2SCBbS2L8dsCypQ5tLRLhI=
=I1Ae
-----END PGP SIGNATURE-----

--jzd7at6szcexiiki--
