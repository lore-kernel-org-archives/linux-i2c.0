From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v1 1/1] i2c: designware-pci: use IRQF_COND_SUSPEND flag
Date: Mon, 18 Jan 2016 08:51:22 +0200
Message-ID: <569C8B6A.70406@linux.intel.com>
References: <1452888132-134446-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64351 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753800AbcARGxb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 18 Jan 2016 01:53:31 -0500
In-Reply-To: <1452888132-134446-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org

On 01/15/2016 10:02 PM, Andy Shevchenko wrote:
> This is effectively reapplies the commit b0898fdaffb2 (i2c: designware-pci: use
> IRQF_COND_SUSPEND flag) after the commit d80d134182ba (i2c: designware: Move
> common probe code into i2c_dw_probe()). Original message as follows.
>
> The mentioned flag fixes a warning on Intel Edison board since one of the I2C
> controller shares IRQ line with watchdog timer.
>
> Fixes: d80d134182ba (i2c: designware: Move common probe code into i2c_dw_probe())
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/i2c/busses/i2c-designware-core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
