From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 2/5] i2c: designware: Master mode as separated driver
Date: Fri, 18 Nov 2016 14:30:14 +0200
Message-ID: <1479472214.22212.21.camel@linux.intel.com>
References: <cover.1479410047.git.lolivei@synopsys.com>
         <897ada44bfa73aaa5e092d4b178461f52c0566db.1479410047.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:50496 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752136AbcKRMaU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 18 Nov 2016 07:30:20 -0500
In-Reply-To: <897ada44bfa73aaa5e092d4b178461f52c0566db.1479410047.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On Fri, 2016-11-18 at 11:19 +0000, Luis Oliveira wrote:
>  - The functions related to I2C master mode of operation were
> transformed in a single driver.
>  - The name of the i2c-designware-core.c had to be changed to i2c-
> designware-src.c to for the cmake to be able to correctly compile both
> modules into one
>  - Common definitions were moved to i2c-designware-core.h

>  drivers/i2c/busses/i2c-designware-src.c            | 252
> +++++++++++++++

Perhaps i2c-designware-common.c ?

> @@ -21,8 +21,6 @@
>   * ------------------------------------------------------------------
> ----------
>   *
>   */
> -
> -

No need to do that in this patch.

>  #define DW_IC_CON_MASTER		0x1
>  #define DW_IC_CON_SPEED_STD		0x2
>  #define DW_IC_CON_SPEED_FAST		0x4
> @@ -32,6 +30,123 @@
>  #define DW_IC_CON_RESTART_EN		0x20
>  #define DW_IC_CON_SLAVE_DISABLE		0x40
>  
> +/*
> + * Registers offset
> + */
> +#define DW_IC_CON		0x0

Okay, can we split this to move definitions and the rest?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
