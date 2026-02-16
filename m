Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8F62737F2
	for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267824; cv=none; b=VPPpFq0fzinJImNpXTGdErqmUiSZPMQgXdVGNc8mLJc3z0swLKy+4DgCnT+B+icorKZgEbLK0GUoG3VlQZ2CTD4fsbufl6n16OEjcC5Xj1/9CZhzqaQoIdxFFtSt6/1QNCeBWhXv/DPxVOGFBuH56sWrI/qNpX9UKLzbPRB4Q04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267824; c=relaxed/simple;
	bh=X8NJGja7lTkdEnX03MYM6GVzjKQi0FoO+CsihGvHVoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRPvFbqkyZP7QsMVSx9DICqUMqAN3SIiBh1co16XW2WwRXKYxSLDrKdbUcI/MciTaa3l2ul1J+5RI5VumwuB5hgHyUwBaAYSsqk3EVbXUsNYXZAQoZqT28J6f3T7AoxwntSRdjOS2VWxA9UOoqh3gqxlqkPg3sonSbKvq6fPF8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA8Xu/2F; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA8Xu/2F"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-387114fdbedso29532641fa.2
        for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 10:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771267821; x=1771872621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l2AvSSRlaXVJb7/w7Tk1weJEeTXvEX63lHs6sjttYiM=;
        b=FA8Xu/2FId3qXjZGGFf65sFL90ps05iheUyVfgEigqe4ohl+Lysd4pAKdbKiLyu1sQ
         zvEZWbyq6uRHQh80G/pPHL4gR6fh6e3pYXMWXdIJVywBiVP6GVgniNGGqcztnPZzfKbq
         wqirjf31rkK8U2l6dhat2ooPm3Rsa9En3hkq3hJ3/Uv6gXy4LUBWigH5ymXi9eyEOEt+
         3YA26t6ZNsAhuD1MSEZ+YP5YIi058xJB3iUb93eIFIvlxTNUeW29mbfZS3v3TyUG3QE/
         gZQ/NvJznVvT5qlMsPRe2azx3qrj7eEBJSszGZpgf1c5aMjjlyvH/E5fmrPeF6LW0i4/
         46ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771267821; x=1771872621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2AvSSRlaXVJb7/w7Tk1weJEeTXvEX63lHs6sjttYiM=;
        b=jraWLAPWU9AIenyt4x4Rj9eSNbhau+axcAnC5L8qaPekxIDC9kvC4GWPCYAvmrd7n1
         Tv0SHcK70kReg2Lp+gAh6LBkEyNbGkR/YiMRQYauYq49fyF6/B9UHPXHOHiyF49jbGr4
         XwgBOKVYbqZ12SDgfn5Sto0SYNCItGK81TaTkLYV0lXB+dP8ZjlZiRqt5BbP2X4obNBH
         tBMaODE9XMAuG6D8lPbRosodBHw5Y+6XAzMOCUL0vWTDPH9/65QB3iDPDWSGj3Z9BhZi
         85y2LQaZztdoQINSE07Bpc0hGNo3jBhfaxho4JUrtPm0RPyRR3DS5CSz6QnAzJlimq+N
         GI5g==
X-Forwarded-Encrypted: i=1; AJvYcCW8eYNTZFXyO46WYVR9QvUdlrsEHPjDZ/WDqZl4k5y5wg/wCU+Xj7HIfMouXaQRtisiHiHEfdMqoNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrGBobCbbt0JTTry/74tqBwJusOLEWWJlcBtwUeafBz9d5Okfe
	wKNwnJJrkh1dHQ/ftACaUpi6BPLDO9lrS/DDV453IxoCUHVLYAYzWPzv
X-Gm-Gg: AZuq6aLZ/GzmWekk47r3LAqANWFtwlrBQEOHuDfNzyz/ZiutcCz/BxJK7zfG2GDE42M
	Wi7qNxadV7jcAjBavRXAY+w5UiyHE+8N6B/6TzL+RdxymcXg6tVMGmFHsoAdCimHxwIjdI+BSZG
	DlFSm5+5//8YIiskND5I9TJx5fu357b0RYyouz7ozpTu3GaWaFFLhhN+t16se6scbyhsOnXAo1X
	3I2imGoGF1fVC0Y6npYzljxTX2jTXEKot4vcXcmDPba8bspFPa6lRJTpV7tZ3BgIkc1dWaUW7ks
	JX7NsGEwK3H7c027gLQ6CYrm/Qw8pY7hzVGO0Z2F0+390bHShFggdv5TdgNPqDDInBP+Tq8oQ3G
	h1H36+bKXHC05x6IzqE7ZwmSorvLtWXZb7AftcBJqhcGgI4bUKK0spvNSmJrO2d1sKjilvmE4UW
	bfZCVtgPm0nl/exDlw5sqEeDUzgJ4PoLRXjthgWjX+tzz8oRmu3BJn4vFfzCuI
