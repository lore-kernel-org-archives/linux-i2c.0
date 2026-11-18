Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794989625;
	b=ndZCHyFxb4SAFwDC4b3NsvhF4wkB9vzYexxxx6pTkzmGs1tay5wN5HkQ0RQTlp8D8or3
	 QuuleA1tAhUdC3g+T9XcqkF6V+Qnt8tmWPikE4B96gXQQrTn9wumTFe/em6Po+2TKAmsY
	 CmkQcMkJR6AuLFEhT5ChAxqeooNQplKCgyXInv4h8seY1eQBMEygWRw4OW/JVFdnCIgz6
	 LwlDiesTHPYdQFkt3lHljmFTWb2g4xP5v1hJyOU+sA1kCw0JQspTyaU8p5NeE28VtxyxC
	 64IiJHGbERs+O5YBUUfv9MNTy3VczTKrf/Yt/9t0NV5DA29y1xUMa/KiMAMqOAY5ebw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989625;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=WYyTzxO2ETRiJUcj33BfWavJfCzA6eXVlj29pjh6uOk=;
	b=anGsC0QLpbi1JvwiroRT7fv8u3MUG5n60D1behq+0kIVR4Q1j94cVapELY4KsSiKOenP
	 jft0pdEPdZ41hIf1q6FFDiazZiRXOzuf2qFLM892qoj9C85yO/j111/YA7K0NvyWc12IB
	 lL8+SXbo8D78fUrPeEQQmlVzX1WtGVlfuNkkk8THBFyQNlwL/HNqidjInI9j3uMXKkVib
	 yXBXcfOOmdO9D70YnBjOk+vSKDki0/0IS+aE81FnjQswNE/BhWf0qgNufz3R41bgKlKTZ
	 sptrRazM0hNFvmJn29X4Jn6AfO3bDQyRhWqwgPR4VoDhlYlJAiTTCJv4HoBd6XDiIpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JpUBqGod;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE31606A32C;
	Wed, 18 Nov 2026 08:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EE31606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JpUBqGod
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6CF561A16A7;
	Wed, 18 Nov 2026 08:13:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2EA455FE9B;
	Wed, 18 Nov 2026 08:13:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C022C11BC07B0;
	Wed, 18 Nov 2026 09:13:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794989622; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WYyTzxO2ETRiJUcj33BfWavJfCzA6eXVlj29pjh6uOk=;
	b=JpUBqGodIl5ANwxil/ZfClbFcF4GJqmoPYauYylAL1OeFCrSY4BOsOFB1uYA7twru1jWRH
	i+H5bcmdoWe4H/CJ+Nv+8c15EEVxHupjaEuzDjruNlMebQFpsYOILj6Hmj4XP7k+5HAvMD
	u//04/Mq01Esj/TZIq4zGhujzIHk4+L0+i5Q73Jl/VIzuztupAYVjrcKGHqB+DayZYRFNe
	i6GZc0a/3Kuag3X8KK+CDn9QubDCPLK1nw0K5YZOpRKeAH0iGfHc3+q6IAlzd0GG2z0zak
	2fIitc71vXpZ2aoz7oRGGX4Vy+yn0ePwPodaj4ZtW7L5JXlPfu6DlrQlLoTLhQ==
Date: Wed, 18 Nov 2026 09:13:34 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Luca Ceresoli
 <luca@lucaceresoli.net>, Rob Herring <robh@kernel.org>, Andi Shyti
 <andi.shyti@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Peter Rosin <peda@axentia.se>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Jonas
 =?UTF-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2 RESEND] i2c: muxes: Add GPIO-detected hotplug I2C
Message-ID: <20261118091334.3d51a5f0@bootlin.com>
In-Reply-To: <CAPVz0n3jt04xEwGr1aiDTJ7OonYYgOy3QneteLXgdGruXGMP_A@mail.gmail.com>
References: <20251013060018.43851-1-clamor95@gmail.com>
	<w3bn5bqxqjhf4uvxov47rwlvmnbic6xnlk25xbpnbmi2eyup7q@tjuiu7pl3mmo>
	<CAPVz0n1-jN5WLFq4e0CZrneExrN_A=GNeGTwGHTCj14NAta+jQ@mail.gmail.com>
	<aPCfiJxyKOXsgNJe@shikoro>
	<20251021132529.GA4133357-robh@kernel.org>
	<CAPVz0n3jt04xEwGr1aiDTJ7OonYYgOy3QneteLXgdGruXGMP_A@mail.gmail.com>
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

Hi Svyatoslav,

On Sat, 17 Oct 2026 20:17:39 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> вт, 21 жовт. 2025 р. о 16:25 Rob Herring <robh@kernel.org> пише:
> >
> > On Thu, Oct 16, 2025 at 09:32:24AM +0200, Wolfram Sang wrote:  
> > > Hi Svyatoslav,
> > >  
> > > > Herve and Luca did not come up with anything meaningful, they provided
> > > > just a few rough ideas. It will take an inconsiderate amount of time  
> > >
> > > Well, IIRC they said that your use case can be mapped onto their
> > > approach. Which is meaningful in my book.
> > >  
> > > > before there will be any consensus between them and schema
> > > > maintainers, and even more time would be requited to settle this into
> > > > schemas and implement into drivers. Why should I suffer from this? Why
> > > > should changes I need be halted due to some incomplete 'ideas'? This
> > > > driver uses existing i2c mux framework and fits into it just fine.  
> > >
> > > I am sorry to bring you bad news, but you need to suffer because this is
> > > how development goes. If I get presented a generic solution (see Herve's
> > > mail) and a specific solution (your driver), for this case I as a
> > > maintainer will prefer the generic solution. Generic solutions need more
> > > time because there are more things to handle, of course. This is typical
> > > for development, I would say, it is not Linux or Free Software specific.
> > >
> > > I appreciate that you tackled your issue and were open to share it with
> > > the community. I see the work being done there. However, there are so
> > > many things going on independently that I can't really prevent double
> > > development from happening despite it having a high priority for me. As
> > > soon as I get aware of people working on similar issues, I connect them.
> > > That's what I did here as well.
> > >
> > > So, if you want upstream supported I2C hot-plugging, you need to wait
> > > for Luca's and Herve's work being accepted. Or provide a superior
> > > solution. Or, if you want, join the ride. You already have experience in
> > > this field (and hardware plus use case), you would be a very welcome
> > > contributor, I would say.  
> >
> > Agreed.
> >
> > What really slows things down is when there is only 1 user of a new
> > binding. Too many times have I accepted one only for the 2nd user to
> > show up right after accepting it and wanting something different. So
> > now I just require more than 1 user and it is on the submitter(s) to do
> > that. After all, it is their itch, not mine.
> >
> > Rob  
> 
> Hello there!
> 
> Were there any advancements with i2c-bus-extension so that I could
> finally configure and make my tablet work? Could anyone point me in
> the right direction? Thanks.

No new advancements. I moved on a prerequisite: Having support for addon
format in dtb in order to have support for a list of exported symbols
resolution when an dtb is applied on a live devicetree.

Anyway, the v3 series [1] need to be updated and a new iteration need to be
sent. Also, same operations need to be done on the SPI version [2].

[1] https://lore.kernel.org/all/20250618082313.549140-1-herve.codina@bootlin.com/
[2] https://lore.kernel.org/all/20250729-spi-bus-extension-v1-0-b20c73f2161a@beagleboard.org/

Best regards,
Hervé
