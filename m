From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: Re: [PATCH 0/2] i2c: designware: Post-slave mode support patches
Date: Thu, 29 Jun 2017 15:00:42 +0100
Message-ID: <b313ec16-5749-484f-cbd6-0f3eaeadf2cf@synopsys.com>
References: <20170628142329.14818-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:47333 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753229AbdF2OBD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 29 Jun 2017 10:01:03 -0400
In-Reply-To: <20170628142329.14818-1-jarkko.nikula@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org
Cc: Luis Oliveira <Luis.Oliveira@synopsys.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On 28-Jun-17 15:23, Jarkko Nikula wrote:
> Hi Luis
> 
> I noticed couple minor things after review. Here are patches.
> 
Hi Jarkko, thank you. Just tested them and everything works as expected.

> Jarkko Nikula (2):
>   i2c: designware: Make HW init functions static
>   i2c: designware: Let slave adapter support be optional
> 
>  drivers/i2c/busses/Kconfig                 | 1 -
>  drivers/i2c/busses/i2c-designware-core.h   | 6 ++++--
>  drivers/i2c/busses/i2c-designware-master.c | 7 +++----
>  drivers/i2c/busses/i2c-designware-slave.c  | 3 +--
>  4 files changed, 8 insertions(+), 9 deletions(-)
> 
Tested-by: Luis Oliveira <lolivei@synopsys.com>
