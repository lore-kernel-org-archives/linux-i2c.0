Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC0C1D5AD4
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776927691; cv=none; b=sNl7IhwF6qTKw4I2lWCQf412gLgD4XFCPYKH5KzuVYFVnzhwe63s2s+vmCHPQ+nbm1TVf3YNf9iwocEHUCvNY3XAnoagA30emx4fRSdJaQbogjHn9JONa/SAGvKSoTU7BkgC6D0EbYd2SaiWkrT6HO+dnPrlI2Px3kR6Rw64O08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776927691; c=relaxed/simple;
	bh=hexwbOGW/6m/Df6+GU12KM4IKYYaGu617h9GqYfIhNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XU6IovkrgkxgoPPPs7Cx03Ecoy39JrTJKcEZQLw/vaoRzemBLA9yAGK4EpaIX7XqLSMtTr+p7j1bwqx0QtXKx7B7AEnIFtV2grmXISrXNW72W/z5W/d8VW5QrTBNUQIUJDohjsdOt8ZyDlrAeDP6HNPSkf2Z1Y0LDgVF4OB7IGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79ab3e26cceso57510937b3.3
        for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 00:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776927690; x=1777532490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FB5PTwtw54UUlBS193h15pAhGHmMjXQQ1mJTpaYMvb8=;
        b=XUlCMgDk8Fi0d5oaWN3Syx46N9JqLmKQIgRxuFzce0X2KjQoKK9NR8hXAoZxUzNpKK
         LLD+5gVTY4AKiuO9KDHx8Sr1Nkc+e2rECEcAjWBb2HseRcTgAasn2vrr8NwqZ7A4SlPW
         T+A8mS+qAotPoZA0wYNJyvqP7ZuXPJgKi7TVf7P1hriLAI0MTdck/zBazpaP8xErHdq+
         7rO2Rn73EjIVCLI0dpwmMTWg0P67VFiu+vI5uh4k7L8Sv3yO9NOY1RX+MSmP1Mbti8Hk
         dV+jzx4l89STlKJ1jErP3d4em2ATr4UJ5vvQz820gZjz2yaet3yy6dwLftF9FkHlpITq
         Y0og==
X-Forwarded-Encrypted: i=1; AFNElJ/e7bzO6V5qdZcleKQdtjz61J0mfjnUwNq7ommiGA2qC1zIggU3K6l4W7MAFyMF6EBtny6c+jNaBOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7RRijD60SPQWkBrVHo900YTm6iUfQwd5dOu1/qb+q1eltOtqd
	7gX5XvRNB1jVP8EVSxkmLIP/SmzgDyTzOo2o/Qe8cFKSdqmhBPw1+t5Iq6/cMe9wb50=
X-Gm-Gg: AeBDieupceHPnNw1hW0FmqUntGAB7C+JP3N2N1NiPRRYkDNXZ1HVo83XCb9AlFXGTNZ
	nyHhZuEi+ukEn6+ncFYcbhDGo/BlYvbDzVodzl+WwqRNwdEHT201mDNVsaIDWBIFqg2W6HwrqFD
	UW6pSV+8rGmMs0jVmgrXqOA5AJF/F+8z7vVo/I1v73LIiX9rP85PNL5ZIRol9fSBE/ayulRt33/
	8H3SfH774GAnLCxktT/banDkQqPe/lGTBsh7ZWhgUvYEp6UNvNz3PAdMaBvCkKfcx4dxWn+ulvq
	HyzrXf5kehWvx3ALJ+fIiDkmlhadzrZj1QJa671OgqaOaQSW4Z+kik/QtZQnNDKFp/vG+lAk71s
	6EP6ssfkgD4RQDjX5e8MW2ro5emzuWa1sYxNnWQL5GpxV1jJS3GzNbkYZ4uJ0uahKxkSzibMj8g
	+7zJLWMOHVyAedQewBVUS4n0Z+D/gPM87OCrbB0hXTioeKAq3N1bhiHvcHrHNx4FeOlQeFh7E=
