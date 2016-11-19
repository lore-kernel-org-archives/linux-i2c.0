From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH] i2c: i2c-mux-pca954x: fix deselect enabling for
 device-tree
Date: Sat, 19 Nov 2016 21:49:58 +0100
Message-ID: <20161119204958.GA2856@katana>
References: <1479548918-21006-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:52872 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752881AbcKSUuB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 19 Nov 2016 15:50:01 -0500
Content-Disposition: inline
In-Reply-To: <1479548918-21006-1-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Alex Hemme <ahemme@cisco.com>, Wolfram Sang <wsa@the-dreams.de>, MakeB <mabnhdev@gmail.com>, linux-i2c@vger.kernel.org, stable@vger.kernel.org, Ziyang Wu <ziywu@cisco.com>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 19, 2016 at 10:48:38AM +0100, Peter Rosin wrote:
> From: Alex Hemme <ahemme@cisco.com>
>=20
> Deselect functionality can be ignored for device-trees with
> "i2c-mux-idle-disconnect" entries if no platform_data is available.
> By enabling the deselect functionality outside the platform_data
> block the logic works as it did in previous kernels.
>=20
> Fixes: 7fcac9807175 ("i2c: i2c-mux-pca954x: convert to use an explicit i2=
c mux core")
> Cc: <stable@vger.kernel.org> # v4.7+
> Signed-off-by: Alex Hemme <ahemme@cisco.com>
> Signed-off-by: Ziyang Wu <ziywu@cisco.com>
> [touched up a few minor issues /peda]
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to for-current, thanks!


--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYMLr2AAoJEBQN5MwUoCm2A6gP/3mDY0IT6gwqbYFCUOK4twSk
0uVrmn3ZdqtY2QUUukk4kl0GjI7a+IthzaUp/S39OqC8cdLP9dON0NebLXdZZQ+P
6ToorI7LVF1RQAqDFQy3+NfO2sUYgCs4f6G1pn707RgRYjrUTt6wu8pvlpJe86r/
uDYnKKtV3IS8XZCElZMTBF4lzAQNwH+KzsOB2Ya2O/A8+Jx5SDqaFcP8M38AaceA
IEYskrlG4rWOCC8s3KGcZKOZtUUkTY3pysl8K/JFH+9zdXQ+GwFY1/jiyH9yqybB
XN/BK4vG+x41btQY0Wxfq/oHXPFVMwoy2TEu0uZGwA7RZAYW28MyVOr6WTi/07dS
ysnCqG7NiIcXDeOWKp3r1glaB4lI27PH/ddo6LNKFpUXtInGhFK28Yr25DFnipfP
36eYlCWEvyogZnycUjf6AJXNicmKEn2K0hEE9ybwgV+XbFaHUbTWpcm1eRu0UZ1u
RmgYVRtVavnxUUo+20i7wWqqWJwGwZiHMzu0oJRv61vNyQS0jNVNC7mqRGFaalA1
BU0vifTKfVbSbv4WdJ1MkyDMTgaHXoQUpFi8lc11OdwqPswP8uNB5skObvz551HS
gtP0RKEeRS4Oo/pOZ7EUbIxDtbWdNbsKg/DEDkVzXDr4Bn0+Evf340c0SMvYPq9i
pCFpPoD6XfShmst7xvbt
=tlee
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
