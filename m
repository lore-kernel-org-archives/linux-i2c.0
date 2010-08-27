From: Andrew Chew <AChew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 1/1] drivers/misc/akm8975: Add compass sensor driver
Date: Thu, 26 Aug 2010 19:10:48 -0700
Message-ID: <643E69AA4436674C8F39DCC2C05F763816B7C05787@HQMAIL03.nvidia.com>
References: <1282872717-12228-1-git-send-email-achew@nvidia.com>
 <20100826191037.abdf65e5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100826191037.abdf65e5.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Andrew Morton' <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: "lkml-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <lkml-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Yes, really really sorry about that.  I'll have to see what's up with my git send-email configuration.

-----Original Message-----
From: Andrew Morton [mailto:akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org]
Sent: Thursday, August 26, 2010 7:11 PM
To: Andrew Chew
Cc: lkml-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org; olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org
Subject: Re: [PATCH 1/1] drivers/misc/akm8975: Add compass sensor driver


> From: Andrew.Chew-FOgKQjlUJ6BQetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org

Your email setup is doing strange things.

On Thu, 26 Aug 2010 18:31:57 -0700 Andrew.Chew-FOgKQjlUJ6BQetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org wrote:

> From: Andrew Chew <achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> This is for the Asahi Kasei's I2C compass sensor AK8975.
>
> Signed-off-by: Andrew Chew <achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/misc/Kconfig    |    8 +
>  drivers/misc/Makefile   |    1 +
>  drivers/misc/akm8975.c  |  670 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/akm8975.h |   87 ++++++
>  4 files changed, 766 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/misc/akm8975.c
>  create mode 100644 include/linux/akm8975.h
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 26386a9..9bb3d03 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -304,6 +304,14 @@ config SENSORS_TSL2550
>         This driver can also be built as a module.  If so, the module
>         will be called tsl2550.
>
> +config SENSORS_AK8975
> +     tristate "AK8975 compass support"
> +     default n
> +     depends on I2C
> +     help
> +       If you say yes here you get support for Asahi Kasei's
> +       orientation sensor AK8975.

Should it be in drivers/hwmon?

Perhaps not, given that drivers/misc/hmc6352.c is in drivers/misc/

Did you review the userspace interface in hmc6352.c?  Is the interface
for this driver identical to that one (I hope so).

Your changelog didn't describe this driver's interface at all, and the
patch provided no documentation for the interface.  But the interface
is the most important part of the driver, because it is the one thing
we can never change.

>  config EP93XX_P
>       tristate "EP93xx PWM support"
>       depends on ARCH_EP93XX
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 6ed06a1..366791b 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -31,3 +31,4 @@ obj-$(CONFIG_IWMC3200TOP)      += iwmc3200top/
>  obj-y                                += eeprom/
>  obj-y                                += cb710/
>  obj-$(CONFIG_VMWARE_BALLOON) += vmware_balloon.o
> +obj-$(CONFIG_SENSORS_AK8975) += akm8975.o
> diff --git a/drivers/misc/akm8975.c b/drivers/misc/akm8975.c
> new file mode 100644
> index 0000000..17a096e
> --- /dev/null
> +++ b/drivers/misc/akm8975.c
> @@ -0,0 +1,670 @@
> +/* drivers/misc/akm8975.c - akm8975 compass driver
> + *
> + * Copyright (C) 2007-2008 HTC Corporation.
> + * Author: Hou-Kun Chen <houkun.chen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

It would be nice to get this person's signed-off-by.

> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +/*
> + * Revised by AKM 2009/04/02
> + * Revised by Motorola 2010/05/27

And even person@motorola's, if possible?

> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/irq.h>
> +#include <linux/miscdevice.h>
> +#include <linux/gpio.h>
> +#include <linux/uaccess.h>
> +#include <linux/delay.h>
> +#include <linux/input.h>
> +#include <linux/workqueue.h>
> +#include <linux/freezer.h>
> +#include <linux/akm8975.h>
> +
> +#define AK8975DRV_CALL_DBG 0
> +#if AK8975DRV_CALL_DBG
> +#define FUNCDBG(msg) pr_err("%s:%s\n", __func__, msg);
> +#else
> +#define FUNCDBG(msg)
> +#endif
> +
> +#define AK8975DRV_DATA_DBG 0
> +#define MAX_FAILURE_COUNT 10
> +
> +struct akm8975_data {
> +     struct i2c_client *this_client;
> +     struct akm8975_platform_data *pdata;
> +     struct input_dev *input_dev;
> +     struct work_struct work;
> +     struct mutex flags_lock;
> +};
> +
> +/*
> +* Because misc devices can not carry a pointer from driver register to
> +* open, we keep this global. This limits the driver to a single instance.
> +*/
> +struct akm8975_data *akmd_data;

