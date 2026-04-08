Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D2539DBC7
	for <linux-i2c@vger.kernel.org>; Wed,  8 Apr 2026 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635876; cv=none; b=t6H8UZjjMWVIvacABKcGFZjyqx8gymtr4wr2pyAG77387zAH7QhalZ2vklgwlJcP+1Ge5Np8T4+W6cgoMaQBqekWQSPyKDqU40pT97hod9zLMAinidpAq2TMYsIvZhDdvvTWvG4Ij9kHiU5cj24feLB0jyGKftgA3TOsonIehmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635876; c=relaxed/simple;
	bh=qgkECxzGSpnuq07rnxhj52qCBc/KBJvowuMtgBzyENM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlU4vBrfTRQbo0z/mf8zoCb6fMaY6rf5fCx+r2rQWKEwVPC+KOGD2sRxZDPxUsZF4TtcTdPZRwgrFWyuERfvCcUH5qSVjOK0A7EQlovPh3ZtaUbeDlOptpXluanABZksbEO//QhDvL/ff7dtur6ZdmRLRJApd1Wat/E96z0dzu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b23fcf90b2so57990515ad.3
        for <linux-i2c@vger.kernel.org>; Wed, 08 Apr 2026 01:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775635875; x=1776240675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgSjrs+bZCBNPvbS97WPj5GTT7jaQlR+JpRwd/gT2+Y=;
        b=Q+D2uoMXNWHcF5Tz8RKasSpmZxaU/mYA4bnzVv+zA2FOGnNOK2FVpqhesYQbyUR5sE
         CEAZOm9F6uPaprP0jdV7JjkGKU5qSN8530/9mA4y3T45qK3aCkvnghXB94VIEW2c5FXb
         bXJqKIs7oirn54rEsI4pV3WcF76Q3xPNoyFdgfGnMEylwxpGF1ISiopI6SPS+EOuG53C
         mw2iapPAjuC4qCF8Wt35COHqaqqVUAxP0xWNnDEj+j6bYjLJwTeIDj+bG+Dv4E3pcrqB
         j8gEsfbWFIJJKw8q+/BQ0dnOzpq8CVmPWGf0O5tHMznkz1mPogSMGaTOeMsCm3oOc4DK
         TTZg==
X-Forwarded-Encrypted: i=1; AJvYcCUCFlEnNH9SdiH2vFDQJGmS/HklLMhekz0wVy6aqmHHztw5hdSqU2XbrDIVjk2/LVvx2hdiRhWh4fo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7CV1rwyNMCfa/3N6oH5mYm6JAdD2G+jEcKt+y5ayS8kIscaww
	bQ+tl9AzWRpMy903a74FE5Oe87DO/B5OAN6pE1pt7C64CdaxVjeBtFSveJZpUI3s
X-Gm-Gg: AeBDiesEKeepGulJ9UQymGvr4fVihtLQXB+uDxBMWDhlqYHt+RPsCW3zuHuwNnirRRj
	taGBBNa1y8nTiRGZMJrBn+yvGJZZf8fml00W7XWXXMum2l/b/zcvheI1VSbY/TYbP9fqD7b25ME
	fOMl4j6jCYeWxm0/sivB9ouXJAtsL8XdLw4mbcMzUvMDFRfJmfGg+nyOl7qTwrTSE3SbBC02jZ5
	a3oLbLgSF5BxrAQjVGCXAlzKsTRGRDBb2SmfCZSO+IBjBl7B3+CKHFaLpYMhETXgAE1rV57JEtV
	5hB6usKY4z10vrHFJ1axCcJXt6rUk0JVY16uKs0FHE8rSijENcZVAvTXMGRstIki2S04QXP9NE7
	miZG2FR99chJxaag5iFHU+CSMruRYUvhEPKFiIq+EIsTD064gwuFjZ1CDZcOObnu2CWS2IL+4MJ
	Pxefo7th5vxsoc0EVpbFI1l6WAlhsB0XuMyAqiBvO5ij5cbwhULjz6GV4JrIJqDxGa
X-Received: by 2002:a17:903:2f08:b0:2ad:bd4c:a5 with SMTP id d9443c01a7336-2b281706ecfmr217575385ad.1.1775635874696;
        Wed, 08 Apr 2026 01:11:14 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com. [209.85.214.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749c38adsm246348625ad.69.2026.04.08.01.11.14
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 01:11:14 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b23fcf90b2so57990365ad.3
        for <linux-i2c@vger.kernel.org>; Wed, 08 Apr 2026 01:11:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0kdZ4XhSQ4DIMTWP7yABetmX4LKqg1WDBbZAQ7enkDQ3QfsD4Sl49x6Ozgbq5PL4wDJOwXM5zQw4=@vger.kernel.org
X-Received: by 2002:a05:6102:688e:b0:607:9b47:81f2 with SMTP id
 ada2fe7eead31-6079b478f09mr649179137.20.1775635395263; Wed, 08 Apr 2026
 01:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com> <20260325143555.451852-2-herve.codina@bootlin.com>
In-Reply-To: <20260325143555.451852-2-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 10:03:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVh2gFQf16AarJCY+2y+24bOgaQyTUv6opPqVKCoUwMag@mail.gmail.com>
X-Gm-Features: AQROBzDnP0FsdrSe7kiaKBzgO-Rt21-zwjAE4PjirQbwD7WYIqJw4iFM_IJ47Kw
Message-ID: <CAMuHMdVh2gFQf16AarJCY+2y+24bOgaQyTUv6opPqVKCoUwMag@mail.gmail.com>
Subject: Re: [PATCH v6 01/27] Revert "treewide: Fix probing of devices in DT overlays"
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Niemi <kaleposti@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 15:36, Herve Codina <herve.codina@bootlin.com> wrote:
> From: Saravana Kannan <saravanak@google.com>
>
> This reverts commit 1a50d9403fb90cbe4dea0ec9fd0351d2ecbd8924.
>
> While the commit fixed fw_devlink overlay handling for one case, it
> broke it for another case. So revert it and redo the fix in a separate
> patch.
>
> Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
> Reported-by: Herve Codina <herve.codina@bootlin.com>
> Closes: https://lore.kernel.org/lkml/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com/
> Closes: https://lore.kernel.org/all/20240221095137.616d2aaa@bootlin.com/
> Closes: https://lore.kernel.org/lkml/20240312151835.29ef62a0@bootlin.com/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Link: https://lore.kernel.org/lkml/20240411235623.1260061-2-saravanak@google.com/
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Acked-by: Mark Brown <broonie@kernel.org>

> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -327,12 +327,6 @@ static int of_weim_notify(struct notifier_block *nb, unsigned long action,
>                                  "Failed to setup timing for '%pOF'\n", rd->dn);
>
>                 if (!of_node_check_flag(rd->dn, OF_POPULATED)) {
> -                       /*
> -                        * Clear the flag before adding the device so that
> -                        * fw_devlink doesn't skip adding consumers to this
> -                        * device.
> -                        */
> -                       rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>                         if (!of_platform_device_create(rd->dn, NULL, &pdev->dev)) {
>                                 dev_err(&pdev->dev,
>                                         "Failed to create child device '%pOF'\n",

Note that all these removals no longer apply cleanly due to commit
f72e77c33e4b5657 ("device property: Make modifications of fwnode
"flags" thread safe") in driver-core-next, which is gonna complicate
backporting to stable.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
