From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH RFC] Misc: Driver for NXP Semiconductors PN544 NFC chip.
Date: Mon, 25 Oct 2010 13:55:00 -0700
Message-ID: <20101025135500.bebd50fb.akpm@linux-foundation.org>
References: <1288017858-8669-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1288017858-8669-1-git-send-email-matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 25 Oct 2010 17:44:18 +0300
"Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:

> This is a driver for the pn544 NFC device. The driver transfers
> ETSI messages between the device and the user space.

err, this reader at least doesn't know what an NFC is, nor what an ETSI
message is.  I could google them, but it wouldn't kill you to spell
these things out a little more completely please.

> Signed-off-by: Matti J. Aaltonen <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/misc/Kconfig  |   12 +
>  drivers/misc/Makefile |    1 +
>  drivers/misc/pn544.c  |  912 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pn544.h |   99 ++++++

Is drivers/misc/ the best place for this?

Don't be afraid to create a new drivers/nfc/ even if it has only one
driver in it.  If someone later comes in and adds a new NFC driver then
things will all fall into place.

>  4 files changed, 1024 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/misc/pn544.c
>  create mode 100644 include/linux/pn544.h
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 1f69743..23977ff 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -402,6 +402,18 @@ config PCH_PHUB
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called pch_phub.
>  
> +config PN544_NFC
> +	tristate "PN544 NFC driver"
> +	depends on I2C
> +	select CRC_CCITT
> +	default n
> +	---help---
> +	  Say yes if you want PN544 Near Field Communication driver.

OK, I did google it ;)  Interesting.

> +	  This is for i2c connected version. If unsure, say N here.
> +
> +	  To compile this driver as a module, choose M here. The module will
> +	  be called pn544.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
>
> ...
>
> +static void pn544_print_buf(char *msg, u8 *buf, int len)
> +{
> +#ifdef DEBUG
> +	int i;
> +
> +	pr_debug(PN544_DRIVER_NAME ": Got %d at %s:", len, msg);
> +	for (i = 0; i < len; i++)
> +		pr_info(" %x", buf[i]);
> +
> +	pr_info("\n");

You might be able to use print_hex_dump() here, but I wouldn't blame
you if you didn't ;)

> +#endif
> +}
> +
> +/* sysfs interface */

OK, this is more serious.

You're proposing a permanent addition to the kernel ABI.  This is the
most important part of the driver because it is something we can never
change.  This interface is the very first thing we'll want to
understand and review, before we even look at the implementation.

And it isn't even described!  Not in the changelog, not in a
documentation file, not even in code comments.

Please, provide a description of this proposed interface.  Sufficient
for reviewers to understand it and for users to use it.  Pobably this
will require some description of the hardware functions as well.

Please also consider updating Documentation/ABI/

