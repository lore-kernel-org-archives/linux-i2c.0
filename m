Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070A7175A83
	for <linux-i2c@vger.kernel.org>; Thu,  6 Aug 2026 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785984723; cv=pass; b=dtE8Y/MSrBUhN61riQ/BxmGQyEC3pVcsjGWxxx6NiGizm1zkdiLUzBKiKQts1k0t26RKbQ1VBtjFxzAH10fpXTj0LrTJuhbhsK3U6phCf7V0GruDNxZzNsRnQPVgAOBdeXaOERunnRJX5bYp+uE16AAujXkE9xrF+me6Prc4YRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785984723; c=relaxed/simple;
	bh=BofN+QkBqcBCXaM7Ffk3SnOnc6dFmU5Id2Z8stGZ/CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tb37Kxu6GGE/bt9tHtPo/bkfqiWhl3ladAOYdm38ZIRFn59yc6wWP9Vk2nmqMrdMASrDT2GkoZv9cijFhbkHR3cs3vFLGpHcEr9WIer64pVSXr6grLbccic8vcN5xnSStOH69RsrnN7/HOQ5lwvBomZalrjF2zHmvVgIYU9nYEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GP9HOzyJ; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GP9HOzyJ"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39c7ef2b1e2so17658441fa.1
        for <linux-i2c@vger.kernel.org>; Wed, 05 Aug 2026 19:52:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785984720; cv=none;
        d=google.com; s=arc-20260327;
        b=Z6b0wSnyP+HFvlwug0eBeNo8J6fdya5fON2XkMU4JBuE07buVuDxn6+KBAp6IRwP7M
         6uCbNHrrDd848HIjhQdzSp7wQpUt66vP2Dq5Z+0mx+9qMQZmeh4VAlVxi1U87yEDxHcq
         nsA3jfsPNBLWLW8Hqm36B6Qh+TtQI+PsgkiGLOkBv98hMqxAmFLF4zaQvCH5ZfuzBKVu
         cTPeHVuaqrFy3JxY5iI1/7cPRGfHElQWEN5pxATfrW7pQQEeqiDfMd8Cm3eM2s6WQGtQ
         UGcYZ/A8Xbd6mDc9JSr77IqUNEbJeyXhwv8SyYBdExAK3743jBhrxfFyvfSFTAvODzPR
         CRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LH9Hb22G5gTotHoIdzC5eUl1OJHBKnjFRO4+QY5Ci1U=;
        fh=q/SAs6St7Tf2JiwMLOGB1I56AUyCch3uXVIB5P4h6rE=;
        b=nsVEAsuXI2NT+HxD4lPsGGjATraNLCGJBbNw55f4Er+XawZl/72nt4mcoyXTUSdVki
         VqOqOWnhXgVWvTnt5VsgEKpgp3i3ZihFCxrs7eq69BfcIidbHtUWTExnLRDwPJUGGtl9
         zuJ+4rcUp5SR4GAo/LPYnA0z1Ovsci2EL2gjZyA6VSSkTpax+AgDso1wN/mRohZYR2eG
         feaKbeLbLSrAHEIP+dQCoTwZGX7LAtNiSFiaE35/wiMwTPi6xiApn884MAAI5qjeJWcA
         CPqm9Trsl5E5sUUq58mwhwU2+sW0w/S6XzA/SOvOc8zkdY3PLEBzWSLtBBH9Ex/YEUlD
         Ns6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785984720; x=1786589520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LH9Hb22G5gTotHoIdzC5eUl1OJHBKnjFRO4+QY5Ci1U=;
        b=GP9HOzyJkjXzt2dbcuJG5kY6a1t+fskClpHSqYhiokGzmNXtRKLdGHL4O4KZwMzP71
         ICU16Y+nbJuX7ilIEDlpW6bhGdzxUzQZaRO5bnD0MbnZvcpEjdVlzeTaFX9m6Ip/q4C5
         MHl5FYd6oC0UGG4DZmpJUC/fd5doCzgLkekB/EFxE1zluzLhhQzfdwxb1hGC4iB1mOgK
         5FUbfGiQekZneqmzrSBE+PTWpLk500NsjLgW+MZbPZj21CoWJjNEMasnruGwwMWYubu3
         9/4tE+R21uUAvzif7Tm82tsbdSHKQnBUdok2v8W3H7Ol4w0RlpskRjcgoa0orKPOFmtG
         S+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785984720; x=1786589520;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LH9Hb22G5gTotHoIdzC5eUl1OJHBKnjFRO4+QY5Ci1U=;
        b=aQLok2Lgq7PFMDHXgHfJdoJ7XaqMv3ojljMCZ2ea0jMCDLlliFlxuGg1PpmdsAZ9ly
         9vgk5EBW2fEEJpIxnSwTdIn9DuPnUSWunFZW8h5n9ge50w53n0mB4F+8/UpY3yRicC1e
         XC7KGPqxH5pKYs6/POuRW6JMzLEAP8FmcNHa2Vvg8d4zIcZv7+y0gggcDPmWNh9ZVG7t
         Ln9xsmpOh/d26bKTLUG6fFECMGCuN9H6i/orhP3tPL6Rkofsxv8HQkc9TBgxQT3Koz9v
         WaCPHGBKrO6uD+lPrH6DNh9CmGrV+VjRXzZhe73jumiFFe6kXH41NYq9v55QBTRFhdRc
         iagw==
