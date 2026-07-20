Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8FC4307A2
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784585443; cv=none; b=n3PFIzjJuN6VhQpwyFf8PEHrFqppTav2CEv+pmDOQ+U/yf5ndne/hnu8jwVt9SgGSx2CSgANWILQp6eM1ETbAykZXsaYgrFsXdRjvZ9K8bqNT1kva/nVAynyBRRNchvL08HfRNKXQj1EVgIyA+D45mojAIyB/PD6wmId6BDjbMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784585443; c=relaxed/simple;
	bh=DszXciH9HNnJq5fDFI3sSXpjjnBLRzA8/Kld82wCbiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txiDlzbK25rUY5MT0KhdfHnNC9IkMyNlN2Ehc1U0HCi38cIVdFLorOsgHRoMB6RckofVTnZneIdrXeIo863+xK2c0CinQniROrY2j6QSf3hiRYPSOrwh4SOwoUmLSrjMAXbLgkPXA5h0bMEeIDlHz6DseDHQkPrFlRLCvgwZ+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ZxeTV9na; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZxeTV9na"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=kMQe
	+p/wSTQqPe8i2tSWsfB28vAlTgZGOKSBE6PWEHI=; b=ZxeTV9namuWjBRSkyxH8
	BLD4B5xJMe50I762uHSyoa8rTTlQaNu7opKKwTdE+6C4CudgGJkwU/1eOH8s89Sk
	IqDTSI2N4FQzu7uQrca8FzfjjjV1m02FGCQLa+hvPmFvpu4yKjfKU43iKgVdMZAa
	dSRdcsVdTQ6eA77//ZygpTB96CCku/VpHyGrAlzB27uW/oFc3RK2cK0XOBMgTJD1
	akS+pdU2Kt3t/HwZ4v95SmxKLKW5C9en4AFdfvjZdiMU5zpK5fn07/D1auMtoZNn
	rSimRuP34vZ0e1AedbC0PXfDny3EWIHFQNn+2/nV0jLz8WUPrZSbDFVrS9/9ryHu
	Eg==
Received: (qmail 2620680 invoked from network); 21 Jul 2026 00:10:33 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Jul 2026 00:10:33 +0200
X-UD-Smtp-Session: l3s3148p1@hsfVLBJX8IwujntM
Date: Tue, 21 Jul 2026 00:10:33 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Vasantha Likitha T <vasanthalikitha.tandra@amd.com>
Cc: linux-i2c@vger.kernel.org, jdelvare@suse.de, git@amd.com
Subject: Re: [PATCH] i2c-tools: i2ctransfer: Set I2C adapter timeout using
 I2C_TIMEOUT ioctl
Message-ID: <al6c2VXwLFcNRLu7@shikoro>
References: <20260720163401.2001860-1-vasanthalikitha.tandra@amd.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qqLrAVAyoeQ7Ymdv"
Content-Disposition: inline
In-Reply-To: <20260720163401.2001860-1-vasanthalikitha.tandra@amd.com>


--qqLrAVAyoeQ7Ymdv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

thank you for this patch!

On Mon, Jul 20, 2026 at 10:04:01PM +0530, Vasantha Likitha T wrote:
> Add a -t TIMEOUT option that calls ioctl(I2C_TIMEOUT) before the
> I2C_RDWR transfer. This allows the adapter timeout to be set from
> user space at runtime, controlling how long the I2C core waits for
> a transfer to complete before returning an error. Drivers that rely
> on the adapter timeout will use the value set by this ioctl.
>=20
> The timeout value is specified in units of 10 ms, as this is the unit
> the Linux kernel expects for the I2C_TIMEOUT ioctl: i2c-dev converts it
> with adapter->timeout =3D msecs_to_jiffies(arg * 10). Omitting -t leaves
> the driver default unchanged.

I agree that reading/setting TIMEOUT is missing in i2c-tools (same with
RETRIES) and it would be nice to have.

I don't think 'i2ctransfer' is the right place for it, though. One might
also want a different timeout with 'i2cget' or so.

My suggestion is to add it to 'i2cdetect'. It already has '-F' to list
the features of an adapter. We could add '-T' to read the timeout value
and '-R' to read the retries value. If '-T' or '-R' parameters also
contain a value, then this value will be written to the adapter.

Was this undestandable? Do you agree?

Another option would be to write a dedicated tool ('i2cconfig'?) for
handling extra parameters, but it feels a bit bloated IMHO.

Opinions?

All the best,

   Wolfram


--qqLrAVAyoeQ7Ymdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpenNUACgkQFA3kzBSg
Kbaz7g/+JIzyaJLN0wFcHMOYPESF2okHFt3emdsi0zA4p20CyzqaMtaB5L3M3kvf
ZPTmPjh5VhE3bXwNqYn9gEpgB075HF9hHwH61+zpUbeoRE/7JQpOQ+5eYqREjWe+
40fRyILCGNyxAKeeVWWMtsOPEazjGAsUkVwaFsAE3PgATarigSlk4hnoehdPJPxx
5vfXrUn6BR4P/gUOA7z2+6edSmE7a8Pzgmr01TpAw9h/lVlTbDnxD/COYzfsc6z9
OaXBqde1PauutY+3lXC/ElzOKbb9HpKKCpwuv1EobexJ4jCbU0nig5Kv470zay+4
oR5RPdu4z7bKOjU5X48WeRvz+lvErYY7Ks/EBOJOX+ScgHNyRSCMgaZ4uduJi66y
37it0ld/rjj8lSJe97oOD4B6hIEO4IbBNADTr8QS4rhFCjgr+AXpLetU/b7Ty9b9
yRo1IsRYx2ygBV8X7KEor3pRQ/PGH6NfBjipabbrXQFR45tXH0mn9dkAvMqTLADY
fq1uGE4SbnJ1iEDn005gq65Ys8mcXjNzpEikotXiYz5U/J15PPgFFSRBSHCvlo2I
PGTImYiJD7w5tDJBIDf+d/yxUM4rpwj6eJAG4FHloy3RsL64mfOhWAcf/9+3wW3/
qFxQW8B9zhFcdlU7DJBXLzSzkaoG0CEKD2162YYlxJ/X+lhA1Bs=
=yMQ0
-----END PGP SIGNATURE-----

--qqLrAVAyoeQ7Ymdv--
