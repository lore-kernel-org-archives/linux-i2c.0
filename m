Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067F1917ED
	for <linux-i2c@vger.kernel.org>; Mon,  9 Feb 2026 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625017; cv=none; b=kHdpIfL8jnDebkQdKXNeJBCFUAhI74Otie1tZNx5hl4mx/LJnYpPZdoEeWc/g+zYb1FWuC7eTh7pqPSNkBjKHV7juXldSFcj0wvga+DuXMsp36am3F20cVH7XIWxuWnAfqKtQekUD4K0TpTXiuCbIYMgTnpsgyYrrbQJnmNAU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625017; c=relaxed/simple;
	bh=/zYgLPOAHXK4/exWmt8hOWg3cIDWG24Bmk4iX8O5iZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQyPhEs2vmv06x0gy5XhG6rWlmR/mMdzMMvn5PflGbq3cvAOXd5CwaeNpyw9EErv2XEiEUaQTyBWDjSWCmfO/TsgcDYuGfbRubxyT8yugoTbJV5ofmLP8/EfWHkX9aQNt+8+N+bLC/fMZZF12heDpHocX43s/P8mAYeVbo0THiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56711650601so2051780e0c.1
        for <linux-i2c@vger.kernel.org>; Mon, 09 Feb 2026 00:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770625017; x=1771229817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bAsoauLtymOFaOmBSRU1sXzH6MyMCHQePcHPtAadtM=;
        b=TRNlDW/g5Pek1prV5vUJD7XNQtrqDNoDN4GSHwKBG/0SXOUyVtKWryJN8rTy5gPt4k
         fbb7UN/jpeThL4iSJlgpQScqgDQPEx+vHmqMGmNT0BxWxoUZUlXOw7LZ2sUsKDEKN6WB
         eoQNXJMTp6XuA9Rl3iQe5+eR8E86MlQWLUZf4JJjajirXFjp7Egy6I3clX7J+/fEIgEH
         sxsC9+CD2cOWakOt9jeQJiNvrO5rEs1GO6kFI+rSdAtayfBcIiAab+T6DepxxipcU97L
         /rU0CA/o72yOXOjErDYrNm6vEMFn0m/9eTluql5m5isXW0uWrq6o40RX7vt3BwVZeAZP
         HB3g==
X-Forwarded-Encrypted: i=1; AJvYcCU3lk/dL9R46GtJtIQoRQ292PGrRXRnMIhanDF4dvvMwAkhYqlGX2jDNTN5MBkGSm83MKa7P7lHH8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4lxrIB3RsOCd6QlqKyxXZugdy9dByVTKWkIWfMKf7SFs8TqGf
	Xw+LIaY5PVbmHYYz6qzq1C50s2E2GK14Y1FXNqWJ9wSmqLlElaYh4aPGByg+Mw5Y
X-Gm-Gg: AZuq6aJt3dezYadWiIAEXO9ItyMEhFDyI8ZithCsFTsKvSU7tQMNxuHZq2edvaw40hA
	8qvkq+SIMT87UsktOJXkaLrtj/C7izIgwjompooPjJ1UQqK3EydLIEilQUS+1+JiBXlBBRr1mVj
	KfpS0pr5wW2KIh3/0YjIkyHdJEBou9FT2X4XdwuxJxfEivX+Db/xlMVzz0j0D2+ECt2vpTgfHjf
	zn5qznqX6rr0iCxX52QqorNPyinDGAwff0ZhdW/wKhA4iEls6rl0ektRwtHOFcGFVHiip13viI2
	bQU58HgyTuMnogzsODJk6LPS2MPD4KerGG/WEFsCP0GmMnykzkQASV1b6PgrHbNoFBXOoIgc8z5
	asVBmKgIIxBffAg0wb6X9THDxVkuHLYoK5BXgdjMLsWhd4/umltM1s+Ab39QaExeySCn65r7/Q6
	oMdwyGyDMy3BUXHUosrQ5gxlAaxFHSvfOVqUOkeXOZaGuZi3HDWvxY
X-Received: by 2002:a05:6122:80a7:b0:566:271c:b48d with SMTP id 71dfb90a1353d-56706060b66mr3448078e0c.18.1770625016642;
        Mon, 09 Feb 2026 00:16:56 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5670743e58asm3359471e0c.18.2026.02.09.00.16.56
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 00:16:56 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56641b5a471so2363167e0c.2
        for <linux-i2c@vger.kernel.org>; Mon, 09 Feb 2026 00:16:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7NMFrwhmi0uqjz8FMgxgnYqWIJ+lPYEbBym6+NweXnSEoiSk1nT8/4NLGU6o3lmtLdEZrGJxhMnk=@vger.kernel.org
X-Received: by 2002:a05:6102:5092:b0:5f5:3c96:983f with SMTP id
 ada2fe7eead31-5fae8a3ad9cmr3362584137.1.1770624619183; Mon, 09 Feb 2026
 00:10:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com> <20260208-rz-sdio-mux-v9-3-9a3be13c1280@solid-run.com>
In-Reply-To: <20260208-rz-sdio-mux-v9-3-9a3be13c1280@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Feb 2026 09:10:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV2a7uvtrJpSprU3YbgFSTmtKkMi+Z6j0m9-4vVXWK4=A@mail.gmail.com>
X-Gm-Features: AZwV_QhXlEX6D1abbrehjsrn3uf8WxyCcirF_ZvMoX3URB-GFlRdZjQEEn6kewA
Message-ID: <CAMuHMdV2a7uvtrJpSprU3YbgFSTmtKkMi+Z6j0m9-4vVXWK4=A@mail.gmail.com>
Subject: Re: [PATCH v9 3/7] mux: add help text for MULTIPLEXER config option
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Josua,

On Sun, 8 Feb 2026 at 16:39, Josua Mayer <josua@solid-run.com> wrote:
> Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling this
> option thorugh the kernel configuration without explicit "select" driver
> dependencies.
>
> Select it by default when COMPILE_TEST is set for better coverage.

Merely enabling COMPILE_TEST must not enable additional functionality.

> Signed-off-by: Josua Mayer <josua@solid-run.com>

Nacked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
