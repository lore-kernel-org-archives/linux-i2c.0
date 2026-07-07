Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7020379991
	for <linux-i2c@vger.kernel.org>; Tue,  7 Jul 2026 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453397; cv=pass; b=JFJS0PkGpRnn3wmVoFqX3XHuMW0Yc+vkasGGjsnagjlPBhRQ8i5iqKvfzW7nBHbUf4bIVUyrsfVvqNeU0k6qw08FQ2s410DsaiTqhcQqdRkV6H9dfl6sVFX8xY/0KdDi70EAbqaxv/X+mDAHmKCe8h66ZY9MDdksaAYCNtGVYgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453397; c=relaxed/simple;
	bh=QfT1yL0KZE9kc3QIXQAHQN2bdjQ2tBY3krHPlSith7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OyEA+DgCcghCr9P79PTN+D93gRFQps5iIiePrkKcA6B4H5wpycq7vC/lHKxONt+jp7bVSU1s4u89iDTs+AJOD+HB6gmr69iLHDmziTL8B8iLjN3n7g5XFP/nC4Efdui+Na30W0w1od5f+VpCYTgX3s+9NSUS962o+cSCPMFdNKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=oJ0B5Zbr; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oJ0B5Zbr"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso6192325a91.1
        for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 12:43:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783453395; cv=none;
        d=google.com; s=arc-20260327;
        b=ACrxoao/3HM4h1uiBJdR+XYvybGybJkg4ICa33y+imHGyp/V+if46lhJmKw3ht/WQl
         6TX402kMuvphCttT4qjxLSIs3H9jAE+KUd5X5rII03ru4fa7FN/lxzzIo57aEbn3arsB
         WGp2ztp/+T5CpyHpA1sYnpYeSK2iuM3pPhYiXuDV5xxJS+IIaJaCC60yckZt52zH/Fvk
         jxYzzvyH4Eun6ebnyiLt4VM0010rqYPZVRRWLxMu3Gjwy9Rt34NsrgPrV454qp91KUSn
         874wgJun+u/qSk3Hb7UxcPbIpRdXUjEZanOgIhZbubGBHuUq6pH7t6Sk7Dc50dCaCZmZ
         0OLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QfT1yL0KZE9kc3QIXQAHQN2bdjQ2tBY3krHPlSith7k=;
        fh=Q61QgYl6yfdRd6NCgcbX934bVisGkunjdW28HJ44xTU=;
        b=C2RN8U2aAoIn/ffEDkRi6GKI0BUHg2MrS7OsrOtfBScQ8Je3FQn+iiU0iAeqiVqYtD
         qcmTtqUPQKfEWp8G9LcKEQQTvRY3AST3Qxf34T02yqk82yfmGc/x+cCC87H4rHThCpag
         ABvX8b8PKWNbxXpveH10W65UN78wNg7XICQnYY4m/EoncPD5arh/GVZMARotkTBVWp+X
         pODnd0zaSMAei42kkTXhw/mbbesWfd76F4+aLLUpGfpVOSP0kVQ6rn/KLsPVHbdb82e4
         Nj+TM75G6XMkIaRNjsOMvHdrqQTgZ6LVt71gnoaIclR6+KF5CO3MyebmZmGSXA3Vv6w8
         9qnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1783453395; x=1784058195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QfT1yL0KZE9kc3QIXQAHQN2bdjQ2tBY3krHPlSith7k=;
        b=oJ0B5Zbre6HTT3jrkz0hMxuvszMlU63D2dvVJ2nCJQdJ3SVYK6M/ulhU2/cVj+q7Lq
         ytwtfaPsV/tvSD3kW9iH/kNmENeLEr9e7wBa1/D02dArtChwOQbbcnX9DpZlipM3JSg+
         ihsI9nUyb9X5AXsVSX9zCQQwLMBvT5hnUp19dtng5omY4FeF3/+xYRW2Qat8/XTIeYkb
         ab7F7pyqLSMTyPbfE+8Qicxys/NRw/OpM42t1zwrLZWxu9hJ/+6bgDoEXQcZDd9f6EiE
         SetiSVfHtAsl0wPRXdzYtX0kYE+P3FbCpseZ4p153m+bHYvESuVkwWSciyBh78/OSwOO
         9j3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783453395; x=1784058195;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QfT1yL0KZE9kc3QIXQAHQN2bdjQ2tBY3krHPlSith7k=;
        b=mqAxZaCwGMuIK6vHbHoKkv/hIyXw6ZuLPl4ZLT0qSwVYPa2dtLdH2rn+fxu7Uhjgq4
         RuBW3Z3rG3r81EvJoJPaUaSqv4o7+KNnTWGqIjl629uisC7R4u8YAlg/8X7o6WhDAgw0
         XGW8klb3NH5Sb2aDuLgRUiPnPbnTw8j6ikheyDS4iA9L7/REYurn28OI6IWeta9leV5N
         qW6HlHB6X58++wQjm0JR66KNmI6lFB90NL3OXPZOX26YSvtl939gnD644fFEpQeRViqU
         NQdMg4QjlYjm8Gz52CcFpgEIk6v0Y874dkvZPvwFfKDlihsHjxJByLSI2aPB3wyQ/I74
         4Jtg==
