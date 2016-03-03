From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv2 2/2] i2c: xiic: Implement Power management
Date: Thu, 3 Mar 2016 09:31:32 +0100
Message-ID: <20160303083131.GB1552@katana>
References: <1456920247-37291-1-git-send-email-shubhraj@xilinx.com>
 <1456920247-37291-2-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:54781 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756894AbcCCIbh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 3 Mar 2016 03:31:37 -0500
Content-Disposition: inline
In-Reply-To: <1456920247-37291-2-git-send-email-shubhraj@xilinx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Shubhrajyoti Datta <shubhraj@xilinx.com>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2016 at 05:34:07PM +0530, Shubhrajyoti Datta wrote:
> Enable power management. This patch enables the clocks
> before transfer and disables after the transfer.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
> ---
>  drivers/i2c/busses/i2c-xiic.c |   88 +++++++++++++++++++++++++++++++++++=
++---
>  1 files changed, 81 insertions(+), 7 deletions(-)

Changelog?


--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW1/ZjAAoJEBQN5MwUoCm23O0QAKuUiud/n/O4nsugycqvQPuq
CDK7GyiCKt2OYq89ud8gGYCRc1NOVEg9XQGmjGsK2MKCqp5SDkljJoAKTP5tT5pz
pnPbbwaHreqjbDIMujwpjDbjGHRtHMfImqHqhpX1Si7Ep+H55LxZ5XzSxi+dzL0q
UKIGjFIqOi/Tf91cpnqF1Tnomd3YpXRqEe0rRdr9YYs0tB+xCz1xvAq3PxZOnnE5
xXBEQgEzNqViXsLqTuirSneqpMBT8H46bVlc4ZHIyz2K+k9Jx4fcPpptb3oiiFaG
4i29LDbXoiDGvJP+cqYeJLgeAQCyCQZP/llwUw3EOSnQX8k3BopNwl/nVdzppJOV
1ABfVyqnMtgRCEFGtHuelYEmQV5G25bfhdcBEY44O6FHLnam3lB2xSB8ky201slL
RcxrXnIx8UudM21y1VYPVwMS2NK/vzPkNAhNkxiVTr2vc8jIyWdvpPQ3EEYzRD9I
g6og1IihNdm3C1lL5SRZqnlhj0WhUYiPHRk1DX+z6esHTP9U6Nz73FhgmNTyxGUu
gfFjO3P1aOM6iDVPRlLEHTAeJR1yxClVhIXvCNFxdPofsXDwpN0ACEKPysI8uowd
JhwaLCIABtX7tXaWOCCRBQqQysidY2vZ6802S5JO8CsWz5n7M/NgTQ3yHJttgthE
u0pkUGsTlN8REP1uVI4h
=KTni
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
