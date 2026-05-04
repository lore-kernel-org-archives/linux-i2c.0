Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EC137700A
	for <linux-i2c@vger.kernel.org>; Mon,  4 May 2026 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777886349; cv=none; b=Ay95dykhE6fPqA9kzPZIgJU4oBvx3/xZ3dAh42G8SbgUGHd3pm39Bo5YL7H1k+CuhPd3qKcV4EonQqruYjOxMKOiXejDAO37wsSqqMkeSEat/hckraurSoo3L66WM0MbY3xy4867SFyrBMwAf28pYF9raxoPk/lSbLp8YvYiIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777886349; c=relaxed/simple;
	bh=B9iom6SoBtIl4KxAXQi4NBPS5mHObXAidFBUUi9eiaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUsQRutFmsWrfdEXhNe+g2aGq8guvtIXMHhKVrHTtVExk/BocE4IE6K1QLLD75/tHim94CmGc2oOdeUTYw1VeCKlRbOdyq7W8aMKtIm5UJaHTSZZ5mn43nQnB4RihAyTBXzNP0w4NmquUeARFawWAFkv63NFZBFbmC8puS/nlGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ikGAZ4BR; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ikGAZ4BR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=B9io
	m6SoBtIl4KxAXQi4NBPS5mHObXAidFBUUi9eiaw=; b=ikGAZ4BRLlXcusrljtCq
	ZUzhjqsTbHXGuqiMjjQvntHR3fPwQHdvQGLsc7hdn2jgNugYRcqCYCTNB7UaR3I8
	ftPaAfDzT6Fr+8eZBrfR1aykgwqNfxRVvlNNI/PFuyjxu1jVZstpSHGST0ZLkGvD
	TQaL/npMegelSbV/ucaS68anDW2h5m6POCOhQD7Pgl3pD6CHSHuW2csi6HNEiWRE
	OJNVV+BqugbXKQx+w4BZ0pD+bMlKAeam7bq07Hcow2XGvRVyOoYbe72k5vMHDZoF
	TdZ+iVBUV/hG9XjDGIuZGfgsLRDYLYrIAs1WHoLzxMwtI1DGGOnaZwM4PbEdkrBB
	1Q==
Received: (qmail 2122993 invoked from network); 4 May 2026 11:19:04 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2026 11:19:04 +0200
X-UD-Smtp-Session: l3s3148p1@1DoGbPpQPJ4ujnvR
Date: Mon, 4 May 2026 11:19:04 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Niels Franke <nielsfranke@gmail.com>
Cc: westeri@kernel.org, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Add ELAN0678 to
 i2c_acpi_force_100khz_device_ids
Message-ID: <afhkiGREdd50vYNN@ninjato>
References: <20260418053719.15766-1-nielsfranke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oKyoE85Wsy/3DTOf"
Content-Disposition: inline
In-Reply-To: <20260418053719.15766-1-nielsfranke@gmail.com>


--oKyoE85Wsy/3DTOf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2026 at 07:37:19AM +0200, Niels Franke wrote:
> The ELAN0678 touchpad (04F3:3195) found in the Lenovo ThinkPad X13
> exhibits excessive smoothing when the I2C bus runs at 400KHz, making
> the touchpad feel sluggish when plugged into AC power. This is the
> same issue previously fixed for ELAN06FA.
>=20
> The device's ACPI table (Lenovo TP-R22) specifies 0x00061A80 (400KHz)
> for the I2cSerialBusV2 descriptor. Forcing the bus to 100KHz eliminates
> the sluggish behavior.
>=20
> Signed-off-by: Niels Franke <nielsfranke@gmail.com>

Kept the sorting (alphanumeric) and applied to for-current, thanks!


--oKyoE85Wsy/3DTOf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmn4ZIgACgkQFA3kzBSg
KbY/iw//Q3MTxv0uoed9meVZMOoorKDntUhkTEsHs4nqKCkAg1nd/eTGT7BIRdS7
9slZckra+FUkf64J5XxTvXW2rmX+pWHNxuk9W1POcOWPaTFrR9qjdB8grosviAAe
Jv+Lvq1SrSio0sYWUX8zbXC9+aLz0FSKSZFkVGvIo8MoeSCNj90x0fqx10ibMems
Xm7Dy0w2NeVqX10rJG+PdEofNLj7vme4lElw0MCtHAUI/vyzKT2uRNFUklyDuFvA
1X+dNQZCddRNc13nuDHPv6QxZwyDbezi1oHi8lJg7HlYBdfiPwgCYC0Nx2vrkVyj
Ccm/Fk/aLeGJ2dx1ePhTZhL/CIU/fIVL1+WyH9GrMo/VSVN5MX9HdKGmViN82CGY
FRLAij+dZcJ3wqmr218vlmWin3/x8P/OeIPYzX70QticQfs+D4oyMV2y1JgGs10Z
RIiW/VDISr08qvOSXycukIB1vMfFbDHcvdsP0mkGR8bjNE6GR2CGIZKU9JBk19g9
3TUCefJkY3oLvHxy9dnfKwCU2Q4zlh6MSjbcTeRSeSr3ZQ114Boe9WOx3PZyzoSP
S+5N394XLF7wjzXtgFWkHTntPniLMTbYXuINco8jO66eDP9uSq2e5QHNZ1jSYHYi
Gr9dZg99QumBk+HGdZmRNz3fRgpl2beYCoNDqJDskV/6qL2BtJw=
=BDC4
-----END PGP SIGNATURE-----

--oKyoE85Wsy/3DTOf--