X-Forwarded-Encrypted: i=1; AHgh+Rp/Z9fdrHYoZlGBDlX8J6+0X2np/LFJgEFmQM4KKCkynAV12/Ot0cx3IgDt+C43E5rWVzWzX90a3fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysf88hzOctK6onxyvHyiCga8LjaJW43P3tg8NN1oCaH9wLp/ev
	Qz0U75vplPWFJq91wW5W3UZy8xbcL0Hj8MlTPWrYOmixBhBBl3Xeq85h+ZQ43i7pa0dD0XUDvFz
	aN4N+jmQO+HSt/e6krHl0ziGGCMOAeRs=
X-Gm-Gg: AR+sD13AsIWG0JGNkHcoaN+3a3bTMfuwJAo6fFgBizFYxKhn/LGeehmUaL/Hv80dwXg
	gNV/lVAbzoike2+LSIX6L08tzXEV0YYhc5bhzv+862PbqBLzrsU+oQxEbq1Fc1oQlQaiG7ChGua
	vAxtAs4xitNNYzbouz4oA4mrrckmIQeE4Q4E5aDlfHiCjg348YrKw2hdA5AXqyygXlj5EtvG8yk
	a8rKedEiGuIO+uk5qh2gJv5tERzLeo+r8o1d+u0kce8WVPghXTYh1DxPftpLwAGqHlHn6ZdUnpG
	7E2rh3DoRGa9ofsHxJVty3D0xdSXB5w7cWuLjRyYGhFv14M=
X-Received: by 2002:a2e:a99d:0:b0:39f:bc94:eba1 with SMTP id
 38308e7fff4ca-39fbc94ecdbmr12993261fa.16.1785984719852; Wed, 05 Aug 2026
 19:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-4-muchamadcoirulanwar@gmail.com> <anH7kbxvS6z5GlPI@nsa>
In-Reply-To: <anH7kbxvS6z5GlPI@nsa>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Thu, 6 Aug 2026 09:51:46 +0700
X-Gm-Features: AUfX_my6-BQjJU5blWOqxW9TqLep4CD_a6rLqYdTK1XAnpRjYthQlcT_QYPHuLc
Message-ID: <CAO26r3Rxe1kVSU_JeZetvTF9Z3ChoxYj5x8rHNFwcdX+mHLuiw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/3] iio: position: add Rust driver for ams AS5600
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	dakr@kernel.org, igor.korotin@linux.dev, branstj@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Aug 2026 at 21:56, Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>
> Hi Coirul,
>
> Same as Jonathan on my rust capabilities (maybe now I'll have proper
> motivation to learn it :)).
>
> Just one question below...

Hi Nuno,

Thanks for taking the time to look at this. I'm still learning too,
especially on the kernel side.


> > +impl IioDriver for As5600Priv {
> > +    fn read_raw(&self, _chan: *const iio_chan_spec, mask: isize) -> Re=
sult<IioVal> {
> > +        const INFO_RAW: isize =3D iio_chan_info_enum_IIO_CHAN_INFO_RAW=
 as isize;
> > +        const INFO_SCALE: isize =3D iio_chan_info_enum_IIO_CHAN_INFO_S=
CALE as isize;
>
> Likely stupid question but do we always need the above? Some drivers migh=
t have
> several INFO_* bits sets and we often need to nest the match if multiple =
channels have the
> same bits. For those cases having to define all of them like this and
> then doing the match seems not great to me. I guess we can directly have
> ` iio_chan_info_enum_IIO_CHAN_INFO_RAW as isize` in match but not sure
> if it's also that neat...
>
> So bottom line, it would be nice if we could have something nicely
> readable that we could directly pass to match.

On the const definitions, yes, they are necessary in Rust. Your point
about scalability is well taken though. AS5600 is simple enough that I
didn't notice this, but for a driver with multiple channels and
several INFO bits the const list grows quickly. Brandon Saint-John
raised a related concern in v3 [1] and suggested wrapping the
iio_chan_info_enum_* variants in a Rust #[repr] enum. I didn't get to
it in v4 and I'm planning to address it in a future patch.

> On another topic, I believe mask is present in several drivers for
> historic reasons but note that this parameter is not really a mask. So
> other name like 'info' is more appropriate.
>
> - Nuno S=C3=A1

On mask vs info, you're right that mask implies a bitmask operation
when what arrives is a single enum index. I'll rename it to info for
v5.

Coirul

[1] https://lore.kernel.org/all/20260529053803.3256031-1-branstj@gmail.com/
