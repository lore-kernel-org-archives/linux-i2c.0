Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795573964;
	b=XRwytf+VA1rqbMppJLx1NXvsYJYkbbcDp9s3rpq416LUYD/5UFJxKkZSmdbyIROfnj/s
	 Ji001F1jkRMgjAH+HlBACYU15n1l9iQqjjTSBeZ5+tvjbgzAm3rl6dL/poPNB6/v8Zr/4
	 cNp8nEzBYzu+9xxi1U0wqPjdY7Ct790QlCMIMKIV38jwMV6FMMBrl5vb93cgb1/DXeCdv
	 z9RTzmbhUbapzLQRL09EdGuvhUDbEuyo3hfUYrmzlCs0wlb2L2JwBEp6MSafiGTZqS8pw
	 as1ihmy8sknZ4HbDLBXOpcIl7IJNYqE4lp1bEs2BWtgbfV3J+bEz/zm1VpObSD0JqsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ZON3wd5LTh6DpO3AOL2NcXrQXtyEk2i6wBI9GQETg9A=;
	b=4Og5IZt/Sm369YQJPDAOmlfweCgBm9CYHLelqcS298nTMr+oEGY8hc2dwKnp1hrmjl4J
	 mkqtTwiFa2C3+zNQ/kzTFctZ+6Y2ANLtZ43yokvn/DExwJQ6Invq12aH4iiIjNPx0mDEd
	 DtQeCBidqs0c9Aw/cZHGijiPefqPqJ9mzSNxIF1YLPfMrTQLclpadD5FgNmSvcZwR9c+9
	 KHMq68nzoVa8FHK9bnYBb8YV5jSHfd99ecOoVxUFdMnJ4sz7zI3y+PnNLLYzqyfbhSGC1
	 dDF3DY1ujvJrlPR/d3KO3fXsjwPva4F61sFOhyG51Fr7PJtN5P+baEDCi1W2Uc9PLsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JGnkFeho;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA3C606A321
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 02:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BA3C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JGnkFeho
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3acc7a0b558so52255831fa.3
        for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2026 18:32:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795573963; cv=none;
        d=google.com; s=arc-20260327;
        b=jnk9rVEG0b9llOoOcZP17Rmya7cHiBB+lUvEaBeQKcAEeJPM2VKqQXvgjXmjAWNQIO
         fNNbOxe4lVX4aNzdXo96382kYkfrXwBywN8rTVA1tsjt2h49BMpo17F2StjZt/FSQaZI
         wLEtdtvBhvzVA2N3pp91YNYcqJwV6AUkB9FiaFFw+pPxIvNwh5IOgi3pyhEWETXdmLH9
         o0EMLBmc+JQv6JQPg8I37xQbDluofP9QXLwI8Ii1JaFQ+N+ZDXatScp+jSNDWFvAPuwT
         SIhqgKwfEG9GrWJaEBQrkHnPuaoE/4hVxLo4HStSpf+Lwtlm93A+xQSeQ/jNpxD+T9CI
         gjfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZON3wd5LTh6DpO3AOL2NcXrQXtyEk2i6wBI9GQETg9A=;
        fh=g2AssQ/y7AAXxm/tmAdDwHilkW3+gSTyM6hsi0F+atw=;
        b=fMXiC5D4zPjrjxlAbQmnUVDZ7QhGjrsE4SUilEW0aAB9SerntqVvy42M+wdUw6+UPQ
         SlCOpkKkF6rzPvasaFjELzObh2CfU8I/CIXs6ECS0lnfeHJNDdNo9kvcFTPOiTtSN91f
         3Lw5tWCVFMTO5RvDLIjzQ59Jnnvb67Srju/a19wp01sJySPXzfrtBV5MsZm0L348gl+H
         V1HuomMpVHtIwJnbBADFWiczp0iQVUjrUTN9DIYE1WZEJDFn4ZSnKdpD0H8CjnxwRgjA
         6n+VoUC3ZbjXryGrxU8nK8M04Ws4i6/apFx04nHq8YoXuUQrNkIwJPBCZrJWB1y/sFMn
         mFVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795573963; x=1796178763; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZON3wd5LTh6DpO3AOL2NcXrQXtyEk2i6wBI9GQETg9A=;
        b=JGnkFeho8NHko3O6xmJmlLpcKz9rm42Ze7zDq5eCUuPWhWk2DOetuwlfUCK/zrNhC9
         TySDjoqzKiD+nr+xj8/hVKIYHrk4RyLvfhaO7iuHEFVN2fKNqz2OhzBu9EkSWerrPTuV
         d/eSBJl+nY1/y9CGxu2xM9b7JYmQzUEWNBSSsJnaPL38DxjT0lyd93+RuyPGHSOBpOY8
         ZJXUfkXr61HXdHPJ3FKISio150uY+TrdPChotPmKCcie4Mv65YZIbBqYcyY2WY9z/YWA
         hRd7dXIMSuhXsVYmuTFOpKeFZJaEQSpGwA7sdfNBudqK80lfpDmagKfurFLDqLPdbK8X
         lDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795573963; x=1796178763;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZON3wd5LTh6DpO3AOL2NcXrQXtyEk2i6wBI9GQETg9A=;
        b=URNTCGv0V81c2hYZvscqsUleR+OK7wBFzPljWLj3JWSL/SD8n/8xxheR6zWL6RvWZg
         ZtiYukrxgF1RDHOklHFQSG2t4WQJAaWNjen6ZFE5exwXZ+Rnn0Kgw4L1pVkrlU8Gn55k
         LeZYys7L+mAyvm0gfzMNh4sf7anj7HcxtzAuSCwnFaqEC3NRTbxV8iANg1afRxWDQJ99
         W0vJMEwBQGY5DlxJncSTq9LWJ5/iVKdAsC1sJZIVtELTKjTJgTpSth9voJzBmkQjdmYV
         ynZatdfZYrUKjZ+d1des5qX8LhbDBoxB6qS1P2ciKN7B5P3G5EMtimJfnpL7Go6RDtec
         Xz6w==