> +static ssize_t pn544_test(struct device *dev,
> +			  struct device_attribute *attr, char *buf)
> +{
> +	struct pn544_info *info = dev_get_drvdata(dev);
> +	struct i2c_client *client = info->i2c_dev;
> +	struct pn544_nfc_platform_data *pdata = client->dev.platform_data;
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", pdata->test());
> +}
> +
> +static int pn544_enable(struct pn544_info *info, int mode)
> +{
> +	struct pn544_nfc_platform_data *pdata;
> +	struct i2c_client *client = info->i2c_dev;
> +
> +	int r;
> +
> +	r = regulator_bulk_enable(ARRAY_SIZE(info->regs), info->regs);
> +	if (r < 0)
> +		return r;
> +
> +	pdata = client->dev.platform_data;
> +	info->read_irq = PN544_NONE;
> +	if (pdata->enable)
> +		pdata->enable(mode);
> +
> +	if (mode) {
> +		if (!info->fw_buf)
> +			info->fw_buf = kmalloc(PN544_MAX_I2C_TRANSFER,
> +					       GFP_KERNEL);

>From my reading, later code will crash the kernel if this allocation failed.

Also, is there a race here between reading info->fw_buf and setting it?
Can two CPUs get into thei function at the same time?  If so, there
should be locking.  Say, a mutex local to this function.


> +		info->state = PN544_ST_FW_READY;
> +		dev_dbg(&client->dev, "now in FW-mode\n");
> +	} else {
> +		kfree(info->fw_buf);
> +		info->fw_buf = NULL;
> +		info->state = PN544_ST_READY;
> +		dev_dbg(&client->dev, "now in HCI-mode\n");
> +	}
> +
> +	msleep(PN544_BOOT_TIME);
> +
> +	return 0;
> +}
> +
>
> ...
>
> +static int pn544_i2c_write(struct i2c_client *client, u8 *buf, int len)
> +{
> +	int r;
> +
> +	if (len < 4 || len != (buf[0] + 1) || check_crc(buf, len))
> +		return -EBADMSG;

EBADMSG is a unix streams errno.  It's quite inappropriate that a
device driver be using it.  Imagine the poor user's confution if he
sees this message pop up on his screen.

> +	msleep(PN544_I2C_IO_TIME);
> +
> +	r = i2c_master_send(client, buf, len);
> +	dev_dbg(&client->dev, "send: %d\n", r);
> +
> +	if (r == -EREMOTEIO) { /* Retry, chip was in standby */

And what on earth is EREMOTEIO?  Is it appropriate for use in a driver?

> +		msleep(PN544_WAKEUP_GUARD);
> +		r = i2c_master_send(client, buf, len);
> +		dev_dbg(&client->dev, "send2: %d\n", r);
> +	}
> +
> +	if (r != len)
> +		return -EREMOTEIO;
> +
> +	return r;
> +}
> +
> +static int pn544_i2c_read(struct i2c_client *client, u8 *buf, int buflen)
> +{
> +	int r;
> +	u8 len;
> +
> +	/*
> +	 * You could read a packet in one go, but then you'd need to read
> +	 * max size and rest would be 0xff fill, so we do split reads.
> +	 */
> +	r = i2c_master_recv(client, &len, 1);
> +	dev_dbg(&client->dev, "recv1: %d\n", r);
> +
> +	if (r != 1)
> +		return -EREMOTEIO;
> +
> +	if (len < PN544_LLC_HCI_OVERHEAD)
> +		len = PN544_LLC_HCI_OVERHEAD;
> +	else if (len > (PN544_MSG_MAX_SIZE - 1))
> +		len = PN544_MSG_MAX_SIZE - 1;
> +
> +	if (1 + len > buflen) /* len+(data+crc16) */
> +		return -EOVERFLOW;

EOVERFLOW refers to a floating point overflow!

> +	buf[0] = len;
> +
> +	r = i2c_master_recv(client, buf + 1, len);
> +	dev_dbg(&client->dev, "recv2: %d\n", r);
> +
> +	if (r != len)
> +		return -EREMOTEIO;
> +
> +	msleep(PN544_I2C_IO_TIME);
> +
> +	return r + 1;
> +}
> +
>
> ...
>
> +static int pn544_fw_read(struct i2c_client *client, u8 *buf, int buflen)
> +{
> +	int r, len;
> +
> +	if (buflen < PN544_FW_HEADER_SIZE)
> +		return -ENOSPC;

Disk full!

> +	r = i2c_master_recv(client, buf, PN544_FW_HEADER_SIZE);
> +	dev_dbg(&client->dev, "FW recv1: %d\n", r);
> +
> +	if (r < 0)
> +		return r;
> +
> +	if (r < PN544_FW_HEADER_SIZE)
> +		return -EBADMSG;
> +
> +	len = (buf[1] << 8) + buf[2];
> +	if (len == 0) /* just header, no additional data */
> +		return r;
> +
> +	if (len > buflen - PN544_FW_HEADER_SIZE)
> +		return -ENOSPC;
> +
> +	r = i2c_master_recv(client, buf + PN544_FW_HEADER_SIZE, len);
> +	dev_dbg(&client->dev, "fw recv2: %d\n", r);
> +
> +	if (r != len)
> +		return -EBADMSG;
> +
> +	return r + PN544_FW_HEADER_SIZE;
> +}
> +
>
> ...
>
> +static enum pn544_irq pn544_irq_state(struct pn544_info *info)
> +{
> +	enum pn544_irq irq;
> +
> +	mutex_lock(&info->read_mutex);
> +	irq = info->read_irq;
> +	mutex_unlock(&info->read_mutex);

It usually doesn't make much sense to add locking around a single
atomic read instruction.

> +	/*
> +	 * XXX: should we check GPIO-line status directly?
> +	 * return pdata->irq_status() ? PN544_INT : PN544_NONE;
> +	 */
> +
> +	return irq;
> +}
> +
> +static ssize_t pn544_read(struct file *file, char __user *buf,
> +			  size_t count, loff_t *offset)