X-Received: by 2002:a05:690c:39a:b0:7b9:39f:62c8 with SMTP id 00721157ae682-7b9ecf97d5amr261080647b3.27.1776927689524;
        Thu, 23 Apr 2026 00:01:29 -0700 (PDT)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com. [74.125.224.45])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee8c2083sm76683657b3.17.2026.04.23.00.01.29
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 00:01:29 -0700 (PDT)
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-651bc83e74aso5167005d50.2
        for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 00:01:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8ed06BPd+B+t/CeFPP9kI+a5s4WMv6FRhuFiFysEbjmLhvjodZ5BRwbDDsxHBXDbErbjwZxHmwGBw=@vger.kernel.org
X-Received: by 2002:a05:6102:441d:b0:611:6fef:905 with SMTP id
 ada2fe7eead31-616f750858emr13450072137.20.1776927225241; Wed, 22 Apr 2026
 23:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com>
 <20260325143555.451852-3-herve.codina@bootlin.com> <CAMuHMdU7x7LWFkD9xiq+wyOqnn0bdzr+JLfvbBexoiWyv8kftA@mail.gmail.com>
 <CAD=FV=UK3NQKQN7FXyG4nGdDKO=LQYhnL4ZweomQ_4R9-EAYag@mail.gmail.com>
 <aekg_IELc65BFrWp@ashevche-desk.local> <CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
In-Reply-To: <CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Apr 2026 08:53:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUDCQrQ2Z9D7-ZOKiuDznDJVf2R_b_8P9+Xhk4RiJ3vdw@mail.gmail.com>
X-Gm-Features: AQROBzAvgx3axNivzcvHu1RjLcwZ8ZssrkMMWMoOA6QWZi8LwGEf_PBN_biPlMM
Message-ID: <CAMuHMdUDCQrQ2Z9D7-ZOKiuDznDJVf2R_b_8P9+Xhk4RiJ3vdw@mail.gmail.com>
Subject: Re: [PATCH v6 02/27] of: dynamic: Fix overlayed devices not probing
 because of fw_devlink
To: Doug Anderson <dianders@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Herve Codina <herve.codina@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
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

Hi Doug,

On Wed, 22 Apr 2026 at 21:40, Doug Anderson <dianders@chromium.org> wrote:
> On Wed, Apr 22, 2026 at 12:27=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Apr 22, 2026 at 11:51:36AM -0700, Doug Anderson wrote:
> > > On Wed, Apr 22, 2026 at 10:44=E2=80=AFAM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Wed, 25 Mar 2026 at 15:36, Herve Codina <herve.codina@bootlin.co=
m> wrote:
> >
> > ...
> >
> > > > > +               if (fwnode->flags & FWNODE_FLAG_NOT_DEVICE)
> > > >
> > > > After commit f72e77c33e4b5657 ("device property: Make modifications
> > > > of fwnode "flags" thread safe"), this must be changed to:
> > > >
> > > >     if (fwnode_test_flag(fwnode, FWNODE_FLAG_NOT_DEVICE))
> > > >
> > > > With this change my DT overlays are working again.
> > > >
> > > > I guess keeping the FWNODE_FLAG_* names, but changing their values
> > > > from bit masks to bit numbers was probably not such a good idea,
> > > > as it fails to catch missing conversions...
> > >
> > > Crud, I should have thought about that. :( Do you think it's worth it
> > > to do a rename at this point to catch future problems?

I am afraid it is too late (it is already in Linus' tree), and would
add only more to the confusion.  We just have to take care when this
patch (and 01/27) is backported to stable.  Fortunately the reverse
is caught, as the fwnode_*_flag() helpers did not exist before.

> > You can try locally with allyesconfig / allmodconfig and see the outcom=
e.
> > If there are missed cases, and their amount reasonably low, I won't bot=
her
> > in this case.
>
> I believe I caught all of them at the time of my CL, but the problem
> is in-flight stuff, right? I think the problem Geert is pointing out
> isn't something I missed in my original patch but rather an
> interaction between my patch and this in-flight patch.

There are no unconverted cases in upstream or linux-next
(I checked yesterday, and rechecked this morning).

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
