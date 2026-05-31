Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0788B349CD1
	for <linux-i2c@vger.kernel.org>; Sun, 31 May 2026 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224703; cv=none; b=WF7I/+kRo0gVXcaX+doHN451t3s7WdyyXIi+bHFoiWLYIDpecKeF4SrbMdsNzPX3mb3qxfS9rEIvvYmEPpoJo3ldOetKZG89JHUehJFF4XyW2cH3zDzzHQ039ZhBl7d/HwYtShBmfL390eYb26iDPj+WkMW/TSoGrxp7hFsdf0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224703; c=relaxed/simple;
	bh=3txgGerBEnxbuQaHgQfhzRb0Jc9SeN4tFgx4sHTIeH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5ShutkduUbi4FsT1QjAYa2huvNyeGS8XOj3H6/ZIBiQKZUXA9S8FwlT4Z/0oCBbaXDuoU1mc8ULq8e5pHqc31LtGTus9Rpv/Q50SNMiL+d0CuX+FHUND69mo2M6TkvS+u2b5zXIJ+JVKGO8SsjbN4T4JWwQIg3sSZiSNvmeOtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuXz4plF; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuXz4plF"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39676ff4674so4931031fa.0
        for <linux-i2c@vger.kernel.org>; Sun, 31 May 2026 03:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780224700; x=1780829500; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kgt5nOofv85XgJ9weykvam9yTbMpDc91iTloiOIMZT4=;
        b=EuXz4plFbpH4V9g+nFKn0709Cbq+anYo142Faa3/zFoBj7gVunvYz/peKLdEW5VOs6
         MCJO1vepdxQDTnzN1iCV05VZyGf7Za7IBAwnIGJZWDB4gOj1oU8RABUS1EibDg900a0v
         AZlaKydo0eh8YDM0qlkRpcIVpnf1VJUpNzcmBPzvqtL1izrGJXx5f3rscaaNoKl9DbM7
         fg+s210dh32OvxcDbae3VFyMEdhu7TMJnQcM4GXmlqUrXK+JqR5HFwIj5hb3UYoG+4UA
         NJ2RF13b4cUFoxZPbhFwr68wYKmrzXWcvVfzge2ZCpFj/oq4guYKtLzJEv8ANK6fm43V
         3kYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780224700; x=1780829500;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kgt5nOofv85XgJ9weykvam9yTbMpDc91iTloiOIMZT4=;
        b=e8+snT6AFkTR09U0GJ6/56Ats3hEEO3Qr9szurQZYt1z5J2k+zrLsHdxmTH2NUdoxI
         fBx7R43DHpMNCVDyHCnE+o0wRMwKJnr2GQFB6K3kFV3fjXVGncYoMU98XjvR8LKvMnWx
         FYKCa1nnjgsNjGRXgIEvRclPg1k79t1RoGd3F+S4uJh2IdjkNDoqF2qhQKx9Ryg386Zi
         gddq1c5CGXXMSTEt/lYvNGj4GnDskkiXtZRJwFWJSQZr9oZ4UTKgmEIWUlb+Oslxnf9I
         5pAJ2Y6+AaOyIWK/PMx62j0a02C/d+2lrzCQNFiSS6kGnpAlqLzFdRTF5tkumY8HH1dt
         1Egg==
X-Forwarded-Encrypted: i=1; AFNElJ91CIKwIFdbIZ9HKjef2fdrflPHSFfVu3G1EXmP94ZpQymPS3w/OHXdO3NwqAMrqalDglkl3Fz95S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDzfyQKwGKENR/VSngDYu/3PS1CLawWPvQ3Iz+mjPHY7vakEh4
	2nIMj5tj4zkqjiaXM3I+HPWzhjAnSZ5EitBAq/H8tsZkeVvJS6uq2w4J
X-Gm-Gg: Acq92OGZ2jS8MYIz3TEK+B6/AET7XbbQcOBpkKV4EuNbZFgHZtjdny4G1VT9CeHPtHO
	bcvamjCgZoDR0tJ2vxhFoaCP1XgufPoqX5V/kCAIHlMAd1aEkeVFTsvk0Du9w8+8Ndm3+KLUU1t
	UJeRbCN4mbeGYDXpHsCLJZub5zANKtBKQok/su1qqXTmuxePQppwgJh9B9EmNE/h4ct+YryLWGE
	8dMUfnNiM3d8jRgwRbdoTNTsGvt31zD8fpGum69OFlD3/eczy239MyGECT4w7FfcSOekxBRX+xJ
	AwVxoUnNwUuv6F9HAKP4VyzvoQfCKK0G4d4gdMigY2J9CY8yXrU5DNq+kV+h/5Aw+qsMOL51Bkj
	Mk03sswU1W8shpPHeZMY9kJhEVI1hsNpxznzmVyo2L0+2aVAYAzfM5MR6t/dsmsw+sItfeA9Lma
	kyS4tagRK+AwujZGOdtlLaOCe9C9WuLeW+I/1ZH7agTJ9BbJfc9NjpaCSylD+vYahONz2U1K8=
