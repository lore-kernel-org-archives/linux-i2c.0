From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3 2/4] i2c: designware: move i2c_dw_plat_prepare_clk to
 common
Date: Thu, 28 Sep 2017 16:01:40 +0300
Message-ID: <a9e961af-2d5b-527a-d1bd-040417095a2c@linux.intel.com>
References: <1504073857-122449-1-git-send-email-preid@electromag.com.au>
 <1504073857-122449-3-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:5130 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751906AbdI1NBp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 28 Sep 2017 09:01:45 -0400
In-Reply-To: <1504073857-122449-3-git-send-email-preid@electromag.com.au>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, tim@krieglstein.org, linux-i2c@vger.kernel.org

On 08/30/2017 09:17 AM, Phil Reid wrote:
> Move the i2c_dw_plat_prepare_clk funciton to common file in preparation
> for its use also by the master driver.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>   drivers/i2c/busses/i2c-designware-common.c  | 13 +++++++++++++
>   drivers/i2c/busses/i2c-designware-core.h    |  1 +
>   drivers/i2c/busses/i2c-designware-platdrv.c | 12 ------------
>   3 files changed, 14 insertions(+), 12 deletions(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
