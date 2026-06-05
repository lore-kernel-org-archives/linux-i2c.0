Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8634F3B9DB3
	for <linux-i2c@vger.kernel.org>; Fri,  5 Jun 2026 06:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780640456; cv=none; b=HqFYgGU1V2pYv3KE64WV2QVOWriyK5DjFZ2/G3/+q4Bp3j15LF2NFHRiPqq0VWQdTmYfrn2/FbDr944fBXG55ePqoOx6H+et5OZOVphuVu6uX6OiJ2QvmeNoYYJyntiExuRrRXBDgawBzVLnBeyc0rI/aJh633AmKI8lCEpu2gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780640456; c=relaxed/simple;
	bh=+jzJPvwOEJaIiNDqF6iMVYHjAY2G/SOg8AdG+lPzoSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/lpMseveVwSCMCMPJ1l4b2vQIdLFYlI9Z5u5Vbg/rVo7JdkDip7xd3KeNYIF6AqIDAkk5bS2hvNX2WXg0920TIQ5NUXBv9KEEKSZZi2Zv+6O4s4f4L5MPHSD4hNqFzthN+4qwR9J7K8QV1XSiXBljUCiJmGCBK5FLVmXuFiUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FiQPwTRh; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FiQPwTRh"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4CB47C5846F;
	Fri,  5 Jun 2026 06:20:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AF5535FED1;
	Fri,  5 Jun 2026 06:20:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6926F106A1E91;
	Fri,  5 Jun 2026 08:20:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780640453; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=goBdelbmqDPUNuww9i30YtyTnm4DxBaKBXuOFmsSbGY=;
	b=FiQPwTRhiqnVpcVBSEQt/t2r9luGJ4MHQbtZ7mtpe73RMOp6yMRcTyt2NCvrpl+AozYXD3
	9xr2NcNRoJHgFSDKjoqOS3ADMi/B5UCpDKzr7iz8eiq6knZ13Zj8NieINpBmCDGuN4VgSX
	2tWy3lq1Os5yMLTwLde0Henx29LsguSuZCU84+wblrdXWSKyxg6Ju6qp1sL/9GaycT51+O
	MWkNVx9NlSWVfW7hs9HhqCIk1P2+rFrT4xF5f4g6ixJIMhhuE/gmT29lsW4Yj9jZ6Ljpn7
	eO1w0siO2YFjcxZB4fEmm/Atr3lISODuLmeZXbFRXkf3D4LJi1pBjdIjbJsm4g==
Date: Fri, 5 Jun 2026 08:20:50 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Andi Shyti
 <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 1/1] i2c: busses: at91: Add MCHP_LAN966X_PCI
 dependency
Message-ID: <20260605082050.21b20699@bootlin.com>
In-Reply-To: <20260511161355.35656-2-herve.codina@bootlin.com>
References: <20260511161355.35656-1-herve.codina@bootlin.com>
	<20260511161355.35656-2-herve.codina@bootlin.com>
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

Hi Andy,

On Mon, 11 May 2026 18:13:49 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> The AT91 I2C driver depends on ARCH_MICROCHIP.
> 
> This I2C controller can be used by the LAN966x PCI device and so
> it needs to be available when the LAN966x PCI device is enabled.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Acked-by: Andi Shyti <andi.shyti@kernel.org>
> ---
>  drivers/i2c/busses/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

IMHO the patch is ready to be applied.

Do you think something is missing?

Best regards,
Hervé