X-Forwarded-Encrypted: i=1; AHgh+RrUPS+Z8v2y2ssKDq2wGe852ooupI7X7We4I+oVZpcl2HwM3c2nc/fKj/X+E3kTIbqWZmgcekdxgdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEucDt8USH+GNuEKW3ZTiumnaGkmunnuBHHsmP0jfb1xZYprD9
	tAY6UhOfscqVC+wvKOYHCK3k2iPfWXu7RU6cJ8SkuWFJ60jfxhPu4JWPvLT/6VWCpdFbcyD+RWS
	B6Dk3fsRVkvlNa2a924q3/OB+8+j+K6c=
X-Gm-Gg: AfdE7cmNB6wpHoMYiaa9LwcJ4Wqilx7sif01lutBymjqv3R/+oAz53TAKiHXEbaWLYA
	EBCFI91JrAWNWsAHOOq7hChznht5TAMfA19tAp5QXZ1fI5gFUVHODoGsCyxQ1OHmnbW4JJVOyYH
	l6kI6NbsAvzzqugUa39RBVay7kWYZe0LdWbpknoK8aBqXiAYTmMJfudHFeG2zoCTrcBqD42MEYH
	II1MJFQlBBW50cTCVkJIQ/ZBpgmEuSwg+LftuvMdOxcon4sRKXHbwRUfEcB8qLXtijupLHnfy+o
	MTAfnHtyMrog0oqKrGB7LUfxyg==
X-Received: by 2002:a17:90b:538e:b0:381:792d:f993 with SMTP id
 98e67ed59e1d1-387581641f9mr6285677a91.17.1783453395185; Tue, 07 Jul 2026
 12:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr> <20260702-add-mcu-fan-khadas-vim4-v8-7-244feee91a36@aliel.fr>
In-Reply-To: <20260702-add-mcu-fan-khadas-vim4-v8-7-244feee91a36@aliel.fr>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 7 Jul 2026 21:43:03 +0200
X-Gm-Features: AVVi8Cedwny1fGm0XunQLag-buYK9YXt9UTwEp4HfqUu3ncRpwQYM0HDkqsD-q4
Message-ID: <CAFBinCAejsnBhUy6TZwjgNzuVp8Pa-vTB88NBgzNVcDSAyyenw@mail.gmail.com>
Subject: Re: [PATCH v8 7/8] arm64: dts: amlogic: t7: Add i2c controller node
To: linux-kernel-dev@aliel.fr
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Beniamino Galvani <b.galvani@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 11:57=E2=80=AFAM Ronald Claveau via B4 Relay
<devnull+linux-kernel-dev.aliel.fr@kernel.org> wrote:
>
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>
> Add the T7 i2c controller node used by the Khadas VIM4
> for MCU communication.
>
> Use amlogic,meson-axg-i2c as fallback compatible.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