That has changed.  See the post-2.6.35 patch

commit fa1f68db6ca7ebb6fc4487ac215bffba06c01c28
Author: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Date:   Mon May 24 14:33:10 2010 -0700

    drivers: misc: pass miscdevice pointer via file private data


> +static DECLARE_WAIT_QUEUE_HEAD(open_wq);
> +
> +static atomic_t open_flag;
> +
> +static short m_flag;
> +static short a_flag;
> +static short t_flag;
> +static short mv_flag;
> +
> +static short akmd_delay;

It would bee great to add comments describing the above globals.

The driver assumes that I will only ever have one device in the
machine.  That's surely a reasonable assumption, unless I'm making a
compass-testing workstation.  But it's a bit sad from a general driver
design point of view.

> +static ssize_t akm8975_show(struct device *dev, struct device_attribute *attr,
> +                              char *buf)
> +{
> +     struct i2c_client *client = to_i2c_client(dev);
> +     return sprintf(buf, "%u\n", i2c_smbus_read_byte_data(client,
> +                                                          AK8975_REG_CNTL));
> +}

Please include a single empty line between functions.

> +static ssize_t akm8975_store(struct device *dev, struct device_attribute *attr,
> +                         const char *buf, size_t count)
> +{
> +     struct i2c_client *client = to_i2c_client(dev);
> +     unsigned long val;
> +     strict_strtoul(buf, 10, &val);
> +     if (val > 0xff)
> +             return -EINVAL;
> +     i2c_smbus_write_byte_data(client, AK8975_REG_CNTL, val);
> +     return count;
> +}

And please have a blank line between end-of-locals and start-of code.

The whole point of using strict_strto*() is to check the return value!
If I try to store "42foo" into this pseudo-file, this code will send
random junk down the i2c bus.

<I'll do a patch to add __must_check to those functions>

