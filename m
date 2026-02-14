Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68A9136E3F
	for <linux-i2c@vger.kernel.org>; Sat, 14 Feb 2026 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771072235; cv=none; b=qbBGJpJPeH2OKHPqWZ0lkDzUAhiEexERrlKRSPrH8G2OypnikTPaDkQcOOu/SkWrZ9Yqz+LyCp8M56hgGM65rSAVGZeMSrQRgLHye1+Bfg+qO2gAdrbO3duaVTZIvRbHvFbU8t0m3KmRoYSQudCJ37Wlg/aQxfKcZqDunlGskB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771072235; c=relaxed/simple;
	bh=NISToq9UzThDeT12tXmG2AS9C2a58f+HXzsZbGnrDR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL+Szeag1+VCQmF7geY8Dm/0Kigxo+SMzni1kVhQjBsIXlWBE1Sdxoi7VwWkUQbvSAK0ZuQGRo9Uw+NBDRr8tnw3QvYlIex+S2ex+hYdaDLHrdaK2TW3pzyYF9OYzuJVXbhxgmS3zWl+M6xD0JmZ3gkluBksq3oz+eQ24B7E4a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz3FTiLW; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz3FTiLW"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-386b4c28ad6so13246241fa.0
        for <linux-i2c@vger.kernel.org>; Sat, 14 Feb 2026 04:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771072232; x=1771677032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rU8KsLHRo5ZlxNTKDAHqj+wy/9XSKwf/xleKqlzrXX4=;
        b=Jz3FTiLWvxGPaJ1ZcjvBf0mDdRz1eTQtgEn6OywFYJXXMAgUTc/mnwTmRrSdHcPD79
         s56cX3AwwvS9Mco55jnzHRgGjxm70wVrBKJFt4YWLxFTfZR9NUKpvKD/vEL4V71UJkVD
         GNauTGKT/r8xc9oaNuMosjn8tbD8q2UbRCgNsDrnWeH9Rh+/jAvwyEbm78NVHLw92vmY
         WX3KcYP+TPd3Q4+tIQ6zIG9DLEezvTBgTtBd7lIYdvtoeDry3JL3YpJ+K4Rs1+u4R5kX
         IWfv0W/CjNxJWT6EMYIta1OAugxmsrPZ+uJWe2SW4sfAI01PXFAaiXD6W/aFKU2cyS45
         BQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771072232; x=1771677032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rU8KsLHRo5ZlxNTKDAHqj+wy/9XSKwf/xleKqlzrXX4=;
        b=t+wZrrSNeIIHomck7RYEgvNBku8Cl/Kkk4H91I6hfUzQ3GRN34AWFx3giRCiLhDRQM
         w3E43nxDRmc+G7VEnxRns3yjFrA0r58V9icupU5nJI4985g73v6kZbom1uJoRvH8r33Z
         t69cq/wIK7dkrB51EVs+AgQBozK9kC/2uPjvMs29FH9Qieg+QsuAWz42PSuMgtGN9lV+
         d3O2Ktklc5a8vz7tzjqUwEXeiaJuM8UI7tFAklbIQvXwLLBnnsBIY+0bRBfDEGuugt0H
         829p/FO0jU6xfiFBrW0g4bSkPi+S7bCmloGGbYIkQR25cPhTc+Q53fMa1fiisTFCgWj6
         K4Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXfJZjxATZulw8zsOnRhUD5NJjaRvGLIBFkqvs6KfShneN9jBev1ONpUekkAzydkpG+HmuZYZ3AofY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCKbZVj/J4rFrDbtOm3wjukT4mksmFlTCZv1IHRvAC9oBBI9x5
	Sd6QPmARb6fTJeleJLldwJSdVOQt1l9XNQTiq86T+D6Epg52+Vt5jvF7
X-Gm-Gg: AZuq6aLqbJad855c4HlGkDEnSj6Lo71x4zK8Zyf8pbjsGh3dzDaY+FOO1yFqrEemJZp
	6ORW8WhVNqiyED6ovmXSimDkg/G9P04423kWe/szlX9WbzZL824i28bmzluy/pn8aHKNQBJ0sLc
	I7HkHq+vhYCK3xqPGSFR4kdwaP6QZ0et9puoQWt0wQGqCqjExTqTHaxI0xbfmGfov86T4rJnabx
	zXhwnBWBWrPZUoB2YTNP7H5wzIdvTkjy0+AymuQFDI6zYMr0MrLDUVSwMGDRqnwm59vCRNOdGUz
	+MWXKu1KMoyrkZznOm16r/FrrSps70kCa6zLBcBoNRqG1fiJoARVNJM9hX4EyMVpk133VJCokIY
	hadDqBXkP95WicpOdWcIpuTasj0qjsWs6hFxg06ikEWvr1F1P62Pc0VHnW4CULwT1d4Me7HWklZ
	k73ERBeD2HpJSOXK4ZMVk7vpDp6f6v+6z+eMAVi3EqwK+mOt0ZoiGnVi17JO5H
