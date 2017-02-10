From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Get selected speed mode sda-hold-time
 via ACPI
Date: Fri, 10 Feb 2017 14:28:45 +0200
Message-ID: <ca6a120d-fcf3-b39c-2f55-21e377917062@linux.intel.com>
References: <1486726118-19447-1-git-send-email-chin.yew.tan@intel.com>
 <1486726118-19447-2-git-send-email-chin.yew.tan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57359 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752180AbdBJOVa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 10 Feb 2017 09:21:30 -0500
In-Reply-To: <1486726118-19447-2-git-send-email-chin.yew.tan@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: chin.yew.tan@intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com
Cc: linux-i2c@vger.kernel.org

On 10.02.2017 13:28, chin.yew.tan@intel.com wrote:
> From: Tan Chin Yew <chin.yew.tan@intel.com>
>
> Sda-hold-time is an important parameter for tuning i2c to meet the
> electrical specification especially for high speed. I2C with incorrect
> sda-hold-time may cause lost arbitration error. Now, the driver is able to
> get sda-hold-time for all the speed supported.
>
> Signed-off-by: Tan Chin Yew <chin.yew.tan@intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
