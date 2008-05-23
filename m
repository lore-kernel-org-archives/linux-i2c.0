From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: Push ioctl BKL down into the i2c code
Date: Fri, 23 May 2008 10:23:46 -0400
Message-ID: <9e4733910805230723n2bbe9d4erf363b3c7b430d415@mail.gmail.com>
References: <20080522222327.1af72794@core>
	<20080523093545.175c769c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080523093545.175c769c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 5/23/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Hi Alan,
>
>
>  On Thu, 22 May 2008 22:23:27 +0100, Alan Cox wrote:
>  > Signed-off-by: Alan Cox <alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>  >
>
>
> Description of what the patch does and why it is needed, please. I
>  can't apply it without that. My first impression is a patch making the
>  code bigger and more complex with no obvious benefit ;)


These BKL patches are part of a giant series of patches making the BLK
easier to remove.
There is a write up at LWN about the BKL.
http://lwn.net/Articles/281437/

Higher up in the kernel a global lock (BKL - big kernel lock) was
being taken before each IOCTL was called (and some other things). This
has the effect of serializing all IOCTL calls in the kernel. There is
no real need to serialize these IOCTLs in most cases.

Alan has removed the global lock/unlock code and now replicated it
across the 100s of IOCTLS in the kernel. This patch makes the
lock/unlock calls explicitly visible in the i2c code. He is trying to
remove this global lock since it hurts performance on SMP machines.

Now some programming needs to happen. The i2c ioctls need to be
inspected to see if they really need to be locked against multiple SMP
processors simultaneously entering them. There are multiple answers to
this question,  Do i2c IOCTLs need to be globally locked against all
other BLK users? Or do you only need a lock which is local to i2c? Or
is no lock needed at all? These question need to be answered for every
IOCTL in Linux.

i2c probably needs a lock per bus or controller to keep two SMP CPUs
from trying to program the controller simultaneously. Previously the
BKL had been serializing this.

So, the patch Alan supplied can be applied as is, it is just a
mechanically generated push down of the BKL. Applying it will continue
the same behavior as currently implemented in Linux. But Alan's patch
is probably not the optimal solution for i2c.


