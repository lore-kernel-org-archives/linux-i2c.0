From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1] i2c: aspeed: fixed potential null pointer dereference
Date: Sat, 12 Aug 2017 13:32:50 +0200
Message-ID: <20170812113250.iydbbggbcvfvhxyo@ninjato>
References: <20170729010012.5032-1-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v4pwb3ql6rtpdzc6"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:42738 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbdHLLcw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 12 Aug 2017 07:32:52 -0400
Content-Disposition: inline
In-Reply-To: <20170729010012.5032-1-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: benh@kernel.crashing.org, joel@jms.id.au, venture@google.com, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org


--v4pwb3ql6rtpdzc6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 06:00:12PM -0700, Brendan Higgins wrote:
> Before I skipped null checks when the master is in the STOP state; this
> fixes that.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Is there a suitable "Fixes:" tag for this?


--v4pwb3ql6rtpdzc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmO52IACgkQFA3kzBSg
KbY2CQ/+Lxze5qPyy9atMVEydykqYJU5F1NFE5B9ps/wfvZvs1i0ndiRa/BKCHj/
XslkQsH+bIHJRXaOmj9UkGscUOnff4gUn+YOQ0U+6TCmET0rujLpRoBNEP0VWj5b
drhhHd5/zPEKU3e3r7uualNxuDpv8JRZco9JCwC8Jp0DnW3mu4kIy2TV9dzgs7Pw
H3SrUknCzpIx4RxpUafSSiG3ueqmnrDHHkwevYJd5NojMru25/9xbawOb4kXlCnW
PMlkuBzXG9Od8uBVsTLSooG8DOCjKmR5z5nqoyBXeSTpwJXBFfmTrnHlnEuLyTBj
8Mu4kntUvb7v19gXaTnTr/G8wkLxuiHztwTA8WE3hj/8cCWDp6KZ4tdntYdxNbOK
7Cl17i7tBtkU8Bh73hMdU7gPh0PCL45sjR1qD2l+AZSjdW9oP16sqV7kPWCXIRhe
hsRguDM7iADHbtsSoMnhjbFrNl62N21Nhmdj4cZflvOk7M66eu31wd0aRZQlYAdo
Dt8D05z9FdCowhbS1ONv4OswNxMFkyBt7R61EWK0shjtcJFtU+1f+w8RBSaltq5k
Vsroax95+GsmpeDNjCdqdKz6LH+UAS6AKsNwxWlP+uLDKIraVWM8yPXY9aaL9g6c
EYCNj+rwmLH4xpWHqK6g5XAsHoUCvFHnCCUj/h8Dfybrujvgtcc=
=9OJ2
-----END PGP SIGNATURE-----

--v4pwb3ql6rtpdzc6--
