Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793674800;
	b=hKBLu6LbiqaEZdKSyFKdavLXZkV4iG+Foh+M8hpRlNdTNnH2BWzQr7pPGU5u6YgAYHE3
	 PcxFETMUzS+0iIsUShPFCKcIWUbteelqSxsiMs++ll5nN1z3K3U2E5uufuls0jIJQrkP4
	 9K0emiYLLYhmL7PuXQEuTUN0eXQmLVo4OraS2mR8SKzlwlYIcN64r0vuDaM+WPjWDDmEE
	 +OD6RVWzXpHlVE99dgScio7Jd89fYWpQkFL3Webh/HtbjsjzbydWj5oHPkrRObXe1VAC6
	 O5da3Ertu4+P5St/S539ft2u62EsNyveZ4H3FhfB6wVXO05XgQZiMBgqZEQhrKq7Nsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ETqG1il4N8mKp1ES7UIxjJSG7R/8D8mHYo98MJ4c86E=;
	b=A4++afgXy9+2B0jld9Q4dbfmOJhRw3ThgEeUxt6nGrF99Q1b95tHZl0qrU5oR7twE627
	 5/L2wzdPi/R5DJp6S3LfiTBzGJ+/qy41S6LvOQGoEJvBu/UPd0XGxC5qKpQzXLC6Di5Te
	 La7+gLNtfBkbbHqw2RzRp/SvM0RqGd0Noh6jzCq8iVBp4acisslz1lVl7C/pq0Qj09AEc
	 PAtj5Ud3BOGr8xiLhdQjxNI3F/VwvVmaE8zSF2ffWFi7DidFBNrnhBxB/QIevFCeufLGe
	 k6lDgxm2Wp+ZeDNoQvnylQrMVE8qeAvZsbRes5Ipfhqq/Fs9XRk54NQKe65YIRkG0qQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xaMBHAtc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.169
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F6F606A324
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 02:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93F6F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xaMBHAtc
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3ab3b29a210so2825881fa.0
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 18:59:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793674798; cv=none;
        d=google.com; s=arc-20260327;
        b=Afylajo1YmLxSSbzXYrY67f59C/f8uichjGINvtETM0jfkXTNg3ZLyWqzAyG2pTU+q
         Dg9RWftVhL6cBrbDs0lRMM/RK9ih2MhAwD/nngOtJ8wc6gfxJqb6OdVohxqwwKMGAC7k
         owfKtTXJH2M5vAPskadOqD5nL1okjZajGa5dx0oVf3MsK0MNUrjqi+gTaWMH01fFFCAo
         7TMr0w2iqmUH1QCHa6nCej2C7UKWQAtEUvNz2bv3/lYkppFYcacpzkjf//Im/RAaQSO1
         SyzTNxoOU4ITEn2ogu51Knnahg1PP7yJ7UnW24STgl3k0M+bzM09LSDd2ZOicEH2bhhj
         4a9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ETqG1il4N8mKp1ES7UIxjJSG7R/8D8mHYo98MJ4c86E=;
        fh=ZLqlbf0QTvXSPKHWI6MerTKdKS2WWgLvkNTZWPbYEDo=;
        b=hNmPBtIdzMJhjc/ydpfJUP8CNbpZ+Ka/UEDCgaWy/CRdoIzuRp5u23RJDCSojGBh5l
         EbKpQbs4nqtPFhGEa2ZIG3pe2j78SaAi+t6eIHombf9CmgEVmpFwDmLbDBEE0ShJSUXV
         ODG/gxF6ICj0M2VY0C6tiz5OXHbBE5AeaB4eS0RBo62glDP//MJbJuwCtxrcp+KO14Yn
         P3xsoY21/rKvl1c2KTKoH7v1VFGgqWR4sxjfsfLS2VRq7GmgLLyQPFneSaTQfK0T18ok
         3JYEvHdmCSfO9I7iG2h9jIVm72miOjAI4QYl8x4YhufyKZiJGnaED65oHporcJ01tIIG
         7dog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793674798; x=1794279598; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ETqG1il4N8mKp1ES7UIxjJSG7R/8D8mHYo98MJ4c86E=;
        b=xaMBHAtcgObBuntoHugcBxOLoUrHT2YIGTntbFYY02LjeRx696VZdOCXQJc7RUlHGQ
         WicxPxCoIQt8eO2DyQwNKvexJveUUxNzN6gasKaLm0EtSkMWigSBdxDhZUKv6XcpUM5K
         Y93t+DNvYnLqzloo9M7jUJebky4EjyYaJXhv4OqDnNG4iEfmOQ0kRn0vjbFyiyMltRf+
         6qOEG63pEBR/Z1FVPqHbDteIytOeTLXaVm2Dy2gKHGjA04yf624+iCE8iz2WPzamhE48
         SqDztXrglog9gIw7p1baheGW9fXAcHTAnldQ73PMfzY7n+MUh/AOI6KnmoZrsqXryyWX
         PYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674798; x=1794279598;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ETqG1il4N8mKp1ES7UIxjJSG7R/8D8mHYo98MJ4c86E=;
        b=gUq0uL9puP5sTNGNuUyzHDbw67rHk5gs3VnbbdyOtbhwR8tdflElEF+utrOzlAH7a9
         atOiyz+8+dk6zgVHZf/Cr3UTvkTwnJnGDkokx4akDiEZgGsbzqs+tBWakh5HuDlt1Lh6
         2CE/yaNkrz5fkaYl+g7XxZno0100xiuY+X2hE/yKv5s09YdAb9u1K9XX7ZErWLNq8Kxj
         Ys9+dyyfZ9cP6HfoeISHYTyLzgUy9uoZ8L6Eb5xnPttIr0IOckFFyrEisfxXXi23O7Bu
         EftYm2JYxGeAQArv7JHVBktHV7FYXa5Z62dJd+1cHHSVRfSoOV7xZGtJXu6J1v76QfBZ
         qlMQ==
