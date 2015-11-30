From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv3 2/2] i2c: cadence: Remove the suspended flag
Date: Mon, 30 Nov 2015 21:10:18 +0100
Message-ID: <20151130201018.GD16446@katana>
References: <1448350317-37077-1-git-send-email-shubhraj@xilinx.com>
 <1448350317-37077-2-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37629 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbbK3UKU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 30 Nov 2015 15:10:20 -0500
Content-Disposition: inline
In-Reply-To: <1448350317-37077-2-git-send-email-shubhraj@xilinx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-i2c@vger.kernel.org, soren.brinkmann@xilinx.com, michal.simek@xilinx.com, anirudh@xilinx.com, Shubhrajyoti Datta <shubhraj@xilinx.com>


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2015 at 01:01:57PM +0530, Shubhrajyoti Datta wrote:
> The suspended flag is a flag holding the device's PM status.
> The runtime framework does that for us.
> Use pm_runtime_suspended call instead.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>

Applied to for-next, thanks!


--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXK0qAAoJEBQN5MwUoCm2cI8P/1lZmDXLC7xBwyO/iEM2YC/M
dm3F6D9z9AnlHup3NvJmAQ+aruexIiA08tw34As91FHCGGK6RBCVZnH45lUOa0md
u66z3KDgqh+O+S42WK4C6inSdUKZ2aTk7zImKjGjAd3WutPOOP5RutjU7VRkY5Dw
eGjNenZw/QH7VsUofjfomONMMdu3eLeU5V4j9YuQY+0zzUk9F34Pm27OzeX9Fqlo
dtuwpLgByFyQt5eOKzN3VzS6RFIuD8npHQDBze1PkLwr1vBBKGrXnic1UQIrtFkB
lTiyIxYWN7jx/v9aG9l5JPWWrZ7SlI58ke0ARduBb8Zh4sKrTfFo905XxId3A3OC
ZUeR3ipml8XHbmnZevCimQ+t8bf4t1PBZH6Ez9mzmul14fCYtF34cW1LPSBAi+Y8
R1NxSdLvqQqpyRz37iLySsVN+hMrXvRC3yyGlPN8FgJHZb9u5F6m9FDnSgW0ub/q
4OZGLNbmkl4fBCHUfRdkioXkmN3m3BaVBwwQrt32Uh2a/mYWk4B9Js0vfPAETnJq
Lb5h8f9NPW4DQuAUi8Jwqr8BWeiVCKdDqKM+NDQh11zlo3KBGzHijLUa95gHTtT9
fUAOZN8cu6JTmJ8MR+jc2XbZEf3DZo53/ECsgznri1l52TptKQkpvtKDnLsfF70+
oACoI2ALW2StQwhHj/aw
=9yPn
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
