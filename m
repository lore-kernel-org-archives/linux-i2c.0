Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E32B303A12
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771320175; cv=none; b=lm/2XFffHsj5NCHXLPmzAeYVdgmJcO2yJhsx3ACYvVCVEDqGBtMVjHUG1JhJ/9fVcmVmaCn/8+jWrFjESXp+Eecp01Eoek+11Xx6N4UIV0PG7kNaqvh3zkro3beXaSX8mvsVUic040Jp6dIkiThR+tMMEGppTnnfZU70oUnO6Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771320175; c=relaxed/simple;
	bh=rmOIWrVfPxlf8sqxVf5V3WrFufL/D/zat/KH6AS5qc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0xli5S0j5+QrOjH5UAbPhqdIK01e35R3bq+iPeQXrUHvIzbX9pDeIm+ig3ljb+wJSTvfPZsIUWcydTN5v2BvggImJT4csSHzmPyOjNWlxs1D3fh9iJMgbyIdUeATo7K1wWQNau/qdXKIbTMUafuPHwKq4oTVLESFyzt2E/ZWUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJJF4DRf; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJJF4DRf"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59e6b7b11ebso4510514e87.3
        for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 01:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771320172; x=1771924972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KP22+PfNvIQ4JRJHKrRSAiSbBKzIbTD7/fuUITNUSEc=;
        b=jJJF4DRfKwV25O+7argf/w3tKUr2YF+/dlKWMI/6pwRHh7uAlP6+HIXgYTkWOoG5sg
         2GJ3P4nNOVc3GwGlTWw3z+ty6a6V/+1ulCsM3djl0RCkWw1il9uw1WyAWlFOd+jSfffQ
         x4yEmwfex5wJZjG46+1nZLmoir2VznyiYrufyDaIJKkt3k1dvvL6NEje9oDY7EVAdKH8
         f4n6cSGRIPS+xTuPfSqaxeC9a5oxe727AwaZdZMcVM1Nwe8qCk3zz0Pw5nql3pdXv1K+
         ua2GJv6ZjNMpMeM/o0VOlNFaB0xSlShAP4fOmIKjuKiI2u9pEKrmcnvcyfCkMghIVQni
         sp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771320172; x=1771924972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP22+PfNvIQ4JRJHKrRSAiSbBKzIbTD7/fuUITNUSEc=;
        b=GXafIshz0z6XuLb66rWAgoDUexyJSBmcx3cjQtryT1NIPZRYgs4m5gWICNve2Bq8Cl
         E7S/78IWChjhknxj99Rz0sDjaTwKMhvEwkZom8GNFNNbMFRNIXowGz4pRXzEyGzbWyQ7
         HVPDya7QE6gWdD6bvqa8dqSakc8EUR3hFxjrBr5O8C4CsHz3IDQIAVNa5O/5yjA03Dru
         HhwRhYgTaLTFDORD/fjiteDlQ2IP7hP+gEIrW3QTP0ToMi9zS6+OrCRFRStRT6bfkDct
         q8B1eZZDa4+VbQ/kbXrRVhxSR1gIYDpOZCttCARj/ifDQB2kg2irSvi8Dc8MUl8HadVy
         sLHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmUrjD76loaBrwJpdrb9bDHmreT9uRbEJTxKSXCho2bRWW85q5VfDhXBB6NuzC4hd4nOCVMKG9tc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo3CQ7/Nh+l4oieTAgk0JIsMLej6AsOFmhOHPIUQzEGG7btMMR
	Wxo/z+hxclKOx+rZ5dBJd4jE3i2YGojXEsAuFtqHyqUYPxyosu1006so
X-Gm-Gg: AZuq6aIpy72Uq359YAKwotNZIFJUUftriXQzLWyVdpyH2wi5uCaUv50BSkqAuYMC6vc
	UwUT+OJFq+LZkC66Sa+rSZoI6ieRTNyaAN2XdIc8TZy0EviVIJtYhiYHmbsY8zsLovFBBUzvngP
	5h43YuKVR0D/nvCJMcPX+QFeP3LOM9FiPz5exWxTHgFTRey254nYn5T4BUVaP1RsY0LE+9I3cbD
	tjk5ElJgkRPgZq4mJ0aj52d2Qm+KhAKB1vctBxsF18lqrWns05OoKonRvuSLe4Iwm5I7TE9jWlK
	3kfCWO9Tmv3SUcoGjQyLJ/5TeSSBg9N3qO/hruxBGnyDYi5Sh0b2lEZ/+g9VG1D1utu3PlE2HQW
	w6yNonXCuvms/Es2nUPzYAQdwpnZ/p2upzcv+FnW6EDmzZ8oApbMYDnkW3diLcfeuVTWMAtHk1x
	wxZXyMHf+JBOEJlqUBDdtAVPNdQWJI0P4+saMQVYGlCZqlXbAuBD1QbjqNMfwF
