Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43634A3416
	for <linux-i2c@vger.kernel.org>; Tue, 14 Jul 2026 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784045296; cv=pass; b=L0DQ8Tqe28rrXNsSFqZUsYf5hNaiXnBiR9qHIsTAXXTYE/AfbEFTg4MJD7+i7mKWgQSiADO8PTOKPjyA3WGV1/LbM8yLgNhlO1mWPGCZYGQJv/30Xprn7aa6CTKdU9+PV8gOQ2GZ7Gdg0T3YcZVWRvrnm7YuwlIbHCvWvEp05go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784045296; c=relaxed/simple;
	bh=ZbFdtg5sjBl+H2D0nTxkcOm/iY35+wEQQikqVUFjc8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYeV31N0tsydR1uU2GxRiWKBBvKG0CIzPkgTCbfBZsJ5SW7riLKt4koFKcisX1wr91M7IrcaVsCSQIkht1EsT150nRSBIQdv3sdWUxIsDX3+wnu3Dtys1tQPpFXR5vNqBSkFyKhGLzUkvm9nXZS+ln1uvY18xG2xhsVCjBOGrO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDLATQ6w; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDLATQ6w"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c94d4fdb9so18140411fa.1
        for <linux-i2c@vger.kernel.org>; Tue, 14 Jul 2026 09:08:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784045293; cv=none;
        d=google.com; s=arc-20260327;
        b=FvsxdbXTLti6o5fnK911W1HdhQFvbiszv9LtHc5ZKim5tuOczYlAAee1EXgYiYb/ez
         v3Fl+2NcAtRkvFJV5aV4blyUiTTSIhCkNw65wHlQm52BfoN8BT4lygUmoBS704P9LJb1
         1h7nUQiuXn5STfn/GhRR7/A6YnWztlRroLsny2nDCKiCGyi2dpxU/7ToiZdDfnquqGGK
         Bpw+1SmrEKQi1j3W/bP52Du/uT6/b1VDnIhu65GiNcRkLbRktAr3iyQOlok66pXwfJlB
         tfJJVrxeP8U/xegfx3qC0dMIwJcOknz9G3mBzL5yd3WmQaTyV6+twT4mpIxFohmU3EBP
         aFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZbFdtg5sjBl+H2D0nTxkcOm/iY35+wEQQikqVUFjc8c=;
        fh=MtfFR9Ea9P+HQQdz61Kb0SLRIfYlutgqJyORvY6c/DY=;
        b=T12rR+a8T3F0XYNTh3RlS3+BGAFWFSPsndjtuElR1MSEVzOS2Ukfx/UyYkvFlGyizt
         UqNIgCqE0D5879sLxVOU0da6ogA0sqTs9x/azC5ROcrVFNfAuWmar/0XNOsp37SXYRoP
         SHNrhfSLPWOR4f57pv7qZWjl+zeImAz+DbXnuVZ9+dA3MNSKsDJ4Zy97OCcnDAZVn2o6
         Op23KbUWM7R7bcn1qMbAxU92a8Sg79V+RQTBOisdxxWnOJYbu3iI8bhnqVXCAaPF+dwO
         W8DMrZsFlXEsH1cYqTTZ6eEZGHX5jtw0Sz1EKq8vKS+LkifGxglo5paB5YfJiHnMJIo9
         TuuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784045293; x=1784650093; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZbFdtg5sjBl+H2D0nTxkcOm/iY35+wEQQikqVUFjc8c=;
        b=mDLATQ6w0u58SlPK85ojsN+O1HgYo8r+l7kAnXA451dg0g7KHC5uiPD1NSJnWTZulH
         Mzm7+1EUxstOb4vddW5yDNz/D/hJ4MkQno2z3hQZyTwuI2/g2If6gEGXsX4cgVgBdoPy
         t3qSxDbLmkR+Qp9wK/Tq23QeMXR4/SB2Urcdz0lp1NM9pd94N1Y1n+w+7xdopVjo64Ku
         /fHbxLP3xlUUhrQuJay9mtrJQo2vnN2X8x8U/DBaT+Lb2MrARs5WXZBad3P1cTsZMBHi
         c1ot4fdt1DO/Yl2zh0k7LIRJrOzREr3qd/vdJCagltz/lC+bSSI9ROgyPQNaDaY+F/Bt
         xt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784045293; x=1784650093;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZbFdtg5sjBl+H2D0nTxkcOm/iY35+wEQQikqVUFjc8c=;
        b=tYDu8jxSRwYDod2W3Ta4GLikITJE3xdYihEqXED4XxtBFLieObVrdxU8ckbOaLbn1D
         fvDgNw1gG4rhPDD5J9HPBvNpZBNY7/NU+WDOAegzSUoNRGhU4gP0PWa1+j5pA+VXCFAy
         I2L5iEKk6zLaSrgn0Y+Y80GCUAf6ih3c26jHMXldcyd30+/HEKm4BAKaEL2iBryEeDsj
         9ml1m+QQhWFVsLOimz1JjThsybDwHb9sDidq0cs0P6dpeqwF2AFPztUA8ooLhzvMQJM4
         tVeM9gsjO2FIl1QPQ+I67qJy2Jpo1U0LrhwsRBo664+/u7hijKZanR1fwD/1hzwXBrYC
         ph0Q==
