From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2] i2c: designware: Cleaning and comment style fixes.
Date: Thu, 15 Dec 2016 16:17:05 +0100
Message-ID: <f11794ec-439b-5fcd-65f4-c14c319cd627@axentia.se>
References: <d7b5a22ce09539c2af343c21ca69675bef6a0a10.1481812563.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-he1eur01on0102.outbound.protection.outlook.com ([104.47.0.102]:9198
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752560AbcLOQve (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 15 Dec 2016 11:51:34 -0500
In-Reply-To: <d7b5a22ce09539c2af343c21ca69675bef6a0a10.1481812563.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On 2016-12-15 15:38, Luis Oliveira wrote:
> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
> index 26250b425e2f..3cb81fca7738 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -36,7 +36,7 @@
>  #define DW_IC_CON_SPEED_FAST		0x4
>  #define DW_IC_CON_SPEED_HIGH		0x6
>  #define DW_IC_CON_SPEED_MASK		0x6
> -#define DW_IC_CON_10BITADDR_MASTER	0x10
> +#define DW_IC_CON_10BITADDR_MASTER		0x10

How is this an improvement?

Cheers,
peda
