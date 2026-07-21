Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090664248A0
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616821; cv=none; b=BJNVO+ekWv2Ks/6yXyTPW+yjbUyT5p6hOojs9V3oloGaJcu5dnC2DHpwOgFn8PWW90uN0nSVcqCPhbuxbhXFwesUJLxxQTAU4pDDru+ijxMpswOjUCkftMe/KNkd1rbxcZ5osWKxVX74Rzat/6Kc5rkE7rA0IrdQHoKJMRnI4/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616821; c=relaxed/simple;
	bh=ixdGlAM3wCiU5lS8naFSfuzWJaqJXb660cRLf1Drrso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q04A2J7vpHcDN2F8u34qC+tx4uwiwnAbjB7TNGaQB6GLlqM9QHnqER5HcQAM4b++Q5lxKsJry/mmfYPkwCeAICyRjZqL3OyGO+8C92UaJNzZEzyFpAoZFb35P34JiagC0enSYWakz+BKHJjnkORmlggPc8CBIM4t/HebaFkynRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=bk+Ov2xL; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="bk+Ov2xL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=CFAV
	HN4DnxrSapvSWrDxThLWS1I2WpJWFBcxdY1ys9Y=; b=bk+Ov2xL/0AAcwNpGMIh
	9f14n4Eqb/F8TnAfU29xpnhXo2rsI2tLI0ZBtIJ1mTghsiH09co43wDy9qYJb9fY
	Z1a7uyEIRxLyMPbDUlp17PPfatB0Vr4JjUivp88mQ2EPgT5iZ2k4BbFU+fFW6IWU
	2qzaBcs+2k106xQAkS6OXAaNiHxk0QN73c+6DbUQUC00HcpAdvxqlMQyOdZCWpxY
	sFfNY7Yv8GZVpT8yiTGDI1EpI4kNcdF7lxYdVqbq37om02o3EKDgZpi+bc2IKRj7
	vB+fM2ypfjMtevnhORIYLpU4ZzmFgo/o1Cz+CLuZaLz780tjA8hnHwyc/z/e2zdK
	GQ==
Received: (qmail 2744309 invoked from network); 21 Jul 2026 08:53:31 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Jul 2026 08:53:31 +0200
X-UD-Smtp-Session: l3s3148p1@LIEbexlXDt4ujnuL
Date: Tue, 21 Jul 2026 08:53:31 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Tandra, Vasantha Likitha" <VasanthaLikitha.Tandra@amd.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	"jdelvare@suse.de" <jdelvare@suse.de>,
	"Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Subject: Re: [PATCH] i2c-tools: i2ctransfer: Set I2C adapter timeout using
 I2C_TIMEOUT ioctl
Message-ID: <al8Xa6P7YYRwOn3D@shikoro>
References: <20260720163401.2001860-1-vasanthalikitha.tandra@amd.com>
 <al6c2VXwLFcNRLu7@shikoro>
 <DM4PR12MB77657106776BE150FDCCF7C093C22@DM4PR12MB7765.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L8fXuN5FNXBBuQ30"
Content-Disposition: inline
In-Reply-To: <DM4PR12MB77657106776BE150FDCCF7C093C22@DM4PR12MB7765.namprd12.prod.outlook.com>


--L8fXuN5FNXBBuQ30
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

>   Thanks for the review. Your suggestion makes sense to me - I'll move
>   it out of i2ctransfer and add -T (timeout) and -R (retries) to
>   i2cdetect instead. I agree a separate i2cconfig tool is not needed.

Great, thanks.

>   While checking the list of ioctls, I observed the I2C_TIMEOUT ioctl
>   to set the timeout, but I did not observe any "get" ioctl to read
>   the timeout value back from user space (same for retries). So
>   setting a value with -T/-R works, but reading the current value
>   (when no value is given) does not seem possible right now.

You are right. That shows how seldom those IOCTLs are used. I forgot
that one cannot read them, sorry about that.

>   Could you let me know how you would like me to handle this - should
>   I keep -T/-R as set-only for now?

Yes. This is the way to go.

Happy hacking,

   Wolfram


--L8fXuN5FNXBBuQ30
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpfF2oACgkQFA3kzBSg
KbZhbA//Yr0TbpkW5aZGVwRetVZyYrKwX0VPP7EkUEgznL/B+tHh0WCfmX18H27Q
6ihGxRjpn8hqjDtFLlGuqFtlzrLKryRS7mk/2wMLTf/0Fo3V5h5B3qK7cYVRxG5w
4GEG7pxQApimAjAhzGM7VEoOYWaAn9CJCH/MxspuMSkrYaisQ2NkPJQMCba3odo1
2KWuQtalSSp+QjVqsKhEVXqQX/p90CDdBVR70dTsj51ck/E8PcGkrUKj9xS8/nSL
EbR6ctG8xNFMy3jSDDTDRCDAOXR7vQICZpdqNMl8iOqsaE1++v1kM3w+vLPAqlZp
tcb2oRlCWJLtt3IIiXOw9AC2PopDakJ5cj07EKFskNaL4kQZXRsaFqylP57vdU+s
GnChx2RpRP+5f9AU6FNtGrceVZw/yel9wpoX2bVywUK7tawPLDEnbtKlfLFDZNJw
RNphIxdHbiupSgTm9mbyD/N90yj1SQyqCxrOP3KbaNqVy3e/CqRSY9dRj2xD1AlN
IdphqKGMKwEaU2BNfjOFOmLpc+SmZ+onbf25rzkN66EkD4vgG4wedV3hrEATKJwX
ik3TvEr90DDW6uNONoZBUaCR5ryBOihCFIhhKVwI2jevE5bDN2/OH/7sQ8snAn0x
Foyf6JaYCMoIqexgXddqbhqQ1wSpbi0R/R7cxKAKIpT8uXdJjQE=
=/L/c
-----END PGP SIGNATURE-----

--L8fXuN5FNXBBuQ30--
