From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] i2c: {sh_mobile,rcar}: Trivial fixes of smatch
 warnings
Date: Thu, 17 Aug 2017 17:50:20 +0200
Message-ID: <20170817155020.wuhcsuc4m5wx56rc@ninjato>
References: <20170815203624.19274-1-erosca@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n3l4bheevrvl7opj"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:60257 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbdHQPuW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Aug 2017 11:50:22 -0400
Content-Disposition: inline
In-Reply-To: <20170815203624.19274-1-erosca@de.adit-jv.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org


--n3l4bheevrvl7opj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Eugeniu,

> These simple fixes make smatch happy.

Ah, thanks! I use smatch, too, but always compile with DEBUG, so this
went unnoticed.

> Thanks for taking them into account.

Sure, I just dropped the fixes tags. Thanks for supplying those, but
fixing smatch warnings is not enough reason to go back to stable
releases unless it fixes a real bug.

Regards,

   Wolfram


--n3l4bheevrvl7opj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmVuzsACgkQFA3kzBSg
KbZ7tw//ZQcXLz3RHv6NjeZmq61WXZ1i/q3Ob0ShfJdDUoLMgdRI5/GQJ4CPVDub
BVmPxQoYcijtk0BF7c50zpdV6E/bhxK9aWixcxXFc9s5ah2omuihsEknP4ElCLdA
AgsrIQTcpv3eaHd+qAu83nFfucKVVS8PZl3g0QThEYk3eOGPviE2E66f3w9s48Nm
ixTTGtpbwMnUk1JTE7RfFE9jqJefMH27nsEM6t7npGdJyY1z+VQssZbx6WuLBqCe
MedUApImZHMPVx5DyviQnYwGQW9YBrtvprJbmB/RE3srkzBgYXnGp9z3jXVc5hCG
qBC+ILsIJH30PUgyaOgQFntw5BAOOKHvca4caHm6/cZ3i8pbk98zmoeCWeqInCa5
4SLhJ3OASg8ekQtj+uwaWdJGl6zkydoV51+UOLCL2mCfrhWl9mk4MYMajdYBo2Bo
32osx2UuoyBakB9waB5Tw3OeYoWNUojc+Q1zHyuXfVuC9jDiURWaU9ZqAWlZTaFr
/8aJ3YMex0f8+GN6edf3B0nYOZiCyJAsStGMnmx9VU+HoVIL6U0zQCUjZ+H0k6X/
MpHa8qRLdRJVPFKv1nb6Fn68XzONvf2WmA6PO5uc+QQMI5zfot5tBP/DETCEfajg
g2C8gONDSSLhfl1vBOvXZOhfeBbPjGa47vKDgBjEnvoEVO20Gik=
=oxH1
-----END PGP SIGNATURE-----

--n3l4bheevrvl7opj--
