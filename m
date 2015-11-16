From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH v2] i2c: enable i2c adapter to suspend/resume asynchronously
Date: Mon, 16 Nov 2015 23:37:32 +0800
Message-ID: <5649F83C.9060605@linux.intel.com>
References: <56039D22.8020907@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:54131 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbbKPPh7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 16 Nov 2015 10:37:59 -0500
In-Reply-To: <56039D22.8020907@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.dewsa@the-dreams.de, jarkko.nikula@intel.com, mika.westerberg@intel.com
Cc: linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


Any comments are welcome.


Thanks,
Zhonghui



On 9/24/2015 2:50 PM, Fu, Zhonghui wrote:
> Now, PM core supports asynchronous suspend/resume mode for devices
> during system suspend/resume, and the power state transition of one
> device may be completed in separate kernel thread. PM core ensures
> all power state transition timing dependency between devices. This
> patch enables i2c adapter to suspend/resume asynchronously. This
> will take advantage of multicore and improve system suspend/resume
> speed.
>
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> ---
> Changes in v2:
> - Amend commit message.
>
>  drivers/i2c/i2c-core.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 5f89f1e..c273b55 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1528,6 +1528,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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
