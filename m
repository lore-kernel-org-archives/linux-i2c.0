Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC0F1E487
	for <linux-i2c@vger.kernel.org>; Thu, 12 Feb 2026 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770932865; cv=none; b=ldMQ0kZlzjXhAvhYMgpgE6RgPblgtjAeGE8VNLilBmKNqJtMmZrkBkYfUPbDd/2etgMipAhHCFB+Y3Uk27meHAGzjKndFo4BmcYGIpVG3u6hZhArH9AeAYdV9BkfWQ2qIDgnmXiXT9t3wltruHM1u1PSczhjXd38aTEJxEZsdBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770932865; c=relaxed/simple;
	bh=WUVEbns8lbGeXg02l+QeZugnAQx0JP+e9sc/HPp2eXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nANaDSuC+oWeUl3cSAwZORkV/LC44/GKSqSy60fdNuqakiDTBKFIQoK3cixWzT4feVPAS/exrJ5pLvWEHPaAt4RY7QcaUsQSR0A4vwrJekdhyFGb/eIBD6E9mB/7N3wSpPPwcARTBI6GO1IQy23MWXzQed/99W2Bzy9VVsr3F2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nd3hY9dn; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nd3hY9dn"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59de2d1fc2cso355623e87.2
        for <linux-i2c@vger.kernel.org>; Thu, 12 Feb 2026 13:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770932862; x=1771537662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uI0DWSxvm6NFySyRZeE8NYakt+hMKZcgOA3uk/TYi0k=;
        b=Nd3hY9dnzXCWJokcsBbEVxCNf7afxrkt/I+IMe/Tar9pK5L7/zWVWgmaye+YcXPh41
         Q49U8lbir0ERb2nQ8bwNLAcTdfpI+Y8/k/ssu8Kk+fItzdyn51TMv3GybYHElUddaOMV
         gyIUn8yt2DBYtyWbeRyn0jgAsrTIZcSjyDfyR9c/bnhNQD3vlmC69IRmVTzbZxoYA2Dj
         LtsSSRL+q5C9G4oAyNv8y4oth1FcSv10ft41AQeZRPYIR5MVTZmsuF1HIN154YGxg7WO
         mxeorrrwIkxwD+Rbi7rOsPxkU7We244j6r1WZTw/3JXg2mRtb+qwUxMVGTibcamMomv9
         tgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770932862; x=1771537662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uI0DWSxvm6NFySyRZeE8NYakt+hMKZcgOA3uk/TYi0k=;
        b=iUm+ffLvXdH5g+jF1X+MuMOPMCx3wKD26V8BPUxzaKc6yaBS/zWAyqe9w6S+MipyXi
         O0rtXNVLqniGGDmw8F5GpNqzHB+bIhDfmlmMaOJJUidkCdp/wtpBuMeZre9RUkmttgWu
         tEFOD5PB6Gx7Vbsxfxlro9ZQGVDqw52ue6m/5rmnoT2peAkRhfoBy3kctqtHW8kKIstb
         35WmYYWqeTGvDyPbg9spJIFYYiuTBwE7ac26T/Y8+Eoi7EKB8qjwX2TkIKHcMLZnVn/R
         Rmx9FFb3nuI7GAuTXH4B+VfCA+mjRWahwBD0sDtGIJ1GK4mKwo13zubfr2PNGGEJSr++
         sHFg==
X-Forwarded-Encrypted: i=1; AJvYcCU0u2oaeF6dju8MVSM9sKoTuy8f5DFIF/HtnBbTHfZWpik3gPFduxBgwjguuQBOIc7LMbzlWy5nSL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIhh74AD+lqwwduIW9ACG6o8dpFVg2hYtP8JffPudb95gsIepZ
	lMtJVp3DxZ1W9Tm6HlNvlsk0Gn9tjooFgsiW/TcxMRnYS39opdoLJJjX4tMmLQ==
X-Gm-Gg: AZuq6aKMWyuIygv4tlLi/yA+Nt48ZHyEtvB1uJNy/FNl2BsKZIGaU4aURMB0VPqe7GK
	3CYYjtEwYJN85roEQRGhj7OrKmf/LAumPHb6xnld+z3uWv5Xaz3zfm7Z7lUc+0zbdWCXArclSVd
	+Y+iQ+7wUOPCrXXLNQL0+Vt3ztDnazD29dMvTCuPRxvsku3Pr7zkJj3w1YxhGCEhJoLi0a9nCsW
	LVAd6jjwFBRla+2m+0QFwV3vp0HyrPLyEtXokxhz7H5rLEUeRFf5PEk5pz/Ge+XAmp9zEttc6w1
	X5FGag91wffZl1yGGuK9cM3tTGMGQCe00L5DKN6NZ1wVbQImsNcAn0nsIOeDkd0w7f02lUi/sTK
	QoqhV5WlbUIQ6giVVbzFfljp7EovWPhGU6rpRLsSfSst0IeTrfuO/7j30K0IAEayM763tb9OHF6
	xtohgc9caaYs2MAR5pXmwMn0IcKroNh0NjqxY4y7vV8NArohGv4kn4PLrC5X8A
