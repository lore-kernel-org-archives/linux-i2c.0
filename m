From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v1 1/3] i2c: designware-pci: shrink dw_pci_controllers
 array
Date: Thu, 22 Jan 2015 20:17:58 +0100
Message-ID: <20150122191758.GB14880@katana>
References: <1421937869-28376-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150122190301.GA15297@psi-dev26.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150122190301.GA15297-UmZa8NLUsbhHELxPJs4m+1DQ4js95KgL@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Since you're doing this rework, could you remove moorestown for good?
> It's no longer supported as one of intel mid's platform anyway.

If support for that platform is not broken anyhow, I'd say let's keep
it. There still might be users out there...


--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwUzmAAoJEBQN5MwUoCm2qdgP/26ryltgJtONpUvXcDQcHrrG
Mfx9q4QBDKTSKo4LzJtsu3vnMzMM1VcswaBE8fvGNHNmu9/0mCxvZEABGt2b7qHv
qR3tRAP0a6epmaLi+sSsQEBeYW7czPM4swWaVmRI9N4tmJKOCq6pnbs/DAmaJSNs
ozYfLJBbItV6wC5qlSCm0eicgRd2rYOqjCKlSqCK1v+klwT3JGJiM3cnlQ1nrme7
v5YY0BcZp34V2VcYr/GKvLi85ZNNDr1uubF6czfrikv1hYpE6JGjLzOCWAMwF8BP
9qg+cYhg6dA+XLlAsulKQ68QCegOavvTWeOp2hRSzlIp0v2RQ4FVkyYeukJaWDFX
DaaejeXZPNl7q0566dVnQvW/boDwxdmTQ7UqqcgaOQ6JrHJssTcIVOFb7SKe4JQA
e19UEpAu7BBBYITP9E76UwPDwB8RowTk6py1xuUdRptqspFH3b/ecKpGziiG9l7p
xZFILXwoa3nbpcZOs/aLVXaSEPlIeYgZ2y8fHeViFu6fytZD0yG3yAQ8WIcoLlT8
gIxDGceLfC9bgSzWao6y3VUeH3fw0GivSQEXjB35JU0jil4P0jXTfa6kXItlKcCO
ci5GtOTIDmsQREFeE85BIpUd7JDpbiSNpWCfn4fAVLYg9NFjIpJacVIatepjx6NN
sWsRHtXQ/pyJ+u9pmRi1
=rauw
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
