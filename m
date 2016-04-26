From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 03/15] i2c: octeon: Remove I2C_FUNC_SMBUS_QUICK support
Date: Tue, 26 Apr 2016 09:36:20 +0200
Message-ID: <20160426073620.GA1543@katana>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
 <1461594824-7215-4-git-send-email-jglauber@cavium.com>
 <20160425221621.GI1550@katana>
 <20160426055845.GB5758@hardcore>
 <20160426064242.GC5758@hardcore>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49414 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394AbcDZHg1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Apr 2016 03:36:27 -0400
Content-Disposition: inline
In-Reply-To: <20160426064242.GC5758@hardcore>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> > Yes, I thought briefly about splitting SMBUS_QUICK into read-write
> > variants too. To me the question is if this feature is still used on modern
> > devices or if this is more a relict of the past. I don't know enough
> > about SMBUS to answer that.

Well, note that there are zero-length messages in I2C allowed as well.
Not only in SMBUS. I mainly use the term SMBUS_QUICK because it covers
both cases.


> Checking on ThunderX:
...
> Do all these other numbers make sense (although there are no
> devices)?

It makes sense in a way that it shows SMBUS_QUICK_WRITE is broken :) It
doesn't react to ACK/NACK properly. So, what needs to be done:

1) remove SMBUS_QUICK as you did in this patch 2) move the length check
so it doesn't only check read messages but also write messages. That is
to prevent handling custom setup I2C messages with a length of 0 (which
is legal). I'd suggest to return -EOPNOTSUPP in this case.

Thanks,

   Wolfram


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXHxpzAAoJEBQN5MwUoCm2bYoP/1bFZcSFpXvKlPwlxhp/YEwd
qiVqZRT3xyOUd/7CWTQcMi94Xmp91pTZzH1mdK8juVrzZvNwoSAPFXA7iFxGULpV
0wC06CCLTY8UAeQg0qY86IbYr0g/z66XTB5wEEM06Xhbx3FL0A+Lv0BlhoG82cTb
q+tl7J1V1XgzT1Jw9aZg2HoTR6xOofIfL4dCKYvZ3U60WQyyuj/TF/daPoKqVBcg
ubGmvuV+Zp344JE3WwesdZfhzO9BntEI7j2Gldx5Wv9vyqTwmxpQOCYvyZMr0iFv
sDZUqpMDNAOJQCRKfD7Vsj8wEiao6/a+/W3loCnHXgb4pmX/5kzZux6qiHj5eJfy
I/tE5KetE/f8t42THXyyTrBuJNDmDnCKmeM8B3TgkoFvYXhJxYUDKjLarhHcIM7S
uL4cqeCBE9TlmOUaZATz2gsfDN0uTAITxpquwB1EnCFEq6kLCzeThRCqK9JdPm9C
I6dlx/Ryg6OcpaDgzKnslz9pY9M+bzz9vemNzT0PzFQy+rLmBCrYxqJlyNNb+w+p
OfRXG37i9vomWtrweb9be9N0uMf44Qgh+jgYeCze0IK5Gj4RxC0MCQsLgLpWUAvt
WsJwFQOnctdh+qLAinp61AvVbQopvV3m9zhHJLjX7Wy+5rLWKLYshx9Er8fp/rcs
sanISCsma97ysg77DejC
=h7LX
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