X-Received: by 2002:a05:651c:41c7:b0:385:f7ce:f322 with SMTP id 38308e7fff4ca-387f80ded45mr477031fa.35.1770932861977;
        Thu, 12 Feb 2026 13:47:41 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38706928d9esm10989251fa.42.2026.02.12.13.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 13:47:39 -0800 (PST)
Date: Thu, 12 Feb 2026 22:47:36 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/5] i2c: mux: add support for per channel bus
 frequency
Message-ID: <aY5KeH3Z1S3MswHI@gmail.com>
References: <20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com>
 <20260128-i2c-mux-v4-2-dee49ce276c0@gmail.com>
 <2ecbebd8-0842-34fa-a593-25168c91aa6b@axentia.se>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+EwcLp+XXXrhpKBe"
Content-Disposition: inline
In-Reply-To: <2ecbebd8-0842-34fa-a593-25168c91aa6b@axentia.se>


--+EwcLp+XXXrhpKBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter!

Thank you so much for your thoughs!

On Thu, Feb 12, 2026 at 04:02:16PM +0100, Peter Rosin wrote:
> Hi!
>=20

[...]

> > +static int i2c_mux_select_chan(struct i2c_adapter *adap, u32 chan_id)
> > +{
> > +	struct i2c_mux_priv *priv =3D adap->algo_data;
> > +	struct i2c_mux_core *muxc =3D priv->muxc;
> > +	struct i2c_adapter *parent =3D muxc->parent;
> > +	struct i2c_adapter *root;
> > +	int ret;
> > +
> > +	if (priv->adap.clock_hz && priv->adap.clock_hz !=3D parent->clock_hz)=
 {
> > +		root =3D i2c_root_adapter(&adap->dev);
> > +
> > +		/* if we are parent-locked and the root adapter is our parent,
> > +		 * we already have the lock we need. Otherwise take the bus lock for=
 the root
> > +		 * adapter before changing bus clock.
> > +		 */
>=20
> The assumptions made for the "otherwise" case is wrong, I think.

I think you are right.

> Consider e.g. the case where we are parent-locket, our parent is
> another parent-locked mux and our grand-parent is the root adapter.
> In that case we also have all the locks we need. Trying to grab
> them again will be a deadlock.
>=20
> The more correct approach is to do the parent walk in search of
> the first ancestor mux that is not parent-locked and then call

Hrm, does it not apply for all mutex-locked ancestors?

Consider the following chain:
Root - P1 - M1 - M2 - P2 - D1

P - Parent locked
M - Mux locked
D - Device

In this case we need to lock both M1 and M2, not just M2 ?
I'm not completely sure though, I need to refresh myself on the code
base.

>=20
> 	i2c_lock_bus(ancestor->parent, I2C_LOCK_ROOT_ADAPTER);
>=20
> for it.
>=20
> Again, I think. Famous last words. Handwaving...
>=20
> Cheers,
> Peter


Best regards,
Marcus Folkesson

--+EwcLp+XXXrhpKBe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmmOSnMACgkQiIBOb1ld
UjJJuxAAry/YKUutgdQpqDwjHcLxJ8g9+h48FnCkvCuZYOtcjYn9DnGyzNEHJFRU
QHHwGWr5YkH1I+mxO33fLPHDPcrvXiUeyPNaMbtzc5TJoLPa+3ijYKO0reKvQ2ky
gg66PjR9X1GYAwCbObk7fuBjkMQvsOEG0z8nfT/1EMOMFBgnnkGB8rV/JajjsScT
iek1dWSsdogCaaeC9HBMDrJtiybreMtIVpd6AyKSP4BZJ3SoCxnSzEfmUNsRbkTR
FiekVhRCzE4x/ENnUAffaiPJJ85jkiAh/oiFCGXTbhaVrX3ECmuKBzXgwMG/KfUH
A4Wkn2N/0XmO5DwlBgZjJgoPM+3jEBGmdxtR/8Els3/sbJeopKRJj/K+ugDX+sOi
/aRgqSQSlbXfEGjCFdofLekKmHgu15IxqX6yMjKCVkF1nlUtSKlOyXwunSEwhTXd
rPLJFXTFDd9VyEZt6kPD1QbaAyTqlXGmqD539T9vr/fOB9lYZRUxgS6J729XbWFg
JDjkeEBsZZ+ET5mdGEboFzJY+Mdy5Pgt9sYv/MWsGuvAG4tdilD/EkCCueypcxt3
syAtReFNlgkJCQkV0OI0pS1ttYdom3yzhdNH7GylSbERUTuCpsFX21fgWlgYsiaP
OS+t0KqO4nCKaTEYkS28ZhUBmkgj41PN1vTFsRawGBrCntIfSDI=
=NZ95
-----END PGP SIGNATURE-----

--+EwcLp+XXXrhpKBe--
