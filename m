From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: i801: add support of Host Notify
Date: Tue, 7 Jul 2015 20:11:25 +0200
Message-ID: <20150707201125.66b2b5b9@endymion.delvare>
References: <1435085899-11017-1-git-send-email-benjamin.tissoires@redhat.com>
	<1435085899-11017-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435085899-11017-3-git-send-email-benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Benjamin,

On Tue, 23 Jun 2015 14:58:19 -0400, Benjamin Tissoires wrote:
> The i801 chip can handle the Host Notify feature since ICH 3 as mentioned
> in http://www.intel.com/content/dam/doc/datasheet/82801ca-io-controller-hub-3-datasheet.pdf
> 
> Implement .toggle_smbus_host_notify() and rely on .alert() to notify
> the actual client that it has a notification.
> 
> With a T440s and a Synaptics touchpad that implements Host Notify, the
> payload data is always 0x0000, so I am not sure if the device actually
> sends the payload or if there is a problem regarding the implementation.
> 
> Part of this code is inspired by i2c-smbus.c.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

An explanation on why a fifo is needed would be good to add, as I can't
see any obvious reason.

No time for a full review but just a few random comments.

> ---
>  drivers/i2c/busses/i2c-i801.c | 223 +++++++++++++++++++++++++++++++++---------
>  drivers/i2c/i2c-core.c        |  34 +++++++
>  drivers/i2c/i2c-smbus.c       |  17 +---
>  include/linux/i2c.h           |   3 +
>  4 files changed, 217 insertions(+), 60 deletions(-)

You really shouldn't mix core changes with driver specific changes.
Anyone should be able to backport the core changes alone, and then add
support to a different bus driver, without drawing in the i2c-i801
specific changes (that may not be needed and may not even apply.)

> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 5ecbb3f..22a3218 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> (...)
> @@ -221,6 +233,17 @@ struct i801_priv {
>  	const struct i801_mux_config *mux_drvdata;
>  	struct platform_device *mux_pdev;
>  #endif
> +
> +	bool host_notify_requested;
> +	struct work_struct host_notify;
> +	struct kfifo host_notify_fifo;
> +};
> +
> +#define SMBHSTNTFY_SIZE		8
> +
> +struct smbus_host_notify_data {
> +	u8 addr;
> +	u16 payload;
>  };

This structure seems generic to the protocol and not specific to the
Intel 82801 implementation, so it should go to <linux/i2c-smbus.h>.

>  #define FEATURE_SMBUS_PEC	(1 << 0)
> (...)
> @@ -801,12 +894,35 @@ static u32 i801_func(struct i2c_adapter *adapter)
>  	       I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK |
>  	       ((priv->features & FEATURE_SMBUS_PEC) ? I2C_FUNC_SMBUS_PEC : 0) |
>  	       ((priv->features & FEATURE_I2C_BLOCK_READ) ?
> -		I2C_FUNC_SMBUS_READ_I2C_BLOCK : 0);
> +		I2C_FUNC_SMBUS_READ_I2C_BLOCK : 0) |
> +	       ((priv->features & FEATURE_HOST_NOTIFY) ?
> +		I2C_FUNC_SMBUS_HOST_NOTIFY : 0);
> +}
> +
> +static int i801_toggle_host_ntfy(struct i2c_adapter *adapter, bool state)

Probably no longer relevant, but please spell out "notify" completely
in function and variable names (NTFY in register defines is OK.)

