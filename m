Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B63E1E49F
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855754; cv=none; b=mtoUNyFIjg1FrSqJMmLLMLJ7Tz3U2Mgk70jBTWBxYawfI9DTLiZXjoGIwU5TvyxiU4MlscQ3yMvEIf95WiAtzVoD+6xSyYSwhL5+3gRwBsi8g5vqG4s759foEX+IaOFnYZXPdeYSwOH8NCBgTvKq4DPJlTNevOCpWNIMKXQba1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855754; c=relaxed/simple;
	bh=BPlCyTz8G/El4l0BA0OckJ22InPEejXQZx1TWREEqyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOofZlZcejlfC5qx3OKNVVZOU1Cd1uEz6WtYqLOdnQ/bdehz1OejMtkIoP9loRWFFXZUdAU4NvZI5NN/kE2XqXdIF2CcvtgXPDKc6sxDkNcQ0sxIYaw2oTBdLWPcx46qye+tocsRy1tjmUGBkVRHIdkUZOekoFu90N2SfKyb9Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-566fe6a4ceeso2109635e0c.3
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 06:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771855752; x=1772460552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLzVdK8lDfgaTPyV9xNjlD/1kxno0u/2SblofGNbVRQ=;
        b=PaBqaB7Iwt+RLiI8vvcN6Jg5IH+64ZIYYKXbGZpHSt5Tm4ZtzUGGcOQq9BhvsxByTz
         vNt+3g9MHighIjVkHkMnJGQyYS1kky5ON1IZynwdUTJvfnemjUbcg2i06WXxowvFHdzu
         miUkNKCXkEB2wtv9fYXYS3odDXmF+IghuQazfGwXRVhgp4Yc9MhTuRiNQ9dDW4qU/73S
         J+4NLOh9vd5P586j3bNR1aE6hqO86Qtfjy2Pq4Jyn0jacy9cvtjyXy3dxIVKkn7WLFO0
         JaRAstw3tRV+U/LNm5dbghcW8AhHPYysqyt4otKhwoHG7kwRy/hyljS/amzDNNJLkY1b
         Nj0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWGSFkUv/2Wx2aXWVtstLiHuQVxFmKFX+4bGWnm110iH8WkBrM0igXvilWnhVQ9rI2WUZjYwgQyvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz27DvuS0/oicSCy4GNXopvj6YV2BadbYUwN5KbJu1r2LaW+iIC
	W1FkcTjFDdJKm4U+NqMK+gJGxUbpu2VPES6+20uHDL94rSSoZdkw9k5KV3cVVBtV
X-Gm-Gg: AZuq6aIbZIUkFlIEcG5xPMW0sjAc7a+WECbW9ZUlTDH7h/qyTrhn/PwEw2AuVURWuS2
	CWW9JBjBxMEul6RoyCLnba6d3Y67ipYGgpMFiX1Tjkl5y4AIWP0sw1vIeftWgymkqcg9+PayMii
	mD5vpMra0i5hwGC3YrZA8p15R4ZqJvsS1z0KJAzbbf3zrGme5jY/aW8eCHnvCDMUBo0jOT8gVa5
	MaF1M0h3FK7j60or1l91//VbkaXXmNNakzeNXd5VLo3d8MsSCp33SGJJda+9vq3ZE+P1gS/Al8v
	xUTAbphdotDviKvXQVLmAfCeTNKB+TQOPPTmGi5vw1/srZ+trqqc4aHJaN62hN3ynMo2SOmlIid
	9AU6eaXlQ8L9b33s8QkZmT6fXVP6mTvSauxCV63vmTJYrXPYpQkCVyqbDKeiEFztNBchJf0Ajar
	t47r8nGbkl/1eE3oUSsP+pxJHhuszViCKGxiMAM5k6ZUJf7Z/vxIAZvCw8avEs
X-Received: by 2002:a05:6122:3c4e:b0:566:3c6d:b597 with SMTP id 71dfb90a1353d-568e4867074mr2983695e0c.11.1771855751997;
        Mon, 23 Feb 2026 06:09:11 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-568e579c2ccsm8877442e0c.2.2026.02.23.06.09.10
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 06:09:11 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5fc456c3742so969823137.1
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 06:09:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFr+iBx//aGRsOoDXLfZwaQjvQGW/Hd87yzkV87Y/Vc1ez5/0U6SqLYVjEEn59HOn4EI8CWiwr17I=@vger.kernel.org
X-Received: by 2002:a05:6102:38ce:b0:5ef:a346:a020 with SMTP id
 ada2fe7eead31-5feb2f081dbmr2742454137.17.1771855750377; Mon, 23 Feb 2026
 06:09:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Feb 2026 15:08:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWJCc-UeaJLM4dpDN=toDvteXFvOFpTm5AbvNoKf3rTqA@mail.gmail.com>
X-Gm-Features: AaiRm50V2ONm2B9njU7ZJRcOuR4Nb8zI5Hsqj9aPxNU6M55eyuOZ1HhwjvL4ass
Message-ID: <CAMuHMdWJCc-UeaJLM4dpDN=toDvteXFvOFpTm5AbvNoKf3rTqA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] i2c: configure parent device and OF node through
 the adapter struct
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Vignesh R <vigneshr@ti.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Bartosz,

On Mon, 23 Feb 2026 at 10:06, Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
> Changes in v2:
> - fix a NULL-pointer dereference in gpio-rcar (Geert)
                                      ^^^^
I guess that is bound to happen when a GPIO maintainer touches
the I2C subsystem? ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
