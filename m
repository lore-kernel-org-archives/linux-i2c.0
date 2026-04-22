Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C143F26299
	for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886914; cv=none; b=PF9Us/EvIvqUKEP3MQNivA4e3aHM16W75B4NRE/CZRuhJM/pQE+CizKROfOm9x4Bq4kM/7KECdX5Mh8tWPJAh036rISO1vv89AdJReVIujRZgvLrl0SaMW0gca3ZLpToH84vRypAV+AIsZOQgraCzMhUhUhMQDvNMFmvr72sQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886914; c=relaxed/simple;
	bh=1jDHS3//SVF2/A/vC8oT6/lwq+kdzpM3dPjKRF+cWNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLZpWhmKSQLQbkxnsGOcwtkRhNICnCY5lwcdbKUZyte0LLhCzbS1nOw7oudGGf+3H8W4tD8iLsnYocwnAH88WIAdkaiqbwAUXrvGBnv+V3WSNOsQ4QE0ZpFwnVPkiBaiwGn/Uy+FgSR7L9q0mGiR+snFGEwSSbfL4MAU0htEcEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U3aT7Vb9; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U3aT7Vb9"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b936331786dso762367066b.3
        for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 12:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776886911; x=1777491711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8JHz3Efp15Ndyc9pOP3Ax7qZyPD4IXnQM3cK5pq58E=;
        b=U3aT7Vb98Lz8VE8YP8B4RfEmiuRakVNOfRB7NHV9X5AiP7l4zS/sibLutYsw7zc8iB
         wOrBNBE33ZDlSna+xieWJQJqkgafD0jnmxRUz+gO2EKRwm8MgJSPBa6/MHFIZU3y5CcR
         9pfCAvLcZGN6WKHzwySHOOkH1zPaOY4Ui7kaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776886911; x=1777491711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A8JHz3Efp15Ndyc9pOP3Ax7qZyPD4IXnQM3cK5pq58E=;
        b=R614HdFm9nmla911DHnOxGpX9oFL4zO/dyGn3ZysBjtnRuZBrDJmOXoGDjlCBUY0jX
         wMSv3KLfFL4EUM1mvcNmF4AiSJku7O3jNEPDaGt3n7G3iykhYsB3Oj1nlV/j9ymSpBTb
         BBPJhwTYqipwLLhGD2htMLxM99uSAix+iEje3zVC1WDAmd2S6PKgvluLbwm136AIW0YH
         +inFqTf1oZ9OD2p2flGKXmBKe3juZ8yCMyFRFYD1n9Uf+PugsXL1Xln7CIZZQpkj9lBd
         qZjtadbaQgpqoVwvKKjN52PglSzkkHCwgJpf2YNFL1OARjp3G6xIZX+H2lRxrPwuGJPV
         GswQ==
X-Forwarded-Encrypted: i=1; AFNElJ9yTJsbbFay41DGZszCEYTKdsJA7MrDN3KIXw5ceu8COhH2FTgdH8YsRnK/Q5pp4FSaFUjOmIo9qnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye8J085JnWl0hhzH70QqfPOAaADR6Jepwtvc4ezoS3wzYK8C91
	QIA0bZVOT16cHRE2A1AwwYHZeHvGIdD/9em5POHR/QqMvdrAZr4/u7CVHGGF1b9jZNxrM6w+eJ3
	Bof8ndi5D
