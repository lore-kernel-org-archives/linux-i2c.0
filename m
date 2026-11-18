Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007445;
	b=rcq8cn3zU9KRkRNITGXRYJdnAfOUODQRawponVR0qUrCbTHtHk+ciuQAMKEPXoCCE+08
	 97e2iLa2Y+V97pVwYG31rhm+fv0rm7z1x/rzR8zj+ajPIvxPDqOI4IXxNGBJRiP6fOtVp
	 ri5era/xPlqNGrjiISRXWWC23IpiErEEpilqV8ZcqIBigC5o3/yDHF4+CELsDkplHlakj
	 rKD6CalM/uJYnSAjYzHezyzTa3V5nijFJavsANueNDkwMvJi02fKMdTJLIl9EoUOfNXjQ
	 q/CVN6+knMomM7jutpkuzw98e6fDu18lGyz7IGtA4CIJSEmedeY4VYTU1/0YmfXh+xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007445;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=OV06CLl8OOdgdpg8BFRH5p75zlrKtpNqJrmClfjwDec=;
	b=NWr3l3NgFj11SO4WA9KJJXJg44SxCrlUl1UekJXVeZ/AhOiLGmt2nyGA3KsYDDN/LTeM
	 Y9S1Q0NIh21rh9+NfQQiax8A+tGr0Vy5Ezo91blzEJWYBBBQAb+cieqxj6bj07BTjAWqm
	 iIMwh1Wmtmcfh1ryDUzCUAIAy3uwhYIjZGKVBOFwEQ+SeuXIPrn5ucw+m/I+ic2gZk0jM
	 8bhk3/WGR7dXrsCq9c/MLS95n39asptM+/Y6pWxTVAUELMsUxI09d0IniAa/MmdSwXgIH
	 4xzmYZruaX5F6EydBPI2YhV9gaG5zjfAm+rDqvE3ywCw74b7SrD97d4Tlc5LaH+pjrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=c6mW8uTi;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5161F606A31C;
	Wed, 18 Nov 2026 13:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5161F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=c6mW8uTi
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1D89BC4F77E;
	Wed, 18 Nov 2026 13:10:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 388B05FE9B;
	Wed, 18 Nov 2026 13:10:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D01C11BC1F63;
	Wed, 18 Nov 2026 14:10:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795007436; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OV06CLl8OOdgdpg8BFRH5p75zlrKtpNqJrmClfjwDec=;
	b=c6mW8uTijMvY1u+q/ndfIhhb1kDgwTGQw2FcUjppnSMBuU++Xyt+psPM2vuszpV7hwFXWK
	I5RwxPdHuYq43NJ6pEeVd2DYl+TKpKOsgSLnEbW7tVys7CSltQlLejZTJpmwh3EG8MNs13
	0gdjarX5VrBwBquZaTbTgPfJeZAXnRooX9mEvXkjT6xXZ0bkHP3zERS8EWC5fLZ0gVrMTk
	8W/QC4VxdJeH8j+8NRemoF/5XoYlNyfuPTDA7EFPflNOFJcocbAQ/U6SqIKrXkaD2NnUv0
	pw9ZpSEOHJqWIpEnr4HTnDA0+IA4u7IQH0Lnm22uWR9DfgXe3Iy1wbLADdr5qw==
Date: Wed, 18 Nov 2026 14:10:28 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Rob Herring <robh@kernel.org>,
 Luca Ceresoli <luca@lucaceresoli.net>, Andi Shyti <andi.shyti@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Rosin <peda@axentia.se>, =?UTF-8?B?TWljaGE=?=
 =?UTF-8?B?xYIgTWlyb3PFgmF3?= <mirq-linux@rere.qmqm.pl>, Jonas
 =?UTF-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2 RESEND] i2c: muxes: Add GPIO-detected hotplug I2C
Message-ID: <20261118141028.24179f5c@bootlin.com>
In-Reply-To: <av2Nb_likDLz1u2c@shikoro>
References: <20251013060018.43851-1-clamor95@gmail.com>
	<w3bn5bqxqjhf4uvxov47rwlvmnbic6xnlk25xbpnbmi2eyup7q@tjuiu7pl3mmo>
	<CAPVz0n1-jN5WLFq4e0CZrneExrN_A=GNeGTwGHTCj14NAta+jQ@mail.gmail.com>
	<aPCfiJxyKOXsgNJe@shikoro>
	<20251021132529.GA4133357-robh@kernel.org>
	<CAPVz0n3jt04xEwGr1aiDTJ7OonYYgOy3QneteLXgdGruXGMP_A@mail.gmail.com>
	<20261118091334.3d51a5f0@bootlin.com>
	<CAPVz0n3=rL9jVc7DtG9FmcH0zs11+LXg1+HRRf9aagUqZf=+_g@mail.gmail.com>
	<av2Nb_likDLz1u2c@shikoro>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 18 Nov 2026 12:35:15 +0100
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> Hi Svyatoslav, and Hervé, and all,
> 
> > > > > > So, if you want upstream supported I2C hot-plugging, you need to wait
> > > > > > for Luca's and Herve's work being accepted. Or provide a superior
> > > > > > solution. Or, if you want, join the ride. You already have experience in
> > > > > > this field (and hardware plus use case), you would be a very welcome
> > > > > > contributor, I would say.  
> > > > >
> > > > > Agreed.
> > > > >
> > > > > What really slows things down is when there is only 1 user of a new
> > > > > binding. Too many times have I accepted one only for the 2nd user to
> > > > > show up right after accepting it and wanting something different. So
> > > > > now I just require more than 1 user and it is on the submitter(s) to do
> > > > > that. After all, it is their itch, not mine.  
> 
> For completeness, let me emphasize the above paragraphs again.
> 
> > > No new advancements. I moved on a prerequisite: Having support for addon
> > > format in dtb in order to have support for a list of exported symbols
> > > resolution when an dtb is applied on a live devicetree.  
> 
> Well, I would consider advancements in prerequisites also advancements.
> 
> > > Anyway, the v3 series [1] need to be updated and a new iteration need to be
> > > sent. Also, same operations need to be done on the SPI version [2].  
> 
> Hervé, is that the next planned step or are there prerequisites needed
> still?

I think this is a planned step. Is it the next one, I don't know.

Support for addon dtb format is a huge topic and I need to move forward on this
topic before switching back to i2c-bus-extension.

Even if we could avoid the need for i2c-bus-extension for I2C with addons, IHMO
decoupling things and having devices that belong on a extension board clearly
identified in a devicetree is a good thing to keep, i2c-bus-extension provides
this decoupling.

On SPI, no way to do without a spi-bus-extension. Chip selects must be translated
between chip select numbers provided by a base board SPI bus, wired to the connector
and chip select numbers seen from the extension board (i.e. chip select numbers at
connector level).

Having extension bus for both I2C and SPI make sense and keep things consistent
between both busses.

Working on extension busses can be done without addon dtb feature. I am just
too busy to work on both topics in parallel.

Best regards,
Hervé

> 
> > Rob, Wolfram, since the DT Addon framework is not mature yet, may
> > i2c-hotplug-gpio be accepted in some form? Maybe a staging driver or  
> 
> I vote against it. Accepting intermediate solutions will slow down the
> proper solution even more.
> 
> > with notes that ABI may be changed and are unstable or maybe as a
> > device specific driver only for transformers like
> > "asus-transformer-dock" etc?  
> 
> Which kernel are you using? Can't you use your driver downstream instead
> of upstream unless Herve's work is usable?
> 
> Happy hacking,
> 
>    Wolfram
> 



-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
