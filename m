From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv2 RESEND] i2c: designware-pci: set ideal HCNT, LCNT and
 SDA hold time value
Date: Wed, 12 Mar 2014 08:16:05 +0100
Message-ID: <20140312071605.GA2756@katana>
References: <1394537625-27205-1-git-send-email-chiau.ee.chew@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394537625-27205-1-git-send-email-chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lim Lee Booi <lee.booi.lim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2014 at 07:33:45PM +0800, Chew Chiau Ee wrote:
> From: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>=20
> On Intel BayTrail, there was case whereby the resulting fast mode
> bus speed becomes slower (~20% slower compared to expected speed)
> if using the HCNT/LCNT calculated in the core layer. Thus, this
> patch is added to allow pci glue layer to pass in optimal
> HCNT/LCNT/SDA hold time values to core layer since the core
> layer supports cofigurable HCNT/LCNT/SDA hold time values now.
>=20
> Signed-off-by: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks!


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTIAm1AAoJEBQN5MwUoCm2Z9YQAJ2OVkWwPt98Dc9jTQNn2oCq
anVEFNneh7S0pc1KPT14ur5rENyUulHOFfUMAvovj3Rtrb/m7Gm4il5Ng3gNoELv
8Y0aflcg/6f9BcHocvMnt5FV73Q4DP9fQUQ0Ob0f1huYQ9OPPk6iQLwJ0xvprbs5
hpNxi1KFBTKU4gbCd+C4MzbUzM2Y/psR5xpT89xBR8ZZdwDbBDqnEA9p/8vLN/MC
VjRmQqII8KvNdwE7IKFMsoRyfzAOKMp77V03K/I6JckOyDYCvYWAwybRMJj5wdvv
Umud/4kn38iOU4S0sobpGtUypRxixSM1rm0ccbHTBTkBu6zJ9rduBNrdxfs5clSO
XVAG89OHPlL3/rvyAMAVtFCYHfIe8qbdxKHdocaFRJZY0X+SSxpRns2nUFNQcIyc
Qn1m6LRUEsPfURyFh+eRgmaF4vowpJ+ZFEw7fXQpXalU/8ZfSr80dIbym/WPpdPH
SEwme9gBviIGs7bPaUFegSwmZUjpw6lG+lFaFnx5HWkRzdyv2HO5RZHsBqXErsZt
y3ih7Myr4Z0/vmbH/GL5KVNZlif2bV4fuaHU16shUAOyRbkKwR6W43vwIgLCLV9s
A6nHZjka1b55WN++m1EOHdeEMT8fNp2txLs7tK6Ut7PPkgS7O+EQK++0QBLpWv4j
Obs4nmKPpaDBSLF2ryp+
=wfh1
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
