From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [v2 1/1] i2c: dev: prevent ZERO_SIZE_PTR deref in
 i2cdev_ioctl_rdwr()
Date: Thu, 19 Apr 2018 15:49:02 +0200
Message-ID: <20180419134902.6l5jsf4wpqfiaskj@pengutronix.de>
References: <1524140962-25639-1-git-send-email-alex.popov@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524140962-25639-1-git-send-email-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Popov <alex.popov@linux.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, sil2review@lists.osadl.org, Dmitry Vyukov <dvyukov@google.com>, syzkaller@googlegroups.com
List-Id: linux-i2c@vger.kernel.org

On Thu, Apr 19, 2018 at 03:29:22PM +0300, Alexander Popov wrote:
> i2cdev_ioctl_rdwr() allocates i2c_msg.buf using memdup_user(), which
> returns ZERO_SIZE_PTR if i2c_msg.len is zero.
> 
> Currently i2cdev_ioctl_rdwr() always dereferences the buf pointer in case
> of I2C_M_RD | I2C_M_RECV_LEN transfer. That causes a kernel oops in
> case of zero len.
> 
> Let's check the len against zero before dereferencing buf pointer.
> 
> This issue was triggered by syzkaller.
> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> ---
>  drivers/i2c/i2c-dev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index 036a03f..5790bc8 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -280,6 +280,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
>  		 */
>  		if (msgs[i].flags & I2C_M_RECV_LEN) {
>  			if (!(msgs[i].flags & I2C_M_RD) ||
> +			    !msgs[i].len ||

I'd prefer

			msgs[i].len > 0

here instead of

			!msgs[i].len

because I can parse that more easily. Semantically the patch is fine and
can have my

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

>  			    msgs[i].buf[0] < 1 ||
>  			    msgs[i].len < msgs[i].buf[0] +
>  					     I2C_SMBUS_BLOCK_MAX) {

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
