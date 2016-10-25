From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: xgene: Avoid dma_buffer overrun
Date: Tue, 25 Oct 2016 11:50:40 +0200
Message-ID: <20161025095040.GG1597@katana>
References: <1476119590-21489-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Fnm8lRGFTVS/3GuM"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49305 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755405AbcJYJup (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 Oct 2016 05:50:45 -0400
Content-Disposition: inline
In-Reply-To: <1476119590-21489-1-git-send-email-hotran@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Phil Endecott <phil_gjouf_endecott@chezphil.org>, Loc Ho <lho@apm.com>, tnhuynh@apm.com, patches@apm.com


--Fnm8lRGFTVS/3GuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2016 at 10:13:10AM -0700, Hoan Tran wrote:
> SMBus block command uses the first byte of buffer for the data length.
> The dma_buffer should be increased by 1 to avoid the overrun issue.
>=20
> Reported-by: Phil Endecott <phil_gjouf_endecott@chezphil.org>
> Signed-off-by: Hoan Tran <hotran@apm.com>

Added stable and applied to for-current, thanks!


--Fnm8lRGFTVS/3GuM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYDyrwAAoJEBQN5MwUoCm2bXYP/0/0snAO6uDso1CeZ4CtVLU/
Lf/ahv/3+HNicj/1oIf8VNDUaMk+RUpE7bY1BMZNKzwjDrjwbcsGfA3Nb2OLlTr+
SthSgkRibUD2XyWWzHC+9g12TM2dNS3yUrwOEYnDZQwLD6hsjUODtsiCLNODncHn
r01iTC2bcge1STfy7Zhb7hzo18kKMeR3WizdWnCBowSzUeY6LJzyEg0rXU+Pc+1G
YrMBrTyulWUccoA0dGeepJ/LALCR8WsBtU6nKtVuOkFACLbgqpWSBQiuAoUSW1wd
Bu1CCeY6fj9cO5DR+6LOX1QbAC3haBdgIwgfdSt0j7kaPI7DBKVhD6mwWDRWMK3W
D33cy84jceTITzvEpuALVjhgGM0FqAM3kvhVfurgBi28LCWmfTZiTAo8bcZIHDSn
f0nNETDDInAAg2L49/LQzFJqhhd6dIU3rfe6OfTWBaLYBpOGemIeIFy9Q72XA5S+
QOt59h/jY09OfYTa32IiMMO8CJBVH8ilC1mIALbqqMgn8Fjo6m2AmMLrYYwwsl1q
PSBCeBmTjpIjSYQzIuxlomGVEUw0eujARmRYFWJ5Iu14pqWVS5HbKnlCsDRO+Cja
Z9OuN41FA4Uo0DSoWVDxjsGM74jz2fcVmOhlJec5KsjFP2WWZUOoAhHcW3QxNC9k
KLiT5Pr0w9Jubcz0h0mh
=jJbd
-----END PGP SIGNATURE-----

--Fnm8lRGFTVS/3GuM--
