From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: Designware i2c loopback
Date: Wed, 9 Aug 2017 15:00:32 +0300
Message-ID: <9c0aa22a-5a78-b18a-e2e9-607a1b694140@linux.intel.com>
References: <MWHPR1201MB24949D9452D00C328705A0B9A08A0@MWHPR1201MB2494.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:52661 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752409AbdHIMAf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 9 Aug 2017 08:00:35 -0400
In-Reply-To: <MWHPR1201MB24949D9452D00C328705A0B9A08A0@MWHPR1201MB2494.namprd12.prod.outlook.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On 08/08/2017 05:24 PM, Shah, Nehal-bakulchandra wrote:
> Hi ,
> 
> Is it possible to validate the loopback functionality with designware i2c driver? Assuming that I don't have any i2c-slave connected. Hence I want to validate some Xfer functionality with loop back.
> 
I'm not aware. Datasheet kind of indicates it might be possible by 
setting the IC_TAR and IC_SAR to the same value but don't know what does 
that mean in practice. What kind of transfers are possible, driver 
changes, etc.

Of course now it should be possible to hook 2 controllers together after 
i2c-designware got the I2C slave support - configure one as an I2C 
master and another as an I2C slave controller.

-- 
Jarkko
