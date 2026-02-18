Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6F62459E7
	for <linux-i2c@vger.kernel.org>; Wed, 18 Feb 2026 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771398182; cv=none; b=mIiPKs6FWXeiRVlGb6DZYCqxF18I7ostrJQCe9W0WV0fQc+dodF472zEuJCYfxpuJ/xNGYb0WYLWQ9q4trJFEY1vQUl3Rp8+vJ9yDjGhDYWdXsM0Lr83GXmoHZUWIxRNWD/re0Ne8knI9DnhlI9N3ITxOWzrdvMgb2e5VT7w8U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771398182; c=relaxed/simple;
	bh=qjTiJxJ/J+fAiH4bcVa6aLsQLAjfzOLECOEAUlrfZjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J51LXW4Tn7piSMYHwADQ4XqPHZ/ZnPAkFLRH/VWP/Tr3kZJz3sT2W2qH/vfolbFICyF2oj5VOK9gwibBOYFnpAJ80yAelXXE78tJ2gF9Sr2dVDvIdBPy/R8p+Xh5+VxbEywUqMdbEvRBUXhO2+VQmZB27NUQdugSuKlkoF8cajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SISnZoaK; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SISnZoaK"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59e6253b16bso5363138e87.1
        for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 23:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771398179; x=1772002979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hXXoBmrj44IUOz5Es2ozBzd5fhqRhhv5SZZDcT1xe2c=;
        b=SISnZoaKyPiTx3QHuB0wa/oFlVqmDYS8ICiO0hR3/6xTC23wHvpRtiXuVqBYdHwX9k
         dlL/8QhNkZ8BFDjonKJvAPEA29p5+9GJgyryxWV7qsbsAbL1aBCq/Ou9og6nJvleHb2v
         ebe9ZJviAnYZhqvyVy4WPdhjldLYqUrVRdrc4my0zLk3nu9JuuaJlHYVZjFlP2iUyrHO
         n7jFaeUE7qkgd4kbFeRjKyvSKvZMZ8aQsHUhrnC5YQyvUwa1sxl7kqoUf8Tc2bfdO1dj
         Se0IECL2LLfRDPAZhUUFlREreKz/5bWcEOYEaGkG5K8iazeZAUdOViYdZvyTDBwmVUL/
         OTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771398179; x=1772002979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXXoBmrj44IUOz5Es2ozBzd5fhqRhhv5SZZDcT1xe2c=;
        b=F3B17uMBCKtseIyN1IbUTCT43t3R1/V/ubu11lKNakiwqGH+7VNiCoORwGDfRjjBg6
         66Cczxoi+6AuSkGhD8i6Mko6HhjxcYongAUGenjmENhjxF9XzBRKN1xxrcefdy2DPS+o
         Gdjd5xoTPyT+twypdpu77Paexzodm59OBZBXTEi4l3cKO6uDwOyBWDHNgxidCqKchCEW
         5xPiaOVZRLGI5t8ufLz7TKQpCq/z5ok18guEsPic6hqZOAoa+Xj1crS+8Wb7Z+TYc+/S
         OZkeJAtiWJL67/gmhj8aes5v22PSARlt4LETYnF2s6fT8SjMZmUTSo+soREweq+bgHa7
         ApmA==
X-Forwarded-Encrypted: i=1; AJvYcCUJggsFT9KEkaswGtYEEQW/fO0ORhLnBjOchmSz9Z4HG3wwOldKaAIWn0vFPPXBdjTwmA407gfffzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySmvYx+F1wdFq/6S8MjUKTNxmJjb4hE5p/O/t2D7EOEcHJFK/5
	QRnzQHlxdgSZXPXXH25xsRtAERaAj0uiJiipzgg3BeQuN44uG4K7OW5u
X-Gm-Gg: AZuq6aIIyTR6xs0MVIfN3/G4bTWj//WPoG94GXG5NhAglbK/robz/gMgEYynEyMVcOq
	yjPWY83NZndM0RXkQlbHXwMv+qWzlFuqx71C43ygLfdFGOfYVQxPcHk0QNp6aIBksri6MrGkxwX
	Pop1k+pShzTVL/tY3i1vfh/rnPTv0TJE+PnyPyUB31CDC8XwmJE3rRhRK7cRvjF3Tjc2azeZOby
	Ni+EyKvL4d6tHOOOnGJBAqb3YcBdWvFUtm948ye0fi5MN/CHSYYlZhOyX4jGamiXcEnZryCnVbg
	k9ysRYbxqt43oQMZRt6ote381RPX8ejdsk3+oZkuhNvudHKL1QHT3PqJfRjcSSGPwxK8fqrwa2S
	et8uil71bwZZbmNNUJuT0Mv4hKidxsKZc7gGFiUaidY5vUWnfeWB5+FwkkONE4f9xgQ3YF5fvyo
	ToDKKMJo2y4DMDOUynGPMQaq1nXyckAu6uEyPCsbj+tgJ9t8e/Y4zpmvJoghXn4Zq5bgelEJM=
X-Received: by 2002:a05:6512:686:b0:59d:f71b:3608 with SMTP id 2adb3069b0e04-59f02632deamr5652870e87.31.1771398178667;
        Tue, 17 Feb 2026 23:02:58 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5acb0esm4280001e87.67.2026.02.17.23.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 23:02:57 -0800 (PST)
Date: Wed, 18 Feb 2026 08:02:54 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/5] i2c: mux: add support for per channel bus
 frequency
