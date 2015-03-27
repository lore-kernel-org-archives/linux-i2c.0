From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: davinci: fixup wait_for_completion_timeout handling
Date: Fri, 27 Mar 2015 16:50:34 +0100
Message-ID: <20150327155034.GF27238@katana>
References: <1426578673-10692-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426578673-10692-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2015 at 03:51:13AM -0400, Nicholas Mc Guire wrote:
> wait_for_completion_timeout return 0 (timeout) or >=3D1 (completion) so t=
he check
> for >=3D 0 is always true and can be dropped implying that r=3D=3D-EREMOT=
EIO and thus
> the return of -EREMOTEIO can be done in the   if (dev->buf_len)  branch.
> As wait_for_completion_timeout returns unsigned long not int, and   int r=
   is
> exclusively used for wait_for_completion_timeout it is renamed and the ty=
pe
> changed to unsigned long.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Applied to for-next, thanks!


--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVFXxJAAoJEBQN5MwUoCm2L+4P/1gSu72XdspntqdAkHcNf1Yd
9rXD64bOPymKIR38hKvyc1jwlnYioSAVCjvmDt88u3UxyqQjwRq6ADZbdB2WYJ00
98taYB/q7up/d/3QPfXQAjzfBzyRr+rJAHc3tJtnK+A0KUtkfWiqNsX/s3DtRkCO
roPIJ3EZbgOW5fCS7Qrh6adk/fKqXagjt+KIJ+fAmwz6iahopCvWmbOKWV/S3+eg
kKP9n5RtaBguwOC5YRTAnRqDYIjBsgLKrYrcHANn0MQ2vWvymUG2PJqRmt6vQb7o
xFbT86GGwVYxrmFk/JCyLWWx5txDsEFan01Jh9bfP4COZ3FShzqeqpWcovRHRJJx
UB/t/lX+YjMhfHCL9MiRiri4BLBCNYGYiY5gY6RjVNAyitB3BTR4jIgijXA13d6W
8pz/cXiphlr2YSgNwnmSQ+OdLqaRs0x4bnF+decQOAKNcyLw/rz3PzfvhRowFGPJ
djdDA12iwk1zPovRXvDKxKOHyC+fXedHTJWQNZjNuhX1vQkMWaMKzyerTF8uH2kg
MnGSAATbvhmq/sUgweXktNoDuKpxaGBxfK+T/iTwHtOYhFsIVxnezxWkvdBu4xt1
leCj6UxxT2EVuvX346xueoQbGKw3nnGcNWxfdljS5xytE+9Z7Q/MnQnTzK4XqLi6
0PdhejPNIlUbYhIMTp0X
=pteA
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--
