From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/1] i2c: designware: Consolidate default functionality
 bits
Date: Wed, 23 Nov 2016 16:16:31 +0200
Message-ID: <67a95b37-73e3-7105-d9d1-7bc60c8b6fcc@linux.intel.com>
References: <1479725000-22513-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:34450 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936601AbcKWOQj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 23 Nov 2016 09:16:39 -0500
In-Reply-To: <1479725000-22513-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

On 21.11.2016 12:43, Alexander Stein wrote:
> Use a common place for default functionality bits for both platform
> and pci driver.
>
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
> This patch requires commit c3ae106050b9 ("i2c: designware: Implement support
> for SMBus block read and write") which is included in current i2c/for-next
> branch.
> BTW: Do merrifield and medfield actually not support 10bit addressing?
>
Andy, do you know?

>  drivers/i2c/busses/i2c-designware-core.h    | 8 ++++++++
>  drivers/i2c/busses/i2c-designware-pcidrv.c  | 9 +--------
>  drivers/i2c/busses/i2c-designware-platdrv.c | 9 +--------
>  3 files changed, 10 insertions(+), 16 deletions(-)
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
