From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2] i2c/designware: enable i2c controller to
 suspend/resume asynchronously
Date: Mon, 1 Feb 2016 17:04:01 +0200
Message-ID: <56AF73E1.7080501@linux.intel.com>
References: <569893D1.5050403@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49721 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932715AbcBAPES (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 1 Feb 2016 10:04:18 -0500
In-Reply-To: <569893D1.5050403@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 01/15/2016 08:38 AM, Fu, Zhonghui wrote:
> Now, PM core supports asynchronous suspend/resume mode for devices
> during system suspend/resume, and the power state transition of one
> device may be completed in separate kernel thread. PM core ensures
> all power state transition dependency between devices. This patch
> enables designware i2c controllers to suspend/resume asynchronously.
> This will take advantage of multicore and improve system suspend/resume
> speed. After enabling all i2c devices, i2c adapters and i2c controllers
> on ASUS T100TA tablet, the system suspend-to-idle time is reduced to
> about 510ms from 750ms, and the system resume time is reduced to about
> 790ms from 900ms.
>
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> ---
> Changes in v2:
> - Move the device_enable_async_suspend() call into i2c_dw_proble()
>
>   drivers/i2c/busses/i2c-designware-core.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index ba9732c..5d6ad27 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -861,6 +861,7 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
>
>   	init_completion(&dev->cmd_complete);
>   	mutex_init(&dev->lock);
> +	device_enable_async_suspend(dev->dev);
>
I'm aware Andy had concerns about about stability and you also mention 
in another thread:

"if enable all LPSS devices suspend/resume asynchronously, the system 
can't resume sometimes on ASUS T100TA(BayTrail-T SoC). But, I have 
verified that the system can resume normally every time if enable only 
i2c controller async mode and let other LPSS devices in sync mode on 
ASUS T100TA.".

What I'm thinking would this change move things forward and help to find 
out what potential underlying issues there are in LPSS code.

I'm fine with this I2C side change but can we assure we don't 
accidentally enable the same on other LPSS devices before finding the 
root cause for the crash?

-- 
Jarkko
