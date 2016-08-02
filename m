From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 3/3] i2c: designware: Find bus speed from ACPI
Date: Tue, 2 Aug 2016 17:03:47 +0300
Message-ID: <5e268060-7350-c24a-a53f-c4d9e6b07403@linux.intel.com>
References: <1465212383-24639-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1465212383-24639-4-git-send-email-jarkko.nikula@linux.intel.com>
 <20160714133645.GH4149@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4423 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967153AbcHBOEX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 2 Aug 2016 10:04:23 -0400
In-Reply-To: <20160714133645.GH4149@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Weifeng Voon <weifeng.voon@intel.com>

Hi

On 07/14/2016 04:36 PM, Wolfram Sang wrote:
> On Mon, Jun 06, 2016 at 02:26:23PM +0300, Jarkko Nikula wrote:
>> Fast mode is the default speed of i2c-designware which can be overridden
>> by platform data or by "clock-frequency" device property. Even though
>> the ACPI 5.1 can pass device properties via _DSD method, shipping systems
>> define the connection speed between I2C host and each slave in their
>> I2cSerialBus resources. Which means speed is not defined per bus but per
>> slave.
>>
>> As there is now support in i2c-core to find the bus speed from ACPI use
>> that to set up the bus speed prior registering the I2C adapter.
>>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>
> I can't apply this one? Neither on v4.6, v4.7-rc1 or on i2c/for-next?
>
Sorry the delay, I was on vacation.

This one was dependent on Weifeng's fast mode + and high speed set while 
the patches 1-2/3 conflicted with Octavian's set I guess.

Weifeng's set appears to apply by resolving a single line. But since we 
both need to resend anyway maybe it's easier for you if we post our sets 
together after I resolve conflicts in my patches and do some testing?

-- 
Jarkko
