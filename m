Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06698284672
	for <linux-i2c@vger.kernel.org>; Thu, 12 Feb 2026 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904181; cv=none; b=sCiBOzYKr7iNyRtjt4mxj5JUiLX9zA9mRAYqvZfThBf3Fp5FCg5kUGszLkXgATEuU59afJClSMPmpm9zeVw5SRCT8kCrQ0J/DkzaYdzs9KQbUbe/2D4HF/ahG3k8H/sA+fZK5RpTrgunktvE25ets3XbWzrecotevdqriBfbCQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904181; c=relaxed/simple;
	bh=XoRTysmGOAbvFNIaBGY4BvJwXgLYDVmLc1+jYE2Zq+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIi1ckB+whCZBORK52rGnG7c3nBoaVNfv6jDobomHJLo5Egdhmc/9641IqPI5f7nfkcSp57heyomHzywiQFs4tITxf9A+H3sSacO2PvXw3U5Zkr3+X51AmmxaeMC4/E6E6cCx9blAPttdVkZFMiuTh7k31rIHB4HpzFXMua+Sa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMja6STh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMja6STh"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59e60b3ccdfso2206580e87.0
        for <linux-i2c@vger.kernel.org>; Thu, 12 Feb 2026 05:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770904177; x=1771508977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUxxqBz3jOTMwO/v0XklbtGC8c413o3aUlrwycDgd5k=;
        b=nMja6SThYr+RdMgsmfRgrYgLJDoPr+LJcwiHTIIvffABP9s0zOcAgDEWjyVBBo7gs2
         qJjyI6gK88cpeuDf5YTnU2ZYpumimNObeHKXnaSGf0cODqwugKdGp9h2b3Y1S1sH9sqJ
         R2quMsF6ONQKU4Ieir0RHYq9SHefRwWLN+kK8ozz7CvUKZauk4I7gKN7oL7BjEklHsT5
         w09rDSE6Yl/+HY0RuQcbO7bMNKdGeTzZViOUSfoKZHf4OQAWg8ikKYvjWKj9X4AIi6Nc
         5zKAoI3xarv7beftoK7i67CfQfNbmNhkRRmdlDRRX5ZFDqXVbvYAT+p41b58IGag4z+v
         K/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770904177; x=1771508977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUxxqBz3jOTMwO/v0XklbtGC8c413o3aUlrwycDgd5k=;
        b=tbOndxgYrkAhzBjiX0XKAyvJjVd1XhAuISnuGUhH8ZXkTAxwduisAoq458qY6Guis8
         bJ2WQ7qwLAGQfdcdsD1A+oVXgIT0Y7qsj/MU+F2hDLXbHn1X2ljQkpQMnILyXo7NE+qn
         FO6y3RAhoLCHSA6SxaYF9a+QFSneGbRRJ448+auhr4WAaypa5nF+/MQ/opcM/spzcV2f
         DeGc2JIiPscSVabtSDJd5qExsaSlMDdXgJG4TrX1B12fhw2vU4HZYBA5YXrKovAARPbW
         zJrsf1B+FYF0P1OZCg/dh6NRvn5yUPSjbAZ0i9L14RrWeD+86GlHuWa9nCGA9JaLHVnw
         4upg==
X-Gm-Message-State: AOJu0Yx4BDO3pnE+FJg8OUuTjALsLetUk7w9+Xqnl6P2/QNdWVKtnqsB
	Vyb3xmcFJrk2cGutNq4FAXzMAE712T/kGFqRV/ASIi+A74vgzX1fuWsM
X-Gm-Gg: AZuq6aIXLycnf35sX2XgDgabGAE2AtkKBspeUInzvJxf9mCiWsSh/M35tT/8ALlFy8g
	Omnu9RSBEtv8iXs83HN7GcmSXaGFPt9UmJUwvLajraGdG9OF3MogsN1xti8qSLc82VVGDTHQWhL
	k5ED4DX5nop2l9ng/Yk8QKkOyW11bpe9kBmGy6kzS9rr5+mldXAn9SlougcuW7WVqOb/1835DOk
	pv23/AmJmGd8vTjqKUnlTccwqjuz8aOzEsD50YgTAyQa9W2Z2xXn1zIW176LKOZSg7teFyjROJk
	hs3ky/EOIWkhINUBj8KrWxWVr1nwckpM+869r5Mj9257JV7nvtSFdO7QkpE71CP4Hej5DoRmJIC
	E6KdFltbs0XK50mULfZM3fY1JUxiglEj+YejwQH2vsHGbZ9HvynIZWdktu8kEeUQ36//hI6+vND
	3nq7k3hWixxaMKQKFMYUlNvbcJuL73gQP8e9awqWsI+Baosh5zfXbk2p+Md6AP
