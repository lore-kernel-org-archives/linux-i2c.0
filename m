From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3 resend] i2c: designware: add reset interface
Date: Tue, 27 Dec 2016 16:41:15 +0200
Message-ID: <2cc1faeb-1a1b-76e2-0b12-9918ac42861d@linux.intel.com>
References: <y> <1482848560-3752-1-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:38417 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751256AbcL0Onb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 27 Dec 2016 09:43:31 -0500
In-Reply-To: <1482848560-3752-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, p.zabel@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org

On 12/27/2016 04:22 PM, Zhangfei Gao wrote:
> Some platforms like hi3660 need do reset first to allow accessing registers
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Ramiro Oliveira <ramiro.oliveira@synopsys.com>
> ---
> rebase to 4.10-rc1
>
>  drivers/i2c/busses/i2c-designware-core.h    |  1 +
>  drivers/i2c/busses/i2c-designware-platdrv.c | 28 ++++++++++++++++++++++++----
>  2 files changed, 25 insertions(+), 4 deletions(-)
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
