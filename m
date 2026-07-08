Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABED2C3259
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501874; cv=none; b=kgQr/AcZmcgCuiwkrYYzfujLZDcTCmwo76+2iTG3Tu1eM9ZTryg7qPYRdud2tj7My7VaAO32fFh/AknPOldd4ag1TRlnrbCIS6Ki1G6RsAx7kduP+NPdejrinL4plYeWqHxryGH4bQwtbnRiaGD7C/HV5M0g2QVFGQ1u+OPbfgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501874; c=relaxed/simple;
	bh=DVArNrYSiMg8MxFhNbWDCkpRrT1vLwYVqEtdsIQkNJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtoLSZVRtvbRW+cbWn+AR19VTQsXcbql0UrI9QYr09KschPDKWi/klaz1S/Tyws0J2dfk4vWtb94B9bnWakhr6wbWlU1fBlW/1kqiTYSESQ+vT578tbXYMk9E0bBp/vW0GBmoDC6MbJ3sE3jsq6Xlz2V2bN8O0ihuilHw5dMiao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kbr31m1y; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kbr31m1y"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BBCFE1A0ED6;
	Wed,  8 Jul 2026 09:11:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 86F3E60337;
	Wed,  8 Jul 2026 09:11:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6604B11BC334F;
	Wed,  8 Jul 2026 11:11:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783501868; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=y7fDorsALu2Vucac3zTyCEDn5rZ6ELH2pBT2z6iPFwM=;
	b=Kbr31m1yxLHOhTjRlXGbiqF2m8PZfBlqRqmjtWq5aZo/wlwrRJ/kHnLfrizmiNfuyUN4wO
	XAZYkIVIY1pj6Vqat2XVeSKsRd5dyxRrMX+ZaC2u53RV/hrm7drZdEPxo/jT/dzA/0f1/N
	3pZCIzAmW5h8+xgG9xW8VIjI50plCvMZV/jL3u78ey+Y/+dENMa3m0+i56lKQ6WxRLOcg0
	LEEvPowjLTNYNHD0ktIlewF28sO49g/0mf3OWCUSXQC4xlytNoQgymolWoDAwhGi8C95bh
	M+i9QdGGh+MAGeD/tAxJ0F7isNatLFNR9fbuoqC8BZbt/a0371oLwqfymHpJ4g==
Date: Wed, 8 Jul 2026 11:11:02 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Peter Rosin <peda@lysator.liu.se>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, Saravana
 Kannan <saravanak@kernel.org>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Andi Shyti <andi.shyti@kernel.org>,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 2/3] i2c: mux: Set adapter physical device
Message-ID: <20260708111102.468f9171@bootlin.com>
In-Reply-To: <8eecaa15-460f-4f39-b65f-98b8334994be@lysator.liu.se>
References: <20260630103010.413688-1-herve.codina@bootlin.com>
	<20260630103010.413688-3-herve.codina@bootlin.com>
	<8eecaa15-460f-4f39-b65f-98b8334994be@lysator.liu.se>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Peter,

On Sat, 4 Jul 2026 11:28:21 +0200
Peter Rosin <peda@lysator.liu.se> wrote:

> On 2026-06-30 12:30, Herve Codina wrote:
> > For i2c muxes, the parent of the mux adapter device is the adapter
> > device the mux is connected to.
> > 
> > This parent is not the physical device related to the mux adapter.
> > Indeed, the physical device of the mux adapter is the mux device itself.
> > 
> > Fill the adap.physdev with the mux device.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> > ---
> >   drivers/i2c/i2c-mux.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> > index 681a201c239b..f4e73e7a0e33 100644
> > --- a/drivers/i2c/i2c-mux
> > +++ b/drivers/i2c/i2c-mux.c
> > @@ -315,6 +315,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
> >   	priv->adap.algo = &priv->algo;
> >   	priv->adap.algo_data = priv;
> >   	priv->adap.dev.parent = &parent->dev;
> > +	priv->adap.physdev = muxc->dev;
> >   	priv->adap.retries = parent->retries;
> >   	priv->adap.timeout = parent->timeout;
> >   	priv->adap.quirks = parent->quirks;  
> 
> Given how similar the implementation details are for address translators
> and muxes, I expect that this pattern is present there as well.
> 
> I.e. I think a line with "chan->adap.physdev = dev;" should be added to
> the i2c_atr_add_adapter() function (in the obvious place).
> 

Yes, I can add the physdev setting for i2c address translators.

I think also that you will expect the same kind of modification done for
muxes by patch 3 (create missing devlink) to be done for atr.

On my side, I don't have any address translators devices on my boards
I won't be able to test modifications for atr.

Do you think I should add both new patches related to atr (setting physdev
and creating missing devlink) in this series (again, I cannot test atr
modifications on my side) ?

Best regards,
Hervé
