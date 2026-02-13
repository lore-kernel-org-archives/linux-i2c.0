Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A0F354AF1
	for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980351; cv=none; b=EM/ACDyWtuxqxPs8zotW5/Rc9BTeYhvJ0XmQANY1q+V7Z2S7zeI1/pWykcPI14FLoFmBy+5QryDnaeyQCV6/fHP5wWjSbETNIwO8RGf4hgqZlre0dCatdlfJthhqLkxH6B5K3kfXXC6qKcu5eeK/9eMvt06tMFpMncZul9wwPbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980351; c=relaxed/simple;
	bh=PC0XhXcGA5PB7/p4XiApV7wHd+gbBqWWky3OF/ZvMnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+5NvhqnKbXrAVtc/NXmaVVxJ/ZYuypPGfwvDv55PZ7G31gYD6HKxV2DzWyTTWRb/vzchC4y7QC8Zc10cBX9AnsqG8InLW/nFH2oRwWAzieKsNE3X7qsQrtDymJnYBf95wXdPWzKf098F4uZiBmdjB+77VrnXaXJWwUG3vDaDnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3/L3F/G; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3/L3F/G"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59dd54b1073so916595e87.0
        for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 02:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770980348; x=1771585148; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+T4GI3Ari/F68CoDGesyTms8wzhDFFZmgjFqbgJPCOE=;
        b=M3/L3F/GebPv2gwLhcthVL76WgA0euGEgRSW4YLEXJa0UbTTl7nTUV90yqRn56GffO
         Cv2CNA28Btul0tVVStd4191M6V/DEx+ZKgX/3YwQpi4RL5M6M/wy9TM+tOc0ujKsaQeq
         oWNzITJVYhH6/81us3cbQZRUb2ahK6eUyN/laUHJFqwkvCan3Xk6OGmzfEL6I8y1alku
         GXMbx2QyBmUXts6bl6CynwFmRGESFuiKmJXZvk0dQ64k53aycyqHVH77T9wRAEmI5J20
         gJ6dVNTcMgke+2JaxvEUKjlS42ZZwWqPNZ/LGx9QXGexocNJqyDUPhUcQgm6u+PqmFhB
         ukjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770980348; x=1771585148;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+T4GI3Ari/F68CoDGesyTms8wzhDFFZmgjFqbgJPCOE=;
        b=T6CCm/ch41yz2qxHhX0gTCBwoqrEyPiDBL7wUcJx/Hf8V4jqlL2aXEYwjUGFbiX1vQ
         RQmaeGTqU1J6Ud9WmsM00lfJ41Kb/aJBiWUjyEUBf43thpuNTVdtH6E1IWO0fofguunl
         ln7Z/a3YsQoNx8aqdMHwHUvtNBgcMmsaXLUnunlkWNAjIg93wNP27231+EakdDevHKhS
         hyNhNff0WpA+UdW5Pc6q5/faDkOuXLiQFWJJ0JycYvq+oKvW3EhPaIGLk96WRZYNzBlc
         nbSpAoo09o7hlJYy4P/UnlZYE8K+Xv4peqw5kGigueJMOM8RT5VsQg+fLBd2qXJRgGpm
         USyg==
X-Forwarded-Encrypted: i=1; AJvYcCWRRoNXQn4cDFhUk97Ni2XpFdij4V5itcsc87IEDwzGbE6BVIJ940MW2r1/s8ij+tNTozI9DdN8CqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztv3GphN87dqqZiaaNb451lpHgu/6LTuv4I0sRRnFt1+l340XH
	CzajE3Dgd6e4crWpNMOL68Q5H5vYBP3F/h3b1v8vbyvk876snqPqR8P+