> +{
> +	struct i801_priv *priv = i2c_get_adapdata(adapter);
> +
> +	if (!(priv->features & FEATURE_HOST_NOTIFY))
> +		return -EOPNOTSUPP;
> +
> +	if (state) {
> +		outb_p(SMBSLVCMD_HST_NTFY_INTREN, SMBSLVCMD(priv));
> +		/* clear Host Notify bit to allow a new notification */
> +		outb_p(SMBSLVSTS_HST_NTFY_STS, SMBSLVSTS(priv));
> +	} else {
> +		outb_p(0, SMBSLVCMD(priv));
> +	}
> +
> +	priv->host_notify_requested = state;
> +
> +	return 0;
>  }
>  
>  static const struct i2c_algorithm smbus_algorithm = {
> -	.smbus_xfer	= i801_access,
> -	.functionality	= i801_func,
> +	.smbus_xfer			= i801_access,
> +	.functionality			= i801_func,
> +	.toggle_smbus_host_notify	= i801_toggle_host_ntfy,
>  };
>  
>  static const struct pci_device_id i801_ids[] = {
> @@ -1166,6 +1282,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  		priv->features |= FEATURE_BLOCK_BUFFER;
>  		/* fall through */
>  	case PCI_DEVICE_ID_INTEL_82801CA_3:
> +		priv->features |= FEATURE_HOST_NOTIFY;

Please add a /* fall through */ comment for consistency and clarity.

>  	case PCI_DEVICE_ID_INTEL_82801BA_2:
>  	case PCI_DEVICE_ID_INTEL_82801AB_3:
>  	case PCI_DEVICE_ID_INTEL_82801AA_3:
> @@ -1250,6 +1367,15 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  		}
>  	}
>  
> +	INIT_WORK(&priv->host_notify, i801_host_notify);
> +	if (kfifo_alloc(&priv->host_notify_fifo,
> +			SMBHSTNTFY_SIZE * sizeof(struct smbus_host_notify_data),
> +			GFP_KERNEL)) {
> +		dev_err(&dev->dev,
> +			"%s:failed allocating host_notify_fifo\n", __func__);

Adding the function name does not add value. Other messages in this
driver do not include it, so for consistency do not either. A leading
capital would be good too. Also kfifo_alloc() returns an actual error
code, which you should save, include in the error message and return to
the caller instead of hard-coding -ENOMEM.

I think priv->host_notify_fifo is leaked if i801_probe() fails later on.

> +		return -ENOMEM;
> +	}
> +
>  	if (priv->features & FEATURE_IRQ) {
>  		init_waitqueue_head(&priv->waitq);
>  
> @@ -1292,6 +1418,9 @@ static void i801_remove(struct pci_dev *dev)
>  {
>  	struct i801_priv *priv = pci_get_drvdata(dev);
>  
> +	cancel_work_sync(&priv->host_notify);
> +	kfifo_free(&priv->host_notify_fifo);
> +
>  	i801_del_mux(priv);
>  	i2c_del_adapter(&priv->adapter);
>  	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
> @@ -1315,8 +1444,12 @@ static int i801_suspend(struct pci_dev *dev, pm_message_t mesg)
>  
>  static int i801_resume(struct pci_dev *dev)
>  {
> +	struct i801_priv *priv = pci_get_drvdata(dev);
> +
>  	pci_set_power_state(dev, PCI_D0);
>  	pci_restore_state(dev);
> +	if (priv->host_notify_requested)
> +		i801_toggle_host_ntfy(&priv->adapter, true);
>  	return 0;
>  }
>  #else
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index eaaf5b0..87904ec 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -2145,6 +2145,40 @@ int i2c_master_send(const struct i2c_client *client, const char *buf, int count)
>  EXPORT_SYMBOL(i2c_master_send);
>  
>  /**
> + * i2c_alert - call an alert for the given i2c_client.
> + * @client: Handle to slave device
> + * @data: Payload data that will be sent to the slave

Actually this is data that was received from the "slave" device
(temporarily acting as a master), if I understand how Host Notify works.

> + *
> + * Returns negative errno, or 0.
> + */
> +int i2c_alert(struct i2c_client *client, unsigned int data)
> +{
> +	struct i2c_driver *driver;
> +
> +	if (!client)
> +		return -EINVAL;

Do you actually need to check for that? It seems redundant with the
check in smbus_do_alert().

> +
> +	/*
> +	 * Drivers should either disable alerts, or provide at least
> +	 * a minimal handler.  Lock so the driver won't change.
> +	 */
> +	device_lock(&client->adapter->dev);
> +	if (client->dev.driver) {
> +		driver = to_i2c_driver(client->dev.driver);
> +		if (driver->alert)
> +			driver->alert(client, data);

So you use the same driver callback for SMBus Alert and SMBus Host
Notify. This makes some sense, but if a given driver supports both, how
does it know which event happened? The data is completely different and
most probably the action required from the driver as well.

> +		else
> +			dev_warn(&client->dev, "no driver alert()!\n");
> +	} else
> +		dev_dbg(&client->dev, "alert with no driver\n");
> +	device_unlock(&client->adapter->dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(i2c_alert);
> +
> +

Please avoid duplicate blank lines.

> +/**
>   * i2c_master_recv - issue a single I2C message in master receive mode
>   * @client: Handle to slave device
>   * @buf: Where to store data read from slave
> diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
> index 9ebf9cb..26439a8 100644
> --- a/drivers/i2c/i2c-smbus.c
> +++ b/drivers/i2c/i2c-smbus.c
> @@ -41,27 +41,14 @@ static int smbus_do_alert(struct device *dev, void *addrp)
>  {
>  	struct i2c_client *client = i2c_verify_client(dev);
>  	struct alert_data *data = addrp;
> -	struct i2c_driver *driver;
>  
>  	if (!client || client->addr != data->addr)
>  		return 0;
>  	if (client->flags & I2C_CLIENT_TEN)
>  		return 0;
>  
> -	/*
> -	 * Drivers should either disable alerts, or provide at least
> -	 * a minimal handler.  Lock so the driver won't change.
> -	 */
> -	device_lock(dev);
> -	if (client->dev.driver) {
> -		driver = to_i2c_driver(client->dev.driver);
> -		if (driver->alert)
> -			driver->alert(client, data->flag);
> -		else
> -			dev_warn(&client->dev, "no driver alert()!\n");
> -	} else
> -		dev_dbg(&client->dev, "alert with no driver\n");
> -	device_unlock(dev);
> +	if (i2c_alert(client, data->flag))
> +		return 0;
>  
>  	/* Stop iterating after we find the device */
>  	return -EBUSY;
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 7ffc970..fbca48a 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -72,6 +72,9 @@ extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  extern int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  			  int num);
>  
> +/* call an alert. */

What a vague comment :(

> +extern int i2c_alert(struct i2c_client *client, unsigned int data);
> +
>  /* This is the very generalized SMBus access routine. You probably do not
>     want to use this, though; one of the functions below may be much easier,
>     and probably just as fast.

-- 
Jean Delvare
SUSE L3 Support
