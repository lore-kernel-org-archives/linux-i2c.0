Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638905;
	b=GEAK2tV5uNbkEmUIajnxGY/oUjbVuTRXMU76Du7bkrNT61BBbmluJTeTh3CnmrYMPW59
	 +mFwYg+NFSggvBbmSAXn0T18/nDCcJvYcD8cLVMXt3kyc/p6lpVobKCNXwJeCg1KgxZ3L
	 tKIeEtaeGRHplM/6ngpCCa332DiX4PDk3v5W9ueZCLyJ5CDqNgSZGepbAxS75FYO30hQK
	 RUH/Gzzbx6hbwVdkGpgNzNuyAfLzCoPUarThub9QYVoqkrs0DUPrIPvS5FzGTVAAVc/5C
	 lfDWTtw3PlZCn6w22Y4WLSI5jus75MDZKyi9OJunc30rGxU/5hZ+6jekPoU0iR8uqHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=//2dH0tf9WsNJ1T/56d2QvgVSnUsRCYl2PIU9XEdbPI=;
	b=uZew19XLLxx4a/Txc+wLXqg0bjLRtinSqLN9WTQCVJWtf1Q4Oy2gb7qhRT253C8XZ5Pu
	 G8wdnpJ+xaqUmzHYtFtuS37u2PMTabjyfv067aJWC0BUK1Uw3HY8pXn0bU+7R5566X3vD
	 ie0mkfRzY+roJ5RB9nHuh0S2lGrt52bIbwKk9eIG+zUprPd/YdamqKl7OWM2iBlK65kfV
	 IoR2JcamoAL3FpFM66febOFk39ygp2FbdOKkr+AnPVR6v/d+2H7RZ8l+D3HWWxbgiM3Yy
	 rCYRHmpjDdiaW9v+IcXqZPDbp3EnsZ8v0axkSuUdHvC3qvFTbDGexysHL0loRBwA0kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n0M4GQdk;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F1606F22D
	for <linux-i2c@vger.kernel.org>; Mon,  2 Nov 2026 17:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C6F1606F22D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n0M4GQdk
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a214af2076so24987105e9.0
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 09:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638904; x=1794243704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=//2dH0tf9WsNJ1T/56d2QvgVSnUsRCYl2PIU9XEdbPI=;
        b=n0M4GQdk28w4KtKpcrsogDAta86YM5Wp928CKaOwOkxmtfRhJtNe4E360NEhiHoyEX
         t9fm8FwNtQEjXWDUqvu5aY0R2jxNWL65fDnRJ/95QLOM5Q8Ex+MK1kDVasCVgkKss2rA
         AceNYF2yTnDaTVyQanJ7fvrCnAIp5EGxC8bBgchj54TTXcQ97ErKJHsFfIhwWR7zcYZP
         mpiW28w8zrQjfmsC6OT89zUFDrpt0QfDLL83o1EzOqrQLjvTmNs2XJzLSG/e106a8jqG
         AftueCoUUSyUxnqiGHKNqvOxHwuG3gws4V+2XmOXo44oDOoYeZQwYGYSRfG/0Yzu3tmU
         SHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638904; x=1794243704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=//2dH0tf9WsNJ1T/56d2QvgVSnUsRCYl2PIU9XEdbPI=;
        b=2U/EBwH1k0XrbYCijNe0+Ny3jDiPdE2OHzHKcaKV/XuivoBGbb632ILeQ4pD0zJc2o
         Gzs/do7gKPqAJJtYjiDhXbZIPNMbgUCsZ/NBI/DpDJhnsNrmAs4oMDIeOr1eB7GHon7S
         AyYS8S5CrNIYMEtliQcYaj17PfneXv5sY+GRymqloWI8yV8y4kVa/r8upyNBSee9ZItU
         ClXCiDo4lws7SjqGdh+0QemcCFNmwtlgAPNu3WisU5EStM+tKBEyN5FKVwwGDKvay/Gh
         qYc+/eR58/LvxcLRNGcdNgpOee1s3Orw11jiZN9i6RV7+ckdWQBQrvwNy1Ahkj4Z4YKe
         QPwQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1B6N5mFXvgBGsv+Mh9cV2EZobML/LwPzVMqw4Q+dCHxiW2MB+luWkWtmZTEkMYDA6Gd7rtWWqBU0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvEzLmmZvqcB0l1e1HEewAsRABSBFnn1b7jUzZWwVqPultSBol
	5RRPucAKUDtsCvyDbwNhXwQnE6pzEl8VtgIYussR3oUfvySQ/gornMna
