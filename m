Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D64361675
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846348; cv=pass; b=TXAK6e3bW9vtK7dV4C5MxFScMrTwl40LKYxfQeE2Sfjpe1PsO/NSHaDqx7aekau9adX0yh9o8fAexotOKPeGhSXtfuzQiLW0gpFYHUWedE567Rq0NHzrE9nQKjAUVprgO+Ts27aOnwScimQtAlssSVflT2GzjAmbMh/gzJFbqRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846348; c=relaxed/simple;
	bh=uHtxhZgqkvvhkDixZGvThzOeJrJuPZvcOjfb03f5dzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vu4Q09DYZESaQb+aEQ84+wgi3EcyEoJF8Eg9gn1pDQrg4WZUNCbwihLZRXnQvNyWuctxHkQgnaLMT07UpQwZw5g/3Dge7TF/hBKPozstH1qoAIZn4WZoIUG7n8Ado+YMsXdx7F4PMaoVAivoVCFk4KdaZ4nunaG3w50bhU552J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=jtvUPGtb; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="jtvUPGtb"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64aedd812baso3884941d50.3
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 03:32:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771846345; cv=none;
        d=google.com; s=arc-20240605;
        b=An3I3S9/0LgxanenlDGcsMs1qtn1oeoIozj0pE4Y76oBb0XpGDEblIZJRbDU5LaTs0
         +3aZZ2CvxkaYrjZn7ZKaDaaR1udN/PpCNoZtoRqvZB7N+8CERF7DKfABHCrd8F3Z0L8h
         6h0nwFyByfIC3pIojSCImlxDjDmrXyk3++pLaz59pl149RtBVBmwGMle0NQDEKU/Rz2S
         PwGTLZ7KzVARm8/2zdqq+K7I/6qMklLfHaCxpkYpdXWieed8sXGVvAZsNkjETRIeRGrq
         qFYwy8xd75QLH3vmPhJp4xcYVJO0kLoghW26TjsnM0HXV+LjYYhjWN5Hg445JnkhFetz
         8fAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JV6MMROodIfNHs5yZIiROnA2XT+gIEtvvO+RXDqEFEw=;
        fh=t1JSyLYxfeydqgztUmgLTFb3bQj/omBP2CJSdoRpI4M=;
        b=ZjqbLwIWZyLAm1DHp0fFjmHIAWXxLgYrAZG2Rp1yeM3CdB2XeQWa8J2qgoAdrq/cxk
         5dXCRlNN38p4uEFUxWQoVjm3AqF6qqFASy4Y6kKTW19ipJOucBVCG7OeebwT98rW+CYi
         /ujjPTvcJFw5zjmPrIVw64T2BIr8TvSSzsOr+EzTXNrtcV55SWLXLGhJv/bWSay6uHyH
         T6hHruPUU5aZgjmeCfnRdJ5AK3P3mK3Fjx5U7Qu0ddv+wV7Ht4fPbwxloxPGlarJKfJo
         sKZzz34TIrPx0KhOs1dx8qqZaMWxHiW6B/EMGTLbrknu+jkmHUc2efSR/Phg56hWP3HQ
         XDyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1771846345; x=1772451145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JV6MMROodIfNHs5yZIiROnA2XT+gIEtvvO+RXDqEFEw=;
        b=jtvUPGtbU2Wj3IxSdHVfaI7AQSst6+thnd2ba2zTb/HK23eB0wcplM4TJf5noWT8j1
         ge8ldNisA1GAvbE06Pm7tTe59J+DICve1TZzAcm+hcDMBSbqidGhRGyoChKHP5qz0N94
         6lPKDePnGkuhwYSW4jfj5UxApMpW6AVdVO3pHkW3BdL8kRZ+nZu6JbCIi6Dg3KAfr9c1
         NteUpZJJ/x71K8cFUedwQDypq1yxKjEGLc4tOKm9MCsZYKOPt72K70b+vt9xb7x1CYy6
         SElcFIvERsf7RiLwck3t7NjFJolmQ3rbFhdthU0HhXs5EfxgOnQXYv/T53AlWotxAmvu
         y7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771846345; x=1772451145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV6MMROodIfNHs5yZIiROnA2XT+gIEtvvO+RXDqEFEw=;
        b=X13fPf7nGx8/jNrVIEZN3FhjsMwHthl+0NAb64dStXhOfiOCTqIVR95Zgqv1EVuEIv
         SYmdaeQbIyy4zjBvQKOXU0QxwkLTAJJRsf+/ulaRuj69dN7DNB7z+PxmfeuvgCDw7gP9
         Cr6Hyxltb1R426/CWGKO74XAZY/2Mr44jQtv98GzdDD4OIFFe7m9rsA+AUCnxo61JqzR
         mP7NrHK0iKqP4K2BJeibS+l64berrYKdZXZvF1KtNEMCPjWosSM1ZPplw9kBxmb9NxUd
         EeFgJrNPVfMvLfih5G5NNJ8wookKBM5ZvUuPDp5TB3hwo4Hg9sc2Fm+V4e1MYYrobm3H
         1EAw==
