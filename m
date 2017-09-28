From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3 3/4] i2c: designware: rename i2c_dw_plat_prepare_clk to
 i2c_dw_prepare_clk
Date: Thu, 28 Sep 2017 16:01:44 +0300
Message-ID: <d90696b0-b304-3f2c-1f48-d10c763f1221@linux.intel.com>
References: <1504073857-122449-1-git-send-email-preid@electromag.com.au>
 <1504073857-122449-4-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:5130 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752913AbdI1NBr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 28 Sep 2017 09:01:47 -0400
In-Reply-To: <1504073857-122449-4-git-send-email-preid@electromag.com.au>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, tim@krieglstein.org, linux-i2c@vger.kernel.org

On 08/30/2017 09:17 AM, Phil Reid wrote:
> For consistency with the reset of the file rename function and parameter to
> be consistent with the reset of the common file.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>   drivers/i2c/busses/i2c-designware-common.c  | 10 +++++-----
>   drivers/i2c/busses/i2c-designware-core.h    |  2 +-
>   drivers/i2c/busses/i2c-designware-platdrv.c |  6 +++---
>   3 files changed, 9 insertions(+), 9 deletions(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
