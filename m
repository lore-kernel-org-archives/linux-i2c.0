Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598561;
	b=ClWTpgfcU6jbWyJMHpW6N2t4KMOZ2wIcI3cWwZmCtdCx7WiPGqf7wzn/0MnnnFsj2RXn
	 /RkM22T+mnHYfxpY2zoaH1YMfy3ZMJTP1c1f/gKRtdZqBDmg+WS+a8POWIdM17kxPOJsg
	 37U8dKPWxpIzV+4CFZVWfmLk0DQbXmYnK8Xguu3bZIb+P/YVDTHyHmCgfPbrNfFMMk+e2
	 WW8fSIVJR12wxyrrv+Syv5+fu3dgZIcddXThoYt0HuDQgChvfApuVmJTNla/j7iOofeV1
	 9GaEYQ3PE6h1yse2+XxUyY+RSJtAgZeXc8BsepM+A92geoza+WwnkhOQGIpLFi9ZmsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598561;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-AI-Review-Draft;
	bh=BRlxrQSfS1UNcDdT1XkBQE7tSEvLo170cVjw3ZxNwhk=;
	b=jgoxNRKPEEQZEPcZKaheJRGUGhfdQiBXGymLfzrBnR51jzrwmjq7zgMNe8xLtlfA0jUI
	 xA6R9Lp9lRZ7U04RmogIL5cOW9NDj/WBF6ilE5+hC3srhGzcnlSVJepIIoPYNeT2z5bgk
	 +IVvHa7HtRn/RZQ7ktRORxyGKVC/DhOutBOdl+4AdeM0NrYKquCmOAZARnPepTMcUNTxP
	 huKS14L68aFAvFhvAKS3VTC+dG73pMINURJsUUbpyQ0xY/xGDljccPHb/QrN9FIEGDjbi
	 0p8mxDpwdL8BmIu2/LIK6n+2Z9M2ZkVHZXekD2MpyTciEZeFKMiMUw9iXFiKzlAgmdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZGK1KaB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8049606A32D;
	Fri, 13 Nov 2026 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZGK1KaB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283501F000C5;
	Fri, 13 Nov 2026 19:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794598561;
	bh=BRlxrQSfS1UNcDdT1XkBQE7tSEvLo170cVjw3ZxNwhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RZGK1KaBXBWLxMZBHey5dJXrbL4nVczh/xIwOzCRniov+bn9OtKY0B/RQcX3IocWZ
	 1Kiypj35UfpQgaqo29YOvy1NXQOrhEBOsd20ymaDdu1C31LYRBFaxxupLZLHMKBRBY
	 i45VB01iagpQG+t/Ov26tmWXiJasn4kdKVYgNSxxJ6QdHjv8HJNKDidCMb2L2qrDUh
	 XuRXROEQRRkALSmcXpfD89a5vImyvVqt+ektJCD+/OT8vxeYE6lP0hCoEAFImoNolx
	 T9gzYrtyXWVvdXKQRVmybI+UDyMz0TY+j9OeWRP3yZ04Ship9sOirAMTmBgv2GGSAZ
	 jgnsbmBMd5WMQ==
Date: Fri, 13 Nov 2026 19:35:57 +0000
From: Lee Jones <lee@kernel.org>
To: Samuel Tirwa <samuel.tirwa@web.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: intel-lpss: fall back to polling when no usable
 IRQ
Message-ID: <179370025139.793788.5031830505403657514@kernel.org>
References: <20261103085954.1497-1-samuel.tirwa@web.de>
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
In-Reply-To: <20261103085954.1497-1-samuel.tirwa@web.de>
X-AI-Review-Draft: <20261103085954.1497-1-samuel.tirwa@web.de>

--- checkpatch.pl (1 issue) ---
Line 3: WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
----------------------------------

On Tue, 03 Nov 2026, Samuel Tirwa wrote:

> On platforms such as the HONOR MagicBook Pro 14 (2025) (Intel Core Ultra 9 285H)
> the firmware ACPI tables report the Intel LPSS I2C controllers' PCI INTx line as

These lines look excessively long.

> not connected (Interrupt Line = 0xff, GSI 255) and do not grant MSI control
> through _OSC.  As a result acpi_pci_irq_enable() sets dev->irq to
> IRQ_NOTCONNECTED and intel_lpss_probe() rejects it, so all three I2C
> controllers (8086:7778/7779/777a) fail to probe with -ENOTCONN and the
> touchpad/touchscreen are never exposed.
>
> Treat IRQ_NOTCONNECTED as 'no interrupt available' and pass 0 as the IRQ base
> to the child devices instead of failing.  The DesignWare I2C driver already
> supports a polling mode when no IRQ resource is present, which keeps the
> controllers functional on these firmwares.
>
> Signed-off-by: Samuel Tirwa <samuel.tirwa@web.de>
> ---
>  drivers/mfd/intel-lpss.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
> index f71e076..f785d5d 100644
> --- a/drivers/mfd/intel-lpss.c
> +++ b/drivers/mfd/intel-lpss.c
> @@ -1,5 +1,6 @@
>  #include <linux/mfd/core.h>
>  #include <linux/module.h>
> +#include <linux/interrupt.h>

Alphabetical.

>  int intel_lpss_probe(struct device *dev,
>                       const struct intel_lpss_platform_info *info)
> @@ -7,10 +8,17 @@ int intel_lpss_probe(struct device *dev,
>  	struct intel_lpss *lpss;
>  	int ret;
>
> -	if (!info || !info->mem || info->irq <= 0)
> +	if (!info || !info->mem)
>  		return -EINVAL;
>
> -	if (info->irq < 0)
> +	/*
> +	 * Firmware on some platforms (e.g. HONOR MagicBook Pro 14 2025)
> +	 * reports the LPSS PCI INTx line as not connected (IRQ_NOTCONNECTED).
> +	 * Fall back to polling mode in that case instead of failing probe.
> +	 */
> +	if (info->irq == IRQ_NOTCONNECTED)
> +		info->irq = 0;

Does this even compile?  Isn't 'info' declared 'const'?

Moreover, mfd_add_devices() inside intel_lpss_probe() passes 'info->irq' as
the 'irq_base' alongside a hardcoded 'n_resources = 2' on the 'mfd_cell'
definitions (which include DEFINE_RES_IRQ(0)).  Simply passing '0' as
'irq_base' does not omit the 'IORESOURCE_IRQ' resource - it just shifts the
child's IRQ resource to '0', whereas 'i2c-designware-platdrv' only enters
polling mode when 'platform_get_irq_optional()' returns '-ENXIO' (no IRQ
resource present), or should this be handled in the glue layer or by adjusting
how the cell resources are populated?

How was this tested?

> +	else if (info->irq < 0)
>  		return info->irq;
>
>  	lpss = devm_kzalloc(dev, sizeof(*lpss), GFP_KERNEL);
> -- 
> 2.56.0.windows.4
>

-- 
Lee Jones
