Received: from pokefinder.org (pokefinder.org [135.181.139.117])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFE23ACEF3;
	Tue, 19 May 2026 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188024; cv=none; b=SNFAlcvsQhD402/b/4JdKpqSOYLm1KHvoR9BIqDOKtoQ7n5A5O89zrdcU9sN4uvVABbO1yKsTl5UD/3hHGXZrPDbvUNfKoZ7vIHq/jgN53V/UOzhqGA4wnRXaGoyi5qUc1I6E9smbYBhQbgWuQPg2zb1bPKYGJDTmMdK0yui7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188024; c=relaxed/simple;
	bh=ksMT1KM+FqniW5A/seZ1vubTTiUVBj73UT6iYLn3irU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+JQdMHLL0fVa8shPMYo5o9l3lUZ2JD8LZtimJj2YYLE63VZcxIl7VJ7950ywXcqql/w40JtEsjrK53ghxwL+kQcsPFQxRi3wcsLdGSh7zmBVmlNaH65OdkfUhf6AG2D3DGf/uxWwe0yJB01WvxH3bOg2jPcho5v2zIrzmVL0Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de; spf=pass smtp.mailfrom=the-dreams.de; arc=none smtp.client-ip=135.181.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=the-dreams.de
Received: from localhost (p54b3371a.dip0.t-ipconnect.de [84.179.55.26])
	by pokefinder.org (Postfix) with ESMTPSA id 426C0D63AA3;
	Tue, 19 May 2026 12:46:52 +0200 (CEST)
Date: Tue, 19 May 2026 12:46:51 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>,
	"open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] i2c: core-smbus: fix a potential uninitialization
 bug
Message-ID: <agw_mywR1xwbVPTa@shikoro>
References: <1525525030-9805-1-git-send-email-wang6495@umn.edu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d3EIFAQZgCAmzUsP"
Content-Disposition: inline
In-Reply-To: <1525525030-9805-1-git-send-email-wang6495@umn.edu>


--d3EIFAQZgCAmzUsP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 05, 2018 at 07:57:10AM -0500, Wenwen Wang wrote:
> In i2c_smbus_xfer_emulated(), there are two buffers: msgbuf0 and msgbuf1,
> which are used to save a series of messages, as mentioned in the comment.
> According to the value of the variable 'size', msgbuf0 is initialized to
> various values. In contrast, msgbuf1 is left uninitialized until the
> function i2c_transfer() is invoked. However, msgbuf1 is not always
> initialized on all possible execution paths (implementation) of
> i2c_transfer(). Thus, it is possible that msgbuf1 may still be
> uninitialized even after the invocation of the function i2c_transfer(),
> especially when the return value of ic2_transfer() is not checked properl=
y.
> In the following execution, the uninitialized msgbuf1 will be used, such =
as
> for security checks. Since uninitialized values can be random and
> arbitrary, this will cause undefined behaviors or even check bypass. For
> example, it is expected that if the value of 'size' is
> I2C_SMBUS_BLOCK_PROC_CALL, the value of data->block[0] should not be larg=
er
> than I2C_SMBUS_BLOCK_MAX. But, at the end of i2c_smbus_xfer_emulated(), t=
he
> value read from msgbuf1 is assigned to data->block[0], which can
> potentially lead to invalid block write size, as demonstrated in the error
> message.
>=20
> This patch initializes the first byte of msgbuf1 with 0 to avoid such
> undefined behaviors or security issues.
>=20
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>

Applied to for-current with commit message a little reworded, thanks!


--d3EIFAQZgCAmzUsP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoMP5oACgkQFA3kzBSg
KbYGsA//YONgFxVrGVGR62Mu4dCaIAltwkqjqDjiVSV5VShz/iXFUM+2P0eZUZR2
q8vreLQczCu2gvv78em+07aD7I7lZfeEJhnz74R+uZEP2ZA7KzqhefkE//feXWhv
IPie7daFNk6YU1OOW39UbZvyRQtnLplJGdApskCJGaD9vsL96aLgy3/gCf0+R4Cv
D+tNx2y6HzT24q0l+km9WmPk87yVW5H3eB/2GbzqxKQqRagt8d8tNmlX8c7khw3K
ciqI+lJbx/3OQAIiCexGFCglKrpGKOsV9YxWhheS60afnJY7qdi1aDdDRgnJv1CG
q+dFPnqn4bPEXB/UOIBLauBOXt+THzFa0YmPExo5SrVKe7Ejhp1nejbd0a/U+3OC
ozNGfIJhTgTAxqkOVIa2ImxE1LaR1N7M6tqC1OjwAyXvjCBsRQDENW/88tYUiRwm
A8GUnWoWSmen1IJTjW3MYBvH6L29/fyPm2UChc0jFwujv+pe9opWid9TiZ5WoI5u
5c/heoxkgjCU/yzqouf2RLebSAFx1N0q7Ua/wk1pMxhI1G2px3c0+HrGMXd35A6Z
nmKlZ4Zz7E3bsRQpNzrt6rFnZeMeIF9u/Dxy41s05+6mkFQMXDatCG3lKpDsokVH
mMoBo1vTvR+5UGdEc8/j1sIocRujjiiN7y4MKcShz38aodpaa5A=
=c/xK
-----END PGP SIGNATURE-----

--d3EIFAQZgCAmzUsP--
