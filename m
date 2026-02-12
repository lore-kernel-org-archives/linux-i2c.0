Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA9A357716
	for <linux-i2c@vger.kernel.org>; Thu, 12 Feb 2026 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770915503; cv=none; b=LE/B5Gdga0ay1Pbch27DQaVu8Ie+6l5XWpvzTY3Ny5+A4Oue7/xtQZxQLqoQzNgiRH85ABksdLOWUfZ3+JnP/mpKXysul1Rxn8+DLvwC5uvfq3R+jLzViMGY3Mx5sRfFEgSm5ssrRD0pq2jxnq8IwFW7HoeNdl1CgC/CQ2ebBk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770915503; c=relaxed/simple;
	bh=FavnLYuCSZbZEB88+6M4JKOu7/zHNtiz8QGLBab5uI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHJ8dEjus4vVGuE25u4OHxV1ZfaM4g/tKVy8pPTP4azvTRYcsVnoFtpY4d308QSES52F2O1SFx3YBzCbFluwW/OJpyUmgoABI3deBq6tbKjy+8wGoI+DGESgxxXOlmOf15D/aOxglVc4jxlcmzTt4sHti0b6kGbl1LXfYQsS1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56637565faaso66219e0c.1
        for <linux-i2c@vger.kernel.org>; Thu, 12 Feb 2026 08:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770915501; x=1771520301;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om3cuNbQzAgOvOQckRciuNr9O8eg7IAaHrWKXJVxB8U=;
        b=U1OBlasZD5XpYlbRpsaqEuivO7sbuU0fvsEKyetBVwGtHfRlMoSgZKe2PthKEW/tZA
         vShJvLAmTsMfopDLsx+Y8fopvl9DeKZSlbBrGbhCbAIuvLLPkiS1UVz/hj2brMXeUf6p
         OErUq4h1BCsxxayoQtKv7lZL8ZjWgp3vjsjOj55QhgZGStRb7dtQEnxDv40v6r+aPI1q
         2oFZd8aGoeK7kO5aFBGUsr2leZNOI5U/jNcI2Y+FoDL7UGzKOKd3j+UxMNaaJhX/nEcr
         0h1HJBr11hqlVSOtPfVqstuWeXt325reEcjBIBUOOhBMaTW+dCJzI2gOtbqfcQqsS+pf
         IfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXOUpG2GKOPpCb2WRLfClF/38O1DUhftKulHqB8cu1LMLaKX8fogkL4A9M0xvidSQ/fmXtujGKtpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMcOus25zkhjAVmomre6eXBdgJgwYpxzpKmgHAIQ6Cgk4gzxgW
	awFhP9mk3SnFpmERCvs6x13FlSp9l3ppkGPiqNb6QrBPc/fHRK896iXbQfTAJ1fm
X-Gm-Gg: AZuq6aJcbz1qBS4XYfuiNkenoaZ8se68xmPlGV2DRl58q3Vx6gwKmmEH2wee6YJewhQ
	BXfytUt3VuwjBAdHmgDBR1hgVHTvHq7eii0q7czBRLgKwBscdHwxi+WbX+OT6cB4iZIC8Tko3rW
	YdBICMhoAZrUIGKhFEaBg9RbPo5P5zSTbPCvwHNNhslY4k95k37tUs8CRxCZwS3VXg1RCsyfptX
	s0Uedpxm4HuwrGQMtiFH0RPTwmffSxLfXMuxLo5onaIrcZxbFmWNHUIimqncHETY8HTT/nIQBpd
	6wcjR3ChwyaeELABL4GWAxXde3Xxk+kX+HIQMsy/zYfGOP7xpFQ/RGSfvuOnKJzEM/lWLTH7YV7
	PJEjCDuLEAEovKQ0O8yWHUAcXqQXULZ4aXU8HdUuG54gTLXivRGuq07UputKi4PNdJl+ATCv+eJ
	cbinFK9bEyn9DqkkJe7cBtQ/s1gqTvP2tIN6j7DvsGo86UAJiBbP0ajN059u6pWbNU
X-Received: by 2002:a05:6122:3293:b0:563:66ec:8fdd with SMTP id 71dfb90a1353d-5675b7b66e3mr903790e0c.16.1770915501000;
        Thu, 12 Feb 2026 08:58:21 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5674c25ecdesm1881482e0c.20.2026.02.12.08.58.20
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 08:58:20 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56750cb34c8so55341e0c.0
        for <linux-i2c@vger.kernel.org>; Thu, 12 Feb 2026 08:58:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVvfbWwVRBADpE/QRP8L0CaWRJ4y+yb5CcM6QjIXSh1H1EZ/vlG0SR/xorNd3LJqrvBZWj1mGA8dU=@vger.kernel.org
X-Received: by 2002:a05:6102:3051:b0:5fd:f8d6:e5d7 with SMTP id
 ada2fe7eead31-5fe003fb1fcmr1021759137.11.1770915199593; Thu, 12 Feb 2026
 08:53:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com> <20260212164823.mbeycqwzsy2dfq6e@skbuf>
In-Reply-To: <20260212164823.mbeycqwzsy2dfq6e@skbuf>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Feb 2026 17:53:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
X-Gm-Features: AZwV_Qjd18dp3H6_yOLJUoqzfa3vu8ojTLTUkfH0N1bdOdZMnHdC-jkEvP2Togs
Message-ID: <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
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

Hi Vladimir,

On Thu, 12 Feb 2026 at 17:48, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Sun, Feb 08, 2026 at 05:38:56PM +0200, Josua Mayer wrote:
> > Rename the temporary devm_mux_state_get_optional function to avoid
> > conflict with upcoming implementation in multiplexer subsystem.
> >
> > Acked-by: Vinod Koul <vkoul@kernel.org>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
>
> In the future, when you have a series with cross-tree dependencies,
> please try to think of it as individual mini-series for each tree's
> 'next' branch, and specify clearly that you need stable tags (to be
> pulled into other trees). Telling maintainers what is your expected
> merge strategy helps avoid making mistakes.
>
> For example, if you did that in this set, you wouldn't have missed the
> fact that in linux-phy/next, phy-can-transceiver is _not_ the only
> occurrence of devm_mux_state_get_optional(). There's another one in
> drivers/phy/renesas/phy-rcar-gen3-usb2.c, and that should be also
> handled in order for trees to not enter inconsistent states.

To his defense, the one in drivers/phy/renesas/phy-rcar-gen3-usb2.c
is a recent addition.

So this is yet another case of "convert all current users" (i.e. those
present in the typical subsystem base, typically *-rc1), with new
users popping up in -next in parallel, which happens all the time...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
