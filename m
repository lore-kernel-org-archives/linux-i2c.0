Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A9A296BB8
	for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770998727; cv=none; b=qlHPTW3KmFbTnU6oFIJmKGpBvt9ZTTEGvyQqHsUHm656VUc2rpO8lHsz/p250x/sccDqSzaaFlL2T1jsn/L6+8LolHVlWxVQNOslkZ96h241ERJkQL0L5mXTm6td3LAXebgloxy7kGA0ULus9rsFG34Vdtfg7ojZm97A/1hEjGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770998727; c=relaxed/simple;
	bh=li8j2JEFVMm0scO35dahdaq9bPSooqZRS2P/W5cQdRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqbypYlKXMecwlRGBnpbP4xJhZ5hYQJZLd8XrkJK21E800GOk3jNRCjP04iI6e+O5c6JE3OV9dLgf0/bpam7TlfQ4DpfpBLPDo2RVZk6vzU5nS7Xoh+KqjduHou3CFUtJwOibF6cqNYXIXL7U6qe+Q8Vz3a6E91wM0fZ629UQvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQnHkqzU; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQnHkqzU"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-385d9fb297dso9839181fa.2
        for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 08:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770998724; x=1771603524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=smt2I3TIoGWQUiQ+jL/+iEqgzDTzVh0P/C3zq5KAyl0=;
        b=aQnHkqzUelNg9+rpsVO9nAVfewLlJCb5yY1nH0xG/r0c0zPXsFUnTMMDouyhDHuNHL
         GBTwQjIqcuFDFVn2honpGhgL96TsMEhQL6DpkSp/WpfBwkxtvz28vN9iqeeABetC7WMz
         BCdMiTBMx7mXsQZ3hltfJXzW5SbDC2Z7Qu2aKsusFPclvmmVDezSQ2H07NgAOzD0F0fJ
         sXYoJGJ1cIwLwEmIbiBvo5Rk8kdtW8GBkFnoEMArTEB+lbieFiGdmNrBep+v3TlM6oCn
         0rj/DRj+eKFWgPwVC2quIOp1jdpxXRxbqvm8f5Rol5wZKcMid2Wvi6OAsG6a0B5vCrJM
         4ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770998724; x=1771603524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smt2I3TIoGWQUiQ+jL/+iEqgzDTzVh0P/C3zq5KAyl0=;
        b=RefX8Wgdlfj0nmGD7NDJDwEtYUCD0xvTEvAYogWUwyq5jJJ1w/k5sqDXShYf3/lIR9
         BRep+dDq6+Ad0XN2lsBWvtUxsiyVlRFdB6asDvI5lyaGfL6kcg+msTyIGdFFONvAn61B
         03He8c/ts13ML/BUbnKfO6bAG4nzEjt93JIX0ZOB9j5otBrzCGYzTROZiIQ200aQOb3Q
         di4pQ5pH5g/zFcEwUECyzCn0yrw9ds0lNuvVOUwIuwkYoZ6y2UM6I3Or65iwFC0yO/Xz
         xXyOOb8gI6LUvxYkhmHB75Zj8MnfezxsEz/TNA1P/WeKzb3sYgnwXJDTAgwyGJGGQUsa
         QjqA==
X-Forwarded-Encrypted: i=1; AJvYcCUdW3YkRyy0/KRhEzvcFTID2vvXPNvcAvcM1fGD2lfwGaaHAWoIvAa9cdBXO7YZkQIA6cVzx5Mhep0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfjAd/PBmhorBFVuBaZAM3qmFEf9tRuXZwdd+QctZ/svEZYKms
	50Jt9GQ8RphhBXFgUyS9lZ+DNI2dQDwcMcGs9ISON7N93eageD/1MBOa
X-Gm-Gg: AZuq6aK78pc9IUwpPEXhRMW1w3lqhr6Xp+FcwpmkhXDoPJllBY/X8ERBtJIzm+PqVnP
	lyKwElCuieuNvAjdKwCxjBBbBFNo4LD+qXJOc2BZv6XAqG2zlET96sDNYv74N3Ll0TiW8eQaNdj
	rEWprCRXimAz4LTsAQo0gBz714jyHp3oTXZ9NUkyyl2AQIGkDQNEqJCSyi+9RxGb8n6Y8AYLeIM
	czjT4SlT71tDsN6m8401p4TTpLWIBz71Gzecg1cmeJdmAoNStyaR0zNStbxoL/cIaeVtFHYeoQP
	g+sIl3u6CVaen70JISBzHsd/fKSeqyVVHqbjqVYT5PUxPSXVsHPr7e6s/v497/D3enEhkReDavB
	RItYDms+tGc+iR6HT5VL1fUXErGEXq2sdMdjdaoxTSWmLF8jdgxLE3ZJSKLXoRLiS97whohvvfv
	WYijl0OAANu0W8AADfgYxTPyeWaldFEOv/7PpbOJrM1CjX7bGRzOY3Q4eDoe3Q
X-Received: by 2002:a05:651c:2210:b0:385:d162:bf3d with SMTP id 38308e7fff4ca-3881050bed6mr7426771fa.4.1770998722513;
        Fri, 13 Feb 2026 08:05:22 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-387068923aasm13048961fa.3.2026.02.13.08.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 08:05:21 -0800 (PST)
Date: Fri, 13 Feb 2026 17:05:19 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/5] i2c: mux: add support for per channel bus
 frequency
