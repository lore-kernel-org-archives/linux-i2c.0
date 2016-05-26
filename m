From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 0/5] i2c: designware: Enable fast mode plus and high speed
Date: Thu, 26 May 2016 15:02:01 +0300
Message-ID: <5746E5B9.6050305@linux.intel.com>
References: <1464249672-24566-1-git-send-email-weifeng.voon@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54336 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753558AbcEZMDg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 26 May 2016 08:03:36 -0400
In-Reply-To: <1464249672-24566-1-git-send-email-weifeng.voon@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Weifeng Voon <weifeng.voon@intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jui.nee.tan@intel.com

On 05/26/2016 11:01 AM, Weifeng Voon wrote:
> Enabled fast mode plus and high speed which supported by APL SoC.
>
> Weifeng Voon (5):
>    i2c: designware: Move clk_freq into struct dw_i2c_dev
>    i2c: designware: get fast plus and high speed *CNT configuration
>    i2c: designware: Enable fast mode plus
>    i2c: designware: set the common config before the if else
>    i2c: designware: Enable high speed mode
>
>   drivers/i2c/busses/i2c-designware-core.c    | 33 +++++++++++++++++++++---
>   drivers/i2c/busses/i2c-designware-core.h    | 12 +++++++++
>   drivers/i2c/busses/i2c-designware-platdrv.c | 39 +++++++++++++++++++----------
>   3 files changed, 68 insertions(+), 16 deletions(-)
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
