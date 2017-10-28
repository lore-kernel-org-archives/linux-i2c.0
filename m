From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: generic recovery: check SCL before SDA
Date: Sat, 28 Oct 2017 22:55:46 +0200
Message-ID: <20171028205546.g7hs4voihbzflfhe@ninjato>
References: <1507207454-25158-1-git-send-email-claudio.foellmi@ergon.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="we4etmz4ccrcuamj"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:39449 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751478AbdJ1Uzs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 28 Oct 2017 16:55:48 -0400
Content-Disposition: inline
In-Reply-To: <1507207454-25158-1-git-send-email-claudio.foellmi@ergon.ch>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Claudio Foellmi <claudio.foellmi@ergon.ch>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--we4etmz4ccrcuamj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 02:44:14PM +0200, Claudio Foellmi wrote:
> Move the check for a stuck SCL before the check for a high SDA.
> This prevent false positives in the specific case that SDA is fine
> and SCL is stuck, which previously returned 0.
>=20
> Also check SDA again after the loop, if we can.
> Together, these changes should lead to a lot more failed
> recoveries being caught and returning error codes.
>=20
> Signed-off-by: Claudio Foellmi <claudio.foellmi@ergon.ch>

Applied to for-next, thanks!

Huh, I thought we already fixed the add-SDA-check-after-loop, but seems
I was wrong :( I am not super happy with the now doubled SDA check, but
refactoring the whole loop is a seperate change IMO which can be done
later.


--we4etmz4ccrcuamj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln07tIACgkQFA3kzBSg
KbbPFBAArvOGFq0aHmW/EQFXTklRQVZxAfQ7Wf9C3GOjDhKHi0urk0tyeSMn4vbg
SgggkLUpXKuhxV3zoh1NhpsHxZKxyQJWGm1JYeYSmtOfZmE0bUR/0YtwlDPsPCCi
N2uBegY+7kwz0nNFRsUqFRVryGZoFsXQwfuhcl992HUeYCEummKqG+i2XclEawdc
g1p4umicZ/9WuCzt9u7dbybM+Epm9iHYuvlfnQaoPCAEstvN+jzUX9jVIs791cQ1
Z8A1dJe89suKohlVJnxJ6iXD1np7fkvp1BF38HXtEWOA4pIVuoVQiPcuQ2g7+/Rs
XMqBm+LaNInds6aVlF6RkCQUbTt7P5awiacERGmVxU/CCUliFyRKgHe/yhM3YRtk
lndXM3NXuTg2iRQPvNYB+aShsql5HIG8aHXuxCPH+sxtFo94UxuSqUcXGeKD3EZ0
p/dptiMgsNnrLcRqLL9RGEUJMVkZj4Xr4sn17WWWXUKUCmARFNIRMseuCSA3+AzD
U9DHCI8EuG3I1RtwbMFV4Sbklsi84E1LZwtMNE1QwSc5FsJO1EC6iGkilR/bzVdW
ZQj2ZjKIsb6UH0G7zvlxYvJF5sZEwcBd9sGTckp7V+znZhjhfYHz37kRdcQnVvKK
y2Z6VjVLlTeRorMMyugbzGbeQcURUPVM7yxrL0/Mat6eeL2Sk94=
=UQYQ
-----END PGP SIGNATURE-----

--we4etmz4ccrcuamj--
