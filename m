From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/4] i2c: designware: No need to disable already disabled
 controller
Date: Mon, 2 Jun 2014 19:36:36 +0200
Message-ID: <20140602173636.GO2654@katana>
References: <1400164644-3222-1-git-send-email-mika.westerberg@linux.intel.com>
 <1400164644-3222-2-git-send-email-mika.westerberg@linux.intel.com>
 <20140602161234.GG2654@katana>
 <20140602173408.GB1730@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ickEXl+ukcSQ/3E"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140602173408.GB1730@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yao Jin <yao.jin@intel.com>, Aubrey Li <aubrey.li@intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--4ickEXl+ukcSQ/3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2014 at 08:34:08PM +0300, Mika Westerberg wrote:
> On Mon, Jun 02, 2014 at 06:12:34PM +0200, Wolfram Sang wrote:
> > On Thu, May 15, 2014 at 05:37:21PM +0300, Mika Westerberg wrote:
> > > If the controller is already in desired state (enabled/disabled) ther=
e is
> > > no point in setting its state again.
> > >=20
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > ---
> >=20
> > Does it have a side-effect when setting then enable bit again? Otherwise
> > it will exit the loop immediately on the first try. Not too bad IMO
> > given the additional code saved.
>=20
> AFAICT there shouldn't be any side effect. So the $subject patch just
> saves one register write in the best case. You are right, maybe it's not
> worth adding 3 extra lines of code just for that :)

:) Okay, so I'll drop it.


--4ickEXl+ukcSQ/3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTjLYjAAoJEBQN5MwUoCm2Cr0P/jWccCsesKmuqJv6GzocbaR4
/NmueoZLFIddS8ptFdISgi84dZFkmHq4FA2JVnQhxd4JfA4IIejDGSLPxka71gO1
1osyTsHcnfznpsBTAbvR+2qNkCYe3m649Hw35PEO6NsLwrJNM6vIFx9S3ktmW8dm
wnssftkPR/ptdj+HMXzskJyo707im3k1BgVGVA1Wk8qkuZwylMzLzaXuAuKrAuNq
nt+UzpePm/dDaa44+Wb9npAo+cuIee5C2ni8I8Fu7bUJcYP7tiqKchaeCunYhoCP
fil/omsq+XmhoMIxHQxYw1ERbu7Dla0Qj5XHg7UkNnxlRXu8iHiS5Y9zQQCxwbuC
Xx6eymXTVt3VLvgchG7hR4efKCDBcL9uuIYBxqHFOi3GqqWSMh6EA9sIJjbp9Mqf
iZm4GVPvYI+QYqBLQWZI/6eCsVsvuIGG+K04H397XY9nJixAYCiqny7aOvTok9RN
pD2g31fQb4uEVGhiTHiLN4iGeWYj1/2/2vWHXIdBJpvU9VPIL5dwzvqL73lNYB/s
iKSVuDVRP90dqwyArAsq2gPV0Vd1jt8mZcnnYvsE29mSIWed4w6xQNEraQ997MZB
pEDctC9U6uGgTsmtAp3T2Lr6bBNpDNyRUc5ZU0Pp8KJ552GVKX0oZk1IIvGWe2FP
RnJ7w2w8XAwZE+kKVmte
=nE8h
-----END PGP SIGNATURE-----

--4ickEXl+ukcSQ/3E--
