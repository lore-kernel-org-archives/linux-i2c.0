From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V4 0/2] i2c-designware: Add Intel Baytrail pmic i2c bus
 support
Date: Mon, 26 Jan 2015 12:27:11 +0100
Message-ID: <20150126112711.GA1052@katana>
References: <1417478973-25522-1-git-send-email-david.e.box@linux.intel.com>
 <1421313137-1613-1-git-send-email-david.e.box@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421313137-1613-1-git-send-email-david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: jdelvare-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 15, 2015 at 01:12:15AM -0800, David E. Box wrote:
> V4:	- Added bus lock to i2c_dw_init() as suggested by Jarrko Nikula
> 	  <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>. Addresses infrequent hang that was
> 	  seen occuring during probe.
> 	- Added label in i2c_dw_xfer() to bypass unnecessary lock release when
> 	  acquire fails. Suggested by Mika.
> 	- Changed make to build driver as composite addition to
> 	  i2c-designware-platform. Driver can be module or built-in following
> 	  the platform driver selection. Tested as both.
> 	- Added EPROBE_DEFER return to baytrail definition of i2c_dw_eval_lock()
> 	  to defer probe if iosf_mbi driver (required for acquring bus lock) is
> 	  not available.

Applied to for-next, thanks!


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUxiSPAAoJEBQN5MwUoCm2gOUP/07PyelWHyBnWyXRazX9Adcy
36ebjcYDu6xKhSDzkpoU2pADSq/mYPwPnAcTZmwa0Y9NgHQJ0h8JTlFeqd79ivW9
W0XAvJgEkeHVHIKa5VAWsJLrn2hnuIraDBRxFh6Li/UIbJxk5PJSynXswchZFqKp
2MH5/H2z9bmfCIvLkWBNnQYBKpCw3bRdwykQ+QRNHaIB4fMDbo30IJYkjGaLbw9V
x3geeIc8VYBUlhbIBPA1LXmsqDAIvLJhi+utlKh/NdpEFpAGBvtVn1mwm2eP8d1/
Y5sSCrFAqZTD9UtjyGbZmYooolR3Mz7AHaULRV9EPoKGdwnzLKCh75XRJzb8gNyL
Mr/OGDftmXvL5fhjawU3JXseB2UCJcL6bZpF6OX+yTiWNWBM6FRreIHmYnIfGy09
ps3/VpPORtzc4Vg5SuTtW4C79+NIpy7hnz8EFrJblMAb10216dLPXrFgM/w3E3rc
FEP4SBi7axTfpPCarrSrkvgdY+IT07cGjSAIjVuUa02Eu0Zfnwtu8t0ZEGHb8sui
p47401GOWbeMmdTErRde01/Wy3XHI2tkmWcngYuR95LXQhlNmWWSeHYJX05pP/E3
g/CaRvKoWVNLASegxy1TJkc7ZvjYuJI9RXudGdQmSBqBhBmJ0M/nQOCnqhmtW/K3
RJIaUKYALCLbi1JvIBcr
=bfAl
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
