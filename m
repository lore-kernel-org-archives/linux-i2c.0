Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8323036B07C
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955171; cv=none; b=pvm/cyoFWPGmd61tE0ejqHax9WPp4r31usUFz9A47lTMkFureHoVOPxjCH8kPuBq+UjI1aeOemKULl1KBpXyJha6D7QN0iflgrf7h867t6C10Nco1Ia9Sc4qnKHLuSbXO51HnA+1Y3z6KeWmP8sxbiPwfhPxhYk0Ic3aPPtOshY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955171; c=relaxed/simple;
	bh=0zwZej/5vMv4m/T1Owgnol1Pc+mSVPGovwboGZXGkiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICJzlEo1UuAFcPe87MrGSLX9+3gLxhh9NqoVqqeFuUQ8FstFzUqfPIw94AyaxYp1AcHBKkiOOJWV7gyg6exHyOsUa3N2z8e7wTOAwssRgjJCBcUluEDkYbETVYUD/wvKOop4+wiRHPGOvJUhGmKVzrufwEuoSbQqDPgSq3Dqpik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=klqg1I3C; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="klqg1I3C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=prKu
	xmGVoZEO2az9xB9mAWWi3zUxqWV2p75D9yBRh9g=; b=klqg1I3Cn9x8XiNJ8XQ+
	Q297A0hLq4OpVW9gIx0Aa8aYcqCUWDvXzW9xBDXAkuUGCS+KhdOL39oDrb7N93Lt
	MXFIKynox1sjfeU9Yoe1MLO21SPRMqMwf4J7romdYWQh+j2/uYI7oyvp1D3soCH/
	VlBJlIVHvbqSul1PVPMOyV9xgczqL4efZiqY05GF4zfYsg3OIACgT4lQcoJKdxnW
	PzL7rGzKTyS8lKodh2854KS14FJDNXI0ungG4uYhSdZFHzhNar6KPXJMD3OKW2/0
	LTlYblK7XpkwAfz2wS4iEoA0wGyEpw/W6+5NV9MWHlrQ6LFmGHoeLA/Ox4PhZlS/
	FQ==
Received: (qmail 2683493 invoked from network); 13 Jul 2026 17:06:05 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jul 2026 17:06:05 +0200
X-UD-Smtp-Session: l3s3148p1@n6TrbX9WdJsujntq
Date: Mon, 13 Jul 2026 17:06:03 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Gero =?utf-8?Q?Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
Cc: Brigham Campbell <me@brighamcampbell.com>,
	Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v4 1/2] i2c-tools: Allow passing device file paths
Message-ID: <alT-251aiK7B0ViQ@shikoro>
References: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com>
 <20260705-accept-device-path-v4-1-c62caa708a9e@brighamcampbell.com>
 <DJU1QIKM2DNQ.UOLEBWH0U0QQ@sevenlab.de>
 <alKYhB6PKffxI2vt@shikoro>
 <DJXC1KBY7IXJ.32N5ILIXL8J4N@sevenlab.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EzWhOTgLaJarhdwC"
Content-Disposition: inline
In-Reply-To: <DJXC1KBY7IXJ.32N5ILIXL8J4N@sevenlab.de>


--EzWhOTgLaJarhdwC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gero,

> they have non-unique I2C bus names which uses i2cdump and evaluates
> stderr for the string

I get your point. I'd argue that relying on error strings is very thin
ice, as they are not an API. I think error messages are going to change
with this patch set anyhow. Probably for the better, if done right. I'd
suggest to continue with the series based on our feedback and see how we
end up with the error reporting in a user friendly way. Maybe we can
even use better return values to help scripts? We will see...

D'accord?

Happy hacking,

   Wolfram


--EzWhOTgLaJarhdwC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpU/tcACgkQFA3kzBSg
KbaUVw/+KqENtSl4W20lH0aiygCdvUHZ+4lfhPpSBHo2u3vmuL8ru755sPvG5tLt
YEh1JiZzL+6iqBOSbfUl2DLRwkMD9zCxPldPFYmGpbYQeVyBh80tmIrPdscxLab9
Oy4eTlggpCYt19wpjJ0RHSmrqJqg0Q54y/z6vL1mnuCezB4wUd+nhuG+eOJune+v
dVIRYFi7rrodDFY6i3zyHzNLcyObCSIn2me32/wwp5FpvaCURZyZyvTDvbcsdoLv
pPFV0oyyCbMLNr+YiYydmTchE2vPOB90tjYIxWUd45Igh5Mmlbv1vnA6Y/Q47mWU
eqQSjA1AlNM7vbXWXQaVstGY1erEffejW6ZQh7QQeOMhfKvLmmbtJLOqnn0/USE2
WEg3T0WlKw/o98Rt0BvNz6A+giNVnpWZNAJCNZ/NjLMgfllpul/1vJzAdhZIZqiU
regq8tZtasQrV7MzQgeDTtvy1t49UOGI6LI5NRAR7evAjFDxTxEoIeFeEUyEprJ5
yc4Wq5J165asDHEGziHvPx7n81Y6vX2cqagSrfmDJg0ySZ6FuTEdB5h/MyLUNLY5
KfywQwtUscradrunykj4sX0ig1H8bjd39us/bovw6tK7j2LuXMKXbz83S5jecaRm
esg/cbTVWe0ailVz4IwaRMF9JoGlmCNu3Ep6piYTC8u99NWJRhw=
=xtw7
-----END PGP SIGNATURE-----

--EzWhOTgLaJarhdwC--