X-Received: by 2002:a05:6512:33ce:b0:59e:64d4:12f6 with SMTP id 2adb3069b0e04-59ef97f1e64mr3239213e87.16.1771267820730;
        Mon, 16 Feb 2026 10:50:20 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5a4f5fsm3399455e87.56.2026.02.16.10.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 10:50:18 -0800 (PST)
Date: Mon, 16 Feb 2026 19:50:16 +0100
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
Message-ID: <aZNm6LSK9C8DHC8U@gmail.com>
References: <20260216-i2c-mux-v6-0-9be28ecfd7e3@gmail.com>
 <20260216-i2c-mux-v6-2-9be28ecfd7e3@gmail.com>
 <ab7090f3-4c03-098b-b118-4cd7a68af8f0@axentia.se>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pemrsl7Yj+LEV701"
Content-Disposition: inline
In-Reply-To: <ab7090f3-4c03-098b-b118-4cd7a68af8f0@axentia.se>


--pemrsl7Yj+LEV701
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter!

On Mon, Feb 16, 2026 at 05:40:37PM +0100, Peter Rosin wrote:
> Hi!
>=20
> > +static struct i2c_mux_core *i2c_mux_first_mux_locked(struct i2c_adapte=
r *adap)
> > +{
> > +	struct i2c_adapter *parent;
> > +
> > +	while ((parent =3D i2c_parent_is_i2c_adapter(adap)) !=3D NULL) {
> > +		struct i2c_mux_priv *priv =3D adap->algo_data;
>=20
> This assumption does not hold, making the cast pretty wild indeed. There
> are other i2c_adapters with a parent besides muxes. See e.g. i2c_atr.c

I see. Hrm, not sure how to decide if it is a mux or not. The best I
could come up with is to look at the i2c_adapter.lock_ops. E.g.


	while ((parent =3D i2c_parent_is_i2c_adapter(adap)) !=3D NULL) {
		/*
		 * Check if this adapter is a mux channel by verifying its
		 * lock_ops. Only mux channels use these specific lock operations.
		 */
		if (adap->lock_ops =3D=3D &i2c_mux_lock_ops ||
		    adap->lock_ops =3D=3D &i2c_parent_lock_ops) {
			struct i2c_mux_priv *priv =3D adap->algo_data;

			if (priv->muxc->mux_locked)
				return priv->muxc;
		}
		adap =3D parent;
	}

Or do you have a better idea?


>=20
> Cheers,
> Peter


Thank you in advance,
Marcus Folkesson

--pemrsl7Yj+LEV701
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmmTZuIACgkQiIBOb1ld
UjKMwA/9HbiaQBz/bkSFRLB6Z6Shz2Gp7lfqO/+FS7Ri4hgMDb//wcrTF2757mG8
eCGPnGGAd0hpF+HX5bJ5JIvCDKPeBY1UtTCMJo+s7tfD8oVOabC/fKP6p3FKPtE3
TA5MSGmprqTOrZLI1qv018S/UiGaxAriBqTeoMVD9xswh4llcQmQbmvB5yXTL59t
Vqtlq51mmnHmcBA7UOUdbhthj8otdjs/mDJAFkBHpFAxfnpgFBncCH+cNQxJEtxO
FqwP+vVD7nScYal3F7zayAWRiATY4ElxzcTY44N59Q0bg0kcP/raj5o4ZTAB97J1
E8ij5R/c2BCweaUJsOUD6iNsxk80e1grDm1bqhBrZ0Hq+kzMnK5XjCc7ugb0dvND
NvaH4q1GuNhpUIncPJk9gDTgO8+Pi2f+JBJCEYgktsO9yS8buL30GElw0XDukKa5
P2TzX+W5Wt5W078ZHvA2387ZeOUSD88sGlJluvXKjo+W8Y6w3rVOa6WGUwQ1bpoK
A0xXh2zwT966dimSnI63Vy2MudAlUudnQoyl89+HQoCS5EUCDtVpvQn4GhV/8+oe
ANRL65P5hxThDvw6vo6DT09kl/xqat2LUKmTFw6E3NhFSwL7fkvKrAE5AgynFnde
/eEGiirU2/gPW6hXmBkvuHF/9/F06HxyAtJYyjSNpdCdqM/duYg=
=PrHK
-----END PGP SIGNATURE-----

--pemrsl7Yj+LEV701--
