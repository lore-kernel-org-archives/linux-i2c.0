From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] ARM: pxa: move pxa-i2c.h to platform_data
Date: Sun, 5 Nov 2017 23:08:45 +0100
Message-ID: <20171105220845.edwugarkt2te7ak4@ninjato>
References: <20171105141226.13624-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="it2mhh3fu2wgikzb"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48565 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751030AbdKEWIv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 5 Nov 2017 17:08:51 -0500
Content-Disposition: inline
In-Reply-To: <20171105141226.13624-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>


--it2mhh3fu2wgikzb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> As discussed previously, we move the declarations now to devices.h and the
> platform_data to the platform_data directory. Only build tested, but buildbot
> is happy.

Well, after the initial success message, it looks Buildbot is not happy,
after all. It found 3 more boards which needed to include "devices.h". I
did some own scanning and pushed out an improved patchset. I will wait
a bit longer for reports this time, too.

But this series should still give you an idea about the approach.


--it2mhh3fu2wgikzb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln/i+0ACgkQFA3kzBSg
KbYH7Q//fv2u0h+7cdb5tD5kM/0DdIi2xsxuHOL5GHi7/5XpOb7JPiwmqLWlykpf
xR8bWUbT76xns1+TbZN/7RkOg/8kK8lVi6CxiH19b8x7jyvrCvip+Z/ukSvLH2Xm
aRmdZ05e6/GJ8dL5848+ElFFclhGEZAkPDhEa1sJSn8H8Dgn+dc8gU4HDplJJfRG
lb3g7ZSgrSjgO3/UJHqE3M5yzZ+0RFPtKpHGwskm8Uh7lTLgiYIHFr3l1gCD9Uex
1fgFTWS56wvUOqub+rG8Yt+O4SJsqoYW7ZafN7QezBSBGkivm9YnevFgmDBWP/pd
jotMkPT98Sr+K0CwcLNtRYbCW31E5nyTjrFXfwTUZhabe3ZBPeQsw4DW1gtw8vnA
bh1aK7uhgqqegim3YdHpESO1DjXu1Z3BzCNnoGwx7OWEbFx/0C5gGTftN/wW1+dA
rd9WfNH1GEAZFEOHj67BgMBmHceMZIYurE3Dn2083iaDSvvEp9U2uwcxDtIlAr7l
nydps8JHzMjdV9L5o50tS5aA8gazIlmefDoRB+oV5GC7L4/DZ7s/6BQrfAu3aMek
z7AqGDrJ87j/5LHp6fNMiRQeNYp5gQ2DP/+9oezmS4+QD3mnBBc9cVgzlDqIdW4c
2iymd/s2VFnaltMg7o5IBGCVFAdI512lrIS8jPUgzg8RftWNh2c=
=jjdO
-----END PGP SIGNATURE-----

--it2mhh3fu2wgikzb--
