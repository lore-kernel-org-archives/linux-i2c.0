Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171659;
	b=mvpA83teifC9g1cBrHghmIOoz8rFe2pS7Vei5a0rSB6Jbc19zG3BOGOA0sYBGK+KDMLw
	 I956OHU/2UEyTWw8VJ9DEDieaKNAOaVbJlqe4jVm2DX4Q33wQabgP3iyRj9u1Aufg0lW8
	 jcIslkgKhN7NcpP9dgtRNX0BNa8ooU9UBIb9sRMNxkrAbrWtU5n60u8RQ/BVvvLhJQge4
	 7drIKfa58eEvdueCPx4swb8tVomz1UNMrFqvilJH1u+8Wl5floq0wpWnjcirIxcmllChD
	 k9eGjmeoHo08rWUpw5bc4GPmSecApE6fjFUEf239/tz9gAFaD03NI1wh3YstBoTVL0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=BKa12JHLTaIrkAY7wHaBaCVm5O2tQjU5ZN+Qd4lZVHk=;
	b=2FXyb1vIOWQPqVsUiSYCmzt8JWrh8J0l/E2Zs3ssgHcaTqIX41kvDXNImY3vp96ZFU7D
	 g6FLksby0acifBb+Wnecf/EPIgMRbG5f6UaE65PJ1ENn92IJwENvrsGVqYkf6aVSyK2i5
	 N+CeVyBuLhqGvPv0wvZ/eT7Sna6nt2fkvchVuaj0gkTvkqlcpfM8o000tvmAtIInE9Yjp
	 c6/VjnOzGFjDqHmJbPXAlvqvNA541jNvG2B29HzqFfjcqLEGDgr5CR1UCEJy6gSrFWt17
	 P4eU3czVQdezP1pAmSEDdq5ovkorJ9rL30UXhyZygNVctv/RonG8kdDnFExQhJppuzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DNo5vidD;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861BA606A321
	for <linux-i2c@vger.kernel.org>; Wed, 28 Oct 2026 07:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 861BA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DNo5vidD
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dee593f18so400806f8f.3
        for <linux-i2c@vger.kernel.org>; Wed, 28 Oct 2026 00:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793171657; x=1793776457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BKa12JHLTaIrkAY7wHaBaCVm5O2tQjU5ZN+Qd4lZVHk=;
        b=DNo5vidDAbaZyqt5DqOmh3lLhzHdSiDXFx9EpEXiGF5MxBHB80PQg6WPFPAu4m+3MQ
         G9uIzH2aNzbQXmQoY4eHF7uBgoZ9PnrPQ0C6WnniZ2JKW26vz195fWYBG0ylIyFc05LQ
         LaaM6Af+PKwaLf64NW/ZRalX92SvnOShO0UE2srbrHovIwi3VCioanRkbRZ3lUDeT61T
         5gFKraEKB1Qgi+bCL1dzaz9USpJW1jqR5rk2zwoPZ15oZpTF5JuPCslVlykXJcSbTkN/
         oCvLJ+lx6L46bR+wJ3TVoudqfgzZaI8xOc7/1tV4J3BiDlcfagt6qyJeB+wICmFIAIO0
         73dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793171657; x=1793776457;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BKa12JHLTaIrkAY7wHaBaCVm5O2tQjU5ZN+Qd4lZVHk=;
        b=txKCNFOIRlceNokYAzqEqvNg6lLqpibx7vT85ywwRaWhFWEzfGnf++/45Y0+lAYIfL
         CIosDWQQSdIAVTJGsLSJfqYcxxfVuWcLiLvZLWHk/nyTrEEQvRIXQJ589/YdXeAY/Mqn
         Fu9YaIM36f9nlq1y2zHDlTsIziDyLgM3RQJEnWKbA1hmNz0AzCjfMTsRvuLYlk/wtaly
         tGT4a2KoGYEtQw0vnJ+lZaLJSqIKqCtlBg9cnlzb9qF5IUq4V9v8VeS9veZqbS0a0mlq
         t7UjcAeFXOdc/dwrOOqVMkkVNr2YPVNHyVc/iEIs3zQqdBkxMQYFA01O5IAR4VN4mHmG
         qITQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2VXmBzM6A6NKaQw4xCQGVXHRjQ9hoSQXLgbBbKRPaiszM0QQqYpoF05dUsXAjDzg0N64xRvhjazw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0Us3/aYUNXovezXGtfEponTjISqL2Zbs4jHjres4yb+lo+kYC
	IgjQ3P4io5eJHPZLMS/+AnNMMEe/VOmyWRWSeOKq8H3BKYSnotWd9OG3jpgYu4Arq/rd3bs4w/w
	H+srD1bg=