X-Forwarded-Encrypted: i=1; AJvYcCVX5qK78s6D6U3LgnM9gdKuPAwcd6p5Fb8H5BLb30GKqjm1rknTuzKOVDcNZoxV4DNgoaabWW04dhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT3Ilos4O81y5g4kbJsyscc2jXtCp/d5fW1j94XkT/tQHI1v7r
	3S7ss5DSVFORso3WauG85F6H6l/VpttZxPVApKUGm283mL2AbjGOOZEDRxDLTb/s2HcGtsGCqAW
	tUUccn5JiZxCgk8u40rpPrEBfNTy53SbsSY/jPvOqYA==
X-Gm-Gg: ATEYQzxy8xTqt/OwZF1RqkikuHgqYPd9Hg3UVbEfnLIZw92rX52bG6eb6NDmBGyh/a4
	p5uzzjtfVIPSo8cl/HNtexIBmME+7l64uihYiDfpUgKI43zT5OazMXakHtwvh2ulZsjWXDdZjDy
	W/t/WVcr3OpxnI+6dkALKFrF0zzGj/w7saPHdkmsoHcqWtpVp8xy1+hL0La40i5QZxksxe+wD8T
	MNC44NhIp4tuMoz2e+wJy1rYLS+ALB4xtefCqw9MnEHcJEViM0J/6nLTpUZ2Pk6W9NE7Cs8heuL
	4/34vdeE4Y6J3lZgD9ZVh1CUjhb89JAUm+Komw==
X-Received: by 2002:a05:690e:1601:b0:63f:a7dc:5661 with SMTP id
 956f58d0204a3-64c789c7e4dmr4751859d50.12.1771846345547; Mon, 23 Feb 2026
 03:32:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com> <20260223-i2c-adap-dev-config-v2-12-d78db0a6fcf7@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-adap-dev-config-v2-12-d78db0a6fcf7@oss.qualcomm.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 23 Feb 2026 11:32:11 +0000
X-Gm-Features: AaiRm53g18kb_D8a8Rz5gsK9_gN4L3-bPSeoZhzvicFe1V_X2f1sAQaShwQ_SAw
Message-ID: <CAPY8ntDgMHgjX65ZW8dFvo5jb+yZDUQq6cEJuw=zP6DddmTPrQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] i2c: bcm2835: set device parent and of_node
 through the adapter struct
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

On Mon, 23 Feb 2026 at 09:07, Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> Configure the parent device and the OF-node using dedicated fields in
> struct i2c_adapter and avoid dereferencing the internal struct device.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

When used alongside [PATCH v2 01/12] i2c: allow setting the parent
device and OF node through the adapter struct:

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/i2c/busses/i2c-bcm2835.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> index 0d7e2654a534e92a529f27fdc049812359678522..4f7e4a178b33fdd172657cc625a34018b18f88ca 100644
> --- a/drivers/i2c/busses/i2c-bcm2835.c
> +++ b/drivers/i2c/busses/i2c-bcm2835.c
> @@ -474,8 +474,8 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
>         snprintf(adap->name, sizeof(adap->name), "bcm2835 (%s)",
>                  of_node_full_name(pdev->dev.of_node));
>         adap->algo = &bcm2835_i2c_algo;
> -       adap->dev.parent = &pdev->dev;
> -       adap->dev.of_node = pdev->dev.of_node;
> +       adap->parent = &pdev->dev;
> +       adap->of_node = pdev->dev.of_node;
>         adap->quirks = of_device_get_match_data(&pdev->dev);
>
>         /*
>
> --
> 2.47.3
>
>
