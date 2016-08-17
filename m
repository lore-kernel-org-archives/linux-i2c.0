From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/8] i2c: designware: Support fast mode plus and high
 speed
Date: Wed, 17 Aug 2016 19:53:13 +0300
Message-ID: <1471452793.4887.151.camel@linux.intel.com>
References: <1471010574-28598-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47288 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839AbcHQQxV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 17 Aug 2016 12:53:21 -0400
In-Reply-To: <1471010574-28598-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Weifeng Voon <weifeng.voon@intel.com>

On Fri, 2016-08-12 at 17:02 +0300, Jarkko Nikula wrote:
> Patches here were posted before for v4.8 but got dropped due merge
> conflicts with changes coming from ACPI subsystem.
> 
> http://www.spinics.net/lists/linux-i2c/msg24699.html
> http://www.spinics.net/lists/linux-i2c/msg24857.html
> 
> I promised to resend both sets together since my set doesn't have much
> use
> without Weifeng's set and my patches are done on top of it.
> 
> Patches 1-4/8 are same than before. Patch 5/8 had tiny conflict with
> the
> ed1bf03470b8 ("i2c: designware-pci: Make bus number allocation
> robust")
> because both added the DW_IC_CON_SPEED_MASK.
> 
> Patches 6-7/8 are a bit larger due conflicts with the
> commit 525e6fabeae2 ("i2c / ACPI: add support for ACPI reconfigure
> notifications"). No changes in patch 8/8.

Looks okay to me.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> 
> Jarkko Nikula (3):
>   i2c: core: Cleanup I2C ACPI namespace, take 2
>   i2c: core: Add function for finding the bus speed from ACPI, take 2
>   i2c: designware: Find bus speed from ACPI
> 
> Weifeng Voon (5):
>   i2c: designware: Move clk_freq into struct dw_i2c_dev
>   i2c: designware: get fast plus and high speed *CNT configuration
>   i2c: designware: Enable fast mode plus
>   i2c: designware: set the common config before the if else
>   i2c: designware: Enable high speed mode
> 
>  drivers/i2c/busses/i2c-designware-core.c    |  33 ++++-
>  drivers/i2c/busses/i2c-designware-core.h    |  11 ++
>  drivers/i2c/busses/i2c-designware-platdrv.c |  43 +++++--
>  drivers/i2c/i2c-core.c                      | 179
> ++++++++++++++++++++--------
>  include/linux/i2c.h                         |   9 ++
>  5 files changed, 208 insertions(+), 67 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
