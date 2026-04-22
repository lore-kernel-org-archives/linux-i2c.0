Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532303EF669
	for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776884292; cv=none; b=nBOIFb4f1Kaord3yTmIB3KykoZMitfQj9zHlxToVHB9BD9VWqu4TqmVpoK6iOCvfSPkDWwwVvsbvNWHsny3798sXWCfNIZZ/whh/ZEdgH604hL8tghnluLEb+OnwwCaO1S8oHjPJApJa4Mz0iv+ijNaOjWQs2AhTqRU6AH3PBzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776884292; c=relaxed/simple;
	bh=W3gJGhETv1i99hgZ4Qzxlq7+a/rqAi15n3RaJvZubfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDM5UdPAUHxScpvpcrloS5vxulFj0LjSiMmqTkdlXA6meRE2YqsYl2/snTA6B6gE9X6cIU1fVGYOdnTz9CsbBU+4I2M7iQpEBsQEJMkfvW8ZrB0smJ1ySD+Tq+5IGncE5OOblcIoAUWLD25qLfhrGhgY2smdgOdsBDPmC9Odd3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EWqE7mpO; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EWqE7mpO"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9c9d03524cso803657266b.3
        for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 11:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776884275; x=1777489075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4vBmmJ5gC2QCrFlTLiSjZ3SPsY2SAKP5dBxbzswxUI=;
        b=EWqE7mpOT5Dzeel5Qhvs0qv64YRtUSnfMgIZFwsr1Y/3ekg3DE9uDQwzmM4SKvqEVc
         RcPUizn59NPg/lmvXGr3V1tGr93nqIgAA5/QjKf4ubsIP30tPqHfWMRR3SvD6EE7oR9p
         EcDvR6N/vKWC3E3YG3jCVFdha0iInr1fMeqQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776884275; x=1777489075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R4vBmmJ5gC2QCrFlTLiSjZ3SPsY2SAKP5dBxbzswxUI=;
        b=egqQQhhfvA4bLAZqVQ3KBuelCI/zGdn/Ir3T1zBEIJfkWngi0xq30uKFgx4YIUPqRa
         C/VfzDpTw4QGE++TLtL62Reg4gt2oiqKwhzcRk1fAKmHmhlskuDwWlxPf6moBF7tpgKG
         pY3JSsrlCta9VEcg9exxiF9obCfoRTAsMrvVsW9PAgClQfAe9fa/iUsZCVxMKERlk4ON
         1PReetGlngUaL7Ci4Pl4Nn0yP3k6RFFWbmcJmOX9tK6fta+qAJOZw2JvkX2UjEowoMAN
         +gRORDxdpM01JUmBO+FeuDf7TjxjTo6fSII6GgUjZ66rJVKcyyv7YQRniYOek8qFnDo5
         o/0w==
X-Forwarded-Encrypted: i=1; AFNElJ/aDESkHJhQCg3V9dtEZZj1D1fUpcK8QtRedoRiEbinuql36fg+amDa64R+bFLdiPdI27041EshdmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx87VEdaRpYmHfWQtXaPMKS6I0X7TLAjhJMDlb4mG6mQpBqFYkb
	RmkRUTkVfnK53zgzqcpxrTFsKbdna1pKG1lpsuX8ThQimO89VmyjUAyue+IRDh2ahUptuxi8Z3b
	kak29NpJF
X-Gm-Gg: AeBDieukh6nIEsf6m3ZqFsBlRyOkH17jG9k8FoYrKsX119oIJesadKb3tPxpk8B0q1k
	aVynCGY4IC6CMHHybaFJ/rNSNnYSd/mqZfR5tr+5U46kaxUTLmSOk+mr8vsFyJX+vs+SDNMOzTb
	XLy/xQAWbTMd1le7UQWhKfzDwswzd9Erte9J/dTxr9g2M2U46qbYVWF2zi4b8P5heLPVchA+dR2
	S8JR8PwyeZdYSmaEA+ANvavIqj50i/DTYTlEQKvugjW+UrZSfZnauYw6ycL3vEQMEE86+d1zt0o
	lXAAo1ZOfZrI00sEkj/+3duNOD25QHstgZ6bBNwNyMz08a3lw2aWcY0LtmYnCLo+7VkyclJszFe
	ZLT4aDt22RJS3FE577PPxvwesOwoIJxGIx9af2waE/xCgxCfja3XWdNeKsR73TStURD0mwUXrh6
	AorVUvTiR6MU4IOMuUMs//JXddnKBL7b57djRcHJegzb7gpTfvMi7x9CfhHQQOceSTKd2QxQe0
X-Received: by 2002:a17:907:9449:b0:ba7:f5fd:edd2 with SMTP id a640c23a62f3a-ba7f5fdf17amr784507066b.42.1776884274874;
        Wed, 22 Apr 2026 11:57:54 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45553980csm578316866b.58.2026.04.22.11.57.54
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 11:57:54 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-676d8582a13so2909808a12.0
        for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 11:57:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9S59Tcnm5b57HIy3jCfuj1Il6CmX+lIwxTFg5krrLO17l4NCc2AYRtVsbakh1IsBG2+rpiTdIXjN8=@vger.kernel.org