X-Received: by 2002:a05:6512:110b:b0:5aa:5279:142e with SMTP id 2adb3069b0e04-5aa60a4e72dmr1623402e87.40.1780224700124;
        Sun, 31 May 2026 03:51:40 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa62f7f539sm936578e87.4.2026.05.31.03.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 03:51:38 -0700 (PDT)
Date: Sun, 31 May 2026 12:51:35 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Peter Rosin <peda@lysator.liu.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 5/5] docs: i2c: i2c-topology: add section about bus
 speed
Message-ID: <ahwSt2wYHp-cjWK5@gmail.com>
References: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
 <20260324-i2c-mux-v9-5-5292b0608243@gmail.com>
 <ahX4_WaqodYt3PmD@shikoro>
 <776cefab-fa6c-4092-8b95-236a3eaac729@lysator.liu.se>
 <ahqrEe_m4K4T7LaC@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ahqrEe_m4K4T7LaC@shikoro>

Hi all!

On Sat, May 30, 2026 at 11:17:05AM +0200, Wolfram Sang wrote:
>=20
> > What makes the topology bad is D2. Without that device, it should
> > be OK. So, the question is which is more important?
> > 1. protect ignorant system designers from creating a topology
> >    that includes problematic devices like D2
> > 2. allow multi-level mux-locked muxes with variable bus-speed at all
>=20
> My take is: as a generic operating system, we should try hard to
> maintain a reliable system. If a device gets stalled and blocks the bus
> because of a too high frequency, this is really bad.
>=20
> Now, if this is a flaw of the HW design, we can only do so much but not
> more. If the HW design is OK, we should not introduce risks. This is why
> I want to disable this feature for MUX_IDLE_AS_IS. It cannot work in
> this setup, but the bus itself is likely designed OK and would work at
> the lowest speed.
>=20
> > Checking the rules at run-time feels complicated to me, as devices
> > may come and go. Also, naming people "ignorant" over a mistake such
> > as the above in 1 is perhaps not all that fair. But, it feels sad
> > to disallow things that in fact do work.
>=20
> Like I said, as a generic OS, we should play safe. If someone wants to
> implement a more risky version, it can be built on top of what we have.
> This is agreeing to "I want this and I know I am on my own now".
> Obviously, it reduces maintenance burden a lot.
>=20
> > > ... unlike here. We have MUX_IDLE_AS_IS and MUX_IDLE_DISCONNECT defin=
ed
> > > already. And I'd think we should only allow bus speed switching for
> > > MUX_IDLE_DISCONNECT to avoid out-of-spec scenarios. Opinions?
> >=20
> > It is probably not unwise to disallow MUX_IDLE_AS_IS in this context,
> > at least until someone actually needs it. Which does not seem all that
> > likely?
>=20
> Exactly.

I agree as well.

>=20
> > However, it seems like it should be fairly OK to allow a predefined
> > idle channel, as long as that channel is not lowering the bus speed
> > compared to the parent. But maybe supporting that can also wait for
> > an actual user?
>=20
> I agree as well. I hope that Marcus' use-case is MUX_IDLE_DISCONNECT.

My use-case is MUX_IDLE_DISCONNECT :-)

>=20
> > > > +Supported controllers
> > > > +-----------------------
> > > > +
> > > > +Not all I2C controllers support setting the bus speed dynamically.
> > > > +At the time of writing, the following controllers have support:
> > > > +
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > > +i2c-davinci                    Supports dynamic bus speed
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > >=20
> > > This paragaph is easy to get outdated. We can document that only
> > > controller drivers with the callback function implemented will work.
> > > People then can find out if that applies for their driver...
> >=20
> > There are other such hard-to-maintain lists elsewhere in the text.
> > Not saying that this makes neither those nor this list a good idea,
> > but it is an explanation for adding one more.
>=20
> You mean the list if a driver uses parent-locked or mux-locked. What
> about putting that information into the driver? The core could enforce
> that it is set to a meaningful value and not left uninitialized?

I would prefer to have this information in the driver.
But I must also say that I found the list in the documentation useful
when I started to work on this.

But it is hard to maintain and not optimal indeed.


>=20
> Happy hacking everyone,
>=20
>    Wolfram
>=20

Best regards,
Marcus Folkesson
