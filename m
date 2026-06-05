Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B99405C43
	for <linux-i2c@vger.kernel.org>; Fri,  5 Jun 2026 06:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641126; cv=none; b=LBP1GkFvALdimKKviDBIrIl1dpzcw+pn8HPzcmalfzSvMxCtoU7cgBNunkgz2d8XBJHu5xXsPJ593UBq9M30iraFrQOk1KGSnM7szhMS8lMCr/qImMHjdB85Efm0k0Gdau+CWziKal4WV7jAafj4ramM6222TWZDV3qKinlaltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641126; c=relaxed/simple;
	bh=gxJooimdWcb3bF6nxD6P2ciLJcHuZypCeXCTwcF5DJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXLMLKlIj2Zukl0wMoT3yakS20ePLfiGGg+2uw9zawrR+ggpO/oO/lpHfO+B59azsDsICKEszTTz3BPSkWnt/uWK0OfVUWmAmC8vqL8+As2KYFbzmlnv2GYsKJC2ZAboTJZ5yle3YsBVKEiU320pfhEMs4CZXjYVf4nvL6hOD04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rUQsSZ9x; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rUQsSZ9x"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F1221C5846E;
	Fri,  5 Jun 2026 06:32:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5E6655FED1;
	Fri,  5 Jun 2026 06:32:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 929EA106A1E91;
	Fri,  5 Jun 2026 08:31:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780641121; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RW7JVpHYopt2RBSmx9ADt8ap+K4fSWU7MBfe36CUFDE=;
	b=rUQsSZ9xwmGu2JjnWro+7MNq0KCpEGzNUuKVIEcUZ2T1dZywXDphdknsYLIsZdRFKyZfKC
	nlGxKCuDP/xfPefFb8y4GFAW9wSQiC1cibyFDos2ijZQZ1igx8Y2L2rmzJpJQgcAEdho7R
	RHhop/kvwa2A6df5QIIPvRERKloNE3wVUa9YNFd7TcoE8q6fBoys/n6M/MEsVrWYhb9XqG
	NUIvGwo07de5XH3JTEk90BfSAwptk95oqtVURHWp8p/o5b/S+JH15rW+VPbFNtI64eA4eN
	H9qI+K9iCYdCHvHMpExe4rxyGFVBYdSPH7PrwbkipZB9bHBZqdfyLNb9xNRNxA==
Date: Fri, 5 Jun 2026 08:31:58 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, Saravana
 Kannan <saravanak@kernel.org>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, Andi
 Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 0/3] lan966x pci device: Add support for SFPs, i2c
 part
Message-ID: <20260605083158.28ac874f@bootlin.com>
In-Reply-To: <20260511160051.34700-1-herve.codina@bootlin.com>
References: <20260511160051.34700-1-herve.codina@bootlin.com>
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

Hi Andy, all,

On Mon, 11 May 2026 18:00:47 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi,
> 
> Previously, I sent a big picture series adding support for SFP ports
> available on the LAN966x PCI device [0].
> 
> In this series patches touch several parts and sub-system in the kernel.
> Reviews have be done and it makes sense to split the series and send
> parts separately.
> 
> This current series is the extraction of patches related to issues in
> the I2C subsystem. It has to be seen as a continuation of the big
> picture series but related to this specific I2C part.
> 
> Those patches are related fw_delink issues specific to I2C muxes.
> 
> They purpose is to correctly set a link between an adapter supplier and
> its consumer. Indeed, an i2c mux adapter's parent is not the i2c mux
> supplier but the adapter the i2c mux is connected to. Adding a new link
> between the adapter supplier involved when i2c muxes are used avoid a
> freeze observed during device removal.
> 
> [0] https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/
> 
> Best regards,
> Hervé
> 

I known maintainers are busy but I didn't receive any feedback.

Do you have any comments on the series?

Best regards,
Hervé