X-Gm-Gg: AeBDietsJC7LFXl0UM2zIpqw5erJ5TG8+gJo32gn5oT50eLvo76Q+6YrUbThq4G512h
	iq6qvPBk4FvdhXBqW4gxoyuUY3AJKCPB0ry6VPB3CTQd2tQ8Qu88SM1EQQY/HDwaoyIszrALtLd
	63OHwoIWrqH4lfPL6LoAc2QMxfUBXsuOJPHRku9NFSbkGaKqYLwVDRkYuNB4hTukMJnxibcvPyX
	9rLecBB833+/ZKWYukIPpL20J5RhMvWIZ1/Pd6HDAe2suQoLeS3IIS0tD5Y1dpJV9Jw5In5uRI+
	Ygl4L2cfb//W+XTf3Ol9GW/gmqX64pbDhEf1d8yZsLa6UcuYd2/Y+V9GCtJAMGLz/RaP/u4ymB4
	pKz4vza79JjcdRn7z8J7DZyC4SASv0xs0x/4GIxgyo8yHJfPNfxmPJKChCSOffyZYeVl1cJRpkP
	Fmh6+J/Coy+EKon283tAbOjl8fkrFxQpyk2A9cIXLiVaRW2Q8Nxz4K6BWa3OMTkWBzeB6OiJmt
X-Received: by 2002:a17:907:8dc3:b0:ba6:e69d:f50e with SMTP id a640c23a62f3a-ba6e69e2371mr813365866b.22.1776886910697;
        Wed, 22 Apr 2026 12:41:50 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba538429115sm532339966b.15.2026.04.22.12.41.50
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 12:41:50 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ba61a0a2d26so666366166b.2
        for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 12:41:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8f1hI4RQdl8CMbW5m7TFLGOCI1WpGuagbny5wHEjeQlA4wtWs1EIGF1TRiYrNvUahsO+trcOdC4pA=@vger.kernel.org
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5b with SMTP id
 5b1f17b1804b1-48a55743d05mr122645615e9.27.1776886533988; Wed, 22 Apr 2026
 12:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com>
 <20260325143555.451852-3-herve.codina@bootlin.com> <CAMuHMdU7x7LWFkD9xiq+wyOqnn0bdzr+JLfvbBexoiWyv8kftA@mail.gmail.com>
 <CAD=FV=UK3NQKQN7FXyG4nGdDKO=LQYhnL4ZweomQ_4R9-EAYag@mail.gmail.com> <aekg_IELc65BFrWp@ashevche-desk.local>
In-Reply-To: <aekg_IELc65BFrWp@ashevche-desk.local>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 22 Apr 2026 12:35:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
X-Gm-Features: AQROBzBA2DSdR2HBaIYSKp4MrG-iWYSiPDxUw6OYCOPyJYNxN20LzPXgyZNheJI
Message-ID: <CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
Subject: Re: [PATCH v6 02/27] of: dynamic: Fix overlayed devices not probing
 because of fw_devlink
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Herve Codina <herve.codina@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
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
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 22, 2026 at 12:27=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Apr 22, 2026 at 11:51:36AM -0700, Doug Anderson wrote:
> > On Wed, Apr 22, 2026 at 10:44=E2=80=AFAM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Wed, 25 Mar 2026 at 15:36, Herve Codina <herve.codina@bootlin.com>=
 wrote:
>
> ...
>
> > > > +               if (fwnode->flags & FWNODE_FLAG_NOT_DEVICE)
> > >
> > > After commit f72e77c33e4b5657 ("device property: Make modifications
> > > of fwnode "flags" thread safe"), this must be changed to:
> > >
> > >     if (fwnode_test_flag(fwnode, FWNODE_FLAG_NOT_DEVICE))
> > >
> > > With this change my DT overlays are working again.
> > >
> > > I guess keeping the FWNODE_FLAG_* names, but changing their values
> > > from bit masks to bit numbers was probably not such a good idea,
> > > as it fails to catch missing conversions...
> >
> > Crud, I should have thought about that. :( Do you think it's worth it
> > to do a rename at this point to catch future problems?
>
> You can try locally with allyesconfig / allmodconfig and see the outcome.
> If there are missed cases, and their amount reasonably low, I won't bothe=
r
> in this case.

I believe I caught all of them at the time of my CL, but the problem
is in-flight stuff, right? I think the problem Geert is pointing out
isn't something I missed in my original patch but rather an
interaction between my patch and this in-flight patch.

> But for the future it's kinda rule of thumb to rename when
> semantics changed.

Noted. I've certainly done that before, but I didn't think about it in
this case.

-Doug
