Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A6835F607;
	Fri, 29 May 2026 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049538; cv=none; b=hUgZbM9dOlaaGJHkD+nEQy2cny4AqBo/48+Tm1vOQ9rQh7QKHzTcUFCUyfmSdg9qu7uDWYheUspXtRtn+IQ64nJzyXTrr6MUiwGe/STJ3uy/8pt0nX4TR6jEzWQFzRkh3M8qzAQTCBN//xk4r1D8Ywex0cGzZFQGux4mmbOPKjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049538; c=relaxed/simple;
	bh=ZtIf2ZYmua1fLtL6zNGbqxoAmJiCCFYPh7e0o9Ed0l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhN5mJsqAMErKTpSgQblMiZfwWF3ACZNBukoWvhj7mQuUicpxwwinurVza2L+I7ouUEzcwfo4VgxsLWl9pxGtX0jts30zxN09Qgv5iijWPRKcjmnzv+XuxhWiDG2QIVELzwmeL1ELvFKYNpmXA85ocK8zLoHCT9UJF9iWfjPKmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBaGWIAn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBaGWIAn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04671F00893;
	Fri, 29 May 2026 10:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780049536;
	bh=DnHeGTljeayftA3yxEPPQHId8UZAR2PG9H6YLj8hebc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mBaGWIAnZAEcIHIA75+KnwMiQjbrTvclTU3kpjdY4Y7jJEokI6VnW8M7pMZJ4XMaM
	 nuNbSmuh0gBy6CJa9n1gFqmuOrErpkIzS4QU0bb2IzK1os4vXxVvli85ARpBG4BOcf
	 eo/ygZnsWCOqo60fCqf8DQoPSEimSEwSekZ6apQ8on5R0UgoeKviPbOQANZkrF/C8U
	 q1UnGN7Y7TRTean5pvcrwNLjAhZ2UgRlnsxAjMLN+AFClwcMvSSls9leybgVs9rklj
	 d4pZEaBW7e0Jqm2x5KB5Y8ywB82U3Heg33kJA2/k52GqPJ4tlVQbPtha0m50nfUDaV
	 pgnC95EGC/rMA==
Message-ID: <ee960f3c-58c4-441d-be28-0360bc65c803@kernel.org>
Date: Fri, 29 May 2026 12:12:13 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] Revert "pinctrl-amd: enable IRQ for WACF2200
 touchscreen on Lenovo Yoga 7 14AGP11"
Content-Language: en-US
To: Hardik Prakash <hardikprakash.official@gmail.com>,
 linux-i2c@vger.kernel.org
Cc: linux-gpio@vger.kernel.org, wsa@kernel.org, andriy.shevchenko@intel.com,
 brgl@bgdev.pl, basavaraj.natikar@amd.com, linusw@kernel.org
References: <20260529100838.8896-1-hardikprakash.official@gmail.com>
 <20260529100838.8896-2-hardikprakash.official@gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260529100838.8896-2-hardikprakash.official@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/29/26 12:08, Hardik Prakash wrote:
> This reverts commit 3812a9e84265a5cdd90d29fe8d97a023e91fb945.
> 
> The probe ordering fix in the following patch ensures amd_gpio_probe()
> completes before i2c-designware probes AMDI0010:02, allowing the
> existing amd_gpio_irq_enable() flow to work correctly. The manual IRQ
> restoration added by this patch is therefore no longer needed.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221494
> Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

So that this reverts in older kernels probably want this:

Fixes: 3812a9e84265a ("pinctrl-amd: enable IRQ for WACF2200 touchscreen 
on Lenovo Yoga 7 14AGP11")

> ---
>   drivers/pinctrl/pinctrl-amd.c | 35 -----------------------------------
>   1 file changed, 35 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
> index 64315b0edf2a..e3128b0045d2 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -26,7 +26,6 @@
>   #include <linux/interrupt.h>
>   #include <linux/bitops.h>
>   #include <linux/pinctrl/pinconf.h>
> -#include <linux/dmi.h>
>   #include <linux/pinctrl/pinconf-generic.h>
>   #include <linux/pinctrl/pinmux.h>
>   #include <linux/string_choices.h>
> @@ -40,39 +39,6 @@
>   static struct amd_gpio *pinctrl_dev;
>   #endif
>   
> -static const struct dmi_system_id amd_gpio_quirk_yoga7_14agp11[] = {
> -	{
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "83TD"),
> -			DMI_MATCH(DMI_BOARD_NAME, "LNVNB161216"),
> -		},
> -	},
> -	{ }
> -};
> -
> -static void amd_gpio_apply_quirks(struct amd_gpio *gpio_dev)
> -{
> -	const unsigned int pin = 157; /* WACF2200 GpioInt per ACPI _CRS */
> -	unsigned long flags;
> -	u32 reg;
> -
> -	if (!dmi_check_system(amd_gpio_quirk_yoga7_14agp11))
> -		return;
> -	if (pin >= gpio_dev->gc.ngpio)
> -		return;
> -
> -	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
> -	reg = readl(gpio_dev->base + pin * 4);
> -	reg |= BIT(INTERRUPT_ENABLE_OFF) | BIT(INTERRUPT_MASK_OFF);
> -	writel(reg, gpio_dev->base + pin * 4);
> -	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
> -
> -	dev_info(&gpio_dev->pdev->dev,
> -		 "Enabled IRQ for GPIO %u (Yoga 7 14AGP11 touchscreen)\n",
> -		 pin);
> -}
> -
>   static int amd_gpio_get_direction(struct gpio_chip *gc, unsigned offset)
>   {
>   	unsigned long flags;
> @@ -1253,7 +1219,6 @@ static int amd_gpio_probe(struct platform_device *pdev)
>   
>   	/* Disable and mask interrupts */
>   	amd_gpio_irq_init(gpio_dev);
> -	amd_gpio_apply_quirks(gpio_dev);
>   
>   	girq = &gpio_dev->gc.irq;
>   	gpio_irq_chip_set_chip(girq, &amd_gpio_irqchip);