X-Received: by 2002:a05:6512:234c:b0:59e:2242:fb9 with SMTP id 2adb3069b0e04-59f69c27962mr1550480e87.16.1771072231684;
        Sat, 14 Feb 2026 04:30:31 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5a4f8dsm2150105e87.49.2026.02.14.04.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 04:30:30 -0800 (PST)
Date: Sat, 14 Feb 2026 13:30:29 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/5] i2c: mux: add support for per channel bus
 frequency
Message-ID: <aZBq5QGHFcQYAONv@gmail.com>
References: <20260213-i2c-mux-v5-0-fb2cbf9979b3@gmail.com>
 <20260213-i2c-mux-v5-2-fb2cbf9979b3@gmail.com>
 <aY8JRikJpM4v5BcM@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l+WwOMVdoDQxRCoU"
Content-Disposition: inline
In-Reply-To: <aY8JRikJpM4v5BcM@black.igk.intel.com>


--l+WwOMVdoDQxRCoU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy!

Thank you for your comments, good and observant as usual :-)

On Fri, Feb 13, 2026 at 12:21:42PM +0100, Andy Shevchenko wrote:

[...]

> > +static int i2c_mux_select_chan(struct i2c_adapter *adap, u32 chan_id)
> > +{
> > +	struct i2c_mux_priv *priv =3D adap->algo_data;
> > +	struct i2c_mux_core *muxc =3D priv->muxc;
> > +	struct i2c_adapter *parent =3D muxc->parent;
> > +	struct i2c_mux_core *mux_locked_ancestor =3D NULL;
> > +	struct i2c_adapter *root;
> > +	int ret;
> > +
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
> > +		if (mux_locked_ancestor)
> > +			i2c_lock_bus(mux_locked_ancestor->parent, I2C_LOCK_ROOT_ADAPTER);
> > +
> > +		ret =3D i2c_adapter_set_clk_freq(root, priv->adap.clock_hz);
> > +
> > +		if (mux_locked_ancestor)
> > +			i2c_unlock_bus(mux_locked_ancestor->parent, I2C_LOCK_ROOT_ADAPTER);
>=20
> > +		if (ret < 0) {
>=20
> Would it (ever) have any positive returned values?
> Ditto for other similar cases.

Nope, I will change to if (ret).
>=20
> > +			dev_err(&adap->dev,
> > +				"Failed to set clock frequency %dHz on root adapter %s: %d\n",
> > +				priv->adap.clock_hz, root->name, ret);
> > +
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return muxc->select(muxc, priv->chan_id);
> > +}
>=20
> ...
>=20
> > @@ -223,6 +317,7 @@ struct i2c_adapter *i2c_root_adapter(struct device =
*dev)
> >  }
> >  EXPORT_SYMBOL_GPL(i2c_root_adapter);
> > =20
> > +
> >  struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
>=20
> Stray and unneeded change.

I will remove it.

>=20
> >  				   struct device *dev, int max_adapters,
> >  				   int sizeof_priv, u32 flags,
>=20
> ...
>=20
> > +		of_property_read_u32(child, "clock-frequency", &priv->adap.clock_hz);
>=20
> Why OF-centric APIs? Muxes may and do appear on other systems as well.
> Okay, this function seems fully OF-centric :-(

:-/


>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20

Best regards,
Marcus Folkesson

--l+WwOMVdoDQxRCoU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmmQauAACgkQiIBOb1ld
UjKjRw//TDudQNFb5scI70oKQYlNoQXhaWf3LGN9vJybxeuMDXu5vWYqZWSLx1BP
j7DsY/cHQFVA1E02tPCQfrhrhiezIkKd+Q/7PpjkW/0g0XxySG9wfdHpijZvbTz0
K/ROFizS2DsSuh74HdSUG2qWYyXVlNriZgR7JDJAmZarSTgRuKZ9q2I+uxIe73Ip
eZrwGMM3eCZtMPOUKBa3WNRD4VH01+0x70t3LGWpdQMrlhQHdOYmGQ+/7UqJOee9
srjUXjXTMvstZvb30FSCr1qC6faTcKrbzpZU/9fJ8TgzgAU1K7SzKUBbt541babV
okDQBZbtm//FRlLWP6WsX2Cjo8AKZ1aKURnXJBmJCW4FgYX6U0ZEuhBS7/uHqJwd
N69T35fj2LbvF+sXjIcAeT8pDUx02lWwdfOu8xGt5X/ARPkFUWhpFo7YtreyK8Yn
6ER/LepKtCQ2jC3JF4I+zoDz+uJPz3S4SU7rhyV0ELPer+z1FljRIGQaGnfh0jzb
OfVMPJxIBmxm7I6Ip7mnh9Ey20En+PjuyD1Hyv0rmh9FgSVhSDya4AyUP6VEmEw8
TLRKRH9F3Fo9hHUP+ilaMsABQAnpfUuduqof3Xy2rD9UgsMjS2xDrTe4oULvdaz9
mgDXYDPH99ttNZcCnFrsbz6x4TWawfTIcmfrLYhZmjVw0VIClfA=
=vsIN
-----END PGP SIGNATURE-----

--l+WwOMVdoDQxRCoU--