>
> ...
>
> +static void akm8975_ecs_report_value(struct akm8975_data *akm, short *rbuf)
> +{
> +     struct akm8975_data *data = i2c_get_clientdata(akm->this_client);
> +
> +     FUNCDBG("called");
> +
> +#if AK8975DRV_DATA_DBG
> +     pr_info("akm8975_ecs_report_value: yaw = %d, pitch = %d, roll = %d\n",
> +                              rbuf[0], rbuf[1], rbuf[2]);
> +     pr_info("tmp = %d, m_stat= %d, g_stat=%d\n", rbuf[3], rbuf[4], rbuf[5]);
> +     pr_info("Acceleration:   x = %d LSB, y = %d LSB, z = %d LSB\n",
> +                              rbuf[6], rbuf[7], rbuf[8]);
> +     pr_info("Magnetic:       x = %d LSB, y = %d LSB, z = %d LSB\n\n",
> +                              rbuf[9], rbuf[10], rbuf[11]);
> +#endif
> +     mutex_lock(&akm->flags_lock);
> +     /* Report magnetic sensor information */
> +     if (m_flag) {
> +             input_report_abs(data->input_dev, ABS_RX, rbuf[0]);
> +             input_report_abs(data->input_dev, ABS_RY, rbuf[1]);
> +             input_report_abs(data->input_dev, ABS_RZ, rbuf[2]);
> +             input_report_abs(data->input_dev, ABS_RUDDER, rbuf[4]);
> +     }
> +
> +     /* Report acceleration sensor information */
> +     if (a_flag) {
> +             input_report_abs(data->input_dev, ABS_X, rbuf[6]);
> +             input_report_abs(data->input_dev, ABS_Y, rbuf[7]);
> +             input_report_abs(data->input_dev, ABS_Z, rbuf[8]);
> +             input_report_abs(data->input_dev, ABS_WHEEL, rbuf[5]);
> +     }
> +
> +     /* Report temperature information */
> +     if (t_flag)
> +             input_report_abs(data->input_dev, ABS_THROTTLE, rbuf[3]);
> +
> +     if (mv_flag) {
> +             input_report_abs(data->input_dev, ABS_HAT0X, rbuf[9]);
> +             input_report_abs(data->input_dev, ABS_HAT0Y, rbuf[10]);
> +             input_report_abs(data->input_dev, ABS_BRAKE, rbuf[11]);
> +     }

oh, so that's what m, a and t mean.  <scratches head over mv>

> +     mutex_unlock(&akm->flags_lock);

I keep reading this as akpm.  Scary.

> +     input_sync(data->input_dev);
> +}
> +
> +static void akm8975_ecs_close_done(struct akm8975_data *akm)
> +{
> +     FUNCDBG("called");
> +     mutex_lock(&akm->flags_lock);
> +     m_flag = 1;
> +     a_flag = 1;
> +     t_flag = 1;
> +     mv_flag = 1;
> +     mutex_unlock(&akm->flags_lock);
> +}
> +
> +static int akm_aot_open(struct inode *inode, struct file *file)
> +{
> +     int ret = -1;
> +
> +     FUNCDBG("called");
> +     if (atomic_cmpxchg(&open_flag, 0, 1) == 0) {
> +             wake_up(&open_wq);
> +             ret = 0;
> +     }

What's all this doing?

> +     ret = nonseekable_open(inode, file);
> +     if (ret)
> +             return ret;
> +
> +     file->private_data = akmd_data;
> +
> +     return ret;
> +}
> +
> +static int akm_aot_release(struct inode *inode, struct file *file)
> +{
> +     FUNCDBG("called");
> +     atomic_set(&open_flag, 0);
> +     wake_up(&open_wq);

And what's this doing and why and what's the user-visible behaviour here?

Documentation, please!  Code comments.  And user docs if it's user-visible!

> +     return 0;
> +}
> +
> +static int akm_aot_ioctl(struct inode *inode, struct file *file,
> +           unsigned int cmd, unsigned long arg)
> +{
> +     void __user *argp = (void __user *) arg;
> +     short flag;
> +     struct akm8975_data *akm = file->private_data;
> +
> +     FUNCDBG("called");
> +
> +     switch (cmd) {
> +     case ECS_IOCTL_APP_SET_MFLAG:
> +     case ECS_IOCTL_APP_SET_AFLAG:
> +     case ECS_IOCTL_APP_SET_MVFLAG:
> +             if (copy_from_user(&flag, argp, sizeof(flag)))
> +                     return -EFAULT;
> +             if (flag < 0 || flag > 1)
> +                     return -EINVAL;
> +             break;
> +     case ECS_IOCTL_APP_SET_DELAY:
> +             if (copy_from_user(&flag, argp, sizeof(flag)))
> +                     return -EFAULT;
> +             break;
> +     default:
> +             break;
> +     }
> +
> +     mutex_lock(&akm->flags_lock);
> +     switch (cmd) {
> +     case ECS_IOCTL_APP_SET_MFLAG:
> +             m_flag = flag;
> +             break;
> +     case ECS_IOCTL_APP_GET_MFLAG:
> +             flag = m_flag;
> +             break;
> +     case ECS_IOCTL_APP_SET_AFLAG:
> +             a_flag = flag;
> +             break;
> +     case ECS_IOCTL_APP_GET_AFLAG:
> +             flag = a_flag;
> +             break;
> +     case ECS_IOCTL_APP_SET_MVFLAG:
> +             mv_flag = flag;
> +             break;
> +     case ECS_IOCTL_APP_GET_MVFLAG:
> +             flag = mv_flag;
> +             break;
> +     case ECS_IOCTL_APP_SET_DELAY:
> +             akmd_delay = flag;
> +             break;
> +     case ECS_IOCTL_APP_GET_DELAY:
> +             flag = akmd_delay;
> +             break;
> +     default:
> +             return -ENOTTY;
> +     }
> +     mutex_unlock(&akm->flags_lock);
> +
> +     switch (cmd) {
> +     case ECS_IOCTL_APP_GET_MFLAG:
> +     case ECS_IOCTL_APP_GET_AFLAG:
> +     case ECS_IOCTL_APP_GET_MVFLAG:
> +     case ECS_IOCTL_APP_GET_DELAY:
> +             if (copy_to_user(argp, &flag, sizeof(flag)))
> +                     return -EFAULT;
> +             break;
> +     default:
> +             break;
> +     }
> +
> +     return 0;
> +}

