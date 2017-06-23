From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: ocores: Add missing wake_up() call upon state
 change to STATE_DONE
Date: Fri, 23 Jun 2017 20:29:49 +0200
Message-ID: <20170623182949.xfag5smjvq6cbamy@ninjato>
References: <20170616092317.584-1-sr@denx.de>
 <87a858hz71.fsf@dell.be.48ers.dk>
 <7319c512-4301-8a33-5fc3-62486557a883@denx.de>
 <871sqkhxm4.fsf@dell.be.48ers.dk>
 <df9d294c-357f-788a-5213-b229d4c3c5c1@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ozuqrppz6mgqjfqi"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41073 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754592AbdFWS3v (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 23 Jun 2017 14:29:51 -0400
Content-Disposition: inline
In-Reply-To: <df9d294c-357f-788a-5213-b229d4c3c5c1@denx.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: Peter Korsgaard <peter@korsgaard.com>, linux-i2c@vger.kernel.org


--ozuqrppz6mgqjfqi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> After updating to the latest version from OpenCores, the issue
> with the missing interrupt seems to be resolved. So this patch
> can be dropped.

Thanks for the heads up and thanks to Peter for looking into this issue!


--ozuqrppz6mgqjfqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllNXh0ACgkQFA3kzBSg
KbYfQA/+IXp5o3+MBf/vAAkkzAPY1dhdfmkzn/0dt7JEAEHesC/RAufX07jTTcJY
uzl/vNMwljC8kgHRo03gntbXES5QpP4BS0X814Vymi+Z97LdPX2hfBUGTJyEgt7l
rz2ImhJReS5ep8twVV8K9XwE6pX60pJIjj9+BkJ9INzIk5sScLcir3prkZMXtOCF
7HFsKC4Fk1SpS5UvDS89d5JaC1dYfz/39soGIv6qUFQnA2gJLyk5WmIXA/kIAHY9
2LRwTcOj8ans+MfFUbNcpTrlL2TIMKfBrIa1wqCGTtrXBMUX4rkwdOuZuZNBCCL/
uBMBsg+ZDSIP9s6cCE3LKnYuPUoBwxf9Us0vo8yuo8dxYf04zRfjD61JuPi2X8/0
aTZKOHQ/ppaxsOREQ31zh4FjjuMEQKzsOCvsPFaHG9PTChYy2TKtrbCQnzZoSlv0
7JCVs9ZZ/zGae2z7L0fWQ5HmmejUNkBBz7WEwT/BECqxlIS6aW7/GZKZmi3oZMV8
nU1nHR/wGiw+MhXKAv5ID70cH0wKrdTAUElnWOS3lV9GdAgGfK1OoYeEhTLRXU9G
JqwI32JK/UokFaB6deOImZgiScUlfGnHQaKUza0YdLc5NvQNOQDOT2d9UU72jZPK
KC7YBtXg/sunauoulsw3b5RB7DHH9CanRYi3PWcMvNhTAqi+W9s=
=uUa/
-----END PGP SIGNATURE-----

--ozuqrppz6mgqjfqi--