Again, I really cannot review this code when I haven't been told what
it's reading from, what's in the payload, what it is all to be used
for, etc.  It's just C code to me.

> +{
> +	struct pn544_info *info = container_of(file->private_data,
> +					       struct pn544_info, miscdev);
> +	struct i2c_client *client = info->i2c_dev;
> +	enum pn544_irq irq;
> +	size_t len;
> +	int r;
> +	u8 read_buf[PN544_MSG_MAX_SIZE];
> +
> +	dev_dbg(&client->dev, "%s: info: %p, count: %d\n", __func__,
> +		info, count);
> +
> +	if (info->state == PN544_ST_COLD)
> +		return -ENODEV;
> +
> +	irq = pn544_irq_state(info);
> +	if (irq == PN544_NONE) {
> +		if (file->f_flags & O_NONBLOCK)
> +			return -EAGAIN;
> +		if (wait_event_interruptible(info->read_wait,
> +					     (info->read_irq == PN544_INT)))
> +			return -ERESTARTSYS;
> +	}
> +
> +	if (info->state == PN544_ST_FW_READY) {
> +		len = min(count, (size_t) PN544_MAX_I2C_TRANSFER);

min_t() is the preferred way of solving this.

> +		mutex_lock(&info->read_mutex);
> +		r = pn544_fw_read(info->i2c_dev, info->fw_buf, len);
> +		info->read_irq = PN544_NONE;
> +		mutex_unlock(&info->read_mutex);
> +
> +		if (r < 0) {
> +			dev_err(&info->i2c_dev->dev, "FW read failed: %d\n", r);
> +			return r;
> +		}
> +		pn544_print_buf("fw_read", info->fw_buf, r);
> +
> +		*offset += r;
> +		if (copy_to_user(buf, info->fw_buf, r))
> +			return -EFAULT;
> +
> +		return r;
> +	}
> +
> +	len = min(count, sizeof(read_buf));
> +
> +	mutex_lock(&info->read_mutex);
> +	r = pn544_i2c_read(info->i2c_dev, read_buf, len);
> +	info->read_irq = PN544_NONE;
> +	mutex_unlock(&info->read_mutex);
> +
> +	if (r < 0) {
> +		dev_err(&info->i2c_dev->dev, "read failed (%d)\n", r);
> +		return r;
> +	}
> +	pn544_print_buf("read", read_buf, r);
> +
> +	*offset += r;
> +	if (copy_to_user(buf, read_buf, r))
> +		return -EFAULT;
> +
> +	return r;
> +}
> +
> +static unsigned int pn544_poll(struct file *file, poll_table *wait)
> +{
> +	struct pn544_info *info = container_of(file->private_data,
> +					       struct pn544_info, miscdev);
> +	struct i2c_client *client = info->i2c_dev;
> +
> +	dev_dbg(&client->dev, "%s: info: %p\n", __func__, info);
> +
> +	if (info->state == PN544_ST_COLD)
> +		return -ENODEV;
> +
> +	poll_wait(file, &info->read_wait, wait);
> +
> +	if (pn544_irq_state(info) == PN544_INT)
> +		return POLLIN | POLLRDNORM;
> +
> +	return 0;
> +}

