From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Oct 21
 (drivers/i2c/busses/i2c-designware-platdrv.c)
Date: Wed, 21 Oct 2015 13:28:14 -0700
Message-ID: <5627F55E.1010009@infradead.org>
References: <20151021171623.2d651735@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57953 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbbJUU2R (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Oct 2015 16:28:17 -0400
In-Reply-To: <20151021171623.2d651735@canb.auug.org.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On 10/20/15 23:16, Stephen Rothwell wrote:
> Hi all,
> 
> There will be no linux-next releases after tomorrow until Nov 2 (kernel
> summit).
> 
> Changes since 20151020:
> 

on i386 or x86_64:

when CONFIG_PM_SLEEP is not enabled:

../drivers/i2c/busses/i2c-designware-platdrv.c:340:13: error: 'dw_i2c_plat_prepare' undeclared here (not in a function)
  .prepare = dw_i2c_plat_prepare,
             ^
../drivers/i2c/busses/i2c-designware-platdrv.c:341:14: error: 'dw_i2c_plat_complete' undeclared here (not in a function)
  .complete = dw_i2c_plat_complete,
              ^




-- 
~Randy
