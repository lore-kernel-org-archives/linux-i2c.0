Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC743CE4A3
	for <linux-i2c@vger.kernel.org>; Thu,  5 Mar 2026 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727595; cv=pass; b=iT7CfBUUDt4Wwkm8fYBRH2Ue0ZL895u/fFxoAKo/TdtAr81LQ/KVJPqjOibvdQeBWTpL3TaTpECYUXOouekaWUKcZhirI2JeOMK+Y1QR08S0Ovr8RBDy+Tir5q7fB2fvE3kbocudl9EWeBRIjuOOwOHwHjSjb49AMExrOiDRVOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727595; c=relaxed/simple;
	bh=4+VpwCYiZ/k0oS5DZgX7u4wiQTYlbC6gsA/O1CRuO+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhTwsg6CZ3autpVqvzQJPjm+Pwp4LbwB2YUjwWTQfeCVcu8LWA5UiCdeXZY0BRxVvrMqn53UZ2W8anNSplpyNamqjX4ssiYejDV7ylvNVvAeCS1iROxleDZnC1Geq0sHY66MBr9C9wg8M+ycUlZ9+hQR10UrVszEPwO+5wSPm+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q1rxxZ+R; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1rxxZ+R"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a11da904cbso1097285e87.2
        for <linux-i2c@vger.kernel.org>; Thu, 05 Mar 2026 08:19:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772727592; cv=none;
        d=google.com; s=arc-20240605;
        b=d7qumO5zSJElbhoLcr2s+H+46XmRwCmyBr2Z57Q/uADzUS74O/5DeJvl0yPbMqW/MF
         qal3ZGeGmzzLWbcfc4Ki1PEgoN0oIcRxxJbUGOXXzC1QpghHJWgR0muvetKZYkcszyQH
         vTJ3GtiEJwpTgzNde4s3Jsjr7cEOAv5Jtz+wQmc/xFmz5wqX0yg1yyRjyvYX5Ij6O0Zv
         acEQkkf065w5XzfznYR3tn94ibfZwQbDggj15jEprVsG0WQUc5nP7xQ1TCbPJxbsjxLS
         JliTbKGoYJrKLWvfGVk+VXKzQObdDDLUPKkeKnO1rgKuS4ZzY/3HvQHPoBsa0iPCYBgj
         Q52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ClrW0+oPx++TxWQN/hIjl8TEzU24ahyY2M6DFRgObAo=;
        fh=W5CGrTOI00YfWW0Q8LZ/4oxBQ+GcpjOrcxShrr2wicg=;
        b=EoTS9T3zOhcPmKbiC4ApAjhpn9NYQlcxcx+7e0STvLm2POuivy11n4k3r/PPWPhuFp
         177B4nuy4T0i0LOt0hqPF0ILEXVlN0SXWoXS9KyyLGPY8k3P9+OK/mjC/DbRcOU+Ibb/
         wvfPlhwK78xhyDdDx9gz6JNPMh+5jWMDQSEGlqlgMsONykckm2YhF+oZkhbzT+RDcMjG
         z/Ib1HUWtWVNBBexYBJfUF/yNTuk83YxHWPoYs36TL+RCzng+GDwaxwOGqP1Yq0DGmB1
         y5yFmESViP/x/+qqHQ00WnJx9KeQ2foJ/oicDpsGe0vSNABjrKgobccUyhpYNN75DyjG
         sQDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772727592; x=1773332392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ClrW0+oPx++TxWQN/hIjl8TEzU24ahyY2M6DFRgObAo=;
        b=q1rxxZ+R/c00OLVd9zKREVlXnhXnf6dPnJHoQd9Fv3gM1E3n78TlIvVbGLmf/H6rhN
         QCLaLoqK0Hzum5zfvQ5aGdm869aGH0kiv9vsCJjgeRf+kTE0OCbV/OR06HMNqe/lYz/h
         JI0iEmSqBYk18AeQlvwx5ODpYlKfMNze4jVK/TgBdwpIFFNlZ923Pf63pIjP3SaiwJBO
         h2oRjXurKMaxZIVyQvNcK046OMfRSabM9VrTrrulW9zYWTBJaDImY1lKqSjkBeGgfp6I
         IUegtysfkxBHDj6KnahmtbocAUBZocYgHQHNhJdde5aFLEtXsBmlxeOO9vRDWmULvEfA
         442w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772727592; x=1773332392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClrW0+oPx++TxWQN/hIjl8TEzU24ahyY2M6DFRgObAo=;
        b=AIGTOebPc3qVMFPGH74aapopxWlhR2KDc374Ow2vewAQgoPchfDahcwhvJATYJVhR2
         b7kpQg0tPeFRxhQqaIa8oCmom4fSJeNpp1wd8gfzvJKXBl8Ht3npS6Wd048+oAFZiF/B
         XXbVJrHjMWKa/kAC7jrMZ1ep8AzGlY24n02VpyZh61sWiI57Te8bYol8p9Y9GE4vW9H8
         0hgqzvDN2w0t1IZf9gIXHJNt8J6gyR125PUTQSoo921X2vs4YUD9W6Gjnyj4Sgm/z6gv
         +12mI2PcEb0s/1lXZ7DVekNuaaFF1/I4EQAOr3jFVueo8vBw93ko6icRIW8ef5vTrJfT
         taAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3LWi6lSVY9KCED7hMJX0UNhyHxJvMfo1vJCXntceLDJ4qm09JIxQE2lIXxm5gmpMWAjg9ujT49+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrDHy58iVt7BTQJl784UxOwPozgp7F+2x7Dl0zHKCOmyWAAofS
	s1mXOcXiEZUPsO6+GxQtRk5I7Rsx9ag49gRdP8nwS6uU6xI3bZWat+GKibZ9tbhSCmF+lBRDI4r
	GSPgqCHuITX6FjYsoxZbLH6hlz6GNNhkxHqivfaOwEtbVjXOdMBqSIIs=
