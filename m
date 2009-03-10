From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 22/31] i2c: Auto-load i2c_dev module when device opened.
Date: Tue, 10 Mar 2009 17:56:12 +0100
Message-ID: <20090310175612.7e5b8272@hyperion.delvare>
References: <cover.1236702228.git.scott@canonical.com>
	<c9e8ec654db2ee34fc9fda29222aee9dd085ddaa.1236702228.git.scott@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c9e8ec654db2ee34fc9fda29222aee9dd085ddaa.1236702228.git.scott-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Scott James Remnant <scott-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Scott,

Your clock is off by a significant number of days, isn't it?

On Mon, 2 Mar 2009 18:41:51 +0000, Scott James Remnant wrote:
> The i2c_dev module is missing the char-major-89-* alias that would cause
> it to be auto-loaded when a device of that type is opened.  This patch
> adds the alias.

Why not, however this is pretty pointless nowadays as /dev nodes tend
to be created dynamically by udev, so there is no way i2c-dev will
auto-load.

> Signed-off-by: Scott James Remnant <scott-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> Signed-off-by: Tim Gardner <tim.gardner-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> ---
>  drivers/i2c/i2c-dev.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index 7e13d2d..f3f83ba 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -618,6 +618,7 @@ MODULE_AUTHOR("Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> and "
>  		"Simon G. Vogl <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>");
>  MODULE_DESCRIPTION("I2C /dev entries driver");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS_CHARDEV_MAJOR(I2C_MAJOR);
>  
>  module_init(i2c_dev_init);
>  module_exit(i2c_dev_exit);


-- 
Jean Delvare
