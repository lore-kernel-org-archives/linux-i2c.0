From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: linux-next: Tree for Oct 21 (drivers/i2c/busses/i2c-designware-platdrv.c)
Date: Thu, 22 Oct 2015 08:47:32 +0300
Message-ID: <56287874.40102@linux.intel.com>
References: <20151021171623.2d651735@canb.auug.org.au> <5627F55E.1010009@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28151 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbbJVFt6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 22 Oct 2015 01:49:58 -0400
In-Reply-To: <5627F55E.1010009@infradead.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi

On 10/21/2015 11:28 PM, Randy Dunlap wrote:
> On 10/20/15 23:16, Stephen Rothwell wrote:
>> Hi all,
>>
>> There will be no linux-next releases after tomorrow until Nov 2 (kernel
>> summit).
>>
>> Changes since 20151020:
>>
>
> on i386 or x86_64:
>
> when CONFIG_PM_SLEEP is not enabled:
>
> ../drivers/i2c/busses/i2c-designware-platdrv.c:340:13: error: 'dw_i2c_plat_prepare' undeclared here (not in a function)
>    .prepare = dw_i2c_plat_prepare,
>               ^
> ../drivers/i2c/busses/i2c-designware-platdrv.c:341:14: error: 'dw_i2c_plat_complete' undeclared here (not in a function)
>    .complete = dw_i2c_plat_complete,
>                ^
Here's the fix for this:

http://marc.info/?l=linux-i2c&m=144541136917692&w=2

-- 
Jarkko