Message-ID: <aZVkHoDsJc6CPszz@gmail.com>
References: <20260216-i2c-mux-v6-0-9be28ecfd7e3@gmail.com>
 <20260216-i2c-mux-v6-2-9be28ecfd7e3@gmail.com>
 <ab7090f3-4c03-098b-b118-4cd7a68af8f0@axentia.se>
 <aZNm6LSK9C8DHC8U@gmail.com>
 <e21781e7-0ba2-19ce-3c0c-bd198e73c03c@axentia.se>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BkvM8BP+41dGuZa7"
Content-Disposition: inline
In-Reply-To: <e21781e7-0ba2-19ce-3c0c-bd198e73c03c@axentia.se>


--BkvM8BP+41dGuZa7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter!

On Tue, Feb 17, 2026 at 10:37:39AM +0100, Peter Rosin wrote:
> Hi!
>=20
> 2026-02-16 at 19:50, Marcus Folkesson wrote:
> > Hi Peter!
> >=20
> > On Mon, Feb 16, 2026 at 05:40:37PM +0100, Peter Rosin wrote:
> >> Hi!
> >>
> >>> +static struct i2c_mux_core *i2c_mux_first_mux_locked(struct i2c_adap=
ter *adap)
> >>> +{
> >>> +	struct i2c_adapter *parent;
> >>> +
> >>> +	while ((parent =3D i2c_parent_is_i2c_adapter(adap)) !=3D NULL) {
> >>> +		struct i2c_mux_priv *priv =3D adap->algo_data;
> >>
> >> This assumption does not hold, making the cast pretty wild indeed. The=
re
> >> are other i2c_adapters with a parent besides muxes. See e.g. i2c_atr.c
> >=20
> > I see. Hrm, not sure how to decide if it is a mux or not. The best I
> > could come up with is to look at the i2c_adapter.lock_ops. E.g.
> >=20
> >=20
> > 	while ((parent =3D i2c_parent_is_i2c_adapter(adap)) !=3D NULL) {
> > 		/*
> > 		 * Check if this adapter is a mux channel by verifying its
> > 		 * lock_ops. Only mux channels use these specific lock operations.
> > 		 */
> > 		if (adap->lock_ops =3D=3D &i2c_mux_lock_ops ||
> > 		    adap->lock_ops =3D=3D &i2c_parent_lock_ops) {
> > 			struct i2c_mux_priv *priv =3D adap->algo_data;
> >=20
> > 			if (priv->muxc->mux_locked)
> > 				return priv->muxc;
> > 		}
> > 		adap =3D parent;
> > 	}
> >=20
> > Or do you have a better idea?
>=20
> That looks fragile. My recommendation would be to avoid trying to
> guess how a potentially diverse adapter tree should be handled
> locally in the mux code. To me, it would feel better to introduce
> locking/recursion in i2c_adapter_set_clk_freq() for muxes (and
> address translators), i.e. take inspiration from i2c_transfer()
> and i2c_smbus_xfer().

That would be a more robust solution indeed.

>=20
> I guess an unlocked __i2c_adapter_set_clk_freq() is needed.
>=20

Rethinking the whole locking approach;
If I follow the same locking logic as in i2c_transfer/__i2c_transfer, do I
really need do take any more locks than the root adapter with
I2C_LOCK_ROOT_ADAPTER?
As the frequency can only be lowered, an intermediate i2c message will
not mess anything up?

If so, do you think  i2c_root_adapter() should be moved to i2c-core-base.c?
Then i2c_adapter_set(_root?)_clk_freq() could lookup the root adapter
and take the lock there.


> Cheers,
> Peter

Best regards,
Marcus Folkesson

--BkvM8BP+41dGuZa7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmmVZA4ACgkQiIBOb1ld
UjL5kQ/9FZG4RjJZzJAb9lOuafAbwZSG92RdAK7UgHrvI6dlRPsPquhlCA1ql78G
leKeilwgMiRZ4/eof6B+M89fvRgGzb+NKaJHb8epXz3BVDwdK0L3ovdj0xZntOfM
RrZVy1pfKosINPCZ3+VYX3x/8hy7FiK8zuoRCdRkQSZOsIiQA+swNHjtEUL16FTa
w4o5U+2zY0zBHuY0IBDPoFjzVgZa5bQHR4EtlBxV9rhj3rB9DgkLkO9olLt9LbUW
D/WVAaFxt05rK2GCneAde86ABxjZ8EVBujs5U/HTBMK9CtlOM2Q45Q7yMBztVqZ6
hRyU6eEbEZztPHbJlMMuLoHDM/FqgVWKvHuDMJ5zJf2VKGncewfBBNMKbgCFG2DQ
e8U8QiFyEikGoSOs7POF2V+Sg0PplbomLA7oIegxPcIrWXZVHWSUBI9tPTHNH7PO
zfASvV/LHYXIUzfIXtPvPRREkh5vrMu5eIfihIdAfgrgNY8p0SMwiOeYt2v//Bq2
5n9lc1O5xVGJEa6bTo/+2Yu8wY/HTI/WAFAY/gV1oZ2Zgn0kqYcEp57F5LgNafsj
Xc10LHEkl4tfuCz8FgxWUV3rMMwZhib7GEgvQaFl7fiMsnv0RJjyWcK74e/G6Z2S
s0+s3v8GHBqR/g4lsEJEIfbggh6GJTrdJ9MvEwOkTiymXF/1iXM=
=6mY5
-----END PGP SIGNATURE-----

--BkvM8BP+41dGuZa7--
