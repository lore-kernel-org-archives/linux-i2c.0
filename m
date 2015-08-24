From: "Fu, Zhonghui" <zhonghui.fu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: enable i2c adapter to suspend/resume asynchronously
Date: Mon, 24 Aug 2015 23:22:05 +0800
Message-ID: <55DB369D.7030305@linux.intel.com>
References: <55D20919.5020800@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55D20919.5020800-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

Any comments are welcome.


Thanks,
Zhonghui



On 2015/8/18 0:17, Fu, Zhonghui wrote:
> Enable i2c adapter to suspend/resume asynchronously. This can improve
> system suspend/resume speed.
>
> Signed-off-by: Zhonghui Fu <zhonghui.fu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index c83e4d1..90251be 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1439,6 +1439,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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
