Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C03D3CE3
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949692; cv=none; b=YFr46IoVwkutFo0roeBWrWEm2ezCopLW2aki2Vlc6yksrT5ZBXqKwAc9dwLPZr3pCpTh5PBZKMreSk4m9+0w+e0TbhNCphKvcoXuT6OdQbT+tj+XgHZMqcibmJzaqZJbyJe7QajafO2bQNbmMyq3ylI6KAnlCh1l8dXMBUaGtCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949692; c=relaxed/simple;
	bh=B5m5KJtPr9RSOOs+Q1p7BihUOA4EJZ1/x2F8XqpsIZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqgQijIo2diRtojGHiVL3YcAfKHfJ21JOyRCCBwFZU83u0mnrNC31jfYkKbU54+VWgZd4IirUjhz/Lt9W/mBh4Rksx02ypj0qoQCw7eKwNM+hGQYCVmY23c011r1tY3IJlLkf6l1UYPf56nDegn3Zz2nSpYAc5gD1kyqx3/vVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=fYfJqoGG; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="fYfJqoGG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=B5m5
	KJtPr9RSOOs+Q1p7BihUOA4EJZ1/x2F8XqpsIZg=; b=fYfJqoGGBFBugfeDHDt/
	wevScgw+NtsVi0OReH45UEph0XydkmTR5DgJa93MMhK5pLw5KUCkX4tFsmmCTIbP
	Z6O4EkLWd3sihxdeHpPDKm36XJ+d1O/4Vr8zbmvfkf6qXJvZM0YILFgHaTL3KEdu
	6ZeZM6ngX6eZQD0a6K+9H5OFI146Si4XdUXb5JFHtB4cFXLnZR0qsDpljOqeX4Y6
	8xUc0yGvIHWkjvfoOl4HgFZkg5pDjKRy1f2QcNhUzx6nVy2ro2J6PhGBBln9HV4A
	pebOvkcZJSgVmb0bCQZ3CSDSc1Bok54/zCgYY1J/MsQQVPmdQWFT0XwOkTy/z9xI
	Bg==
Received: (qmail 979871 invoked from network); 8 Jun 2026 22:14:38 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Jun 2026 22:14:38 +0200
X-UD-Smtp-Session: l3s3148p1@ZZXyqMNT8osujntX
Date: Mon, 8 Jun 2026 22:14:38 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c <linux-i2c@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] MAINTAINERS: i2c: designware: Remove inactive reviewer
Message-ID: <aicirrlTEogrPM3S@shikoro>
References: <20260608124903.1188986-1-andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dRzbzpOf6CdY1rFy"
Content-Disposition: inline
In-Reply-To: <20260608124903.1188986-1-andi.shyti@kernel.org>


--dRzbzpOf6CdY1rFy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2026 at 02:49:03PM +0200, Andi Shyti wrote:
> Emails to Jan Dabros bounce with a permanent failure due to an
> inactive account. Remove him from the list of reviewers.
>=20
> Signed-off-by: Andi Shyti <andi.shyti@kernel.org>

Applied to for-current, thanks!


--dRzbzpOf6CdY1rFy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmonIqoACgkQFA3kzBSg
KbYkiQ//ei/RKwr7xqp44FJ0lXSjnbfHC3TSlisW3O77coE/bz9XGaq1V84BnOiR
iT2gZN5sITrfwgwC/cTPo41jUvSbYgRy/XGN+VycAOIHAysokGObEA/J2tG+CgXQ
PDd8IrnTx3hrJX+3T5wJQa1gp4AaqkMNURQcDY0omUt9Ao1sSW2MWLZxV8glfFax
O0SXKQq+bFCzglCacVnssQiT2PcEWjO79bzRU2LkFSK+7OZz6bjH6AySDKfcoq1y
sUOcmashazixQasUpQwMFdSK+1LUZ15UBzqAcg7DJ64wFjYrU/9l1jK9NrYygEcM
aYabKf7t+NOZgFJiFebyrAfzSxqpJ+O6ogbLc3IrtSlDMpdPGXpF/GwdBTE99NYk
GlAs/P94KocDB22QqsENE0y2saK0s8fy9SEpl+gBTi1LzUvobiA0RnhCxexCV9es
P4+/htyYNKhUrRHl9HHS/f8n5Wtp9Y2ZUerB4HIiXpQBi6G2A6hLN3BBuGVhFWVu
Xt+R58qs2O1/+TYeFmHW8d5SkW+nOOqjYpKUyf6zfDOLUADaBKO5OWNPpXJ7sr5m
LFz4M0z1nWraNf8X1PzqVkJkeTrT7VVEzsERIgSJPL3vNj9t/N0+nxvdJTSWypkF
0rrwXR68GnMDVgiF7xHl2KvlUWMTB0aO5T7AagZO/aO+HrnTuPc=
=mB0D
-----END PGP SIGNATURE-----

--dRzbzpOf6CdY1rFy--