Message-ID: <aY9LvwgTS50jLSCH@gmail.com>
References: <20260213-i2c-mux-v5-0-fb2cbf9979b3@gmail.com>
 <20260213-i2c-mux-v5-2-fb2cbf9979b3@gmail.com>
 <ccd960bb-9dec-3a1b-cf3a-d22b4ccf4df9@axentia.se>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6fcNXqbn+kKd91zT"
Content-Disposition: inline
In-Reply-To: <ccd960bb-9dec-3a1b-cf3a-d22b4ccf4df9@axentia.se>


--6fcNXqbn+kKd91zT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter!

On Fri, Feb 13, 2026 at 12:48:13PM +0100, Peter Rosin wrote:
> Hi!
>=20

[...]

> > +	if (priv->adap.clock_hz && priv->adap.clock_hz !=3D parent->clock_hz)=
 {
> > +		mux_locked_ancestor =3D i2c_mux_topmost_mux_locked(adap);
> > +		root =3D i2c_root_adapter(&adap->dev);
> > +
> > +		/*
> > +		 * If there's a mux-locked mux in our ancestry, lock the parent
> > +		 * of the topmost one. Mux-locked muxes don't propagate locking
> > +		 * to their parents, so we must explicitly acquire the lock above
> > +		 * the highest mux-locked ancestor to reach the root adapter.
> > +		 */
>=20
> As may be more apparent from my recent v4 response(?), this is not
> what you want. You want mux_locked_ancestor to be the nearest
> mux-locked ancestor.

Hrm, I think we are pointing at the same thing but naming it differently; M=
1 in this chain:
Root - P1 - M1 - M2 - P2 - D1

I'm thinking 'topmost' means the one closest to the root (ancestor most
far away), but I don't stick to that naming and I am happy to change it.

>=20
>=20
> > +		if (mux_locked_ancestor)
> > +			i2c_lock_bus(mux_locked_ancestor->parent, I2C_LOCK_ROOT_ADAPTER);
> > +
> > +		ret =3D i2c_adapter_set_clk_freq(root, priv->adap.clock_hz);
> > +
> > +		if (mux_locked_ancestor)
> > +			i2c_unlock_bus(mux_locked_ancestor->parent, I2C_LOCK_ROOT_ADAPTER);
> > +
> > +		if (ret < 0) {
> > +			dev_err(&adap->dev,
> > +				"Failed to set clock frequency %dHz on root adapter %s: %d\n",
> > +				priv->adap.clock_hz, root->name, ret);
> > +
> > +			return ret;
> > +		}
> > +	}
> > +
>=20
> Here, you set the frequency /before/ ->select.
>=20
> > +	return muxc->select(muxc, priv->chan_id);
> > +}
> > +
> > +static void i2c_mux_deselect_chan(struct i2c_adapter *adap, u32 chan_i=
d)
> > +{
> > +	struct i2c_mux_priv *priv =3D adap->algo_data;
> > +	struct i2c_mux_core *muxc =3D priv->muxc;
> > +	struct i2c_adapter *parent =3D muxc->parent;
> > +	struct i2c_mux_core *mux_locked_ancestor =3D NULL;
> > +	struct i2c_adapter *root;
> > +	int ret;
>=20
> And here, you restore the frequency, but /before/ ->deselect.
>=20
> Thers's no symmetry in that...

Good point, I will change that.

>=20
> Cheers,
> Peter

Best regards,
Marcus Folkesson

--6fcNXqbn+kKd91zT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmmPS7sACgkQiIBOb1ld
UjJCaA//X2a3lgD8Yp6cOmM9sQs3eZosPkXjeUxzy15UbQSZrNOGnU3D/Ujz2CSQ
QMwdD+KJKws3jTcawHXesvP8P5zePLAo+/Gj78jqJb9QWK6zEdTi4mJLKBDdaSG8
L9UzSJF17NuHfolZ/nAVo3s84jooY4ZE3PU22FPoJzmwtRU28pyl7JKUQLTz8UT8
25AtgTtO8OfYrYiNXcNilZ2ZqwEgamhE9q8U6GKjErrsDJFG97Pal795bis3fUVu
JChwmQ/HT2NZhK/aXBGxqVqEYIirQL/0MC7ZbN4wnEtK2MqNXkwKK5if2Or6pKbE
tP4Ijg5OXrtQsqUhsRbmfxH3Jb5MJsgvmxbde8NPAi0s4nc4IAicL2Ld1ZyaHSXF
pZ0LiekLFCN+BJH3adCaPWUmu6hIxK9oLqXkNTxtZVXEai2ealPBeq1v1F1QfBkx
XrJhb6NRFI82H20vZnAXJyN5z80fVeJHhv527zNwfFpvUIr5itDfB9uDBprDNFiI
jpqwdxILKG4eP6OglarXcBWrVLMrqx+1YsEhTQUOvSMlqa+P6JIDFDhYxR9B+sdM
lser0vwQyOBt3mrLkyJJCC/HDjZcdbZ2Q0WRRjiSyUlWoiaRD7wPNXpBHZLfyAqW
KdOHkIJOJa0QgDJ00I9RfuzhHi5Zv2JtHnzoOBNkpagfCbbh8hY=
=AYL/
-----END PGP SIGNATURE-----

--6fcNXqbn+kKd91zT--