X-Gm-Gg: AYBFou3EBBon6MkbJf/O9SgOH55jszwS2oObXAKHgtFLSpDSjH3XCRqFSuwmNO5585A
	Eevc4tOyAGS3TDj42j/EY7Ru/aAas/KxtY1xrZrAFHjaZ2opIjl/Kh/7wila9Ulcjrhym2SzFFl
	Rl1FtuvZP5NRCaPrd2xB5zNuQ7AYtLrdhJyl53NImkR4cYYRIJxmNnzFnjhP4q/duKloeBeRhb4
	5IBx9GokD2Jx3ozBDCN19FUgorJ8kxd/KdnuI85nkT2gV3R6LgZDaPoxaVoCa9UQJo7yQlWyJMx
	j94KKtAZTYYvbOR2QmDKtdUZ+S25MSrTxsGGsTy2JhrjHXhTkXJXjwmVU9qNxGn2Gn2a0kfO01y
	92Yugah20YYfJztjdwMej7/G2Ra7J0svxvB24II4XTS04VbF7SVVKbo2DDXdlE+w5iy6Y2cESkD
	2LTz9PfHOP/3UUJJQctFaNsNG5kaakcxwWfYXRA/cQ6UxPj9QlwzJb5CeWir2c8tqZIFSoBwiLR
	U7dxIMrKyG4bN1LzO7uBi+orz7Bo3/habIgSZ7JVRnXCn+d0XG88ByJmycTAL7/Lmj74O5K53Up
	MaLTfoh+i0y7yp13ung3jZxNkhEFaeqcun0+j1US4ZP5lk7aJRbQ0WYKIo5mCyNkbUnDymQZJHG
	ojREgFLWwXKSomsAmFS0yJNFxXLP+XsP20lfV
X-Received: by 2002:a5d:5d0c:0:b0:48e:4300:c70e with SMTP id ffacd0b85a97d-48e5d5ae171mr3363614f8f.46.1793171656743;
        Wed, 28 Oct 2026 00:14:16 -0700 (PDT)
Received: from localhost (p200300f65f19a904c16506b94501b867.dip0.t-ipconnect.de. [2003:f6:5f19:a904:c165:6b9:4501:b867])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48e3ebcb958sm26969844f8f.21.2026.10.28.00.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 00:14:15 -0700 (PDT)
Date: Wed, 28 Oct 2026 08:14:14 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Aniket Limaye <a-limaye@ti.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lianfeng.ouyang@starfivetech.com
Subject: Re: [PATCH v4 2/2] i2c: Add Synopsys Advanced I2C (DWC_i2c) driver
Message-ID: <auGgVBEHvowseCt0@monoceros>
References: <20261027-tda54-upstream-i2c-v4-0-ebeeaf87d181@ti.com>
 <20261027-tda54-upstream-i2c-v4-2-ebeeaf87d181@ti.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nb47bxu4r7dlod4p"
Content-Disposition: inline
In-Reply-To: <20261027-tda54-upstream-i2c-v4-2-ebeeaf87d181@ti.com>


--nb47bxu4r7dlod4p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 2/2] i2c: Add Synopsys Advanced I2C (DWC_i2c) driver
MIME-Version: 1.0

Hello,

On Tue, Oct 27, 2026 at 05:00:36PM +0530, Aniket Limaye wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/platform_device.h>

Please don't include <linux/mod_devicetable.h>.
<linux/platform_device.h> already gives you everything you'd expect from
<linux/mod_devicetable.h> without introducing a bunch of unneeded build
dependencies.

Best regards
Uwe

--nb47bxu4r7dlod4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrhoMIACgkQj4D7WH0S
/k7H8wgAnGAwJoL+e+Le96yU8hRX+LS1mxggdmfwSPFllT2XuqUDX0fD2CksmHRN
8v/0LTJOU6dCoaLDgXojtyhjWD6aQ9eIBohBG9Ednr/skIStvCz9/G5CZOvayK5p
Bz4o9cdfMzCYj7hMfRMEhckEaE7stpZsqAI6PyOLDlPN2VEsTTO2eNWqQQOST685
hoxWdnS1aI3LOPzUubb0vITD+l10XFzqGI5Bbq0KmjyRy7i/AOYXUCw5GVPiDQPm
Dwqtw53FNFvSZP0fhpGHmzAU7GydBWg1NbRITN6AqYzvI6ONc0k2u9fA8GEUqWf7
R51YEtnYj75xSueedmapu+p+CeOHHQ==
=1P7c
-----END PGP SIGNATURE-----

--nb47bxu4r7dlod4p--