X-Gm-Gg: ATEYQzwVn5Ux3FFw8e5CykUz1r8g6nQCMqFYwIn0GClbMnbZmFB4/t9VFehA8uzZF0I
	W7TMogYbgy5kHvKTDGMidhNRo1ruYY1vmHi4Ta7pXOnIxmwO0r1C154QI5hkyWZKYWPONZ1vcQR
	2Zq/AvuqM+ZbYGB9AzwkQ1IWZfCOWFslnLfZIT4gdGvoWN84UR7pjYMNUprnjcJ7R6ir0m7FSSw
	rKPwZzfY3cqFbWYrt8mN4a3Z0+qpBcNdVP7x6MjeRGhTDstrc+M1xyPVtiWSeBdFoBTC5yTtWnO
	trZYAqKI
X-Received: by 2002:a05:6512:1288:b0:5a0:fe69:af2c with SMTP id
 2adb3069b0e04-5a12c339474mr1173761e87.33.1772727592278; Thu, 05 Mar 2026
 08:19:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com>
In-Reply-To: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Mar 2026 17:19:16 +0100
X-Gm-Features: AaiRm52HLUuRfxFPVPVExv-76gWZPV1pu-J_tp-8KI24bnstuTqUB205NGBVxZk
Message-ID: <CAPDyKFr5NZKEKpV2+GXGnzH9pyyj_TLmMCc3rac8h248srX_dw@mail.gmail.com>
Subject: Re: [PATCH v11 0/9] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Josua Mayer <josua@solid-run.com>, Peter Rosin <peda@axentia.se>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Feb 2026 at 14:21, Josua Mayer <josua@solid-run.com> wrote:
>
> This series has evolved over time from adding generic mux support for
> renesas sdhi driver, to partial rewrite of the mux framework.
>
> Several drivers have started implementing driver-local managed and
> unmanaged helper functions for getting and selecting a mux-state object.
>
> mmc maintainers have requested that new code shall intreoduce and use
> generic helper functions that can be shared by all drivers, avoiding
> code duplication.
>
> This series is structured in 5 parts, each of which is self-sufficient
> depending only on the previous patches. This shall allow the first N
> patches to be applied even if the last ones need further discussion.
>
> 1. Rename driver-local helper functions to avoid name collision with
>    global version to be introduced later.
>
> 2. Implement generic device-managed helper functions in mux core.
>
> 3. Convert driver local code from similar patterns to use the newly
>    added global helpers.
>
> 4. Change mux-core Kconfig so that it can be enabled through menuconfig,
>    without an explicit "select" dependency from other drivers.
>
> 5. add dt bindings and driver support for mux in renesas sdhi driver.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v11:
> - changed approach to Kconfig making MULTIPLEXER a bool, and adding a
>   user-visible wrapper for menuconfig.
>   (Reported-by: Ulf Hansson <ulf.hansson@linaro.org>)
> - dropped the "default m if COMPILE_TEST".
>   (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
> - improved kerneldoc line wrapping.
> - removed unnecessary changes to original devm_mux_control-get.
> - fix "reference preceded by free" in mux_state_get function
> - Link to v10: https://lore.kernel.org/r/20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com
>

[...]

To me, this looks ready for a new try. Unless I hear some objections,
I intend to apply this as material for v7.1 via my mmc tree on Monday.

The complete series will be available on an immutable branch, for
other subsystem maintainers to pull in if that turns out to be needed.
I let you know of more details on Monday.

Kind regards
Uffe
