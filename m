Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16346313543
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084736; cv=none; b=VjQI144lrrf5nNWbyjXbp9hYgVzZrp7MeEZklAeB3ZLx99M0k1xQ1i6c7wbI2zwRDjgyqR4ySIbB6LfTSYTAUKHCm9Jf8L9p+cp3/QMSSUtuNSvd470cRhmflLcKR22HCRiK/z3ig32JYSv2a6gj5bt39aHrvii1K6gpBAJu30A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084736; c=relaxed/simple;
	bh=7rYg/nB1mIohKdMRI3YCjf1EDYrIO9a21oB4Fpff0ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPI3OH6DeI6i7DFRQVRpML7yCAcE9r3QvE5noYs4++0Whb8B6ahsudo3rtS2o215zMld3L+XRHuCPCw8plIL4y1eTMVLEMDK9plaSJbJCPSSsmxhJ5MmAFJa5EVY/7shZx9BXa+/qj1KxouAe7nXrF280lW56j5s6W350QdJ+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=NP+tAzbp; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="NP+tAzbp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=7rYg
	/nB1mIohKdMRI3YCjf1EDYrIO9a21oB4Fpff0ZQ=; b=NP+tAzbpkCSmwevzjfiw
	yBq2eC+ZPPom/NIOQ8jahjMhdgaDxuTClXxjCAUcf/dXnUVL4xQhDGH2WHa8LTtj
	xw75htqeV5i5KMbb2uf0Ij1YsjKixJwdswFp3Dfn1+IkCDUXmShbvHUXDOiNJNHD
	+9c0SGcTnPyvfR6zSnzU+2ZpgBVGKE9TPbpAPDHbVF84NagZGv5HH90I5Vk0FtWl
	D+hGXxfUvNxkff+44oqmnU7efy9cHHyJ3OF4Fc1JHClHH5aCtnqpeIB6BYmgJ/rz
	LwLb/+ccJWy/DrJTOor29p7ThkVyqeeOv7Zbgq6UAZYWP7dGH3eHvp2LW5io/qW3
	vg==
Received: (qmail 1526455 invoked from network); 29 May 2026 21:58:52 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 May 2026 21:58:52 +0200
X-UD-Smtp-Session: l3s3148p1@NCkZRvpSdzVdnheM
Date: Fri, 29 May 2026 21:58:51 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH i2c-tools v3 0/2] Add support for message modifier flags
Message-ID: <ahnv-wlmr_70XX9K@shikoro>
References: <20260127-msg-flags-v3-0-e7539945db2b@bootlin.com>
 <20260217131348.007dde93@endymion>
 <5031224.OV4Wx5bFTl@benoit.monin>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bYiXa3qSGDz/EHgE"
Content-Disposition: inline
In-Reply-To: <5031224.OV4Wx5bFTl@benoit.monin>


--bYiXa3qSGDz/EHgE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Did you have a chance to test the patches?

Code looks good to me, will test it in the next days.


--bYiXa3qSGDz/EHgE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoZ7/sACgkQFA3kzBSg
KbZHVQ//VVELZCY54bt7pw+FI/YQuKmt5wQJRpgftQPba0qnw3El2D2mN0vojg+w
aknr84HmdQuAc2Fq5r3cRKgmjaJav11PhxvFleRRLNtOhSmMNquPuYyzHa5EQ7LP
qNhpR7Z5dfQSdbhiIgPoj9yBARr9/jefHqPWb93Me4uAa9veI887ElXdjlcdpwUg
8G8guYVTHfsxodrKgkez0GfTSqi8zfoPfGnuOeEYub4fdLDfBXhCA9UMacw0EbdJ
va13Rf3HVjCdai5BVHfNSvOFRTTX7QZ5GXF+1urjJRQlgD0H8rvwjYBTpI+wOVit
hv76/+94mUY5cHw1ZffI69fUroU2FhHSqwSUWx9uHS7LU2xwKa53dV9jVTI9zxGl
GEi2OtvucI7pqYmZ1XVwEJ2dUPR4Y0ZBkOoCAT7FkHmspfkNWcG3q6YXet/GCBXT
U4cgAl4uB0ZUOCiv+B2fKYFZk3oUZRw/z0d0UrbUwsZhIGsaPlDlqSqGX3fEMC+3
xYFebqJda2WsSQbjoYM9UIUQ+InHDGvebMmZgOASMJjca4eg+R2IpJSgfuHLDF2D
SHIgzMzTe2h32MGVuxrP6rlOCMigKvpNjLQ6qt8X/m0GLYVU2SXW710HmF4+iayM
wIGJ5p73eznKM8Mkq2YVQ2DonY3PcniDFc8J6BGq2F4KvLAjqRQ=
=kKdy
-----END PGP SIGNATURE-----

--bYiXa3qSGDz/EHgE--
