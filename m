From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v4 1/7] i2c: Switch to using gpiod interface for gpio bus
 recovery
Date: Wed, 1 Nov 2017 18:23:22 +0200
Message-ID: <d6f29fd9-1f22-8956-d9c6-aa797aa4340b@linux.intel.com>
References: <1509435239-64848-1-git-send-email-preid@electromag.com.au>
 <1509435239-64848-2-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44174 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751853AbdKAQXn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 1 Nov 2017 12:23:43 -0400
In-Reply-To: <1509435239-64848-2-git-send-email-preid@electromag.com.au>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, nsekhar@ti.com, khilman@kernel.org, wsa@the-dreams.de, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, fntoth@gmail.com

On 10/31/2017 09:33 AM, Phil Reid wrote:
> Currently the i2c gpio recovery code uses gpio integer interface
> instead of the gpiod. This change switch the core code to use
> the gpiod while still retaining compatibility with the gpio integer
> interface. This will allow individual driver to be updated and tested
> individual to switch to using the gpiod interface.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>   drivers/i2c/i2c-core-base.c | 21 +++++++++++++++++----
>   include/linux/i2c.h         |  2 ++
>   2 files changed, 19 insertions(+), 4 deletions(-)
> 
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
