Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C79A31D759
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997204; cv=none; b=WR9aS5sKTEs9h0UF5kaiYfDk+14tqxvHJ3eSxJ6ruDUARjHG9F+3RDenSK43lNdVaJnsqyw2RkPVb6MprvJpCJscyZKBG+WUO3gdMjHg1IPsWlT9t2lzxE5H+G5I/Sbc6mxNxa8ngrdvz0HlAVrxoaZTnbEu375+R05mZCoVGTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997204; c=relaxed/simple;
	bh=WbSeOLEt3AEvOV/iiAgpD0CKt2Ood6ErlL9tEMymr4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbeVenBzWaOevHAw2PbUk13s82dkn9NfKqJfOCWmtmRe1/dHZ80oKCG9V8KyJCH5JDxdgbHNXgQSVxSfqLrYeoKhaTdt5riZ1FLGCcW0VyZFjEmaF8qtL9hwCpMLSdYoaB1fNGFQR/CXWQuIVDE168EXn4fJUPAPoq+12Siz4Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Mwe54qVn; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Mwe54qVn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=vNqL
	2q33Y78Kl4+7wfF/NJOUaf9OxJj11ZemgHEbfM4=; b=Mwe54qVnqRLf0OPl3CXq
	8OIhCGqMJ9FtOnFTGIfk5Ru8SBTnhyV9VJeXh3OJT3MoAHnri4e9F6saTN8c/oet
	VdvRDC0/UtS93/3oasZ3uJIfVkKUhGpEMGEa8lVpUuZPltqLka4s7xgT0Qq8PM4K
	tNq/lUa/EEV8TuQvUPQeCbY72/+D76jV8gP7qe4SVd9DIk6JpqXeMJn3TzZS7db4
	jeuG9fOV7AOS3r7zo2qLYRTtaDVfVQxsZUO6ItAETJBT+t4W1ONMTcqHAsgBElaP
	pBRXjUmvIkh0Mr6MTyHL4ZSXz5irA/hg+O3XVEf3JbsnhVxGKZFT/HLH9u4AA8q6
	Ow==
Received: (qmail 1208722 invoked from network); 9 Jun 2026 11:26:40 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Jun 2026 11:26:40 +0200
X-UD-Smtp-Session: l3s3148p1@jRd+uc5TJswujnvA
Date: Tue, 9 Jun 2026 11:26:40 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Igor Korotin <igor.korotin@linux.dev>, rust-for-linux@vger.kernel.org
Cc: Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [GIT PULL] rust-i2c-fixes for 7.1-rc7
Message-ID: <aifcUBtuker3f9t2@shikoro>
References: <9e49b71b-8b60-479e-93e7-5c12e352c78e@linux.dev>
 <aiZ0eD-A2F8woqTb@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OpCmW6yTceU9o0l8"
Content-Disposition: inline
In-Reply-To: <aiZ0eD-A2F8woqTb@shikoro>


--OpCmW6yTceU9o0l8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

(adding a few more people to CC to have a potentially bigger discussion)

> Please be already aware that from 7.2 on, you will need send pull
> requests to Andi who takes over the I2C subsystem. I will write a
> seperate mail about the handover later today.

Done now [1]. On a second thought, after pulling in the I2C abstractions
a few times now, I wonder meanwhile if the Rust-tree wouldn't be the
better path to upstream. The abstractions are way more Rust than they
are I2C. And potential merge-conflicts come from generic Rust
abstraction updates, not from I2C.

This is Andi's choice now, of course. Just wanted to give my 2 cents
here...

Happy hacking,

   Wolfram

[1] https://lore.kernel.org/r/20260609091612.8228-3-wsa+renesas@sang-engineering.com

--OpCmW6yTceU9o0l8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmon3FAACgkQFA3kzBSg
KbYnaA/8DUWdmhzgbFcKdF+tD5DxBiv6ft5LltSygvhrwAaGB7zbAxc6PmlNVlJC
7g2iFt9LC7TVbeh/GridZ4NXwfOHwLNvFwx7nSg+iPYQrt1DwvkcbdMsqupa3+F6
HZVpsNFjVVvatHT12W1Bfd8XbU6exhuIGWJLeFt5BfI/Yq0x0jB3c2jnRlxajgjb
AcZUnhgcp20Z9uP/rzQOk6l+vV3Y5fEJmhPZnYAwFNx/cDMtlAf/yWxgyED2nhhG
bVTtk7tgHbWrRdMSq8X5/5Ro1iPnch495d7+qc79J5FtNZQyG4DZojdY5xI4XGD2
xyW+OG+rFZrNjsDRNxZxuO42pRZ/R4x/9fT9LF3UoeCNkaFQZsWFEGJ+J1QaXOnd
oV3UQSK7kwqrIwN1rXvpt3QLwrF1Do0ZuAqjHnfsoIHgpG1ldviPzkf4MmHPh5GE
wwNQTjs+5UOPN81MCpw/suWYWhGibIWLvJhcWIohbZ3WgDmXNk+Ffzv6v4qYkz/S
Z54MQvfUnEPKNjtTHXofBVP+b6QPic+pRBev0c12dKUK7v9eL+yElhvP/VxSmXfw
GRgMUHYu5Ck+xEeFMGF9qmkgAUjYulAF0svgZYlzMogg5ipCmqv2aFBiXcO3EWKH
Q+P6i7KCAAHUlGW2gvlur852qqhdbJt++/eJtZnSVxSY1h/NOcI=
=do9w
-----END PGP SIGNATURE-----

--OpCmW6yTceU9o0l8--
