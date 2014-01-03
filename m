From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 REPOST 4/4] i2c: i2c-ibm-iic: Implements a polling mode
Date: Fri, 3 Jan 2014 16:13:10 +0100
Message-ID: <20140103151310.GC7132@katana>
References: <1387552376-12986-1-git-send-email-jjhiblot@traphandler.com>
 <1387552376-12986-5-git-send-email-jjhiblot@traphandler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1387552376-12986-5-git-send-email-jjhiblot-dLKeG7h1OhBDOHtkgc7UlQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jean-jacques hiblot <jjhiblot-dLKeG7h1OhBDOHtkgc7UlQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, jean-jacques hiblot <jjhiblot-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2013 at 04:12:56PM +0100, jean-jacques hiblot wrote:
> From: jean-jacques hiblot <jjhiblot-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> When no valid interrupt is defined for the controller, use polling to han=
dle
> the transfers.
> The polling mode can also be forced with the "iic_force_poll" module para=
meter.
>=20
> Signed-off-by: jean-jacques hiblot <jjhiblot-dLKeG7h1OhBDOHtkgc7UlQ@public.gmane.org>

Do I understand correctly: Polling was not available after patch 2 until pa=
tch 4?

Has the signal handling been tested extensively? Most drivers do not
handle signals because it is usually cumbersome to cancel a transfer
gracefully. That being said, it might work well for you here.


--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSxtOGAAoJEBQN5MwUoCm2u9cP/3k4DwrNZV3awmjXU5eSvPSB
gswi2Ucch2+fcXiY9rgizYJKFaNSE1enddnrehHfZ/QMbVgIBN5qB8dLrih6abgc
JwueQchUMhaw2ULbYGQfIGEG3+LvJMdwuG1HlFrapzSbKXkhYQ1ob3qpga4FRhRL
tyHTDzfqDblCfEBIezqCmUgSP1HcwdvR5kqOLqt/f+WUF2PvQ8usZPflfnXiAdu/
gK83Z40zQLMkxN1dgNcv0XZWCvn3Bb5TUQNOZd/Q5JxFnBa3UQgtZ4kGiLZ0pb6u
qKOjORT6LINvb8aQaUSwa58PFgGHkI+V8iUL9jGxU+bTqKDyahix4jo9qwkrrifs
C2TDEK3OZPpXnF3YN02pICmbgHfWoGN5eyZJGZ2gmcpiqYmFBDNTmaTTGGrjWVTV
omltb7HMwEdXQxsh9V1brqQhRVZP184SL3bsyfEC1lFZA9m/Sz1yf0sj6IbboSa1
QYmcNhNxy0pLvE1qU4BS8E/YMmz+zfKuiNnRPLwHN+sOH4QfLn14DpDUGcRJuq3K
cef2Wv7mtWB8IAiopRd8dPidCLuMbWfte7R/4hEWWcaX2FOUbzNNkKP0yCxv8rwi
qKUcs0qwoYxHjzg7IFLisRMbEJZkrfNCFxlBr0Hpt8TFadqwuHTvSes676F9MO/+
Wb2Yvsh8e2Z8mHrxRd51
=nWFh
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
