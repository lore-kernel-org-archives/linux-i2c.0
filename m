Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7854347A0BE
	for <linux-i2c@vger.kernel.org>; Mon, 12 Oct 2026 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837185; cv=none; b=fKpfi4XcbFuDy70t9YbNrixYHk5dZ3xxrAASDEHyH9pq5MVXbiSt/47dRjyWYQTuCtIIGJorucrqFrbQdLTL3x174qk0ayIcdYjqJDiSBqfQg1GXMUqeZkVe3lWQVHgZFbycxNQMNRVM1XFUbLtH6JmOFcseI0Ya4uMaZY0No/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837185; c=relaxed/simple;
	bh=3dDzxAe3v4K6bmvY5Sku2I2OCIIKOOmdO2oWSS/8r5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnFk8JHKcf0RUzCuE3Q/L5bOGuOZ4F2uKhuLFqrgiTLxY94uKoudvNDf/nVBmobjF8y3qn6CWwPjMvTiRGJKYHGRBBqdRjiVpoWn8vJ654ysRQZgH4IjYhA9pielz1n6bR1r/zX4E1ahsuzyf4DyKvuP3nxDl6JLzC1HoVg1H5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=C2J23s9U; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="C2J23s9U"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c4d870d54so1321631f8f.2
        for <linux-i2c@vger.kernel.org>; Mon, 12 Oct 2026 13:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791837182; x=1792441982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3dDzxAe3v4K6bmvY5Sku2I2OCIIKOOmdO2oWSS/8r5Q=;
        b=C2J23s9UubyCJcxmDzteye4q+6hArWUjeY0by9D4HK7rJ4tJ/yjt80Sn3eH2Y8Mugf
         C+0VLmpl8CluoBNrRVGZgQ+9RyJ2KUX+4CzGVPjYQ64se1W7VwXcF/mA9f1TwZFIllat
         uk2BrLSFFGedsU9cHS4U77FDx1AkQ4r1HA+wXXjWVWUHNb+kFiGaz3gsQiVCpELiipin
         GbETdX2vsCCOn4yAfFBvh6A3V8yfWpasbWNCNTQ8uRZR1xKJQ1fsoYBoigTPR7ov1AqD
         eZ7JIvALkWE86DjAepB7yvbJEOgRpvPFOdrpdXAMdD8BRGqKJQkQ9qYR3Bxrxnqlpt69
         RpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791837182; x=1792441982;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3dDzxAe3v4K6bmvY5Sku2I2OCIIKOOmdO2oWSS/8r5Q=;
        b=yPj3XnG6oIrywOjBuU32mHotWCv6oT8f/B3Cd6Fy6M6da/8P/Q8aqjue1Rrb9wrzWn
         P/i/H9uobvU5Am4APhTrWaBcSCHxRYU4Hic0Dqc0a6DENuDPYiuNdAsQnYP2ETUqsKlx
         B1D0Q6p6mn5ebqZqwD6OGOrtbFng4IheqPhz9M16yIRugGoG4pvK3/OlFNXigH/ablAn
         /MwU3+8wNRwh0BecZgwdB0xUqYjrd2EJXo+GA4k2HtR9B+zO9Vbj+ESJf9jN0h5GMVGT
         MmSaebcp3Y8dY0UN5qmyaft2c8Ar94TAMuUIeri/rrMpkGQbampOEmq1eVAQQd4B4qAs
         1HtA==
X-Forwarded-Encrypted: i=1; AKwUvBxRT/bjClKD3SY1M1jboVIrubZjYg/X5+5kX+chZEEZbDaneZAb5Rg/6/WwSo+fOmcHFqfv8/3Y+fU=@vger.kernel.org
X-Gm-Message-State: AFq9FYImDcwJ316hj+HfzMKPlrIWYRkbkcvoTEf9BjkIqhwSiYYyNOhy
	kgx7Bii6RrIZISoqpO8Mr9zqszTrLNCYywvhI5Ayzp719bF4dl/T1Ae3lwxg6l8ohII=
