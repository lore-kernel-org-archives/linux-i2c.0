From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Fri, 18 Mar 2011 13:19:53 +0100
Message-ID: <201103181319.54191.arnd@arndb.de>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <1300444824-13713-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1300444824-13713-2-git-send-email-waldemar.rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday 18 March 2011, Waldemar Rymarkiewicz wrote:
> Add new driver for MicroRead NFC chip connected to i2c bus.
> 
> See Documentation/nfc/nfc-microread.txt.

As I said in my first review and Alan also pointed out now, the
most important change will be to add a common NFC core layer,
before adding more hardware drivers.

Also, regarding the user interface, we need to be really sure
that this is the best way of talking to NFC devices. The interface
you have today is a simple character device read/write kind,
which may be the best thing if the protocol stack on top is
really simple and there is never the need to have multiple
applications talking to different endpoints on the wireless
interface, and if there are no protocol headers being
send over the character device interface.

Otherwise, a better interface is probably to add a new network
socket family and abstract the protocol layers in the kernel.
Can you explain in more depth what the kind of data is on
this interface?

A few more things I noticed when reading through the driver
again:

> +const struct file_operations microread_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= microread_open,
> +	.release	= microread_release,
> +	.read		= microread_read,
> +	.write		= microread_write,
> +	.poll		= microread_poll,
> +	.unlocked_ioctl	= microread_ioctl,
> +};

As I said, all the file operations need to move to the core module.
Also, this is missing a compat_ioctl function.

> +static irqreturn_t microread_irq(int irq, void *dev)
> +{
> +	struct microread_info *info = dev;
> +	struct i2c_client *client = info->i2c_dev;
> +
> +	dev_dbg(&client->dev, "irq: info %p client %p ", info,	client);
> +
> +	if (irq != client->irq)
> +		return IRQ_NONE;
> +
> +	mutex_lock(&info->rx_mutex);
> +	info->irq_state = 1;
> +	mutex_unlock(&info->rx_mutex);
> +
> +	wake_up_interruptible(&info->rx_waitq);
> +
> +	return IRQ_HANDLED;
> +}

You cannot take a mutex from interrupt context, that may
cause deadlocks.


> diff --git a/include/linux/nfc/microread.h b/include/linux/nfc/microread.h
> new file mode 100644
> index 0000000..a0ad68e
> --- /dev/null
> +++ b/include/linux/nfc/microread.h

Please split this header file into an include/linux/nfc.h file
and the file with the platform data in include/linux/platform_data/microread.h

Do not define any ioctls that are not used.

	Arnd
