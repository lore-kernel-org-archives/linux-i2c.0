From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: designware platdrv and runtime pm?
Date: Tue, 10 Nov 2015 10:42:11 +0200
Message-ID: <5641ADE3.6060704@linux.intel.com>
References: <20151109211503.GA3793@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31468 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbbKJImP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 10 Nov 2015 03:42:15 -0500
In-Reply-To: <20151109211503.GA3793@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "David E. Box" <david.e.box@linux.intel.com>

On 09.11.2015 23:15, Wolfram Sang wrote:
> Hi guys,
>
> while handling the merge conflict for the designware-platdrv, I noticed
> an asymmetry in the runtime PM handling. Currently, code looks like
> this:
>
> 	if (dev->pm_runtime_disabled) {
> 		pm_runtime_forbid(&pdev->dev);
> 	} else {
> 		pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
> 		pm_runtime_use_autosuspend(&pdev->dev);
> 		pm_runtime_set_active(&pdev->dev);
> 		pm_runtime_enable(&pdev->dev);
> 	}
>
> 	r = i2c_dw_probe(dev);
> 	if (r) {
> 		pm_runtime_disable(&pdev->dev);
> 		return r;
> 	}
>
> But shouldn't the above error path (and the remove path) also take
> dev->pm_runtime_disabled into account and act accordingly?
>
I think you are right. Which brings another question to my mind do we 
need to have a patch to linux-stable too?

David: Your original commit 894acb2f823b ("i2c: designware: Add Intel 
Baytrail PMIC I2C bus support") doesn't add pm_runtime_disabled test to 
dw_i2c_remove(). I guess there is possibility power down the shared 
controller by having CONFIG_I2C_DESIGNWARE_PLATFORM=m and then unloading 
the driver?

-- 
Jarkko
