Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6837D343D85
	for <linux-i2c@vger.kernel.org>; Thu,  6 Aug 2026 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018588; cv=none; b=kYrU0yIUK8dH+1d8RgQ8/khU1GC1QTKZV19NELYFRm8mKaEdBGZQMq5aQgESO3eir3eiy8hTzobHWIOylioqSlxxPveDRvrWWt3Nat2ID2gDVTK7Ewkod0WCjjzL+BODD0PxjOgTOIyZRvwBcujt38eZk7RLI4RkZ6thCaccjYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018588; c=relaxed/simple;
	bh=MfcI2RhcsTr0yzfFod4885W1pqBXaezKzSsvnaGWzuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKOZrPYtaeCNECNGafmfkpS5ymst3ArRbn1x7xAexf0BhE28VbS3rEsMZC13yaEpjeiTRbe/qccTT3yiDNNoQ/DtvOMmNOX8p55ToIEi/y3VS/wFNsXX0keSW5gZdDkS2OTnx1aRHxxgurgz1K3+jwRzaU/es7K4nNiPMEvJmhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5bfaf91daa2so509776e0c.0
        for <linux-i2c@vger.kernel.org>; Thu, 06 Aug 2026 05:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786018579; x=1786623379;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U36O9R4trTBcyOnxyg/ehmF6oGcafbI8ItUkmxAwOdM=;
        b=KMEXRugCRY5YKPh7E5Fa1HZABYPTSmsHdgjfFXssTsNCXjepzZsvXhnUzLRVfDHGf5
         7E0oaFAauzJjcZsLpHtlZCOW7TZrtguZyimUlDcanSJ9Rppe8FMciAHFDfBV6h+fSS/y
         hTWEfsn61d7TPeUHWTg0zBUsu27byU5AqIgkelUegSYelinvy3RkT6bsOOwwKjGY/iUP
         We99Gtu0y3DOvjrVNEJGoWfR2Kp4poPKN1inAAT+Bv8BmZCLy8c1q9fDxaD6CTrSx0M3
         sGui/8sGjQ1Pjw8zlYk3eQc0axxOugRpjWBB6TjrrU9t9XvMchTqi71BJpErBNtoEj2v
         cEIg==
X-Forwarded-Encrypted: i=1; AHgh+RoAd6QhFHHve5pKgesQ/EQ6DbmGVBz08aEPSrSqStwbt6alFcYMZCK40hAqkIwB8rR14/vZici1jBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfx5JFGBeX1KZ2MrUBTpmkgJu1On75ESnWZ0Sr0QOmP0Gt9Yeb
	677lhLf7OBWpRWEjY4k4ZQsohqdISmBnRF2Mfa+IjdAK1xJ9ep2pNMYuI2KPyUda
X-Gm-Gg: AR+sD11J1GCvO3Mb1GbDnO2dtdMw9aYV4O5emn4koFLPw3RW8X8HGVU0Fdgdfd11Jp3
	CzMNiKMUzMSfvl/+OUNgM9o6RCVBprfIrvOSZAjC7a1zC7CPZLH09T7OpP/vUqlWMq2iBIn/VdX
	EUdpGQteUPwjAdgDSdjp2JnIXwngke/QcaerdjTxr97YqZDnCIEtmZgFmBF4knl+rWM8MX+dtIA
	AcPZrSfB//zjp79Q75fF/dT9QxwUWdxZJy5gu1FhzJuejuVDgV7Zm4x1KXUhOo/Tu5S5nvckUJN
	CW1O7xlcZOymzPRiXl95zw0JNraZyAcwVYsE6JqJZKhVVS8adIQI8lwnE/vkkbwtH6ApLbc6qKt
	P12tb8II5tK2P5Ok8zZmOZEaFudqibi3z7uYixHXOMqitdE6Qk5fxBOK1hE38oAYzwrng+WtNcg
	TjnQre0jBJvP7eplsJdmglm5ptIziW6PXtvKpbKjTB5pgo/AE2ABoyhSLfviVzXlVZOxpqke/b8
	0Gxs3qYxRexcKOTNwz1I1ygoQ==
X-Received: by 2002:a05:6122:512:b0:5a0:370:f12c with SMTP id 71dfb90a1353d-5c3d92647a7mr1683844e0c.11.1786018579222;
        Thu, 06 Aug 2026 05:16:19 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d08e9351sm3375695e0c.15.2026.08.06.05.16.17
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 05:16:18 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9770fffa5a6so636865241.3
        for <linux-i2c@vger.kernel.org>; Thu, 06 Aug 2026 05:16:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoaHVAa4P2RiJV3RutRbb88wgaC2UT+AtV+nX63qBDohxO2RfYNdjHaTpB/vHBsDaLB+i+T2XscLIE=@vger.kernel.org
X-Received: by 2002:a05:6102:449b:b0:745:7f23:a876 with SMTP id
 ada2fe7eead31-760ea84c5f5mr3661787137.1.1786018577628; Thu, 06 Aug 2026
 05:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806111018.782380-1-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20260806111018.782380-1-tommaso.merciai.xr@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Aug 2026 14:16:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXBxvXQW43P9QGJxYnnoDrwGxJzCv1d7bXiAcP8CCw+_g@mail.gmail.com>
X-Gm-Features: AUfX_mwjDsO_L7mP6JsEcg0THPfhb-ZJpCX_tP9gPgzN2ZLuyGkUnH850M6oOv0
Message-ID: <CAMuHMdXBxvXQW43P9QGJxYnnoDrwGxJzCv1d7bXiAcP8CCw+_g@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: i2c: renesas,riic: Drop clock-frequency
 from required
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, Chris Brandt <chris.brandt@renesas.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Aug 2026 at 13:10, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> clock-frequency is described as optional, with 100 kHz assumed when
> absent, yet it is also listed as required.
>
> The description is correct: i2c-riic calls i2c_parse_fw_timings() with
> use_defaults set, so the core falls back to I2C_MAX_STANDARD_MODE_FREQ
> when the property is absent.
>
> The stale requirement only produces dtbs_check noise on boards relying
> on the default:
>
>   i2c@14400800 (renesas,riic-r9a09g047): 'clock-frequency' is a
>   required property
>
> Drop it.
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
