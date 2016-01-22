From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: enable i2c adapter to suspend/resume
 asynchronously
Date: Fri, 22 Jan 2016 12:45:29 +0800
Message-ID: <56A1B3E9.9060207@linux.intel.com>
References: <567C04C7.6020300@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:49589 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394AbcAVEpr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 21 Jan 2016 23:45:47 -0500
In-Reply-To: <567C04C7.6020300@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: srinivas.kowtal@intel.com, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


Hi Wolfram,

What do you think about this patch?


Thanks,
Zhonghui



On 12/24/2015 10:44 PM, Fu, Zhonghui wrote:
> Now, PM core supports asynchronous suspend/resume mode for devices
> during system suspend/resume, and the power state transition of one
> device may be completed in separate kernel thread. PM core ensures
> all power state transition dependency between devices. This patch
> enables i2c adapters to suspend/resume asynchronously. This will take
> advantage of multicore and improve system suspend/resume speed. After
> enabling all i2c devices, i2c adapters and i2c controllers on ASUS
> T100TA tablet, the system suspend-to-idle time is reduced to about
> 510ms from 750ms, and the system resume time is reduced to about 790ms
> from 900ms.
>
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> ---
>  drivers/i2c/i2c-core.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index ba8eb08..72d5466 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1564,6 +1564,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>  
>  	pm_runtime_no_callbacks(&adap->dev);
>  
> +	device_enable_async_suspend(&adap->dev);
> +
>  #ifdef CONFIG_I2C_COMPAT
>  	res = class_compat_create_link(i2c_adapter_compat_class, &adap->dev,
>  				       adap->dev.parent);
> -- 1.7.1
>
