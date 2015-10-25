From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: busses: Use setup_timer
Date: Sun, 25 Oct 2015 15:58:26 +0100
Message-ID: <20151025145826.GB9701@katana>
References: <1445365039-23695-1-git-send-email-falakreyaz@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445365039-23695-1-git-send-email-falakreyaz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Muhammad Falak R Wani <falakreyaz@gmail.com>
Cc: Vitaly Wool <vitalywool@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2015 at 11:47:19PM +0530, Muhammad Falak R Wani wrote:
> Use timer API function setup_timer instead of init_timer to
> initialize the timer.
>=20
> Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>

Please note that the proper prefix in the subject would be "i2c: pnx: "

Fixed this and applied to for-next, thanks!


--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWLO4SAAoJEBQN5MwUoCm2As0QAJ41CvMKtktTcGHov/z3OLQk
ezPnNV6MxTKOhV2b+uzlUoI3Qoyn85FDuVEAQhFuRAfNHKunREBRECm+EKfOldFu
9bjoPgMWyxKnRHskRNuTOdil0jE0QP306O6UK0eAIPx8QbXS9DNFjHBYSDyM1Zdd
MuXrBKMfzVRac9BTzB7Lh4sMH0ak0Z7MkKIgFsH0yF3nk773Bt7NNYHBrr5QIY6u
MtEiSkIx39dik76iKJthDcC5GxIWx2wX4YjuiZJHKt6AbA35wetvDADTiVwq0OgW
Fi+FTtQmV2HisSvw+mCansa1/WZFRt7/oyEIh0/ayXqZuRPR9XHYYZHgLSVCBxBL
0fNS5a8cY6CHPkq/2eHZ22qG5RKAQx710UWbJhuv+RDbGTuoWO0lwmOhiEdm4I1f
lcUF40C5fd3jwit3xPEHjraZfeFusZkOp4Byb/Wo0L+6DFwQlGhEo+XupLmI2YbT
Vfm2NxAlhW1oPVCvnHdNOfCdt5IgKzkr62Ti0hIpZ2ECHPKt4rwIUXk69EhpaCaE
XJauFjbHb7iQz5zo8IUeEu+8RVBa548O0tZaRbY3/8tY+mk24vQV5pMYrH2c8LAH
W/73+nQWgmlMBqDqbAcj+Mfqu/9jqxpjpKghKFJq3+10JYIJQD/or3HNN9SQhozS
W5l4PGdLkdJ+kye3ms2X
=0YMb
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
