From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] Revert "i2c: designware: detect when dynamic tar update
 is possible"
Date: Tue, 14 Feb 2017 22:12:01 +0100
Message-ID: <20170214211201.ql4qbohj3xltma43@ninjato>
References: <20170213091819.4370-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nivfoddtucuhvmxz"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55994 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753011AbdBNVME (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 14 Feb 2017 16:12:04 -0500
Content-Disposition: inline
In-Reply-To: <20170213091819.4370-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Lucas De Marchi <lucas.demarchi@intel.com>, "# v4 . 9+" <stable@vger.kernel.org>


--nivfoddtucuhvmxz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2017 at 11:18:19AM +0200, Jarkko Nikula wrote:
> This reverts commit 63d0f0a6952a1a02bc4f116b7da7c7887e46efa3.
>=20
> It caused a regression on platforms where I2C controller is synthesized
> with dynamic TAR update disabled. Detection code is testing is bit
> DW_IC_CON_10BITADDR_MASTER in register DW_IC_CON read-only but fails to
> restore original value in case bit is read-write.
>=20
> Instead of fixing this we revert the commit since it was preparation for
> the commit 0317e6c0f1dc ("i2c: designware: do not disable adapter after
> transfer") which was also reverted.
>=20
> Reported-by: Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>
> Reported-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: <stable@vger.kernel.org> # v4.9+
> Fixes: 63d0f0a6952a ("i2c: designware: detect when dynamic tar update is =
possible")
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-current, thanks!


--nivfoddtucuhvmxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlijcqEACgkQFA3kzBSg
KbZhBQ/8C16UReDHYTnacRn6Bdcf8eblXsG4j9SV+iOP9y3+s3O7SJrkvaoFFRA6
c0SDwAtQFFyWGqU4i2p97OW/vQGmsbNiun/VuhtvYo1gqsS56tM4pvcEaFpfYQKn
gwITaBZhUjD5frUxe3Gn9VzS0px/4hRll3S60Zdg05AskgpWLFbJQ0W7bDKKpJ7O
aiIRfD26MDPoh7u3NhRgQ8nXXwP+YpeEBuUWHD76M60CLiBwEvqzPb4HWlxcv2xc
GiBKycCYmUT9QH/nHCAP0tZgW9L2Wq/x1ufF4QmSVyYdgmTiU1M2l2VQf7IlETwy
9BV3k3iMyoDDZPaTBNRTdckPXvaOmwc6GACkEdzYrNc/uO3pHMrgukuSAvMDDQIX
QPNPkk4W0dycPSIBdeLCpy6dGk1LMqpYoecrinjcg+k07ZkDZucoyZ25ITldlDS5
cCyg4eZNEqnJkiJRA3BkTGMerOvHZBXyom6AaM0wWBEXNkLqUxQuh/ZXXYhTaSb0
rK2vyHgbrtwIaOxPpVM4x7aoQsNiLk1a3xkWyadU0rU3LQZVbHh/YfugNa9eM6z1
FSTT7x3GJHpsTGQur1BUOHpa/xcjMIP979RWpcXH3aCEn+aII/BNf13wJOdpWHuE
gNnyHTH2LIJZrIjjLGVoars0aPgYniK9BIAVTdGd8SiT5AIUEP8=
=FGcg
-----END PGP SIGNATURE-----

--nivfoddtucuhvmxz--
