Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816265;
	b=LdBmTNgrIWxXuL+oIdrm2lAnH5z9fmu4XaUkzmrO0JjenZy1FMcDjtr5cqUtJoKtr7e9
	 JREbgI+gHOINH1mSWPyHr89Br0NoDLSJwsH622Mmo5nPZECp5z+Ek0hIC0sAomopqvpm/
	 S3AF1p+DdFbwmS3y33Dl6hdSA4HkuUUMDVdBXx+CmIVYuTq9rUn8w5o5Ttbbf8CPt5B2E
	 3r/n0CJjXllW43I6ah28g3XplhlcMRy0y0XsDVAJVWlC902QhNt4HFSDD8gdcm+Zul21p
	 1NbNNh+D4Er6gqJ3wKQVkoaS0o+MzsuDGENYscuP/S0qzVD+jB+jBX3gTvfON5oRKWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816265;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=V8HxuoKO03g2IFeqlwZNAE1fT9EmLlBHAP34FZhEWTY=;
	b=d61HBcYTUxCGeG6s+SDuIHEyjlsEYRUGwiQxqCud0rX8+ymjqkXGn+2FPKeWbkE/qASZ
	 kaL8loGg6QBEgb+4+hGSuk0rH+UvKiX6vtMH4mUTEPp2lobx/Vdvp++3+lb5HR70efIwA
	 c8k2o0PiSZM5LjYntnDdqkvHZSWK6LMjVE+A5C1APpaHK/9kmPm+/tzEkzxzVc1/6ombT
	 Gi6/ilc8aNQCdS9789DapThoGV2v6LGK3lb8AsmuX/VOwXKUva+Aldn1Xjkj5uFDBqGLo
	 Y2I4XT/JS79CKs1iU3A52VYvrX2IXq7RAgJJ++JuLquWteJZ3XFTjz6NBp2zDKPXG/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b="Ep/CkKWR";
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E72606A329
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 08:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63E72606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Ep/CkKWR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=V8Hx
	uoKO03g2IFeqlwZNAE1fT9EmLlBHAP34FZhEWTY=; b=Ep/CkKWRGNQHwNMgqRsn
	7hzXjVPEIoHVVLiJDYf3OGRK9l5rYk/SsZhnLwJlOVdkjd9Ku89LeM/PXVaXVYqm
	5OwcXbNJp63VSa7XGSj+rOlxeKgjdkCaN6zsGhmXFm4uCOYIwl03yblQ4WfUbwHT
	xiQY5LYD3bjGuQxfdKZ+nEmTA5cde+AMXSqpyEnTHfGvjPuW38Qc4mUJQt3HLwVj
	ZC3UTJqGq5m4WnVdYEyTELyr/DXSHMG0aC37eMmmEMmXH8mtlg5ilI/sxEwLaIW1
	1JEGU34DV5vI5FJa8aBtoWfLERgYTFdtsljwa8Gens+H2fOAfUiXDu5uobG58XTQ
	Cg==
Received: (qmail 1188795 invoked from network); 16 Nov 2026 09:04:22 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Nov 2026 09:04:22 +0100
X-UD-Smtp-Session: l3s3148p1@Rq++OWBgLOMujnv5
Date: Mon, 16 Nov 2026 09:04:22 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org,
	Gero =?utf-8?Q?Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
Subject: Re: [PATCH v5 0/2] i2c-tools: Make tools accept bus path
Message-ID: <avq5BubiO_KtXg_F@shikoro>
References: <20260722-accept-device-path-v5-0-9c0bf9b4da26@brighamcampbell.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uYxqee2ysI1NcoxD"
Content-Disposition: inline
In-Reply-To: <20260722-accept-device-path-v5-0-9c0bf9b4da26@brighamcampbell.com>

--uYxqee2ysI1NcoxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 02:52:39AM -0600, Brigham Campbell wrote:
> The purpose of this series is to make i2c-tools userspace utilities
> accept an i2c bus character device file path as an argument. This is
> useful, for example, if a sysadmin creates udev rules to create a
> persistent symlink to an i2c bus and wishes to use that symlink with
> i2c-tools.
>=20
> Since v1:
>  * Scrapped brittle checking against device major number 89 in favor of
>    an i2c_bus_hint variant struct.
> Since v2:
>  * Scrapped i2c_bus_hint variant in favor of combining the lookup and
>    open steps into one function. No more awkward variant.
> Since v3:
>  * Rebased onto `master` and fixed minor conflicts.
> Since v4:
>  * Inline much of the functionality of open_i2c_dev.
>  * Where possible, make functions static.
>=20
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
> Brigham Campbell (2):
>       i2c-tools: Allow passing device file paths
>       i2c-tools: Document device paths as I2CBUS arg

Applied, thank you!


--uYxqee2ysI1NcoxD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr6uQYACgkQFA3kzBSg
KbYQ1w//aZQXpbjYTWKRR2fE1ZSpRUz0XHLxEfgmLDgD/3f18hRiVkFn0Z2T9I+S
Ze77MksqwiQSXU++PzTpHYuBGCBu1TY/Lm75NiMRY0yBhnJ1oZcwz4LfObMR5DFY
8TiPU1zReZEw41Zx6r9Q+jK0XMf4YLZNw8p8b5DUoNjZ9QY83kvb82Qualdz0fhC
eQfbLYqAwEWJNVKcic72M/CuEVk0Tcf1uwZR4eyzr9rM3xTlX1/kHGJqsQ0JsoX5
NLPpiHejrGnsxaU1KlWjEqt5mjOrfqolTL1K/Xj22uqy8DDKrUfW+fq3DfcxVBpa
jXQ7MPoPaDJAMbUbFEhtG4oIILUJ6u51nLP6ibRXI2uOp0L8Z/w/H8KLUXmD8lI3
z04MOWy9Nf/rsOkhq3kUfScG3efe2tkzA/F/o1vqMf3Got2UATmWJL+bppXctUs9
Vwiv7vksnVuoi6Dyw5uRV/DXMJ/1pK/jC7kf1sjOZRcZe6mIQIGbFs1BjpXL3v5H
B85ERAVV5LlJ5M8OMaoqUf05T34fvVi3t+/dJlMOMuBIxIzTZrnEHa6zLn8sM4tg
PtSn8tcJysJIznl00x+k5O+o7s4A2+L5Ytc4Xa2yIe/ZNGCaUW9nZDdP4etjfy6q
uHwl4q5OlBUkwT5Zh7Yzob7AkR/o2UQ10Jh2w+TxzKzrMA1Ozjs=
=qd6/
-----END PGP SIGNATURE-----

--uYxqee2ysI1NcoxD--