X-Gm-Gg: AYBFou2NMAcKpX1Qn/Btoy15V6JcUFr4gerUrHUkN5qowzsWSlA5Cp1vsbduMaoWbQ8
	HIhAZor7e2iGsWer6qNvJ0a07BregMeR9tRmYWNZxnRU05s3pDWIs4EhsNKQfGA2p5jbliz4BKV
	ub9b4u1MLILXe1qnItgefiAzP6pub88N7sDqu9bCum/CUm6Rt+gjOlvKEWC0lEKOVQu5+rgurpD
	W6oDPkZUvbrh5JzW5TpAehULdX58q0/uT3lCVjT01yBTIRRhYpDsiLPPKUSfwLnWBS/66xib61/
	wPC5rkPq9qlZeK0PYKABRwfGRp07R7fC423D5HqNMZW/u/uyJU9TMJZjrMBXPnDgj5ZxQ/B9zBV
	inu5xvieNVsxVEX2DprNh14MKyIf9RuUxDldNXHwv13f0bzrucy3TmZ3Yhy9I1HGlU6l6Ryj3mS
	yQ0ljOvcSKEN19e5pJOCs1gIi5kNwMdBRCKyyujXeJDJDreDQIE6/GtlyIu99C3YE19GuErEfCP
	cKQJsHDiO8XRbmGBwn1EyvFb0ym+x0mlBbDLGqymudWmEyZjwhS08z4fLTMBK8360dGkJgZvBiu
	bDePkZ3zZw/aMy865UroWULXcy6qkOhqIlgu9V2wbAS5GgCdM5yQ6STePt4Afr0kHLwKHNmwyND
	/SIlHib2agFpYETJ7RObh3tO+/02dSc1VaAFuSJmpUu4AtWrG3KeKDy+ctxbaSzlOBFxNYRjEUw
	xL/idPOW7XaEvri9LJ2ASCBUeJPiRDfkYuRocsjxUeq/qBRRFAQ5pdwBR+dLmuaT2zG3KIJKoC5
	A==
X-Received: by 2002:a05:600c:314a:b0:4a2:fd2:985d with SMTP id 5b1f17b1804b1-4ac1775316amr237285955e9.12.1793638903629;
        Mon, 02 Nov 2026 09:01:43 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-0499-f85d-af98-1439.ipv6.o2.cz. [2a00:1028:8388:a84e:499:f85d:af98:1439])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a5372d8bsm1215295e9.0.2026.11.02.09.01.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 09:01:43 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Thorsten Blum <blum@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marius Dinu <m95d@psihoexpert.ro>
Subject: Re: [PATCH] crypto: atmel-i2c - find the bus speed behind an I2C mux
Date: Mon,  2 Nov 2026 18:01:41 +0100
Message-ID: <20261102170141.54660-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <auieEHLkx76881ZL@solitude>
References: <auieEHLkx76881ZL@solitude>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Marek,

thanks for the ack and the warning.

The hwrng core starts a fill thread for the current RNG, whatever its
quality. It reads 32 bytes every 60 seconds, even when idle.
atmel_i2c_send_receive() puts the ATSHA204A to sleep after each
command. That means about 1440 seed updates per day, and 100k cycles
in about 70 days.

The ATSHA204A becomes the current RNG when the MCU firmware has no
TRNG. It also stays current when it registers first, because both RNGs
have quality 1024. Today the probe fails on the Omnia, so it is safe.
This patch could wear out its EEPROM within months. It is also marked
for stable.

The patch also lets the ATSHA204 on the Turris 1.x probe, as its I2C
controller has no clock-frequency either. There the talitos hwrng wins,
because the ATSHA204 has quality 1. Without talitos, the ATSHA204 would
wear out the same way.

Should we fix the wear before this patch goes in? Does "proper power
management" mean the idle command instead of sleep? I can look into
it.

Josef
