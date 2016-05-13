From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: only check scl functions when using generic recovery
Date: Fri, 13 May 2016 12:40:33 +0200
Message-ID: <20160513104033.GF1778@katana>
References: <1463045119-7375-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bqc0IY4JZZt50bUr"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:53259 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791AbcEMKkh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 13 May 2016 06:40:37 -0400
Content-Disposition: inline
In-Reply-To: <1463045119-7375-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>


--Bqc0IY4JZZt50bUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 12, 2016 at 11:25:19AM +0200, Wolfram Sang wrote:
> A custom recovery function doesn't need these pointers to be populated
> because it may work differently internally.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Tested-by: Peter Griffin <peter.griffin@linaro.org>

Applied to for-next, thanks!


--Bqc0IY4JZZt50bUr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXNa8hAAoJEBQN5MwUoCm25OUP+weMfx9nP8Yvl1uLIizKECH5
VgqoltrqXY/eR7kDOO3ho17s1O7LCeNCVGGDxO8hdwx+Rti2WfmNS6iFZDiKvcE5
xPNzlV3UQ3lDOWD9EJ3/T7I7k5spDeETpgvG3GWatRAcNB078/XWP88zBrI3REEY
YPGU3auesqWbvjnX5pQVMzMQ0keokJ/zxRUolVlMuq9IaA1dW2+tr4aq1UQ4zQa6
kjLyEgdzhLTLnQnw95ocv0x3qVVXRknCsrdMMHHcD17pNfJpx8t9sQV/XrqhXpw9
E8U05ZgfFYAVskYG1C76y3N9YcQcEgGAPiT1mdsAbiMHFQIBPIoH1LN0YhtU1vr5
xHz66pBOAjwikuWfNBAN86KwDYKIwgok9ZuzCbk0S1ng0ALL8ldeqetuqzV2CNSf
Cu+4FaV8uil6ka3MJO31qIpXRpoGOGofsidgxgE6Sa4XrLg5zsEmkWInwdFNFtBs
mDV+21izxz+kqZrdEqsruVn5vOSXlPfiUo/cYAX+Oksl9jWjJpc+BuswTK2BTKi+
/gVAioSXf2k6SlUcRvqOKrEbFfHnwqAAvv2CWemJJZsUEtBcj2WJ32qor/cp6sbV
3W+mxg1gUtPQnyaxfcAEMO5n6CiRhv+YCi7xwrfijE30J6rxLwpq1pZUakc2ou+7
O3p4YDNZrrG2MajNPMAK
=osSy
-----END PGP SIGNATURE-----

--Bqc0IY4JZZt50bUr--