X-Received: by 2002:a05:6000:2f8a:b0:43d:7a08:a5e6 with SMTP id
 ffacd0b85a97d-43fe3e073c9mr39087653f8f.29.1776883909243; Wed, 22 Apr 2026
 11:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com>
 <20260325143555.451852-3-herve.codina@bootlin.com> <CAMuHMdU7x7LWFkD9xiq+wyOqnn0bdzr+JLfvbBexoiWyv8kftA@mail.gmail.com>
In-Reply-To: <CAMuHMdU7x7LWFkD9xiq+wyOqnn0bdzr+JLfvbBexoiWyv8kftA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 22 Apr 2026 11:51:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UK3NQKQN7FXyG4nGdDKO=LQYhnL4ZweomQ_4R9-EAYag@mail.gmail.com>
X-Gm-Features: AQROBzAV3w_CPq4qi5veiP_uOv4VWrOsaTYpBbypDAKqTbu6jiZzeNsnLIn0Vds
Message-ID: <CAD=FV=UK3NQKQN7FXyG4nGdDKO=LQYhnL4ZweomQ_4R9-EAYag@mail.gmail.com>
Subject: Re: [PATCH v6 02/27] of: dynamic: Fix overlayed devices not probing
 because of fw_devlink
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Herve Codina <herve.codina@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
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
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 22, 2026 at 10:44=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Herv=C3=A9,
>
> CC Douglas
>
> On Wed, 25 Mar 2026 at 15:36, Herve Codina <herve.codina@bootlin.com> wro=
te:
> > From: Saravana Kannan <saravanak@google.com>
> >
> > When an overlay is applied, if the target device has already probed
> > successfully and bound to a device, then some of the fw_devlink logic
> > that ran when the device was probed needs to be rerun. This allows newl=
y
> > created dangling consumers of the overlayed device tree nodes to be
> > moved to become consumers of the target device.
> >
> > Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
> > Reported-by: Herve Codina <herve.codina@bootlin.com>
> > Closes: https://lore.kernel.org/lkml/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgy=
o8x6=3D9F9rZ+-KzjOg@mail.gmail.com/
> > Closes: https://lore.kernel.org/all/20240221095137.616d2aaa@bootlin.com=
/
> > Closes: https://lore.kernel.org/lkml/20240312151835.29ef62a0@bootlin.co=
m/
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Link: https://lore.kernel.org/lkml/20240411235623.1260061-3-saravanak@g=
oogle.com/
> > [Herve: Rebase on top of recent kernel]
> > [Herve: Add the call to driver_deferred_probe_trigger()]
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Tested-by: Kalle Niemi <kaleposti@gmail.com>
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -235,6 +235,79 @@ static void __fw_devlink_pickup_dangling_consumers=
(struct fwnode_handle *fwnode,
> >                 __fw_devlink_pickup_dangling_consumers(child, new_sup);
> >  }
> >
> > +static void fw_devlink_pickup_dangling_consumers(struct device *dev)
> > +{
> > +       struct fwnode_handle *child;
> > +
> > +       guard(mutex)(&fwnode_link_lock);
> > +
> > +       fwnode_for_each_available_child_node(dev->fwnode, child)
> > +               __fw_devlink_pickup_dangling_consumers(child, dev->fwno=
de);
> > +       __fw_devlink_link_to_consumers(dev);
> > +}
> > +
> > +/**
> > + * fw_devlink_refresh_fwnode - Recheck the tree under this firmware no=
de
> > + * @fwnode: The fwnode under which the fwnode tree has changed
> > + *
> > + * This function is mainly meant to adjust the supplier/consumer depen=
dencies
> > + * after a fwnode tree overlay has occurred.
> > + */
> > +void fw_devlink_refresh_fwnode(struct fwnode_handle *fwnode)
> > +{
> > +       struct device *dev;
> > +
> > +       /*
> > +        * Find the closest ancestor fwnode that has been converted to =
a device
> > +        * that can bind to a driver (bus device).
> > +        */
> > +       fwnode_handle_get(fwnode);
> > +       do {
> > +               if (fwnode->flags & FWNODE_FLAG_NOT_DEVICE)
>
> After commit f72e77c33e4b5657 ("device property: Make modifications
> of fwnode "flags" thread safe"), this must be changed to:
>
>     if (fwnode_test_flag(fwnode, FWNODE_FLAG_NOT_DEVICE))
>
> With this change my DT overlays are working again.
>
> I guess keeping the FWNODE_FLAG_* names, but changing their values
> from bit masks to bit numbers was probably not such a good idea,
> as it fails to catch missing conversions...

Crud, I should have thought about that. :( Do you think it's worth it
to do a rename at this point to catch future problems?

-Doug
