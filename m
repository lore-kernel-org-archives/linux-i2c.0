From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH i2c-tools] i2c-dev.h: copy over typo fix from kernel
 include
Date: Fri, 19 Jan 2018 09:37:53 +0100
Message-ID: <20180119093753.71e9457f@endymion>
References: <20180115204030.26400-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36145 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754070AbeASIh4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 19 Jan 2018 03:37:56 -0500
In-Reply-To: <20180115204030.26400-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, 15 Jan 2018 21:40:30 +0100, Wolfram Sang wrote:
> We had a typo in a define which got fixed in the kernel. Fix it here,
> too!
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  include/linux/i2c-dev.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/i2c-dev.h b/include/linux/i2c-dev.h
> index 839d25a..bbb50e8 100644
> --- a/include/linux/i2c-dev.h
> +++ b/include/linux/i2c-dev.h
> @@ -66,7 +66,9 @@ struct i2c_rdwr_ioctl_data {
>  	__u32 nmsgs;			/* number of i2c_msgs */
>  };
>  
> -#define  I2C_RDRW_IOCTL_MAX_MSGS	42
> +#define  I2C_RDWR_IOCTL_MAX_MSGS	42
> +/* Originally defined with a typo, keep it for compatibility */
> +#define  I2C_RDRW_IOCTL_MAX_MSGS	I2C_RDWR_IOCTL_MAX_MSGS
>  
>  
>  #endif /* _LINUX_I2C_DEV_H */

Hmm, no. As part of the libi2c plan, we were supposed to get rid of
kernel header files duplication in i2c-tools. See commits 93caf007f4cb
("i2c-dev: Move SMBus helper functions to include/i2c/smbus.h") and
652619121974 ("i2c-dev.h: Minimize differences with kernel flavor".) At
this point i2c-tools' i2c-dev.h and the kernel's i2c-dev.h are exactly
the same file, modulo the difference you just pointed out.

So the right thing to do is to delete include/linux/i2c-dev.h from
i2c-tools altogether. We no longer use it and we no longer install it,
so it should be a straightforward change. I simply forgot to do it
after the library conversion.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
