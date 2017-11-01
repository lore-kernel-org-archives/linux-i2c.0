From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v4 4/7] i2c: designware: add i2c gpio recovery option
Date: Wed, 1 Nov 2017 18:22:11 +0200
Message-ID: <f13c736e-324e-087d-f191-a7d4966688d9@linux.intel.com>
References: <1509435239-64848-1-git-send-email-preid@electromag.com.au>
 <1509435239-64848-5-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29907 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933087AbdKAQWS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 1 Nov 2017 12:22:18 -0400
In-Reply-To: <1509435239-64848-5-git-send-email-preid@electromag.com.au>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, nsekhar@ti.com, khilman@kernel.org, wsa@the-dreams.de, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, fntoth@gmail.com
Cc: Tim Sander <tim@krieglstein.org>

On 10/31/2017 09:33 AM, Phil Reid wrote:
> From: Tim Sander <tim@krieglstein.org>
> 
> This patch contains much input from Phil Reid and has been tested
> on Intel/Altera Cyclone V SOC Hardware with Altera GPIO's for the
> SCL and SDA GPIO's.
> 
> Signed-off-by: Tim Sander <tim@krieglstein.org>
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>   drivers/i2c/busses/i2c-designware-common.c |  6 +++-
>   drivers/i2c/busses/i2c-designware-core.h   |  1 +
>   drivers/i2c/busses/i2c-designware-master.c | 57 ++++++++++++++++++++++++++++++
>   3 files changed, 63 insertions(+), 1 deletion(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
