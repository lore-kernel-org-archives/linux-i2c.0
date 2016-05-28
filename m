From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] Revert "i2c: dev: switch from register_chrdev to cdev
 API"
Date: Sat, 28 May 2016 18:04:58 +0200
Message-ID: <20160528160458.GA1614@katana>
References: <1464426467-1824-1-git-send-email-wsa@the-dreams.de>
 <20160528091559.GR11011@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160528091559.GR11011@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Erico Nunes <erico.nunes@datacom.ind.br>, kernel-janitors@vger.kernel.org, LKP <lkp@01.org>
List-Id: linux-i2c@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> These kinds of use after frees don't always cause a runtime problem.  I
> found it using static analysis, but I bet you could detect it if you
> enabled kasan.  The other option is to enable PAGE_POISONING?

Thanks, PAGE_POISONING did trigger the issue. So, I now picked up your
patch instead of the revert because I could verify the problem and the
proper solution. Thanks again.

What I still wonder: Which analysis reported the problem to you? I
always run sparse, smatch, cppcheck, and coccicheck on the patches when
applying and no-one reported the issue.

   Wolfram


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXScGpAAoJEBQN5MwUoCm2On0P/AkADGBmG/2uWkVvY+fPag4i
Lc9si0cBxJFN0OucrJ/QAbEPGU7zX8s8jR/pePWCBg976IdJ3mLj2C7T+RQXXEGO
pSxkJS0EGmjNZC/e6hUOxnng+KZC0HM7vC+o5Qi1JVbS8ClJM8bZEvtvSHVIfGea
HZG713CdhQfiD6tRyDjS9jx/oAs+0yZ6z/40q9YzvEP6lKdYj1EZQ4srRS9Yqe2C
SAi3i29q48pS1gBCm+NKTXylXrozCPAbouWF7ydxpgiZ4UlSqEgmnAhABG8dAmkV
6aRvt4qXL+pKAmSneg+rKA1YEuZS/dZwY/vr6SL/Hclu7nsxd0PdZxDlPOSQWq6i
ktY62TvGsM9eXpuaCX35xYIjSW5o4Q0a3uj7NxvHLiMBK7Nq37hP6+XHH3wVEDdf
LJO6fPvrCqGVU8NU4Ru7m4beDLhIt60OAj/2MMPxfe1eQAVWQFezMeXglDuR3g6D
SxMiwuj+0rayocTP/r23mpRAURuiRDRDuWxFvOHXNPpAzkzuo5ymiM+kSlzuceT6
B/AF+mu8i+H34ZCYu4LF07gxcOhTc9ykCxvMhSN75KvYZ0RL4ULRSMwicLOkuV0k
EIBT3jVptNHKhqGtom8tpjcC+mAdCyqcSjnxkfsMv3cLpWWOBdFAvc3DfnFy6670
DVG5Kdeu3rx192uKdkw3
=DLQd
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
