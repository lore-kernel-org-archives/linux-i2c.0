Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC83428464
	for <linux-i2c@vger.kernel.org>; Tue,  4 Aug 2026 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785829870; cv=none; b=rga2Two4aB7mQKbeAiF6lMGeOf0P7xPCh6N9q1iaUK9AOKuxWTSA9Y5NlPPAr0AqCIXONwzJcYuzhBUymokoXgk35Z0w/ScIYNoHtFlak/G74vPKdzxVQF3fp3o/Qs4gJG0NDZvLhp7UYtRUcUy+JKGKLJ1zdoSRwEHL4ZH6PPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785829870; c=relaxed/simple;
	bh=UeaaGkfj+CmXQK3D7/sp1H2v+3bv6fIBMs0uAbi+VxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNnvbNwoYa0ZdSgz/Bis6GETQPaUO5NnK+zVokKCARC3siCEb9KFGmOqWTsdKRfHLlwno2sFA5xput0BCr8v0hNRCkwsVPJPE3JWmpcNHJsNwYVEcVSS8x/m/jJoqt5o4sLpCVndDLGQsiSyhXFxKlWPlwshbB/fCOgR0XUJi9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lh//8K/B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lh//8K/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA481F0155D
	for <linux-i2c@vger.kernel.org>; Tue,  4 Aug 2026 07:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785829868;
	bh=UeaaGkfj+CmXQK3D7/sp1H2v+3bv6fIBMs0uAbi+VxE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Lh//8K/BjNLfqPOULpksK3++stnAXFzDO7EQjE7RTS72eRu03/yiUQxcZSuM+L5np
	 2PKIOyi37oW7GwEbPksUNbxSo142sphFkeF4sJQ1ori5DYjV9Pwmr0baYlAYiSHLPb
	 eh1O0GhAMkgXyM37ZPWKVVmOe1ehK9H9TiSyBO5MntPmbqhkY1/Z58FKTvjoyb1hIQ
	 VJU7ZAnZT3orLOwpdldiLYNuyZximnx/qx/wcY4RCithAZ67jozuXoDr3RiJruvih5
	 39i1vgGKDKngp41aQZBCvccOATqvJWuK5911lTscvbF0OnTEza5c/+F0nqMXTDmJY2
	 61T2CXr6Cke5w==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeb24c0807so2967605e87.0
        for <linux-i2c@vger.kernel.org>; Tue, 04 Aug 2026 00:51:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrSJu9Y0EG4U6Hg6AHPJjG5gqP9cnciplWJTVPIiQCSsHF4+Z/1UkAxnZkgwY79D6Ys1oeIcXF1LLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwppGoPiLJiu8+7SmHp9Tkveb2EiO4BPckl/7G01WBAJx7XOQLP
	X64rzRKjX72hD5XeHJonILePYa7r12UOkqn/XVzwH0LD05EQ5LTcJYiI6i1Xw2PrOQMalBc10Ml
	g00fLVzRq9ntE811p6mvxS3keVsFtWAE=
X-Received: by 2002:a05:6512:10d5:b0:5b2:9c9d:6448 with SMTP id
 2adb3069b0e04-5b2e4f11a0fmr2873674e87.12.1785829867354; Tue, 04 Aug 2026
 00:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801-apple-m4-initial-devicetrees-v2-0-5cb07cc275da@cyberchaos.dev>
 <20260801-apple-m4-initial-devicetrees-v2-5-5cb07cc275da@cyberchaos.dev>
In-Reply-To: <20260801-apple-m4-initial-devicetrees-v2-5-5cb07cc275da@cyberchaos.dev>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 4 Aug 2026 09:50:54 +0200
X-Gmail-Original-Message-ID: <CAD++jLkkvrHR9nqO3gTiyU0s=q2-7mr3FY_07JAG4sFyuCENQA@mail.gmail.com>
X-Gm-Features: AUfX_mxbSJUYZ_-VvnAPg1iAT8y_V2wQkeDasemCN2JDNhyPEfoJfdRT5MtVKyg
Message-ID: <CAD++jLkkvrHR9nqO3gTiyU0s=q2-7mr3FY_07JAG4sFyuCENQA@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] dt-bindings: pinctrl: apple,pinctrl: Add t8132 compatible
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Hector Martin <marcan@marcan.st>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Sasha Finkelstein <k@chaosmail.tech>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 11:41=E2=80=AFPM Yureka Lilian <yureka@cyberchaos.de=
v> wrote:

> The pin controller on the Apple silicon t8132 (M4) SoC is compatible
> with t8103. Add "apple,t8132-pinctrl" as SoC specific compatible under
> "apple,t8103-pinctrl".
>
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
