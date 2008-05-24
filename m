From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: Push ioctl BKL down into the i2c code
Date: Sat, 24 May 2008 10:50:48 -0400
Message-ID: <9e4733910805240750g21130ae9sd01e928edff8eb64@mail.gmail.com>
References: <20080524100623.3b059a49@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080524100623.3b059a49-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 5/24/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
>
>  This is part of the effort to get rid of the BKL.
>
>  [JD: In fact i2c-dev doesn't need more locking than is already done
>  for the other i2c drivers, so we can simply switch to unlocked_ioctl.]

Note that the existing locking code in i2c (which may be correct
without the BLK) hasn't really been tested since the BKL was
serializing things before they got to the i2c code.

>  Signed-off-by: Alan Cox <alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>  Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>  ---
>   drivers/i2c/i2c-dev.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
>  --- linux-2.6.26-rc3.orig/drivers/i2c/i2c-dev.c 2008-05-04 09:49:48.000000000 +0200
>  +++ linux-2.6.26-rc3/drivers/i2c/i2c-dev.c      2008-05-24 08:33:29.000000000 +0200
>  @@ -366,8 +366,8 @@ static noinline int i2cdev_ioctl_smbus(s
>         return res;
>   }
>
>  -static int i2cdev_ioctl(struct inode *inode, struct file *file,
>  -               unsigned int cmd, unsigned long arg)
>  +static long i2cdev_ioctl(struct file *file, unsigned int cmd,
>  +                                               unsigned long arg)
>   {
>         struct i2c_client *client = (struct i2c_client *)file->private_data;
>         unsigned long funcs;
>  @@ -487,7 +487,7 @@ static const struct file_operations i2cd
>         .llseek         = no_llseek,
>         .read           = i2cdev_read,
>         .write          = i2cdev_write,
>  -       .ioctl          = i2cdev_ioctl,
>  +       .unlocked_ioctl = i2cdev_ioctl,
>         .open           = i2cdev_open,
>         .release        = i2cdev_release,
>   };
>
>
>
>  --
>  Jean Delvare
>
>  _______________________________________________
>  i2c mailing list
>  i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
>  http://lists.lm-sensors.org/mailman/listinfo/i2c
>


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