So it can poll() somethnig as well!  This driver *really* needs
documentation!

> +static ssize_t pn544_write(struct file *file, const char __user *buf,
> +			   size_t count, loff_t *ppos)
> +{
> +	struct pn544_info *info = container_of(file->private_data,
> +					       struct pn544_info, miscdev);
> +	struct i2c_client *client = info->i2c_dev;
> +	u8 data[PN544_MSG_MAX_SIZE];
> +	ssize_t	len;
> +
> +	dev_dbg(&client->dev, "%s: info: %p, count %d\n", __func__,
> +		info, count);
> +
> +	if (info->state == PN544_ST_COLD)
> +		return -ENODEV;
> +
> +	/*
> +	 * XXX: should we detect rset-writes and clean possible
> +	 * read_irq state
> +	 */
> +	if (info->state == PN544_ST_FW_READY) {

Is some locking needed here?  What prevents info->state from
transitioning while this code is executing?

> +		size_t fw_len;
> +
> +		if (count < PN544_FW_HEADER_SIZE)
> +			return -EINVAL;
> +
> +		len = min(count, (size_t) PN544_MAX_I2C_TRANSFER);
> +		if (copy_from_user(info->fw_buf, buf, len))
> +			return -EFAULT;
> +
> +		pn544_print_buf("fw_write", info->fw_buf, len);
> +		fw_len = PN544_FW_HEADER_SIZE + (info->fw_buf[1] << 8) +
> +			info->fw_buf[2];
> +		if (len > fw_len) /* 1 msg at a time */
> +			len = fw_len;
> +
> +		return pn544_fw_write(info->i2c_dev, info->fw_buf, len);
> +	}
> +
> +	if (count < PN544_LLC_MIN_SIZE)
> +		return -EINVAL;
> +
> +	len = min(count, sizeof(data));
> +	if (copy_from_user(data, buf, len))
> +		return -EFAULT;
> +
> +	pn544_print_buf("write", data, len);
> +	if (len > (data[0] + 1)) /* 1 msg at a time */
> +		len  = data[0] + 1;
> +
> +	return pn544_i2c_write(info->i2c_dev, data, len);
> +}
> +
> +static long pn544_ioctl(struct file *file, unsigned int cmd, unsigned long arg)

And an ioctl interface as well!  An undocmented one.

ioctls are pretty unpopular for various reasons.  To a large extent,
people have been using sysfs interfaces as a repalcement for ioctl()s. 
But this driver has both!

Does this code need compat handling, or it is 32/64-bit clean?

