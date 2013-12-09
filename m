From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-mux: Inherit retry count from parent controller for
 muxed bus.
Date: Mon, 9 Dec 2013 12:08:10 +0100
Message-ID: <20131209110810.GA2569@katana>
References: <1386499701-5522-1-git-send-email-eliedebrauwer@gmail.com>
 <1386499701-5522-2-git-send-email-eliedebrauwer@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1386499701-5522-2-git-send-email-eliedebrauwer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Elie De Brauwer <eliedebrauwer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 08, 2013 at 11:48:20AM +0100, Elie De Brauwer wrote:
> Today if a mux i2c bus gets created the default retry count of the
> muxed bus is zero. Hence it it possible that you end up with a
> situation where the parent controller sets a default retry count
> which gets applied and used while the muxed bus (using the same
> controller) has a default retry count of zero. This can be solved
> by initializing the retry count of the muxed bus by the retry count
> of the parent at creation time.
>=20
> Signed-off-by: Elie De Brauwer <eliedebrauwer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Makes sense. Have you checked the timeout value, too?


--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSpaSaAAoJEBQN5MwUoCm2rc0QAKtsEXYDgeCzynySQISmU5j/
eXQDsxW8/5bPS8CoeNumcVyNHt7PUx3YamVrnpB5RrOTCbw0oGpdI33JlWoiroDV
0351O/XQb0Dh9Zddf1iqXVGbsY/e3TN581I06SNNiPGwSDIivd4QfvRB699cYqzH
gRFSKWzjQVTA5yHEJ5uERPRXQ2chL6lkr2AkO2R0IacZ/e62+lxZb3Jy9h8MwlU2
/eDERlbvYV+Pm1dHtPuFf0ZJIytXdbdbnc7C8aboAcqRLjg/DDZ1jhotlDbj1smO
48ytp6eN684byzkFvWdgxoi7zGnk58q2KywH6q/EVYTh6giaanf6VJixQlc1iluE
Dp9WsEeen62axhcaYF0CzPasgOgBcvpFcCr2RbC2etKQHLxXd8M+etpuk39OJX8A
rA5BGWpt1k9TV2Ft+xEqsBF/xHNG0Q4ZIiefz1wOBbmciJ2zlNWh5LmAQcX0h4W3
ib8VPVfjfu1A9KWOW2mQxswkdsQ8/T4Ou5CP0jnxCLvm/m/jCsSPfcTskT2OehKO
vOnmuehXAYpL4gZTyO+MMoPHeP4DBGAJmS0+i91RH8aHtOMpWkA0kw1tIBB5gMhh
+ee3EBkBni6P60b4Vw7MrD1XS6F2eU5vOzlR7aKlIOv12i5yw8UJOKj9ewnXfkp6
/lp547m9RRT93nL2tg4r
=sso6
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
