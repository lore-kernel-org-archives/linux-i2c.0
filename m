Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E903603CA
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516024; cv=none; b=aXjLDRg/SsBTm42RdAN6HmVTwTU8HZnbYLQa4a8B3LGXZ4ZeVP7W/b6yuQlQYxkVe8jtdNsdbINFnE7p/Do4HssIXTs01t4wlFaTwcjTSZJ4HIIb28yqqdnyJ3Al4jv9hLRaLGQ9aeZRkA++qjV/QW6rsSAYTaF4TzLRaH0vGoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516024; c=relaxed/simple;
	bh=1TzaCDI1+JWxmUau8vYOJqiF9XlrFrSbb3k3byq/E5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Er9LEQJEH+Zk/SuoBSK0Ea17lWKMFUg3d750gtAIQ1dSeG6eZ5sxH8RFx60QQDEI5c/D0PZJ0qQKVbv0eyxEBrOOQc7SRc8Lf2GoH5m+PYQPLl9oQmIV58vKFaw7GF5vRaW0po/TOB7FouVPlDE1QE9mjaFeT8xQlfTEjlq1w2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fZB0OdV2; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fZB0OdV2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1F6364E42BF3;
	Mon, 11 May 2026 16:13:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DF4C960646;
	Mon, 11 May 2026 16:13:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AB74111AF9F45;
	Mon, 11 May 2026 18:13:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778516019; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9QJE5rWP/MNjg3svbbHFxSI4hthH0tMoTvM+RF9P1Is=;
	b=fZB0OdV2hsw5usHJBb9ov/CKadtw9OCv86zTjUQRiiPHNCft7HOFEEGmQWMP60bYIPidDp
	9lA+rU20RnirftJ69NixUrg+ySxp+18xTl3L6CJoLL8+Jpte8ntDzghkUc1A7A2rqljqeW
	/ouM5myLwZZSosd0/s8CyNtcV6guIBkJjK+Zk9PRKizAhdHKoR6Dq3VVb3HiuhEqHt4+n4
	HIobfL7jW1iF5O7oXYogUkSxZRN7OifScmHzJWGd3pkoN2OQqKlEl9loLSwlHNQKoVPPqJ
	7Cc1DawrSGoc6oe8MhMmMrO93FGT5zJyTTTLuQf7gdFLkWV7fJcxlK5Q6HuuGw==
Date: Mon, 11 May 2026 18:13:34 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Andi Shyti
 <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 0/1] lan966x pci device: Add support for SFPs, clock
 dependency part
Message-ID: <20260511181334.26fc869f@bootlin.com>
In-Reply-To: <20260511160128.34786-1-herve.codina@bootlin.com>
References: <20260511160128.34786-1-herve.codina@bootlin.com>
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

Hi Wolfram, Andi,

On Mon, 11 May 2026 18:01:26 +0200
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
> This current series is the extraction of a patch related to a clock
> build dependency issues.

Oups, this was not the correct series.

Nothing to do with i2c. A wrong command on my side.

The serie has been already sent to correct (clock) maintainers.
Please ignore this one on i2c side.

Sorry for the noise.

Best regards,
Hervé