I'm suspecting that we're not getting ourselves a standardised Linux
compass driver API :( I think this is a significant problem!

>
> ...
>
> +/* needed to clear the int. pin */
> +static void akm_work_func(struct work_struct *work)
> +{
> +     struct akm8975_data *akm =
> +         container_of(work, struct akm8975_data, work);
> +
> +     FUNCDBG("called");
> +     enable_irq(akm->this_client->irq);
> +}
> +
> +static irqreturn_t akm8975_interrupt(int irq, void *dev_id)
> +{
> +     struct akm8975_data *akm = dev_id;
> +     FUNCDBG("called");
> +
> +     disable_irq_nosync(akm->this_client->irq);
> +     schedule_work(&akm->work);
> +     return IRQ_HANDLED;
> +}

enable_irq() and disable_irq() tend to be red flags - drivers really
shouldn't be fiddling with them.

Maybe there's a good reason, but it should have been completely
described in code comments.  This reviewer is mystified, and assumes
that people who read the code later will be as well.

> +static int akm8975_power_off(struct akm8975_data *akm)
> +{
> +#if AK8975DRV_CALL_DBG
> +     pr_info("%s\n", __func__);
> +#endif
> +     if (akm->pdata->power_off)
> +             akm->pdata->power_off();
> +
> +     return 0;
> +}
> +
> +static int akm8975_power_on(struct akm8975_data *akm)
> +{
> +     int err;
> +
> +#if AK8975DRV_CALL_DBG
> +     pr_info("%s\n", __func__);
> +#endif
> +     if (akm->pdata->power_on) {
> +             err = akm->pdata->power_on();
> +             if (err < 0)
> +                     return err;
> +     }
> +     return 0;
> +}

Can ->power_off and ->power_on ever be NULL?

> +static int akm8975_init_client(struct i2c_client *client)
> +{
> +     struct akm8975_data *data;
> +     int ret;
> +
> +     data = i2c_get_clientdata(client);
> +
> +     ret = request_irq(client->irq, akm8975_interrupt, IRQF_TRIGGER_RISING,
> +                             "akm8975", data);
> +
> +     if (ret < 0) {
> +             pr_err("akm8975_init_client: request irq failed\n");
> +             goto err;
> +     }
> +
> +     init_waitqueue_head(&open_wq);
> +
> +     mutex_lock(&data->flags_lock);
> +     m_flag = 1;
> +     a_flag = 1;
> +     t_flag = 1;
> +     mv_flag = 1;
> +     mutex_unlock(&data->flags_lock);

This makes no sense.  We take a per-device lock to protect global
variables.

> +     return 0;
> +err:
> +     return ret;
> +}
> +
> +static const struct file_operations akmd_fops = {
> +     .owner = THIS_MODULE,
> +     .open = akmd_open,
> +     .release = akmd_release,
> +     .ioctl = akmd_ioctl,
> +};
> +
> +static const struct file_operations akm_aot_fops = {
> +     .owner = THIS_MODULE,
> +     .open = akm_aot_open,
> +     .release = akm_aot_release,
> +     .ioctl = akm_aot_ioctl,
> +};

.ioctl is deprecated.  Please use .unlocked_ioctl.

Do these ioctls need 64-bit compat handling?

ioctls are generally a pretty unpopular way of interfacing to a driver.
Usually we get around that by using a shower of sysfs files, which
isn't much better.

> +static struct miscdevice akm_aot_device = {
> +     .minor = MISC_DYNAMIC_MINOR,
> +     .name = "akm8975_aot",
> +     .fops = &akm_aot_fops,
> +};
> +
> +static struct miscdevice akmd_device = {
> +     .minor = MISC_DYNAMIC_MINOR,
> +     .name = "akm8975_dev",
> +     .fops = &akmd_fops,
> +};
> +
> +int akm8975_probe(struct i2c_client *client,
> +               const struct i2c_device_id *devid)

static, please.

> +{
> +     struct akm8975_data *akm;
> +     int err;
> +     FUNCDBG("called");
> +
> +     if (client->dev.platform_data == NULL) {
> +             dev_err(&client->dev, "platform data is NULL. exiting.\n");
> +             err = -ENODEV;
> +             goto exit_platform_data_null;
> +     }
> +
> +     if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +             dev_err(&client->dev, "platform data is NULL. exiting.\n");
> +             err = -ENODEV;
> +             goto exit_check_functionality_failed;
> +     }
> +
> +     akm = kzalloc(sizeof(struct akm8975_data), GFP_KERNEL);
> +     if (!akm) {
> +             dev_err(&client->dev,
> +                     "failed to allocate memory for module data\n");
> +             err = -ENOMEM;
> +             goto exit_alloc_data_failed;
> +     }
> +
> +     akm->pdata = client->dev.platform_data;
> +
> +     mutex_init(&akm->flags_lock);
> +     INIT_WORK(&akm->work, akm_work_func);
> +     i2c_set_clientdata(client, akm);
> +
> +     err = akm8975_power_on(akm);
> +     if (err < 0)
> +             goto exit_power_on_failed;
> +
> +     akm8975_init_client(client);
> +     akm->this_client = client;
> +     akmd_data = akm;
> +
> +     akm->input_dev = input_allocate_device();
> +     if (!akm->input_dev) {
> +             err = -ENOMEM;
> +             dev_err(&akm->this_client->dev,
> +                     "input device allocate failed\n");
> +             goto exit_input_dev_alloc_failed;
> +     }
> +
> +     set_bit(EV_ABS, akm->input_dev->evbit);
> +
> +     /* yaw */
> +     input_set_abs_params(akm->input_dev, ABS_RX, 0, 23040, 0, 0);
> +     /* pitch */
> +     input_set_abs_params(akm->input_dev, ABS_RY, -11520, 11520, 0, 0);
> +     /* roll */
> +     input_set_abs_params(akm->input_dev, ABS_RZ, -5760, 5760, 0, 0);
> +     /* x-axis acceleration */
> +     input_set_abs_params(akm->input_dev, ABS_X, -5760, 5760, 0, 0);
> +     /* y-axis acceleration */
> +     input_set_abs_params(akm->input_dev, ABS_Y, -5760, 5760, 0, 0);
> +     /* z-axis acceleration */
> +     input_set_abs_params(akm->input_dev, ABS_Z, -5760, 5760, 0, 0);
> +     /* temparature */
> +     input_set_abs_params(akm->input_dev, ABS_THROTTLE, -30, 85, 0, 0);
> +     /* status of magnetic sensor */
> +     input_set_abs_params(akm->input_dev, ABS_RUDDER, 0, 3, 0, 0);
> +     /* status of acceleration sensor */
> +     input_set_abs_params(akm->input_dev, ABS_WHEEL, 0, 3, 0, 0);
> +     /* x-axis of raw magnetic vector */
> +     input_set_abs_params(akm->input_dev, ABS_HAT0X, -20480, 20479, 0, 0);
> +     /* y-axis of raw magnetic vector */
> +     input_set_abs_params(akm->input_dev, ABS_HAT0Y, -20480, 20479, 0, 0);
> +     /* z-axis of raw magnetic vector */
> +     input_set_abs_params(akm->input_dev, ABS_BRAKE, -20480, 20479, 0, 0);
> +
> +     akm->input_dev->name = "compass";
> +
> +     err = input_register_device(akm->input_dev);
> +     if (err) {
> +             pr_err("akm8975_probe: Unable to register input device: %s\n",
> +                                      akm->input_dev->name);
> +             goto exit_input_register_device_failed;
> +     }

Seems that the driver implements an input device!?!!?  This patch
*really* needs documenting!

> +     err = misc_register(&akmd_device);
> +     if (err) {
> +             pr_err("akm8975_probe: akmd_device register failed\n");
> +             goto exit_misc_device_register_failed;
> +     }
> +
> +     err = misc_register(&akm_aot_device);
> +     if (err) {
> +             pr_err("akm8975_probe: akm_aot_device register failed\n");
> +             goto exit_misc_device_register_failed;
> +     }
> +
> +     err = device_create_file(&client->dev, &dev_attr_akm_ms1);
> +
> +     return 0;
> +
> +exit_misc_device_register_failed:
> +exit_input_register_device_failed:
> +     input_free_device(akm->input_dev);
> +exit_input_dev_alloc_failed:
> +     akm8975_power_off(akm);
> +exit_power_on_failed:
> +     kfree(akm);
> +exit_alloc_data_failed:
> +exit_check_functionality_failed:
> +exit_platform_data_null:
> +     return err;
> +}

No suspend/resume handling?

>
> ...
>

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
