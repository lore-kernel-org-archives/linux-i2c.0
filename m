From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Get selected speed mode sda-hold-time
 via ACPI
Date: Fri, 31 Mar 2017 15:12:05 +0300
Message-ID: <237c2cf5-17dd-3d9c-ed4e-d0eadf611dfc@linux.intel.com>
References: <1490690882-11623-1-git-send-email-chin.yew.tan@intel.com>
 <1490690882-11623-2-git-send-email-chin.yew.tan@intel.com>
 <1490692426.708.26.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:30466 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932858AbdCaMOU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 31 Mar 2017 08:14:20 -0400
In-Reply-To: <1490692426.708.26.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tan Chin Yew <chin.yew.tan@intel.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/28/2017 12:13 PM, Andy Shevchenko wrote:
> On Tue, 2017-03-28 at 16:48 +0800, Tan Chin Yew wrote:
>> Sda-hold-time is an important parameter for tuning i2c to meet the
>> electrical specification especially for high speed. I2C with incorrect
>> sda-hold-time may cause lost arbitration error. Instead of loading all
>> speed mode settings, only selected speed mode settings are loaded.
>>
>> Signed-off-by: Tan Chin Yew <chin.yew.tan@intel.com>
>
>
> Looks good to me:
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
