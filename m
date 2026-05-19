Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA763A641C
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779189350; cv=none; b=jsGFcdvuCA+7Kqb25JrBhRDBNtH00ED5k5v3F34Z3u9vCpXmT7OhXTohIgYL1nB0niUQ50gpR0u3sm580c92dheGwpBYsuRVoxGjNs05W1Xhh+Q7/aHOpCBupeVNTZ7jH0tzDPzwp+DLbI6ERYh2tVe7ZGqQVQSWDzFlWPsCeOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779189350; c=relaxed/simple;
	bh=SxIqYwpxaZPLYro/SnI2DWyy9R65L2pm+ouhzoYT0E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXHTBp7X6+lPtXZUYa9uGadxs+LpZd71+IdVkEx6yEuxuGEvn7HVZ1QON5yOWx7eQh6HMNomMzwMe1oD7XJFayP2iDPgLA/GYVYgz+haxAM+hvjt2vYPj9tbwD7kfjSBWiqfxqo+g5vVndUxbUmwFN+nSMKiDDXVxfys+U6tix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=CVRKtgA2; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="CVRKtgA2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=3DP2
	QxkvUv46rOvmPjWqG2LXb5FdPjuKuP26P5iyXSw=; b=CVRKtgA2Q3QvYehBEhap
	b9A+8Uc546DdLls13sY6Cc1PR2UGDKj3vfFFCw2oYOF3/46JzXSKtstLhsqSBNoA
	LLSL3QZpmvrReFSQupvu/gKgqqT/S16kax3Th8YOJWCozlwmkOkr0lPvZfffIXBT
	Et+takk/CALSvI1oRlvfQVS8mDg9/RSXxdKPxcsFpvYKaXAi9xX3/NPJRJK67YlW
	Y7j9YY+uPctBs+EN/dYDAprc9QspqxNLPVR2mp1q69YDZQanTfxSlpi29DGaigBd
	pkn9DjQKMh24yUIz0SKeLWzUzlww48xqDUOst8RXDJ+F+P8B+HMJ6visRc0DxzZG
	cg==
Received: (qmail 240482 invoked from network); 19 May 2026 13:15:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 May 2026 13:15:46 +0200
X-UD-Smtp-Session: l3s3148p1@rB/6zClSep5Uszca
Date: Tue, 19 May 2026 13:15:44 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Sameeksha Sankpal <sameekshasankpal@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+76501d32a94a432940a8@syzkaller.appspotmail.com
Subject: Re: [PATCH] i2c: core: prevent use-after-free in i2c_get_adapter by
 removing adapter from IDR earlier
Message-ID: <agxGYNfGltZJxxjE@shikoro>
References: <20251117034150.6380-1-sameekshasankpal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PJlhTLNxF3ic4GTC"
Content-Disposition: inline
In-Reply-To: <20251117034150.6380-1-sameekshasankpal@gmail.com>


--PJlhTLNxF3ic4GTC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for tackling this syzkaller report!

On Mon, Nov 17, 2025 at 09:11:50AM +0530, Sameeksha Sankpal wrote:
> i2c_del_adapter() currently removes the adapter from i2c_adapter_idr
> after device_unregister(&adap->dev). This leaves a window where
> i2c_get_adapter() may still find the adapter and call get_device(),
> which WARNs because the kobject refcount is already zero.
>=20
> Fix by removing the adapter from the IDR before unregistering the device.
> This prevents new lookups while the device is being torn down.
>=20
> Reported-by: syzbot+76501d32a94a432940a8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D76501d32a94a432940a8

Seems reasonable, but to get more confidence, could you tell me how you
debugged this? There is no reproducer in the syzkaller report, so how
did you ensure this patch fixes this issue?

Happy hacking,

   Wolfram

> Signed-off-by: Sameeksha Sankpal <sameekshasankpal@gmail.com>
> ---
>  drivers/i2c/i2c-core-base.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index ae7e9c8b65a6..229158401d54 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1773,6 +1773,15 @@ void i2c_del_adapter(struct i2c_adapter *adap)
>  			       __process_removed_adapter);
>  	mutex_unlock(&core_lock);
> =20
> +	/*
> +	 * Stop publishing the adapter before tearing down its device/kobject.
> +	 * Otherwise i2c_get_adapter() may still find it in the IDR and then
> +	 * get_device() will WARN because the kobject is already at 0.
> +	 */
> +	mutex_lock(&core_lock);
> +	idr_remove(&i2c_adapter_idr, adap->nr);
> +	mutex_unlock(&core_lock);
> +
>  	/* Remove devices instantiated from sysfs */
>  	mutex_lock_nested(&adap->userspace_clients_lock,
>  			  i2c_adapter_depth(adap));
> @@ -1813,10 +1822,7 @@ void i2c_del_adapter(struct i2c_adapter *adap)
>  	device_unregister(&adap->dev);
>  	wait_for_completion(&adap->dev_released);
> =20
> -	/* free bus id */
> -	mutex_lock(&core_lock);
> -	idr_remove(&i2c_adapter_idr, adap->nr);
> -	mutex_unlock(&core_lock);
> +	/* IDR entry already removed above; no new lookups are possible now. */
> =20
>  	/* Clear the device structure in case this adapter is ever going to be
>  	   added again */

--PJlhTLNxF3ic4GTC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoMRlwACgkQFA3kzBSg
KbaVwRAAoEE57KJgt66Wp2it5cvry+ARixClO/A4J0sLhvkt4N3l1TdJkQDzUhvM
Tt0PuC0pvw0nbMZ5sdThkXXSfBMP/E3BTRVFV7cH6iDvKdtaDzXul2y613SchhfV
5mY+Lv2T2cUld3BIwOEK9TeV8+ABaoUHb1mkNlY85emJz4Aw3FsjuB3ZWoQZRTpz
1PyYv7iKXt0CIPnFozCVUb5KP/HbtT6hMaHMTIFSwbeK/LoTUf2GOFOKXk34pMCF
NVhEVJrrS2oBQmJ+pDZK7EAZ7TNHHiNvD+Pg7KHBd+QIKjwfomajgQpdP8Of3b+L
dqUagtGfdHTArxUW0KyYDpedxN3yrMkO5U8910tGohhrhSa1d2XBbloiBOSt3rru
/jKWst6OILowC7VgPEXe+phP/wQPf6cZbrZv1KRlmA2ZrrTB5v+EHCxVtRzVUwxR
Pgx9UJnNc8fdtw3ma86ehwSDzRMiBx3Ig5d3x02YVzJTfi/z4ZHLHmSpgONUKQUI
PTYqnz9Ol21+mH5+lTZcBtKWGokpQMK4+Tqt/Suonx1KxQxivA+ReaIjpI2cVht4
IpRmFFkdkdMXLxsgm7sY+9YQ/rzlorLtH4KZd2NRlHI64JBtW5Xso9XCQLO6owbd
mWaQMR+2aO7xtFM+uS+vHnp7d691U7Q5GffsGWxDBsPuduTdwAk=
=gwZ9
-----END PGP SIGNATURE-----

--PJlhTLNxF3ic4GTC--
