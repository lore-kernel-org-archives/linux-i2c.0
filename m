Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08A33CAE6A
	for <linux-i2c@vger.kernel.org>; Mon,  4 May 2026 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896170; cv=none; b=JJeEsFA/ocb09uBgLXvuaqd1a/qhfHjG9G7w5aANcCOGSz9UpkzP5BnAQKQJjZtdhm6hk5b3NjNd79ceERz2gsd+fFVqhU5Qn8r8J3P8QR4tzUznHBHBSZiStF4yyuttcI0gLuIvQ2blp0AQkq32lYKv2R+BtQPGGqe/9K6cMGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896170; c=relaxed/simple;
	bh=olCbkCWISbkFgW2JM8v+xUYNgHLBzLcDRxs8yUm3/p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ab6u5HaQHdxirwLnyU7RHjb2Ry0HfrRqZo70gMCN3ywsxpM9xjnzzYuX+0SmIh/P8j9IWero6XVFfCuKHjbug6VE/eNCpB8o/0sYNiffR6aI5qo7uSn6ybunGwj4551NMS41RgVrFVGPba4EfiJ/p5rWg+DLeTcQIH+mJXMZTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Y6cd8qRS; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Y6cd8qRS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=rnzE
	3fagmRQ4MynxdSY2IA23lAMp8yjSa1dYK89grj0=; b=Y6cd8qRS7qfD2QlarjE9
	nZebitcDfoml2x4gEpe31NN6N9DU9R0EdkGqpTtAOmaS9G+OiJ0Gpvd0upXwzLS7
	xS7Kg5P4gbfhiwdyRicsXlG+hZNgpH+nbKqvZtTqymkhTmKxi4/KOGomDD/LkYcg
	puG9gLchoaih7ytzbLimb9u1XqYdF91fCmfCHKxugRqeFSfiLdy5ut8hD032Fvfj
	U08zRtG79A9V+RUZnnal7wDNFPoT3fXnyKTfq+QQFM/DcSBIJztqGlgOVkBsJXT6
	JHjwiBCUdHu3y/O5JaXLrzyhZ6JaxBfzAu8ovp/vYxax4BirK6f8NN0wHgyfWSjf
	TA==
Received: (qmail 2187862 invoked from network); 4 May 2026 14:02:44 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2026 14:02:44 +0200
X-UD-Smtp-Session: l3s3148p1@NqpMtfxQytUujnvR
Date: Mon, 4 May 2026 14:02:43 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Xiang Mei <xmei5@asu.edu>, linux-i2c@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] i2c: smbus: reject oversized block transfers in the
 common path
Message-ID: <afiK49_aMEZYDQAg@ninjato>
References: <20260330042622.2608889-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eMUX46Q21S3g+g0m"
Content-Disposition: inline
In-Reply-To: <20260330042622.2608889-1-bestswngs@gmail.com>


--eMUX46Q21S3g+g0m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

thank you for fixing this issue!

> +	if (data && (protocol == I2C_SMBUS_BLOCK_DATA ||
> +		     protocol == I2C_SMBUS_BLOCK_PROC_CALL ||
> +		     protocol == I2C_SMBUS_I2C_BLOCK_DATA) &&
> +	    data->block[0] > I2C_SMBUS_BLOCK_MAX)
> +		return -EINVAL;

Like with your other patch, we should also reject if the length is 0.

Happy hacking,

   Wolfram


--eMUX46Q21S3g+g0m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmn4it8ACgkQFA3kzBSg
KbYpRhAAqpSlOB8BKuT/yHV9fk64YKylspo+CilLrT6J7NXoRaCTj7jLTZAtCrQa
tryXCryDrIXvRyEL4MNMRdBNVY1FssbxENzT90jY/uNHTY+IIZyYiiuPsPZ/ntxI
KOrt+m9kIGO6SMF9HwlaUQmXKqzhev+qEoo3jVZgmSPx2rwxcht+ZUKvVBw3NOUf
eVPToDCxPrF/SaxA+TcOUWlyYmqT+5I9XJW6l19X+p3yZw580F3jNyCzTgUqZdgT
1naTEZkwkS3HmLnnSiKwavDW1KqsKTRHxvpwggO8r03R05Z584eEnDf3kt/hjm6D
sgEmyfJunDoMV/nVvc2lRdavU9W5isS2pTCVpMweayg+NWEElf6ARB3/NRHZPJIq
YWi7ySyKkeJdzm11pUHQ+Bw87rBQbDoLZIkqmhG0utSSE07Pie1YpBvEMPyFwuaI
nZSBdG9WgYF3zFVgclkpT8aFG1B0R5CJFk8K4aOkRmRUXax8Hvj39uaYL+vkx9N7
w6p7Ljcm/I9efwXw0Eqar00M3Qbs76LdWqb3BTxXX5zHc1219X6DTRmqYrrjSfiv
fRSLk0Wqp1jYc6eD4gGb2viGaTTZRF70/dBn02W/vu+/+miDF+jnab1kcULhv4+l
DD+PBg+3TWa+GLPuYxizUzv/3LDY3pmYdZf/wi1cVSgs1/COPy4=
=gtKk
-----END PGP SIGNATURE-----

--eMUX46Q21S3g+g0m--
