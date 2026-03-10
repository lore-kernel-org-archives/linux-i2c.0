Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64912D3ECF
	for <linux-i2c@vger.kernel.org>; Tue, 10 Mar 2026 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155437; cv=none; b=KZX3N21GckPdeDmjWt2G2S6qCQbbDI4AcQ2OPEFHjH2LhNO5WTJH52TbTeLbiHogO/cKN95/aXN2QVyHNeshlnxPqeJGWgfFPlYJSYoxaBFJMXTXAtB4hppzYPKH0S8QGxKZsOgMfg0Ln+veuAuUvCagfEHk8zUQ47PxbIt+43A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155437; c=relaxed/simple;
	bh=QEW3lhhJANPdrCVBmAIqH1dXUDPD23689ylzZ5dnJco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADRxOZoO3UItLRxcfPvKi3CqHZwrowJwk0Jo40/YWFcoeMhkqOIcSN6SGS0x0n/LzIL+1U+W9QanBvthVCDdhk3aLfgh0b2pYvmk0dUL90fz3xKAPr80kSvgczS9WlvDsBv6eYGVatT7cWaaEc0VFyeP36lfVcRwpHgxHIyomt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb40149037so1385577885a.2
        for <linux-i2c@vger.kernel.org>; Tue, 10 Mar 2026 08:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155435; x=1773760235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ru18n38/qbgrYN5XhGLEd0K3IukQ/mw6D37X8x0z/qo=;
        b=iVya0H8dJu5LJgDoHSwCv1FMvDLG9b4dYJXmKjVRTtUT6C2kjdwEODmQyhtc2QlnmU
         8eYjBkobaXWGdbKwC99Zp8r/1if6HJpVtUCBVWKpcpL9cdUgNBtjCYDLBGveRTqVYmKu
         7skdhAzfshQFupeVEmveArRK/eQGbOjB+KBRz6Kcjutmrjf0lZd6KbZZSi/DzeUxGjoK
         NhYqFesxv/3bis8VKkRQERHS9ugiXswET1TEN2HNEKKxtQEL92kTxJLgwmrCZ25bZvAT
         dyXYIJvM3o+mulGkkl2TDsX0SYYsxpkcmwJ5tWc0rDGmUBWGb6Q8Q4A11+pLlQA8l1TZ
         lw+g==
X-Forwarded-Encrypted: i=1; AJvYcCWR0OOj3QonzdtPcTLtO3X0aOnQMxLqOLm1/SmtiBsIkFG1zYlx4cqajfN/HVW9wpkYaBfnY/YmGrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdH6wjrfh/NVhbpsUfHIXr+S1uZJKWnUiLMXz6/UfF8BvBplMh
	RpXrDWUlIVEd0Nmw6/FCrIb/ztY5jzDEwSJvobPzU/EITemVo/H1A7fv8Y+vwtD4
X-Gm-Gg: ATEYQzyScovs3rUAhvY+Jta7WvlJ8Zu1TrFS/MyAxZUJfuSZHHfLpj3fvVvpNdU7xcs
	BZDKREyAQUW+x3lJlH0ZrwQdkuasj0q6avyrW2VnjrOPefYqDltH6l1FfYStBsawBtuAniiMBV4
	FrqzNbt1WVKeyeYSVMTjeME5oL85AYrr5ODMveagcB3MeUfIXGQm6QIeajk0WywsYLkHMLMEBWF
	yGlXE4yYvNjshR/N72cOx/l2i9cZn38OX6SAXRhGIDCnEvbD+CUJAQU5vM2yV3a7xgLKH6ZsmdA
	3g5+E/IQ4QOjUbAAB7dSSFH7eqgWv+t2EgDBEnOjTUBASRMQZCaAbWeh18Bqn2M88RKH03wb3MZ
	L1Q7keTA9nafQ30u3DT/iyRnjLXFONbN3Gm2Y3FFxgoAk0nuBsbo9ZhZJ7uA38VRq2GPY7C/i7O
	xqTvMbmTJZ//VsR/TwRqsJ4e5Tvbd7zqTD+Pr0/6ATDNjGXMROPzY3aqMdjJWCkIkk
X-Received: by 2002:a05:620a:190a:b0:8cd:9322:d449 with SMTP id af79cd13be357-8cd9322d8bamr514411385a.56.1773155435086;
        Tue, 10 Mar 2026 08:10:35 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f4878bbsm899379085a.4.2026.03.10.08.10.34
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 08:10:34 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506251815a3so116522651cf.0
        for <linux-i2c@vger.kernel.org>; Tue, 10 Mar 2026 08:10:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxKWE5sHDfmf5WNji+vmdlX1WvCQOPdcrK5jGOq97IBBjKTURRmOWf35CR9i6jZfqhUHeU//NtmxI=@vger.kernel.org
X-Received: by 2002:a05:6102:c8f:b0:5f1:70fe:3027 with SMTP id
 ada2fe7eead31-5ffe6121c90mr5181206137.24.1773155033187; Tue, 10 Mar 2026
 08:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227135428.783983-1-herve.codina@bootlin.com> <20260227135428.783983-3-herve.codina@bootlin.com>
In-Reply-To: <20260227135428.783983-3-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Mar 2026 16:03:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVVsEB-xb8Jz4ujBam2NxtxAOb7byYa3VR_eHsbTD5rXw@mail.gmail.com>
X-Gm-Features: AaiRm53b7liJL7XJhyMA-JPl81LkjhC0Orfn04kAcG7__Cf3-wDY5cIOlphhcC4
Message-ID: <CAMuHMdVVsEB-xb8Jz4ujBam2NxtxAOb7byYa3VR_eHsbTD5rXw@mail.gmail.com>
Subject: Re: [PATCH v5 02/28] driver core: Rename get_dev_from_fwnode()
 wrapper to get_device_from_fwnode()
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Saravana Kannan <saravanak@google.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Fri, 27 Feb 2026 at 14:55, Herve Codina <herve.codina@bootlin.com> wrote=
:
> get_dev_from_fwnode() calls get_device() and so it acquires a reference
> on the device returned.
>
> In order to be more obvious that this wrapper is a get_device() variant,
> rename it to get_device_from_fwnode().
>
> Suggested-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/lkml/CAGETcx97QjnjVR8Z5g0ndLHpK96hLd4aYSV=
=3DiEkKPNbNOccYmA@mail.gmail.com/
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Saravana Kannan <saravanak@google.com>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

FTR, one more user of get_dev_from_fwnode() appeared in commit
9035073d0ef1de81 ("reset: convert reset core to using firmware nodes")
in reset/next.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