>
>  Bonus points for a diffstat of the patch.
>
>
>  > diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
>  > index d34c14c..16cf0f2 100644
>  > --- a/drivers/i2c/i2c-dev.c
>  > +++ b/drivers/i2c/i2c-dev.c
>  > @@ -34,7 +34,8 @@
>  >  #include <linux/list.h>
>  >  #include <linux/i2c.h>
>  >  #include <linux/i2c-dev.h>
>  > -#include <asm/uaccess.h>
>  > +#include <linux/smp_lock.h>
>  > +#include <linux/uaccess.h>
>  >
>  >  static struct i2c_driver i2cdev_driver;
>  >
>  > @@ -266,8 +267,9 @@ static noinline int i2cdev_ioctl_rdrw(struct i2c_client *client,
>  >               kfree(rdwr_pa);
>  >               return res;
>  >       }
>  > -
>  > +     lock_kernel();
>  >       res = i2c_transfer(client->adapter, rdwr_pa, rdwr_arg.nmsgs);
>  > +     unlock_kernel();
>  >       while (i-- > 0) {
>  >               if (res >= 0 && (rdwr_pa[i].flags & I2C_M_RD)) {
>  >                       if (copy_to_user(data_ptrs[i], rdwr_pa[i].buf,
>  > @@ -320,11 +322,15 @@ static noinline int i2cdev_ioctl_smbus(struct i2c_client *client,
>  >
>  >       if ((data_arg.size == I2C_SMBUS_QUICK) ||
>  >           ((data_arg.size == I2C_SMBUS_BYTE) &&
>  > -         (data_arg.read_write == I2C_SMBUS_WRITE)))
>  > +         (data_arg.read_write == I2C_SMBUS_WRITE))) {
>  >               /* These are special: we do not use data */
>  > -             return i2c_smbus_xfer(client->adapter, client->addr,
>  > +             lock_kernel();
>  > +             res =i2c_smbus_xfer(client->adapter, client->addr,
>
>
> Coding style.
>
>
>  >                                     client->flags, data_arg.read_write,
>  >                                     data_arg.command, data_arg.size, NULL);
>  > +             unlock_kernel();
>  > +             return res;
>  > +     }
>  >
>  >       if (data_arg.data == NULL) {
>  >               dev_dbg(&client->adapter->dev,
>  > @@ -355,8 +361,10 @@ static noinline int i2cdev_ioctl_smbus(struct i2c_client *client,
>  >               if (data_arg.read_write == I2C_SMBUS_READ)
>  >                       temp.block[0] = I2C_SMBUS_BLOCK_MAX;
>  >       }
>  > +     lock_kernel();
>  >       res = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
>  >             data_arg.read_write, data_arg.command, data_arg.size, &temp);
>  > +     unlock_kernel();
>  >       if (!res && ((data_arg.size == I2C_SMBUS_PROC_CALL) ||
>  >                    (data_arg.size == I2C_SMBUS_BLOCK_PROC_CALL) ||
>  >                    (data_arg.read_write == I2C_SMBUS_READ))) {
>  > @@ -366,11 +374,12 @@ static noinline int i2cdev_ioctl_smbus(struct i2c_client *client,
>  >       return res;
>  >  }
>  >
>  > -static int i2cdev_ioctl(struct inode *inode, struct file *file,
>  > -             unsigned int cmd, unsigned long arg)
>  > +static long i2cdev_ioctl(struct file *file, unsigned int cmd,
>  > +                                             unsigned long arg)
>  >  {
>  >       struct i2c_client *client = (struct i2c_client *)file->private_data;
>  >       unsigned long funcs;
>  > +     int ret = 0;
>  >
>  >       dev_dbg(&client->adapter->dev, "ioctl, cmd=0x%02x, arg=0x%02lx\n",
>  >               cmd, arg);
>  > @@ -388,28 +397,37 @@ static int i2cdev_ioctl(struct inode *inode, struct file *file,
>  >                * the PEC flag already set, the i2c-dev driver won't see
>  >                * (or use) this setting.
>  >                */
>  > +             lock_kernel();
>  >               if ((arg > 0x3ff) ||
>  >                   (((client->flags & I2C_M_TEN) == 0) && arg > 0x7f))
>  > -                     return -EINVAL;
>  > -             if (cmd == I2C_SLAVE && i2cdev_check_addr(client->adapter, arg))
>  > -                     return -EBUSY;
>  > -             /* REVISIT: address could become busy later */
>  > -             client->addr = arg;
>  > -             return 0;
>  > +                     ret = -EINVAL;
>  > +             else if (cmd == I2C_SLAVE &&
>  > +                             i2cdev_check_addr(client->adapter, arg))
>  > +                     ret = -EBUSY;
>  > +             else
>  > +                     /* REVISIT: address could become busy later */
>  > +                     client->addr = arg;
>
>
> No unlock?
>
>
>  > +             return ret;
>  >       case I2C_TENBIT:
>  > +             lock_kernel();
>  >               if (arg)
>  >                       client->flags |= I2C_M_TEN;
>  >               else
>  >                       client->flags &= ~I2C_M_TEN;
>  > +             unlock_kernel();
>  >               return 0;
>  >       case I2C_PEC:
>  > +             lock_kernel();
>  >               if (arg)
>  >                       client->flags |= I2C_CLIENT_PEC;
>  >               else
>  >                       client->flags &= ~I2C_CLIENT_PEC;
>  > +             unlock_kernel();
>  >               return 0;
>  >       case I2C_FUNCS:
>  > +             lock_kernel();
>  >               funcs = i2c_get_functionality(client->adapter);
>  > +             unlock_kernel();
>  >               return put_user(funcs, (unsigned long __user *)arg);
>  >
>  >       case I2C_RDWR:
>  > @@ -419,10 +437,14 @@ static int i2cdev_ioctl(struct inode *inode, struct file *file,
>  >               return i2cdev_ioctl_smbus(client, arg);
>  >
>  >       case I2C_RETRIES:
>  > +             lock_kernel();
>  >               client->adapter->retries = arg;
>  > +             unlock_kernel();
>  >               break;
>  >       case I2C_TIMEOUT:
>  > +             lock_kernel();
>  >               client->adapter->timeout = arg;
>  > +             unlock_kernel();
>  >               break;
>  >       default:
>  >               /* NOTE:  returning a fault code here could cause trouble
>  > @@ -487,7 +509,7 @@ static const struct file_operations i2cdev_fops = {
>  >       .llseek         = no_llseek,
>  >       .read           = i2cdev_read,
>  >       .write          = i2cdev_write,
>  > -     .ioctl          = i2cdev_ioctl,
>  > +     .unlocked_ioctl = i2cdev_ioctl,
>  >       .open           = i2cdev_open,
>  >       .release        = i2cdev_release,
>  >  };
>
>
>
> --
>
> Jean Delvare
>
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
