From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: ismt: Add Intel DNV PCI ID
Date: Fri, 19 Feb 2016 21:45:03 +0100
Message-ID: <20160219204503.GA5283@katana>
References: <1455807273-133516-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160219083917.GE1491@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:42295 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946140AbcBSUpO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 19 Feb 2016 15:45:14 -0500
Content-Disposition: inline
In-Reply-To: <20160219083917.GE1491@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, linux-i2c@vger.kernel.org, alexandra.yates@intel.com


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 19, 2016 at 10:39:17AM +0200, Mika Westerberg wrote:
> On Thu, Feb 18, 2016 at 04:54:33PM +0200, Mika Westerberg wrote:
> > Intel DNV has the same iSMT SMBus host controller than Intel Avoton. Add
> > DNV PCI ID to the list of supported devices.
> >=20
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>=20
> Wolfram,
>=20
> Please do not yet apply this patch. It seems to have same PCI ID that
> Alexandra (Cc'd) added to i2c-i801.c.
>=20
> Alexandra, are you sure that the PCI ID you added for DNV is actually
> compatible with i2c-i801.c?

OK, I also dropped Alexandra's patch until this is cleared.

Thanks for the heads up.


--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWx37PAAoJEBQN5MwUoCm2RAgP/A2vKct3yfNiUDlDNItcilXl
HYIIAHMHIBulbA3K5g1AzV2xgpgUozI73qVG7uLOhpl5LOuqdFi7zNysQZTSO6Yx
GKY+MC/fG5Ypd/RLSVEBWt1uUFAjO3tAPfqQ3yURfWMmcTSv1MurGHY6wL9CClU2
F/93W0Eg4O+ejpenbVHG89NUYTogYsB00YUulwUiMl4l5XTNShszuFKzvG6RT3LA
CdbtCDbQg4ngGkM8asdqcK7AFMvNNDi1srd1Fvko/yvFo628eCpAcdd0gpxPY8sE
Xy4qVxCCdDpfmh5nS+aX3b7KmMULLahRUsk0W68KItuOK20uSaU1VjqkMC4GDJGK
j0zHEh0sm+P5EK79WJ4mLvUlm+IoZz702VLo1hMA/rrDlZTVMQofGqphko+Czshk
cRQW6CyJI/2zPDWpEMzyXvHqBxZNWsaEc/r7UMiAt+sHBBjrAlGMuXTiPgPMa2uk
4N6p7DdpdJSfFmFBpF0ZJdmf9sB3OV6xa1xoakYDpVE0V8Zdyq8A5EhDwYOJ6RwI
yl5JZgs77SR71icivlHoft07CqGCARqrlSHOaNgaCwuNcIymyBj+Zbzc5/YYdft5
VjMU3bCQTwtywpZE5rdEnrPDUERy1asByxGfRp/ByFXV6fAJK/hfQ4Tr9/67zwno
/t2/VdmCpPSqiGK8qh3e
=QLS1
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
