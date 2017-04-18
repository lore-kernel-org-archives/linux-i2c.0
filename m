From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: do not show SDA hold time warning when
 not needed
Date: Tue, 18 Apr 2017 13:23:28 +0300
Message-ID: <7b011e1e-8fa3-07c4-6688-5e258fd64dbd@linux.intel.com>
References: <1492203192-28025-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1492502087.24567.47.camel@linux.intel.com>
 <20170418095939.68788787@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40098 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755382AbdDRKXb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 18 Apr 2017 06:23:31 -0400
In-Reply-To: <20170418095939.68788787@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 04/18/2017 10:59 AM, Thomas Petazzoni wrote:
> Hello,
>
> On Tue, 18 Apr 2017 10:54:47 +0300, Andy Shevchenko wrote:
>> On Fri, 2017-04-14 at 22:53 +0200, Thomas Petazzoni wrote:
>>> When the I2C controller IP block has a revision too old to be able to
>>> configure the SDA hold time, the driver currently displays a
>>> warning. However, it does so unconditionally, even if no SDA hold time
>>> has been configured through the Device Tree. This causes useless
>>> warnings when running the system, so only show the warning if a SDA
>>> hold time was specified.
>>
>> As far as I understand the warning it would be better to keep it in
>> either way, though you may shift it to debug level.
>>
>> Wolfram, Jarkko, thoughts?
>
> Why show a message when the user has not requested a custom SDA hold
> time? Getting a warning about something you haven't requested seems
> really odd.
>
> I think it makes a lot more sense to keep it at the warning level
> (because it's important to get this message if you configure a custom
> SDA hold time), but only show it when appropriate.
>
I guess warning over debug level could have slightly better chance to 
prevent someone not adding needless "i2c-sda-hold-time-ns" property in a 
hardware that doesn't support SDA hold time. But needless spamming have 
negative value so this is worth to fix. (I would do this as a single 
liner by else if ()).

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
