From: Alexander Popov <alex.popov@linux.com>
Subject: Re: [PATCH 1/1] i2c: dev: check i2c_msg len before memdup_user() to
 prevent ZERO_SIZE_PTR deref
Date: Wed, 18 Apr 2018 16:00:23 +0300
Message-ID: <684dc732-88f0-31dd-c1ae-ba54a733abbb@linux.com>
References: <1524010605-21552-1-git-send-email-alex.popov@linux.com>
 <20180418070704.35zj5chpdkirnmdt@pengutronix.de>
 <92f44b44-a5a1-c844-4d96-db0697b2e090@linux.com>
 <20180418082319.wxxhwxwhblwh6llo@pengutronix.de>
Reply-To: alex.popov@linux.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180418082319.wxxhwxwhblwh6llo@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, sil2review@lists.osadl.org, Dmitry Vyukov <dvyukov@google.com>
List-Id: linux-i2c@vger.kernel.org

On 18.04.2018 11:23, Uwe Kleine-König wrote:
> On Wed, Apr 18, 2018 at 10:56:03AM +0300, Alexander Popov wrote:
>> On 18.04.2018 10:07, Uwe Kleine-König wrote:
>>> Your commit log is wrong (and I think the patch, too).
>>
>> I believe this bug is not a memdup_user() issue. There is a nice selection from
>> LKML discussions about ZERO_SIZE_PTR, which convinces me:
>> http://yarchive.net/comp/linux/malloc_0.html
> 
> Ack, no memdup_user problem. i2cdev_ioctl_rdwr() should not access
> msgs[i].buf[0] if msgs[i].len is 0.
> 
> But you should not prohibit i2c transfers with length 0 in general.

Ok, thanks for that info. I should fix the patch.

> So a better patch is the following:
> 
> 
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index 036a03f0d0a6..0137538c36a0 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -280,6 +280,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
>  		 */
>  		if (msgs[i].flags & I2C_M_RECV_LEN) {
>  			if (!(msgs[i].flags & I2C_M_RD) ||
> +			    msgs[i].len < 1 ||
>  			    msgs[i].buf[0] < 1 ||
>  			    msgs[i].len < msgs[i].buf[0] +
>  					     I2C_SMBUS_BLOCK_MAX) {
> 
> But having said that and after reading the comment above the if, I'm not
> sure this is enough. 

I'll check that carefully and come back with the next version.

Thanks!
Alexander