X-Received: by 2002:a05:6512:2244:b0:59b:7c03:f2ec with SMTP id 2adb3069b0e04-59e64149398mr1135497e87.41.1770904176750;
        Thu, 12 Feb 2026 05:49:36 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f568d95sm961995e87.30.2026.02.12.05.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 05:49:35 -0800 (PST)
Date: Thu, 12 Feb 2026 14:49:34 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/5] I2C Mux per channel bus speed
Message-ID: <aY3aboaHYNPbXIbr@gmail.com>
References: <20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2rS0NZa0G0VvGsej"
Content-Disposition: inline
In-Reply-To: <20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com>


--2rS0NZa0G0VvGsej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 10:54:26AM +0100, Marcus Folkesson wrote:
> This was a RFC on how to implement a feature to have different bus
> speeds on different channels with an I2C multiplexer/switch.
> As no major complaints on the design came up during the review, I
> decided to submit the series without the RFC tag.
>=20
> The benefit with this feature is that you may group devices after
> the fastest bus speed they can handle.
> A real-world example is that you could have e.g. a display running @400kHz
> and a smart battery running @100kHz using the same I2C controller.
>=20
> There are many corner cases where this may cause a problem for some
> hardware topologies. I've tried to describe those I could think of
> in the documentation, see Patch #5.
>=20
> E.g. one risk is that if the mux driver does not disconnect channels
> when Idle, this may cause a higher frequency to "leak" through to
> devices that are supposed to run at lower bus speed.
> This is not only a "problem" for changing bus speed but could also be
> an issue for potential address conflicts.
>=20
> This patchset has been used and tested heavily the last months
> on a custom board based on a da850 (DaVinci) platform.
>=20
> The implementation is split up into several patches:
>=20
> Patch #1 Introduce a callback for the i2c controller to set bus speed
> Patch #2 Introduce functionality to adjust bus speed depending on mux
>          channel.
> Patch #3 Cleanup i2c-davinci driver a bit to prepare it for set_clk_freq
> Parch #4 Implement set_clk_freq for the i2c-davinci driver
> Parch #5 Update documentation with this feature
>=20
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Hi all,

A friently reminder to everyone out there who might be able to review this
patchset.

The patches has been tested and used for a long time on a custom board,
so I feel quite confident with the implementation.
It also should not affect existing code that not make use of the new
feature.
But it needs reviews.

Thank you in advance

Best regards,
Marcus Folkesson



--2rS0NZa0G0VvGsej
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmmN2mgACgkQiIBOb1ld
UjJyyA/8DQfVswJwLs4RPMdXzmUPcI98CHFFZ+0g2p3hplUpfq27qmT6pENvo0PF
vsx3QLtpxTWAdSTRwjRda6sW+11AVYLb4PxjJ6KKsAQH6EO6Yht+HwPhjh+2L2D5
fjsMk7DkVL4pHnJj64UP5bHr3MxyTVM/7olk7M7g3Gbj2Qge0IeKVNn/i/AvM1yl
jOAYKEcAFXX0ZofMaJ3L/irlGqV/NwfNWbOXt6ztY0XzK30EWU5CLbY43QBUCNUQ
8HbzbuoarlXoesg33sZnuoFl6rCJIkF4wow99ssbdLMQq/NSXlUdzn611kdBXgiy
ts7iESn/P/tQ45QyzyjksSssHHU9hN3U0NdAx4dRekcJIB0cP07t8wDXIByEK7ig
yRu43LdaGU8vGYyWh3salssI4aHyetyS/p00CWS4ww05X9IKVMNtIFDTm6Tt6ydL
OIi+ORTZjMifI+n5VSKEZZOZO9q7vhB1320W55FP/cPDkqGzKC1xOkXwl3OLyT1t
C32MkUJ3ywBKJZders6aGgjUHGmXr0flLCeYrZOHSDQoxIeTaPRU0TRh2DxMTBHb
dcAj0DpCVM8egl6P21MmLgqx2lHEBIwIpdJG/CipdnpRigDjTD++i/4g478KSuYE
tPU73QKRL3OWKwHIExyMQIn2SjjdySAOpakgzKXRd4jSdJPIjNA=
=d6VN
-----END PGP SIGNATURE-----

--2rS0NZa0G0VvGsej--