X-Forwarded-Encrypted: i=1; AKwUvBzzmhcAPOB+Ce4r9SD/TbxpMM0imjiQ6GPtxD+5MhDvGVnMGNopMyX5jGQ+uMXz0jJ19HkJEyeWe8o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NS72jlCGYmfJmptC3FndSQ5VuNbQouniHU8JUK16npJBhxll1
	HRbFJgkgy2Z7RSZ1/qAuvMmmLXVTJiT+JAESflkh3YYIzpHVq8dV898y2JQ8nTyAqzYbMRLpsqE
	w4PMfd84/6h5LH6cvnXFDnCiy8ZPnokw=
X-Gm-Gg: AYBFou1T72CWDaIKs0dvyiJVBuPO0aBU4gj92oS7S6UWj3P1ZjSWswg/LZSSXjINyNi
	FmR8wCLKh7PI0gncQIqjQ9/XZpXXIjzVLq66eox7PVCBVEm2xmJBjVUq53hES0rZab08qmEIPo8
	NCKYUFbK8S2wfU9sW01vwp1vtkZyOdghJcWcLR9IoG9IuIN+BU4KQYp3oNEZ/ZKLpkCFYLGAcS/
	NPE2TG7Dnbf67U+fDFFVu0pyhFri82VU0qArYGabGGlR5m1COaAh4zoEY/yvBwaO7ihv0TxhixV
	bbWZHHT3Hxr4afd0Es7IF2caUYAsijRBjZh5Ex6WOtsmASTjPzbc1ziE5kjEAACwZgtBeBNH13S
	NppM40UdeWkAR7YkD/f0YyGiN6jRiNqJ9efLrhV4=
X-Received: by 2002:a05:651c:890:b0:3ac:4f4c:8da2 with SMTP id
 38308e7fff4ca-3aca5812ademr34312701fa.17.1793674797546; Mon, 02 Nov 2026
 18:59:57 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016154819.17936-1-muchamadcoirulanwar@gmail.com>
 <179260197668.3127.18219777718091081046@linux.dev> <CAO26r3QK+Q5=JR5TeMzEX-WiLpgYWd8Zn0O1qx11LxTgN96BPg@mail.gmail.com>
 <179286358623.55649.5397316745104390556@linux.dev> <CAO26r3Qk3bEUwL1=MyHP6hu_YQNSN-uD_2-ceA0KtK=ejxLf2g@mail.gmail.com>
In-Reply-To: <CAO26r3Qk3bEUwL1=MyHP6hu_YQNSN-uD_2-ceA0KtK=ejxLf2g@mail.gmail.com>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Tue, 3 Nov 2026 09:59:46 +0700
X-Gm-Features: AclHuK89EtRkVz-OsObyYnxQUnt0Uu1dpICeA0ah4MC2QsH7LZxgTCAmcbRUiEw
Message-ID: <CAO26r3RofEz-YCnaUfTTb+7phdEzUqG5iwVObuho_EgW5Ep44Q@mail.gmail.com>
Subject: Re: [RFC PATCH v6 0/4] iio: position: add Rust driver for ams AS5600
To: Igor Korotin <igor.korotin@linux.dev>
Cc: Danilo Krummrich <dakr@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Mark Brown <broonie@kernel.org>, Brandon StJohn <branstj@gmail.com>, linux-iio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Igor,

I've tested your changes on an AS5600 connected to a BeagleBone Black
over I2C2. Everything works. I'll put the details in the v7 cover
letter.

One thing I forgot to ask before, the registration rework in the IIO
abstraction and the driver is your code. Are you fine with me adding

  Co-developed-by: Igor Korotin <igor.korotin@linux.dev>
  Signed-off-by: Igor Korotin <igor.korotin@linux.dev>

to patches 3 and 4 in v7? I don't want to add your Signed-off-by without
asking.

I will send v7 shortly.

Thanks,
Coirul