> +{
> +	struct pn544_info *info = container_of(file->private_data,
> +					       struct pn544_info, miscdev);
> +	struct i2c_client *client = info->i2c_dev;
> +	struct pn544_nfc_platform_data *pdata;
> +	unsigned long flags;
> +	unsigned int val;
> +	int r;
> +
> +	dev_dbg(&client->dev, "%s: info: %p, cmd: 0x%x\n", __func__, info, cmd);
> +
> +	if (info->state == PN544_ST_COLD)
> +		return -ENODEV;
> +
> +	pdata = info->i2c_dev->dev.platform_data;
> +	switch (cmd) {
> +	case PN544_GET_FW_MODE:
> +		dev_dbg(&client->dev, "%s:  PN544_GET_FW_MODE\n", __func__);
> +
> +		spin_lock_irqsave(&info->fw_lock, flags);
> +		val = (info->state == PN544_ST_FW_READY);
> +		spin_unlock_irqrestore(&info->fw_lock, flags);
> +
> +		if (copy_to_user((void __user *)arg, &val, sizeof(val)))
> +			return -EFAULT;
> +		break;
> +
> +	case PN544_SET_FW_MODE:
> +		dev_dbg(&client->dev, "%s:  PN544_SET_FW_MODE\n", __func__);
> +
> +		if (copy_from_user(&val, (void __user *)arg, sizeof(val)))
> +			return -EFAULT;
> +
> +		spin_lock_irqsave(&info->fw_lock, flags);
> +		if (val) {
> +			if (info->state == PN544_ST_FW_READY)
> +				break;
> +			/* we should block open while in here */
> +			pn544_disable(info);

bug.  pn544_disable() calls msleep(), but msleep() is very illegal
under spin_lock_irqsave().  This tells me that this code hasn't been
tested with even rudimentary kernel rimtime debugging options enabled. 
Documentation/SubmitChecklist section 12 is fairly up-to-date here.


> +			r = pn544_enable(info, FW_MODE);
> +			if (r < 0) {
> +				spin_unlock_irqrestore(&info->fw_lock, flags);
> +				return r;
> +			}
> +		} else {
> +			if (info->state == PN544_ST_READY)
> +				break;
> +			pn544_disable(info);

Many more such bugs there.

> +			r = pn544_enable(info, HCI_MODE);
> +			if (r < 0) {
> +				spin_unlock_irqrestore(&info->fw_lock, flags);
> +				return r;
> +			}
> +		}
> +		file->f_pos = info->read_offset;
> +
> +		spin_unlock_irqrestore(&info->fw_lock, flags);
> +		break;
> +
> +	case PN544_GET_DEBUG:
> +		dev_dbg(&client->dev, "%s:  PN544_GET_DEBUG\n", __func__);
> +
> +		val = debug;
> +		if (copy_to_user((void __user *)arg, &val, sizeof(val)))
> +			return -EFAULT;
> +		break;
> +
> +	case PN544_SET_DEBUG:
> +		dev_dbg(&client->dev, "%s:  PN544_SET_DEBUG\n", __func__);
> +
> +		if (copy_from_user(&val, (void __user *)arg, sizeof(val)))
> +			return -EFAULT;
> +		debug = val;
> +		break;
> +
> +	case TCGETS:
> +		dev_dbg(&client->dev, "%s:  TCGETS\n", __func__);
> +
> +		return -ENOIOCTLCMD;
> +
> +	default:
> +		dev_err(&client->dev, "Unknown ioctl 0x%x\n", cmd);
> +		return -ENOIOCTLCMD;
> +	}
> +
> +	return 0;
> +}
> +
>
> ...
>
> +/* Optional test to see if the chip actually answers */
> +#ifdef DO_RSET_TEST

I'd suggest enabling this via a module parameter if it's at all useful.
Otherwise it should be enabled with a Kconfig variable, not via a code
edit.

