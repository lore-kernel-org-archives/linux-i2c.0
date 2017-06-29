From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/2] i2c: designware: Post-slave mode support patches
Date: Thu, 29 Jun 2017 13:40:05 +0300
Message-ID: <1498732805.22624.223.camel@linux.intel.com>
References: <20170628142329.14818-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41961 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751703AbdF2KkK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 29 Jun 2017 06:40:10 -0400
In-Reply-To: <20170628142329.14818-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org
Cc: Luis Oliveira <lolivei@synopsys.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Wed, 2017-06-28 at 17:23 +0300, Jarkko Nikula wrote:
> Hi Luis
> 
> I noticed couple minor things after review. Here are patches.
> 

I like the series, esp. patch 1.

Reviewed-and-acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.co
m>


> Jarkko Nikula (2):
>   i2c: designware: Make HW init functions static
>   i2c: designware: Let slave adapter support be optional
> 
>  drivers/i2c/busses/Kconfig                 | 1 -
>  drivers/i2c/busses/i2c-designware-core.h   | 6 ++++--
>  drivers/i2c/busses/i2c-designware-master.c | 7 +++----
>  drivers/i2c/busses/i2c-designware-slave.c  | 3 +--
>  4 files changed, 8 insertions(+), 9 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
