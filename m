Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723960;
	b=WFwfp3OpnVUO98+zhK/A391rOGinMY/M0FeZMH/WRJbmBcJaSallroJMJZriLMcAjHdz
	 Kc42zWNixtngEXIVq0/UgWM0Ol69Qw/TR3Eaw7xSPbNr7vPqEQdA/AIe5NKCPlIec/ZvM
	 O3fkUSR8CYKKJEk0t4tZ7EvySFAAtm7EozpCfo+BT9kGPzqh5RrYcCiYPSbvZ4bH/SWHY
	 +W359UAAAw4PBiJyfo2Fu2DP/SkXrgpo3OjW7H0aA6J+55016LNSSFZ2FW2eRmLhytmTf
	 IIqKvU2dRLA6Fin66qJCBMEyVisoKElDabSy0s2lxnp+j79MA4vppXPtiG4fubsrs8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723960;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=oZsjAb6zLwPp0TJs4AixW9+hdl4OwhgbeWLiflyHFIM=;
	b=mKUdbhVgSmDEdg0g2J6zTmrW3YSkqsKhaHK4PftrU6Le+e+3oE0RrLmjgf03qbKMDRXz
	 V8/3l9qeeHLMrjnj+AdxXT6xZXFgVwKRPGQewgn5vbB/V577Q/fvVoDDrHL9vSeu7bCbt
	 dLY4kHQQl97+dHFV+OW0FyAgQD/yj7flqWx8yvUEglg1U/4QShxhHdY9LBWrqI243by52
	 +AJDoQ3FoRHlHAOEFsAZwnHKraTKUJGRFXvcfCv+3KRWgM41+Db2BVAKq+Y0culBZ+PMn
	 Ga0nMbJGx7gDBGIi6LbOBgvMmcKC5pCd2WhTKqWlQTXhJj7oBjWydzqVXMczHjkCXTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Q8Hb8oMt;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F740606EE9E
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 16:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F740606EE9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Q8Hb8oMt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=oZsj
	Ab6zLwPp0TJs4AixW9+hdl4OwhgbeWLiflyHFIM=; b=Q8Hb8oMtVc/5naDLltyf
	nHbDx4q0Ld8aNDXx/KR8AiVXzACj0uHu/YXU3zpTWzWnaLx3nqd4Dleu9vJQZ5eV
	EzfCgefF2HcZeZAmoIhcQi+34PbKjJQIs1AxqImORDTzuRIRYNoo2lxgZhdrvlZS
	DNtobCFdroATQst4hlEFhfNGV0zwbF4RzhpP+XzicxlyC9UGRfIDwI1Id5lprrj4
	qvkYeVAkpNfVs2YVXHXHtGKVGGs8ReFLDBsXREK/yqNCjzNjqEPc3nDlmAj3blUe
	Cf2mtc2vod+9JFwuoRh1q/a6DyXFSqMBwj68OwIM1QYxxhX7Vm4Hl+E/RHhf+Pk6
	/A==
Received: (qmail 356275 invoked from network); 3 Nov 2026 17:39:12 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Nov 2026 17:39:12 +0100
X-UD-Smtp-Session: l3s3148p1@V+b25mFfDJnAwtcC
Date: Tue, 3 Nov 2026 18:39:11 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Frank.Li@oss.nxp.com
Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Dong Aisheng <aisheng.dong@nxp.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"open list:MICROCHIP I2C DRIVER" <linux-i2c@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE IMX LPI2C DRIVER" <imx@lists.linux.dev>,
	"open list:QUALCOMM I2C QCOM GENI DRIVER" <linux-arm-msm@vger.kernel.org>,
	"open list:RENESAS R-CAR I2C DRIVERS" <linux-renesas-soc@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
	vkoul@kernel.org
Subject: Re: [PATCH 1/1] i2c: use dmaengine_desc_set_callback()
Message-ID: <auoOL2JTEDY2abYe@shikoro>
References: <20261102170004.3852546-1-Frank.Li@oss.nxp.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102170004.3852546-1-Frank.Li@oss.nxp.com>

On Mon, Nov 02, 2026 at 12:00:02PM -0500, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across various I2C bus drivers.
> 
> No functional change intended. Prepare make to struct
> dma_async_tx_descriptor private to the DMA engine.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Looks actually less readable to me, but I won't bike-shed. Code changes
look okay.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