> +static int pn544_rset_test(struct pn544_info *info)
> +{
> +	struct i2c_client *client = info->i2c_dev;
> +	struct pn544_llc_packet rset = { /* U RSET frame without baudrate */
> +		.length = 0x05,
> +		.header = 0xF9,
> +		.data = { 0x04, 0x00, 0xC3, 0xE5 }
> +	};
> +	struct pn544_llc_packet answer = {
> +		.length = 0x03,
> +		.header = 0xe6,
> +		.data = { 0x17, 0xa7 }
> +	};
> +	u8 read_buf[PN544_MSG_MAX_SIZE];
> +	int r;
> +
> +	r = pn544_enable(info, HCI_MODE);
> +	if (r < 0)
> +		return r;
> +
> +	pn544_print_buf("rset write", (u8 *)&rset, rset.length + 1);
> +	r = pn544_i2c_write(client, (u8 *)&rset, rset.length + 1);
> +	if (r < 0) {
> +		dev_err(&client->dev, "Write error to rset: %d\n", r);
> +		goto out;
> +	}
> +
> +	wait_event_timeout(info->read_wait, (info->read_irq == PN544_INT),
> +			   msecs_to_jiffies(PN544_WAKEUP_GUARD));
> +	if (info->read_irq == PN544_NONE) {
> +		dev_err(&client->dev, "No answer to rset\n");
> +		r = -ENODEV;
> +		goto out;
> +	}
> +
> +	mutex_lock(&info->read_mutex);
> +	r = pn544_i2c_read(client, read_buf, sizeof(read_buf));
> +	info->read_irq = PN544_NONE;
> +	mutex_unlock(&info->read_mutex);
> +
> +	if (r < 0) {
> +		dev_err(&client->dev, "Read error to rset: %d\n", r);
> +		goto out;
> +	}
> +
> +	pn544_print_buf("rset read", read_buf, r);
> +
> +	if (r != (answer.length + 1) ||
> +	    memcmp(read_buf, (u8 *)&answer, r)) {
> +		dev_err(&client->dev, "Wrong answer to rset\n");
> +		r = -ENODEV;
> +		goto out;
> +	}
> +
> +	dev_dbg(&client->dev, "RSET test ok.\n");
> +
> +out:
> +	pn544_disable(info);
> +	return r;
> +}
> +#endif
> +
>
> ...
>
> +	if (r) {
> +		dev_err(&client->dev, "Cannot get platform resources\n");
> +		goto err_reg;
> +	}
> +
> +	r = request_threaded_irq(client->irq, NULL, pn544_irq_thread_fn,
> +				 IRQF_TRIGGER_RISING, PN544_DRIVER_NAME,
> +				 info);
> +	if (r < 0) {
> +		dev_err(&client->dev, "Unable to register IRQ handler\n");
> +		goto err_res;
> +	}
> +
> +	/* If we don't have the test we don't need the sysfs file */
> +	if (pdata->test) {
> +		r = device_create_file(&client->dev, &pn544_attr);
> +		if (r) {
> +			dev_err(&client->dev,
> +				"sysfs registration failed, error %d\n", r);
> +			goto err_irq;
> +		}
> +	}
> +
> +#ifdef DO_RSET_TEST
> +	r = pn544_rset_test(info);
> +	if (r < 0)
> +		goto err_sysfs;
> +#endif
> +	info->miscdev.minor = MISC_DYNAMIC_MINOR;
> +	info->miscdev.name = PN544_DRIVER_NAME;
> +	info->miscdev.fops = &pn544_fops;
> +	info->miscdev.parent = &client->dev;
> +	r = misc_register(&info->miscdev);

It creates a miscdev.  For the documentation, please.

> +	if (r < 0) {
> +		dev_err(&client->dev, "Device registration failed\n");
> +		goto err_sysfs;
> +	}
> +
> +	dev_dbg(&client->dev, "%s: info: %p, pdata %p, client %p\n",
> +		__func__, info, pdata, client);
> +
> +	return 0;
> +
> +err_sysfs:
> +	if (pdata->test)
> +		device_remove_file(&client->dev, &pn544_attr);
> +err_irq:
> +	free_irq(client->irq, info);
> +err_res:
> +	if (pdata->free_resources)
> +		pdata->free_resources();
> +err_reg:
> +	regulator_bulk_free(ARRAY_SIZE(info->regs), info->regs);
> +err_kmalloc:
> +	kfree(info);
> +err_kzalloc:
> +	return r;
> +}
> +
>
> ...
>
> +static void __exit pn544_exit(void)
> +{
> +	flush_scheduled_work();

This seems unneeded?  We're trying to get rid of flush_scheduled_work(), btw.

> +	i2c_del_driver(&pn544_driver);
> +	pr_info(DRIVER_DESC ", Exiting.\n");
> +}
> +
>
> ...
>