X-Gm-Gg: AZuq6aKISxXp6WgBOdgJa2MiG8fkic8obWzY9L/AKP5k3E0lkSKv15HwqI7NPU4YEpQ
	tnYlmRxPmnpioV1OFr9oYEiuEPR8+S3JUWwKHJaM290L+n7qelI2ZOnVKChbYnemnz83Xj7COlS
	PBjb+YP4DwmUqQErz8zbfbebaylSMLQf6xjKdG9q4Jf0vaK0tqdluYBcKTUk1qCkUMfwnk50/h2
	L1mDUIxxNkaVTwGWu28BGjAO7VJdFByuQidO/rNai1DS7EQMJKwK/MOdYcGmQ2fR289XThoyHxD
	F3M8lRPAGVz2RAc/l+x4nY5S4VpqL3/LZM1H/7tpqsJ2rjoKrTaf4ZuMi0mLfWv6Tznnx0WR2vh
	cP5oHmCOF1Tcj178AufoTOc4kN5ucpdq1bUw+ZaIf3BTBR4UkJhjPvBz7gQAJc3bfzLZXhkz5NG
	/+0UOpFpmV5AqZMndUINSDy4IteQzO6fljHmC5iD+SXm4w3ItM7B5vLDqxl2H1MC/Yk/TW5IQ=
X-Received: by 2002:a05:6512:3a82:b0:59e:44fd:8066 with SMTP id 2adb3069b0e04-59f69c5bb66mr598242e87.33.1770980347610;
        Fri, 13 Feb 2026 02:59:07 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5ad79bsm1495543e87.70.2026.02.13.02.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 02:59:06 -0800 (PST)
Date: Fri, 13 Feb 2026 11:59:05 +0100
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
Message-ID: <aY8D-UJnmmGUl3lr@gmail.com>
References: <20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com>
 <20260128-i2c-mux-v4-2-dee49ce276c0@gmail.com>
 <2ecbebd8-0842-34fa-a593-25168c91aa6b@axentia.se>
 <aY5KeH3Z1S3MswHI@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aY5KeH3Z1S3MswHI@gmail.com>

Hi Peter,

On Thu, Feb 12, 2026 at 10:47:36PM +0100, Marcus Folkesson wrote:
> Hi Peter!
>=20
> Thank you so much for your thoughs!
>=20
> On Thu, Feb 12, 2026 at 04:02:16PM +0100, Peter Rosin wrote:
> > Hi!
> >=20
>=20
> [...]
>=20
> > > +static int i2c_mux_select_chan(struct i2c_adapter *adap, u32 chan_id)
> > > +{
> > > +	struct i2c_mux_priv *priv =3D adap->algo_data;
> > > +	struct i2c_mux_core *muxc =3D priv->muxc;
> > > +	struct i2c_adapter *parent =3D muxc->parent;
> > > +	struct i2c_adapter *root;
> > > +	int ret;
> > > +
> > > +	if (priv->adap.clock_hz && priv->adap.clock_hz !=3D parent->clock_h=
z) {
> > > +		root =3D i2c_root_adapter(&adap->dev);
> > > +
> > > +		/* if we are parent-locked and the root adapter is our parent,
> > > +		 * we already have the lock we need. Otherwise take the bus lock f=
or the root
> > > +		 * adapter before changing bus clock.
> > > +		 */
> >=20
> > The assumptions made for the "otherwise" case is wrong, I think.
>=20
> I think you are right.
>=20
> > Consider e.g. the case where we are parent-locket, our parent is
> > another parent-locked mux and our grand-parent is the root adapter.
> > In that case we also have all the locks we need. Trying to grab
> > them again will be a deadlock.
> >=20
> > The more correct approach is to do the parent walk in search of
> > the first ancestor mux that is not parent-locked and then call
>=20
> Hrm, does it not apply for all mutex-locked ancestors?
>=20
> Consider the following chain:
> Root - P1 - M1 - M2 - P2 - D1
>=20
> P - Parent locked
> M - Mux locked
> D - Device
>=20
> In this case we need to lock both M1 and M2, not just M2 ?
> I'm not completely sure though, I need to refresh myself on the code
> base.

Okay, after a good night's sleep, I think it should lock not the first
but topmost not parent-locked mux only, IOW, M1 in the example above.
Then the locking would be propageted up to the root adapter.

I will send out a v5 for this soon.

Best regards,
Marcus Folkesson