X-Gm-Gg: AYBFou2+pyZgXXjb896IH5VOsbUlDBalrdZStfcenGR7zJs8ctEro5c1am4K5Bo5Llk
	lUgK5tkSwxyzci09BuOYWdVfbvx8/nxuifzeJfALGDScj56MIRJ+4AFV5Y+qrL6qf6FNXPNe9Db
	FgKe160XMpX7NZy2PEX2D7MrPgYe4wrbwETKAR2+Ze1/Un/BF7jeNhdOna/a6opSuP5dzF/dMVc
	jOSbnw/KNMm33xsIyPvFgKmUj26e//c6cy/Loc0XC6W1cWBHBf5gQHtATBeXQ6y9TmGrgz3ykgp
	zDcIJtNYJv1TDJhSYCcPcVEMZ2BYOruaRB21wfPQtm2Uoz89ms+SjA/rplpO+9dYpWQbO+58jpr
	xhgkgRp0H1461sANihTUPZWEyU3mtA4b1m/RNlvI5Ria/1U3ZK//GzSZyAKP4MdxOd38Dxx6twQ
	7I9OIM2ucpfKeA2NL/7vr3QpXaDa2JXZ2TIoXIHM2+sG+zqVEp7znnocXvUlnHUCslkb6SowgsS
	14=
X-Received: by 2002:a05:6000:2610:b0:48b:60a:760c with SMTP id ffacd0b85a97d-48dbacdbca4mr19746116f8f.31.1791837181259;
        Mon, 12 Oct 2026 13:33:01 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48de0967bf5sm1211973f8f.5.2026.10.12.13.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 13:33:00 -0700 (PDT)
Date: Mon, 12 Oct 2026 22:32:58 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fil Dunsky <filipp.dunsky@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 04/11] gpio: Add Cortina Systems CS75xx GPIO driver
Message-ID: <as1Dl08DwxOu-boF@monoceros>
References: <20261012-b4-cs75xx-s2-v1-0-8a7641b7b79c@gmail.com>
 <20261012-b4-cs75xx-s2-v1-4-8a7641b7b79c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rf3tmjyx6r53tpru"
Content-Disposition: inline
In-Reply-To: <20261012-b4-cs75xx-s2-v1-4-8a7641b7b79c@gmail.com>


--rf3tmjyx6r53tpru
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 04/11] gpio: Add Cortina Systems CS75xx GPIO driver
MIME-Version: 1.0

Hello,

On Mon, Oct 12, 2026 at 08:32:59PM +0300, Fil Dunsky wrote:
> +#include <linux/mod_devicetable.h>

Please don't include this file. It contains a plethora of defines for
subsystems not in use here.

> [...]
> +#include <linux/platform_device.h>

You can rely on <linux/platform_device.h> to yield definitions for
of_device_id and so drop <linux/mod_devicetable.h> without a
replacement.

The same applies to patches 6 and 7.

Best regards
Uwe

--rf3tmjyx6r53tpru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrNQ/cACgkQj4D7WH0S
/k6KYQgAgMQZQqqATk7u8/7+zLh1eyfjz96I/KQyBnZbLC753ncNp95vppbzeXYB
/6Xnb+1PMj4yifoVS9rR2GPW2P4F2cVCiv4ys86vtgjDRRS9qfpvIqAGD5bdkjpR
AfIu4ZintCl+3dtuqg2yWsp/Njn0OkGzE115dAhtJMsZGrpiAbpkStIsB8lUqPSl
H5jFp9iVNDnb+9rZe0ckSQeZwDR5JuTFUJq72G71eY2jfDyzjH02v8EejbZDDjqp
vF/L57mOl847cYmA78hOqMnQrXpBaqqNs+uY6m8YLPt5Jgq+OkWhvGGit0ts5Mlt
rdJZC0MMQbclAkv16e9nS/twKH5mPQ==
=4pay
-----END PGP SIGNATURE-----

--rf3tmjyx6r53tpru--
