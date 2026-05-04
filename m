Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E5E388369
	for <linux-i2c@vger.kernel.org>; Mon,  4 May 2026 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890887; cv=none; b=szOWh7SWLFzDDW3z64hzus1cxNmAzkPQUrSPnI9Hx80tG4zaL/HoU96zxAnLzLwLpcXDIeV3rZEleEN48S3K/K4Mi31BgUEu3tnE6+CmzVzcL3V9nK6O9da7L3YGRKQeNVcetIeuBilUOmHJiEgRKJ0sb+Ooo2zwG8YzA4hg5kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890887; c=relaxed/simple;
	bh=OJ9GKlyaurUwJ/3XL0NQaNUUqnitGkJv8sYoWeru4GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfwonRLcgm+dWyQGwkHTZqOphuedVdkvhSiK+TJXzKDZt5U07qde0FocQq/4dtxFbWIN+VE64fMnun87CmboGSck3Jbg/bcyns1040Ha70/L6y6gyLNzafiQB0Qy2B2fg7Fi9n8DflH3H2wX7X+zlme2VEUv8I8sxI1v/Z9xYYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=e9AeWdLs; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="e9AeWdLs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=OJ9G
	KlyaurUwJ/3XL0NQaNUUqnitGkJv8sYoWeru4GI=; b=e9AeWdLsWbczTvwNX0vr
	tr/aWFJbWNiHqRg5/O3gb5fxaEjaLRZ5k+gyx87THuMlO7LMT9DyFqLiR1LzDKtc
	tH10CRypzr7NNWKz6j8088PLuojt+Y6MSeEsySHvfyvVixKcVKNvJmlUpcP6zN0a
	iSA4wHJUbtWZcla/xFnkrdA3jPMdYVlB502Ku6YiNXT5Bp7Q2iMO8TKT7e6P/uk5
	6dvJwg0ZTe05xYO28SteHUW3ofhF0j/9jqu/ImcRoD2csJygann1OWCI95lSqrZ9
	pGYMsva4Y1nIUly+hgPdlmYXfzpBSWxWsZCkoSHjacx7sbvi+AkjOhKfchf+GVcy
	Mw==
Received: (qmail 2156265 invoked from network); 4 May 2026 12:34:39 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2026 12:34:39 +0200
X-UD-Smtp-Session: l3s3148p1@RlpGevtQxs8ujnvR
Date: Mon, 4 May 2026 12:34:38 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: Compare the return value of gpiod_get_direction
 against GPIO_LINE_DIRECTION_OUT
Message-ID: <afh2PjFHLCdcZQDK@ninjato>
References: <20260415205021.1174764-1-zlatistiv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YYAJQtCNaC1VI/pG"
Content-Disposition: inline
In-Reply-To: <20260415205021.1174764-1-zlatistiv@gmail.com>


--YYAJQtCNaC1VI/pG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 11:50:21PM +0300, Nikola Z. Ivanov wrote:
> The GPIO_LINE_DIRECTION_* definitions have just recently been exposed to
> gpio consumers.h by breaking them out in a separate defs.h file.

Yiha, finally!

> Use this to validate the gpio direction instead of the hard-coded literal.
>=20
> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>

Applied to for-current, thanks!


--YYAJQtCNaC1VI/pG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmn4djoACgkQFA3kzBSg
KbZ1VBAAr7IY+7T8XgIVuTNwXG6GT7/0paie5zhmW882sFgK6y4RQHZcLIe58uUq
ECOROoT9CFAtnQVVI7Yjzm9L3jk5NonLnGFduNEzXJVzHVDSsvLDp6gWNPXBB/XN
VPefIevNxJbfCu2IfRdicThoF7g+3gOQieGfLF2R9mkqelb0CdRi97OstR8047yl
QlvYp4eV2dB7DTZGxN5mup9O7PYAtc7PHJ8RdiN7PzPaoPZPnKBMB8V0KNdgH8M4
ht9Bv8bs6q6rXuHczJVdUKzPpFF4rbgjOJetIYTOsi6g+mpAMqUSlcLCElQZnNLe
PrjBRXjpq/oDJ6mGd7T1nLyD3MCH8Bg9eHSGsdnhOsW3/dmpztbOA6JhCvvwita5
tNctg6ul/JsSmYJ5p0Mi7tQK+vjCq0Y4257nCTgNvqeyj2xOghpZ8OkFd4C9YnQW
qSou5WL6qg5bFWoguIgISWMrmQVuU/AO8nriv3WScBTkTQaEc8xVvF7XXU1lfPxU
VSwpvCoTAwrnD/RK+O9P8mQob19XPErBu60GMf40SF3oDFgz6gGjkTXIwc20KIl3
JA9z2QvSmwRmoU8mSdpupeB6lJ0m/M/jwk63CDbRY/Z6bjB4fqdKiw8Ijkv8tcnq
N3uuGoSWhQddDFLOdeuLBjrDPOyKSgKdQuYvnNRYAY0hyn5Cn/I=
=9Vaw
-----END PGP SIGNATURE-----

--YYAJQtCNaC1VI/pG--
