Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAB62877E8
	for <linux-i2c@vger.kernel.org>; Thu, 28 May 2026 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976638; cv=none; b=e6TNt2MxriigsspZVqAwZCHmng6oX7r1decg08l53nV9gisH6abiFBRKfj5EMM8d8ENU6vJHnlt3DSOY4cR3zR82L51bexscuOuEBKDtkvmk0fNAjrPBxE5wwn6c/wsfcjLkKcjYC5VkRLtFZ2bHuzuHEiAG4M+9H/h+vTX9+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976638; c=relaxed/simple;
	bh=qJnZxcz6RfLpE/mwm2PfU5BypRgi+Wy1GP+W0/wcevE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ1e9DboMp9OQA2pALYCioK+DS5C5ZoZxW5QfOlJkuPnV7pspNRkKFRFzMuPVsLCh82kDm+uuDXYDzqASb9pCjOthCW82gd6wDtJYiZSW31rjwz05zYsfOCbl73xBIPZyEqd7N4iFkJgW4sjzgt+IaWTnvoW+Fg0g5XgGm0tU6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=eJ+vwnPd; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="eJ+vwnPd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=qJnZ
	xcz6RfLpE/mwm2PfU5BypRgi+Wy1GP+W0/wcevE=; b=eJ+vwnPdjTK6d4JO5++a
	FuUqMkM/hO1FqB0ES7woNsP46kymmss3OJrvnKZx4eFLrQLW8x5T/Q0x61WcC8yh
	sRUkPZXv448nCvrVSLY6oB5YfJEp8MIMd8MJ7vFBGfZ1a4YTLH7lvmGSy9p7dNmN
	pykftr68SC4E7VCD23vmWWhMod7877/gMOEOJmeMa1Nafp7xpBInUgObprhYiBZm
	theNsyfMtJPCDsSFcvzgDg2JmaK8SoLaiHmr1q+s7xyJxuUvrBccdGpbZW++7eEq
	8+xur7/Mud5JsBrrr3yqBQP3+NuEptfL/wKq10S6iP1cdjO93KSdPotCdXDpCVaU
	ZQ==
Received: (qmail 1058269 invoked from network); 28 May 2026 15:57:11 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 May 2026 15:57:11 +0200
X-UD-Smtp-Session: l3s3148p1@d9zTGuFSjZKSAB9x
Date: Thu, 28 May 2026 15:57:11 +0200
From: Wolfram Sang <wsa@sang-engineering.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: chris.brandt@renesas.com, andi.shyti@kernel.org,
	claudiu.beznea@tuxon.dev, linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] i2c: riic: Abort the transfer on completion timeout
Message-ID: <ahhJtz7QG3IxQA0G@shikoro>
References: <20260520131206.932050-1-claudiu.beznea@kernel.org>
 <20260520131206.932050-2-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0SzcDRJ98Z7CPpsR"
Content-Disposition: inline
In-Reply-To: <20260520131206.932050-2-claudiu.beznea@kernel.org>


--0SzcDRJ98Z7CPpsR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 04:12:03PM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> riic_xfer() configures a transfer and waits for the interrupt handler to
> signal its completion. If the completion times out, the device may be
> powered off through runtime PM. However, the transfer interrupt may still
> fire after the timeout.
>=20
> To avoid cases where riic_xfer() powers off the device (via runtime PM)
> while the interrupt handler is still running, disable and synchronize the
> interrupts after the completion times out.
>=20
> Fixes: 310c18a41450 ("i2c: riic: add driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

How did you test this?


--0SzcDRJ98Z7CPpsR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoYSbMACgkQFA3kzBSg
KbYOzg//XG9n8a+Duylj3NLlK/rcYTcEke0K/iSwz0k+lactGejUZNb7ANU4SVm7
mtjXN0AuEDVc8Nw5I09ZqRhxiiMLrtitcUn8ie1TG/d/9Jwbmj2R0bc4TNJeUsa3
YUQEymQ8iuZ2bQisQGu960e57aBS1p83shs6bSoJ7oU7Xq+lIIvGwNWtTj3fSuC8
dJDA8VK8vwQPz0bY7bs91AUWp00FfDY9kyYZx5FUziDxDQ/CRBp5+xHtOxmgzJBK
ku2q6U69o3ioKx5P6vGxUwCMGSze73hQHeDbdUzXpJL9Zj1CDnYxOeEdeuNj4ayl
w55gBTsOscgWYGAvuRv/HB7Tp7TY7n3L+8VkpwqvLHb3jRGEguVGdoWjBJrJGt+A
na9Umrhs7086USap9L0rAJly61kNeg26KCVHMR2bG6qTk4tvZTxnG21ogSv0lkki
EavzBh+PuOblxEUgClWy2EfFsenQ2EYxXv66neaDuwxn7/b+n+10+09yTzopPe+x
8hf62cU25qQYLy3UmuQa7e346V9XoQC4woKftQRFef5M/e0FfqnK6SfRAlPA0nTq
hqV/+Xb16h3qgSGWZSElTEELR5eM+zQh0cUEbub5v+nQbNxABpElsVg1s58ggXBX
BHuxyq8u8P9P4rsdT0Z2T1EWirDPhHSoeZcHMfnEkYBv4h5w418=
=LSzD
-----END PGP SIGNATURE-----

--0SzcDRJ98Z7CPpsR--
