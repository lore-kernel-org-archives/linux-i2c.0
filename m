From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Fix false warning from i2c_dw_clk_rate()
Date: Fri, 19 May 2017 10:12:08 +0300
Message-ID: <2d797489-2728-e346-58f2-520002603071@linux.intel.com>
References: <20170511124949.26650-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51635 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750805AbdESHOY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 19 May 2017 03:14:24 -0400
In-Reply-To: <20170511124949.26650-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On 05/11/2017 03:49 PM, Jarkko Nikula wrote:
> Commit bd698d24b1b5 ("i2c: designware: Get selected speed mode
> sda-hold-time via ACPI") causes a false warning from i2c_dw_clk_rate()
> in case platform doesn't provide explicit input clock but provides valid
> SCL timing parameters via ACPI.
>
> After above commit timing parameters only for the selected speed is get
> but code in i2c_dw_init() tries to calculate missing parameters using
> the input clock which leads to a warning when there is no input clock
> defined.
>
> Fix this by reordering the code such a way that timing parameters
> validation/calculation and setting is done for the selected speed only.
> While at it do the calculation only once during the first call.
>
> Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-core.c | 148 +++++++++++++++++++------------
>  1 file changed, 89 insertions(+), 59 deletions(-)
>
NAK to myself. High-speed transfers starts in fast-mode so those timing 
parameters are have to set. I'll cook another version.

-- 
Jarkko
