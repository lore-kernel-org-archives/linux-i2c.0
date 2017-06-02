From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: stub: use pr_fmt
Date: Fri, 2 Jun 2017 22:49:56 +0200
Message-ID: <20170602204956.n7cdqacq3abtwyyv@ninjato>
References: <20170516112105.2793-1-wsa+renesas@sang-engineering.com>
 <20170516112105.2793-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bdac42fytg3u6azf"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:43823 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbdFBUt6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 2 Jun 2017 16:49:58 -0400
Content-Disposition: inline
In-Reply-To: <20170516112105.2793-2-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, linux-renesas-soc@vger.kernel.org


--bdac42fytg3u6azf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2017 at 01:21:05PM +0200, Wolfram Sang wrote:
> Instead of hard coding "i2c-stub:", let's use the pr_fmt mechanism to
> achieve the same more easily. This makes it easier to stay consistent
> when adding new messages. Also, remove an unneeded OOM message while we
> are here.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--bdac42fytg3u6azf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkxz3AACgkQFA3kzBSg
Kbb0vxAApzVc3yFCM51L26EvNHq8tA7802YPXxYiXdA5m2ZBsTOXM2gNsoq00Zzy
ht0GxvbmqowxuqExnfnpyQOURfKFe7Nu67GteBLkjlweh+1Ua6OVrd95mgRxH9hD
8dviDlyzh07AR8fiKGQY7Q8Ma8w6iDBMX68dGe7I6aIT7O/qhgOnLbzIrjHOOPLd
6Jb8t4nEx9o21SLLXVUD7p16P6legSuUfBKv5kb0XMphBaxnfYjwoGp5nRh3l9ZD
ekdzjqb08awzwxoRpIbkuhAIcZPVtt371cDy5vrS75487rNDCXaojbf62ywbVdvS
BaAttF/M2gp+MdYTZmiUsH1KJpzN1QCRbwv4DNS9eT0u0+K4Ih1xIyRBb3IKxCDA
2FRuFHIiL/m1jEqkBrrdyroeC6ViwPSeTo7EEw3Wznnl6OjlK4tIEK8j9gWiMJAC
10vKd8re2kQOp9MwiGGQ/sVtXl21MFJTJP6cr76hMXencAeWm9aAooH8CmYDFQ/3
/oYEJ4S6DZAe4Twit0wPhYvZVUGFyo/0MPkjhJFbMwYMPtsmGW/URK5DDPR5kvfS
9Shr9/ulIRg/mY+9ibapNRHsbA6hrqBiaQbdkBvSMnhOoIyAKQKKoQm3XSBYm+Oz
TkjsME5kjkTRdKmea1ZeRdBD/ftqsoIQvD9pxeojazoBaH1qGig=
=zeYu
-----END PGP SIGNATURE-----

--bdac42fytg3u6azf--