X-Received: by 2002:a05:6512:ac7:b0:59e:465d:e346 with SMTP id 2adb3069b0e04-59f6d35849dmr3079335e87.20.1771320172217;
        Tue, 17 Feb 2026 01:22:52 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f56369dsm3753854e87.2.2026.02.17.01.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 01:22:50 -0800 (PST)
Date: Tue, 17 Feb 2026 10:22:47 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/5] i2c: davinci: calculate bus freq from Hz instead
 of kHz
Message-ID: <aZQzZ4iQPDswwp-t@gmail.com>
References: <20260216-i2c-mux-v6-0-9be28ecfd7e3@gmail.com>
 <20260216-i2c-mux-v6-3-9be28ecfd7e3@gmail.com>
 <aZQvuh1KEAWFSdRU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LvYrtrax5P9jJvAj"
Content-Disposition: inline
In-Reply-To: <aZQvuh1KEAWFSdRU@smile.fi.intel.com>


--LvYrtrax5P9jJvAj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Tue, Feb 17, 2026 at 11:07:06AM +0200, Andy Shevchenko wrote:
> On Mon, Feb 16, 2026 at 01:38:15PM +0100, Marcus Folkesson wrote:
> > The bus frequency is unnecessarily converted between Hz and kHz in
> > several places.
> > This is probably an old legacy from the old times (pre-devicetrees)
> > when the davinci_i2c_platform_data took the bus_freq in kHz.
> >=20
> > Stick to Hz.
>=20
> ...
>=20
> >  	/*
> >  	 * According to I2C-BUS Spec 2.1, in FAST-MODE LOW period should be at
> >  	 * least 1.3uS, which is not the case with 50% duty cycle. Driving HI=
GH
> >  	 * to LOW ratio as 1 to 2 is more safe.
> >  	 */
> > -	if (dev->bus_freq > 100)
> > +	if (dev->bus_freq_hz > 100000)
>=20
> The 100000 has a definition in i2c.h....

Good point, thanks.
>=20
> >  		clkl =3D (clk << 1) / 3;
> >  	else
> >  		clkl =3D (clk >> 1);
>=20
> ...
>=20
> >  	r =3D device_property_read_u32(&pdev->dev, "clock-frequency", &prop);
>=20
> (Why not using i2c timings? The I=B2C core has an API to parse firmware p=
roperties.)

Actually, I found i2c_parse_fw_timings() just a day ago and have on my
TODO-list to convert all bus drivers to use it right after the work with th=
is
series is done.

>=20
> >  	if (r)
> > -		prop =3D DAVINCI_I2C_DEFAULT_BUS_FREQ;
> > +		prop =3D I2C_MAX_STANDARD_MODE_FREQ;
>=20
> ...like this one.
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

Best regards,
Marcus Folkesson

--LvYrtrax5P9jJvAj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmmUM2IACgkQiIBOb1ld
UjKzBw//YXfk8Pa5HmqhP/jWcZBbuAw56cYB1n7qv6qX3dozdeWpBzZM6Ylffeno
p3eMMqgOCleCKhGWLoZETzV8OjNIlSa84S1lrLoaQ6+ke8opse93yyvK2yG7fIJC
/l5Kt+bqayWMMg4um2cm3asau8Z+BVQUYfx23aB3ZbHZCmT+DqWZgx5ahiin8ebf
5OFKIDlJfYs3YtZY+GWDlbRbs1a+yVUbvH8BAY68GEmvS3zasbZOI6y0CCgVvo69
R+1St8eekXOkcgPs/2f83fP7PbjX2zD2x0+51MkI7ioDSJ6t0LWTi2oG48h4SE5z
9gWHXhx527t6FYhk4FAxIGjZGDYSoRHHE2aTXU9aqsBG6h2XCscNfqD2InKj1FVG
zO+fiKzNg+WESGzXey0FyktC8dj09fSCB5TznhQLl8a+rhNNzglOKfkt1l2ZjCLr
69cCwOKrZu94Zzljc1jZJEOep1/CmFIiBP98ENESRaTFA55jtsDrFhPBwXv6p7E5
uJrdwIIpDqMcW5NDdiu3BW7qNH/XrlC9fY3zUVNHErOn+7sIy5FFCkTXkbFzsihq
7bsRwURzunwp1+OQsvGNpfS4ivju93R/NjBbpliGNn6bU7gVemFqPflk4OPFc1z3
6KIj3sWwuUGh9VjoQ+ar/sjU/VYu4ujT9fWz8c6cTIoOjkizpzQ=
=rz0G
-----END PGP SIGNATURE-----

--LvYrtrax5P9jJvAj--
