Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914037;
	b=U7D/BOab3Uk/yIUNRWVsIpwEaP6cU90lPEJ6ec6PlJZnJ1XF1qSNxt4tkqOKyKubRpVh
	 MMBM3cLNZqKd57brhBELddOKCNXyLPV0nbHVOp9YHCcw1SY4SWY6MpoAT4xhtucnRbeUB
	 lHC5HMZdjD+KIsjtZ6aqo6J4B0P7cQd+RMhtbX8gbXqAnswyJOar4Vn4x0rbFM4vjiEnt
	 W2VKUTUnpEqqFOh3dG/duIr0gakq3MHLkD/4sDzwkYgIm1DZIHxi/QmTipmNRAxY1VTKe
	 5pOkapxV3p3wTGahpctD/6AIj6nsubmTxjCgh0dPYE4hq1uknqczkTRyWdmuZrN6wlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914037;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:Cc:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=glvzO48Y6+7GpTDkveWHZy6F12myiqHZccuU9qmQ/ss=;
	b=IkhQCBB9E7YIbxZorlD2r2FMOkUEDz1D9ExERX1wuTdUv9fubgKLF6/G6r2oly3FkewR
	 d/bvIp1GrNDXlelE6OvIIsHcqh0F1xufpet5tTpbH//gXrmLL1kISnhQUIFLIgSFBgCkl
	 x2V6KYy9nIKJNCJAxtac2gTikbpjFxj0CSaBQfBwl32bZsohnkRluE7+H13fCSI3l/0oR
	 YfRGtxv2hqjrSUuTvDoDEGgyiBs8BthjZAQTJ7mmMVjMBz5bfp/pyk3Ff9XfLhvSZLOWB
	 DoxhMnl8soqis/9TcTOa8FRrMyZSiVix3Rz2yQalb258hw9q9yu1T4gTRzC5hT6t+EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=SogGlU2W;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC375606A31B;
	Thu,  5 Nov 2026 21:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC375606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=SogGlU2W
Received: from [10.6.228.16] (unknown [52.172.102.219])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6FA3620B7167;
	Thu,  5 Nov 2026 13:26:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6FA3620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793914020;
	bh=glvzO48Y6+7GpTDkveWHZy6F12myiqHZccuU9qmQ/ss=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=SogGlU2WrDmMZbzv94QIN7p95I30gC5EALjHQVqbKdbXYJrJkMji460pAalZERm3z
	 pE8vXZpeHiYtXIpKsgIK397jwxisifoF2CMt15y0btR3CC2GsfEZX7f1hZb4+HLS2o
	 SiRSxDYdUYiwHcfc/u/gzaysEGN+JH7ys42nFca8=
Message-ID: <b660d79f-887e-4594-ba76-c45dc5f75435@linux.microsoft.com>
Date: Thu, 5 Nov 2026 13:27:06 -0800
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH v1 1/1] i2c: designware: Add ACPI ID MSFT0006
 for Microsoft Cobalt SoCs
To: Andi Shyti <andi.shyti@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
References: <20261104234928.86458-1-sidchintamaneni@gmail.com>
 <DS1PR21MB4279C556CFB876C5562C7F1182772@DS1PR21MB4279.namprd21.prod.outlook.com>
Content-Language: en-US
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Len Brown <lenb@kernel.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Allen Pais <apais@microsoft.com>, "rlmenge@gmail.com" <rlmenge@gmail.com>,
 "hargar@linux.microsoft.com" <hargar@linux.microsoft.com>,
 Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
 Jeff Kirsher <jeff.kirsher@microsoft.com>
From: Jarred White <jarredwhite@linux.microsoft.com>
In-Reply-To: <DS1PR21MB4279C556CFB876C5562C7F1182772@DS1PR21MB4279.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> [You don't often get email from sidchintamaneni@gmail.com. Learn why 
> this is important at https://aka.ms/LearnAboutSenderIdentification 
> <https://aka.ms/LearnAboutSenderIdentification> ]
> 
> Add the MSFT0006 ACPI ID for the DesignWare I2C controller integrated
> on Microsoft Cobalt SoCs, along with its 300 MHz input clock description
> in acpi_apd.c.
> 
> Without an explicit MSFT0006 entry, ACPI device matching falls back to
> its _CID (APMC0D0F), which configures a 100 MHz input clock instead of
> the controller's actual 300 MHz clock.
> 
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>

Acked-by: Jarred White <jarredwhite@linux.microsoft.com>

> ---
 > Cc: Jarred White <jarredwhite@linux.microsoft.com>
 > Cc: Jeff Kirsher <jeff.kirsher@microsoft.com>
 >
>   drivers/acpi/acpi_apd.c                     | 6 ++++++
>   drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
>   2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index 9fc667d6776c8..a1baa056931c4 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -198,6 +198,11 @@ static const struct apd_device_desc hjmc_i2c_desc = {
>          .fixed_clk_rate = 200 * HZ_PER_MHZ,
>   };
> 
> +static const struct apd_device_desc msft_i2c_desc = {
> +       .setup = acpi_apd_setup,
> +       .fixed_clk_rate = 300 * HZ_PER_MHZ,
> +};
> +
>   #endif /* CONFIG_ARM64 */
> 
>   #endif
> @@ -272,6 +277,7 @@ static const struct acpi_device_id 
> acpi_apd_device_ids[] = {
>          { "HJMC3001", APD_ADDR(hjmc_i2c_desc) },
>          { "LECA0002", APD_ADDR(leca_spi_desc) },
>          { "LECA0003", APD_ADDR(leca_i2c_desc) },
> +       { "MSFT0006", APD_ADDR(msft_i2c_desc) },
>          { "NXP0001", APD_ADDR(nxp_i2c_desc) },
>   #endif
>          { }
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/ 
> busses/i2c-designware-platdrv.c
> index 1da6b0314b6a0..f359d38cc63c7 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -280,6 +280,7 @@ static const struct acpi_device_id 
> dw_i2c_acpi_match[] = {
>          { .id = "INT3433" },
>          { .id = "INTC10EF" },
>          { .id = "LECA0003" },
> +       { .id = "MSFT0006" },
>          { }
>   };
>   MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
> --
> 2.45.4
> 