X-Forwarded-Encrypted: i=1; AL+hErHI0odQzQnV3GVawnbNJyIo/uruwDwHqsNxWv1Zf416Q11PM69EFvCRnfmGQ3PRC2MCdSUvemeY03c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RUmRXGE0tXfN3wLvE8w2ahQWlJIE4hfo6Qalf18PVIWldN7//
	P01y1FevrbSyQGuOn+AfaZHEFQskPWU2WcFAXG60Ro736TH0P6WvQ2gQNa+TbB/hoY4v79aNNb8
	g0IdZLVsPDqOu6pLWhH4VIowN/lzR/QI=
X-Gm-Gg: AZFdTZfDOvDljEvtGFUhbAPh6e+6Y+VnzDw/yjmaja6y44xplDtFVNO/ef1f+gcHKP8
	ndELCeN/vaomVIQjs5eGQXvZXfGnour2XcMvgGZHxIWuiPXOtraVas94m0hfm915hstSziFSEGo
	AhTteL63dCq9rhqwGMY53tAP2/Rb8IeHEMQLPBzFQooJA6IeP4YLOi6pw7hj1cL5gogPudoiHku
	fCmJbqEo+5qthgG/Trz8RTEucsy21UPX8/Amj/AB4C+vuhpd45zYQjOE3nSN5LNr3F32569EPin
	nkANK+AHmpUDucXwBNQvOASbg/toR2zV26DjMFEfYU9xMBBUkFyKx0m9RfHGnHyQP5slzpxVFWz
	74UFAOa/rBtrkCg+N2W9k+gp9NM17MI9iblg/
X-Received: by 2002:a2e:a98b:0:b0:3ad:f236:a652 with SMTP id
 38308e7fff4ca-3ae7fa6ce1cmr44004651fa.25.1795573962416; Tue, 24 Nov 2026
 18:32:42 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109155743.83740-1-muchamadcoirulanwar@gmail.com>
 <20261109155743.83740-3-muchamadcoirulanwar@gmail.com> <947615fd284c416891ac6de5d16cdd00ec5267ab.camel@posteo.de>
In-Reply-To: <947615fd284c416891ac6de5d16cdd00ec5267ab.camel@posteo.de>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Wed, 25 Nov 2026 09:32:30 +0700
X-Gm-Features: Aa3M54rr1ufHp2-DDunLUXvNfYN2DvOkdEG5zZTIMyDI3WVeYzjwx6EaEbPlUvU
Message-ID: <CAO26r3QL4R_h4DGWE9CpYE_=6PW5LXo_qy+xKgxZndSUcpbGwQ@mail.gmail.com>
Subject: Re: [RFC PATCH v7 2/4] i2c: rust: implement SMBus access via IoBackend
To: Markus Probst <markus.probst@posteo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, Danilo Krummrich <dakr@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Mark Brown <broonie@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Shuai Liu <847807867@qq.com>, linux-iio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 22 Nov 2026 at 20:34, Markus Probst <markus.probst@posteo.de> wrote:
> Hi,
>
> please add me to CC.
>
> Could you make `I2cClient<device::Bound>` Sync in this patch?
>
> `I2cClient<device::Normal>` already implements Sync. Functions exposed
> only for `I2cClient<device::Bound>` should be thread safe.
>
> I will need this patch (including the change mentioned above) for a
> future driver.

Hi Markus,

I added `Sync` for `I2cClient<device::Bound>`.
Thanks for pointing this out. I'll Cc you on v8.

Thanks,
Coirul

> Thanks
> - Markus Probst
>