X-Forwarded-Encrypted: i=1; AHgh+RpZUE6RnHOuhJdrtYcpu5TxItD8RBpL66qtaNCSpXrmDcxzPws8BaB/qLoze8qJc6cRT2Nwz5OkfhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywar3IObptPBoWJJcy5kdQnWLXjw9INVd6AeGZ6kl7ztK1iL7O0
	OtGRCtlE8HiL3TPDrn8Px3lpMmxoDKub0xmQZwxtBaUd3qvolaNCs/70PEsq0PZTzl0+bYzS10C
	9LPaY2KSmmXIbtiqrOcoPcONygQh6p28=
X-Gm-Gg: AfdE7clIDGgIgdFGDysJkxkrMI9KuE2k8H5Hm99BeP0X4YZYmvn2UYjU9XDG4PSUv3K
	VQjf2Bq69fk2IWxviYFEy1lmaybPDnIX7mXYChYdIJGRYERRKbijzSIa1juYde2dh4isDM0wBhG
	GWXZNdc+QvWR6EpY/6/aaE4rHyIZiU3Xba+DWRp5g1BtNdo8+h5lvbaUc8N6i9dLv4bfjYjTwLG
	v8nJM6WN9rqO2I7JXSTdIySjjo0NozB+qRA9b3Ieh22T1ec/mzk+VToUSJWC6WMF3M+J6IceC14
	CBueVH87X0T6BjTxdbEf1hHJV//1rfc=
X-Received: by 2002:a2e:bc88:0:b0:38e:8357:c5ae with SMTP id
 38308e7fff4ca-39caa138bedmr31683491fa.9.1784045292310; Tue, 14 Jul 2026
 09:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-2-muchamadcoirulanwar@gmail.com> <178376430529.16552.7043868463863908196@linux.dev>
In-Reply-To: <178376430529.16552.7043868463863908196@linux.dev>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Tue, 14 Jul 2026 23:08:00 +0700
X-Gm-Features: AUfX_mxjHjnxb21MnCrWbzQJiYZvtYk867vc7GSuACQWoJdxFFCJgHfV8pHaNcc
Message-ID: <CAO26r3Ttyfqhs3_jWDFym7FpswqFW4-UA8p1pQBcuWzDGGzstg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/3] i2c: rust: implement SMBus read abstraction
 via kernel::io::Io for I2cClient
To: Igor Korotin <igor.korotin@linux.dev>, dakr@kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	branstj@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Jul 2026 at 17:05, Igor Korotin <igor.korotin@linux.dev> wrote:

> This driver only calls try_read8()/try_read16(), so AS5600 itself isn't
> affected in practice. But the abstraction being introduced here would be
> unsound the moment any write-capable consumer reaches for it -- and I
> don't think patching try_write8/try_update one at a time is the right
> fix, since it just leaves the same trap for whichever method nobody's
> gotten around to overriding yet.
>
> Danilo -- since using Io for I2C was originally your suggestion, I'd like
> your read on this before we go further: IoCapable::io_read/io_write are
> infallible by signature, which holds for MMIO/PCI-config (bounds-checked
> implies success) but doesn't hold for a bus transaction -- I2C can
> genuinely fail per-transfer regardless of address validity. Given that,
> is Io/IoCapable the right abstraction for I2cClient to implement at all,
> or does I2C need its own fallible-native interface rather than overriding
> pieces of this one?


Agreed. I will rework on top of Danilo's FallibleIoCapable approach
in v5. I checked rust-next and neither FallibleIoCapable nor
io_projection v6 has landed yet.

Danilo, should I wait for io_projection to land first before rebasing,
or should I carry FallibleIoCapable as a preparatory patch in my series?

Thanks for the detailed review.

Coirul
