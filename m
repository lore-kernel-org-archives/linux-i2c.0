From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH][RESEND] i2c-i801: Add basic interrupt support
Date: Sat, 16 Aug 2008 15:58:56 +0200
Message-ID: <20080816155856.2e0bcf4c@hyperion.delvare>
References: <48A33E77.7060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48A33E77.7060502-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Hans de Goede <j.w.r.degoede-fbo2DhPpy/Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ivo,

On Wed, 13 Aug 2008 22:05:11 +0200, Ivo Manca wrote:
> This patch adds basic interrupt support to the i2c-i801 driver, 
> configurable by the module parameter use_irq.
> 
> Signed-off-by: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  i2c-i801.c |  151 
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 136 insertions(+), 15 deletions(-)
> 

> diff -upr linux-2.6.27-rc3/drivers/i2c/busses/i2c-i801.c linux-2.6.27-rc3.new/drivers/i2c/busses/i2c-i801.c
> --- linux-2.6.27-rc3/drivers/i2c/busses/i2c-i801.c	2008-08-13 20:45:50.000000000 +0200
> +++ linux-2.6.27-rc3.new/drivers/i2c/busses/i2c-i801.c	2008-08-13 21:04:50.000000000 +0200
> @@ -61,6 +61,7 @@
>  #include <linux/delay.h>
>  #include <linux/ioport.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
>  #include <linux/i2c.h>
>  #include <linux/acpi.h>
>  #include <asm/io.h>
> @@ -93,9 +94,9 @@
>  /* kill bit for SMBHSTCNT */
>  #define SMBHSTCNT_KILL		2
>  
> -/* Other settings */
> +/* Timeout settings */
>  #define MAX_TIMEOUT		100
> -#define ENABLE_INT9		0	/* set to 0x01 to enable - untested */
> +#define INTERRUPT_TIMEOUT	(HZ/2)
>  
>  /* I801 command constants */
>  #define I801_QUICK		0x00
> @@ -120,21 +121,71 @@
>  #define SMBHSTSTS_INTR		0x02
>  #define SMBHSTSTS_HOST_BUSY	0x01
>  
> +/* Interrupt enabled */
> +#define I801_INTREN		0x01

I've finally renamed this to I801_INTR_EN for consistency.

> +
> +/* Mask for events we normally handle */
> +#define I801_HST_STS_MASK_NORM ( \
> +		SMBHSTSTS_FAILED | \
> +		SMBHSTSTS_BUS_ERR | \
> +		SMBHSTSTS_DEV_ERR | \
> +		SMBHSTSTS_INTR)
> +
> +/* Mask for all events */
> +#define I801_HST_STS_MASK_ALL ( \
> +		SMBHSTSTS_BYTE_DONE | \
> +		SMBHSTSTS_SMBALERT_STS | \
> +		SMBHSTSTS_FAILED | \
> +		SMBHSTSTS_BUS_ERR | \
> +		SMBHSTSTS_DEV_ERR | \
> +		SMBHSTSTS_INTR)
> +
>  #define STATUS_FLAGS		(SMBHSTSTS_BYTE_DONE | SMBHSTSTS_FAILED | \
>  				 SMBHSTSTS_BUS_ERR | SMBHSTSTS_DEV_ERR | \
>  				 SMBHSTSTS_INTR)

There's some redundancy between I801_HST_STS_MASK_NORM and
STATUS_FLAGS... It would be great to clean this up a bit, otherwise it
will become confusing. My impression is that your
I801_HST_STS_MASK_NORM and my STATUS_FLAGS are essentially the same. It
should be OK to handle SMBHSTSTS_BYTE_DONE in the interrupt handler.
That bit is set between the bytes of block transactions when the block
buffer isn't used. Your code doesn't enable interrupts for these
transactions at the moment, so you will never see that bit for now, but
it might happen later as we add support.

So I think I would change the code as follows:

/* Mask for events we normally handle */
#define STATUS_FLAGS		(SMBHSTSTS_BYTE_DONE | SMBHSTSTS_FAILED | \
				 SMBHSTSTS_BUS_ERR | SMBHSTSTS_DEV_ERR | \
				 SMBHSTSTS_INTR)

/* Mask for all events */
#define STATUS_FLAGS_ALL	(STATUS_FLAGS | SMBHSTSTS_SMBALERT_STS)

If that's OK with you, I'll do that change myself.

>  
> +/* If use_irq is set to anything different than 0, interrupts will be used
> +   if availabe. EXPERIMENTAL! */
> +static int use_irq;
> +module_param(use_irq, bool, S_IRUGO);
> +MODULE_PARM_DESC(force, "Use interrupts if available. EXPERIMENTAL!");

You obviously meant "use_irq", not "force".

> +
>  static unsigned long i801_smba;
>  static unsigned char i801_original_hstcfg;
> +static struct i2c_adapter i801_adapter;
>  static struct pci_driver i801_driver;
>  static struct pci_dev *I801_dev;
>  
> +struct i2c_i801_algo_data {
> +	spinlock_t lock;
> +	wait_queue_head_t waitq;
> +	int status; /* copy of h/w register */
> +	bool use_irq;
> +};
> +
> +static struct i2c_i801_algo_data i801_algo_data;
> +
>  #define FEATURE_SMBUS_PEC	(1 << 0)
>  #define FEATURE_BLOCK_BUFFER	(1 << 1)
>  #define FEATURE_BLOCK_PROC	(1 << 2)
>  #define FEATURE_I2C_BLOCK_READ	(1 << 3)
>  static unsigned int i801_features;
>  
> +/* interrupt handling: fetch & consume host status out of algo_data */
> +static inline int i801_get_status(struct i2c_i801_algo_data *algo_data)
> +{
> +	unsigned long flags;
> +	int status;
> +
> +	spin_lock_irqsave(&algo_data->lock, flags);
> +	status = algo_data->status;
> +	algo_data->status = 0;
> +	spin_unlock_irqrestore(&algo_data->lock, flags);
> +
> +	return status;
> +}
> +
> +
>  /* Make sure the SMBus host is ready to start transmitting.
>     Return 0 if it is, -EBUSY if it is not. */
>  static int i801_check_pre(void)
> @@ -221,21 +272,33 @@ static int i801_transaction(int xact)
>  	int result;
>  	int timeout = 0;
>  
> +	struct i2c_i801_algo_data *algo_data = i801_adapter.algo_data;
> +
>  	result = i801_check_pre();
>  	if (result < 0)
>  		return result;
>  
>  	/* the current contents of SMBHSTCNT can be overwritten, since PEC,
>  	 * INTREN, SMBSCMD are passed in xact */
> -	outb_p(xact | I801_START, SMBHSTCNT);
> +	if (algo_data->use_irq) {
> +		outb_p(xact | I801_START | I801_INTREN, SMBHSTCNT);
>  
> -	/* We will always wait for a fraction of a second! */
> -	do {
> -		msleep(1);
> -		status = inb_p(SMBHSTSTS);
> -	} while ((status & SMBHSTSTS_HOST_BUSY) && (timeout++ < MAX_TIMEOUT));
> +		timeout = wait_event_timeout(algo_data->waitq,
> +				((status = i801_get_status(algo_data))
> +				& I801_HST_STS_MASK_NORM), INTERRUPT_TIMEOUT);
> +		result = i801_check_post(status, timeout == 0);
> +	} else {
> +		outb_p(xact | I801_START, SMBHSTCNT);
> +
> +		/* We will always wait for a fraction of a second! */
> +		do {
> +			msleep(1);
> +			status = inb_p(SMBHSTSTS);
> +		} while ((status & SMBHSTSTS_HOST_BUSY) &&
> +			 (timeout++ < MAX_TIMEOUT));
> +		result = i801_check_post(status, timeout >= MAX_TIMEOUT);
> +	}
>  
> -	result = i801_check_post(status, timeout >= MAX_TIMEOUT);
>  	if (result < 0)
>  		return result;
>  
> @@ -277,8 +340,7 @@ static int i801_block_transaction_by_blo
>  			outb_p(data->block[i+1], SMBBLKDAT);
>  	}
>  
> -	status = i801_transaction(I801_BLOCK_DATA | ENABLE_INT9 |
> -				  I801_PEC_EN * hwpec);
> +	status = i801_transaction(I801_BLOCK_DATA | I801_PEC_EN * hwpec);
>  	if (status)
>  		return status;
>  
> @@ -328,7 +390,7 @@ static int i801_block_transaction_byte_b
>  			else
>  				smbcmd = I801_BLOCK_DATA;
>  		}
> -		outb_p(smbcmd | ENABLE_INT9, SMBHSTCNT);
> +		outb_p(smbcmd, SMBHSTCNT);
>  
>  		if (i == 1)
>  			outb_p(inb(SMBHSTCNT) | I801_START, SMBHSTCNT);
> @@ -509,7 +571,7 @@ static s32 i801_access(struct i2c_adapte
>  	if(block)
>  		ret = i801_block_transaction(data, read_write, size, hwpec);
>  	else
> -		ret = i801_transaction(xact | ENABLE_INT9);
> +		ret = i801_transaction(xact);
>  
>  	/* Some BIOSes don't like it when PEC is enabled at reboot or resume
>  	   time, so we forcibly disable it after every transaction. Turn off
> @@ -558,6 +620,7 @@ static struct i2c_adapter i801_adapter =
>  	.id		= I2C_HW_SMBUS_I801,
>  	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
>  	.algo		= &smbus_algorithm,
> +	.algo_data	= &i801_algo_data,
>  };
>  
>  static struct pci_device_id i801_ids[] = {
> @@ -581,8 +644,38 @@ static struct pci_device_id i801_ids[] =
>  
>  MODULE_DEVICE_TABLE (pci, i801_ids);
>  
> +static irqreturn_t i801_isr(int irq, void *dev_id)
> +{
> +	u8 status = inb(SMBHSTSTS);
> +
> +	/* bail if it's not ours */
> +	if (!(status & I801_HST_STS_MASK_ALL)) {
> +		dev_dbg(&I801_dev->dev, "BAILING interrupt\n");
> +		return IRQ_NONE;
> +	}
> +
> +	dev_dbg(&I801_dev->dev, "INTERRUPT: IRQ status: 0x%02x\n", status);
> +
> +	/* ACK */
> +	outb((status & I801_HST_STS_MASK_ALL), SMBHSTSTS);
> +
> +	if (status & I801_HST_STS_MASK_NORM) {
> +		struct i2c_adapter *adap = dev_id;
> +		struct i2c_i801_algo_data *algo_data = adap->algo_data;
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&algo_data->lock, flags);
> +		algo_data->status = status;
> +		spin_unlock_irqrestore(&algo_data->lock, flags);
> +		wake_up(&algo_data->waitq);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int __devinit i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {
> +	struct i2c_i801_algo_data *algo_data = i801_adapter.algo_data;
>  	unsigned char temp;
>  	int err;
>  
> @@ -644,10 +737,32 @@ static int __devinit i801_probe(struct p
>  	}
>  	pci_write_config_byte(I801_dev, SMBHSTCFG, temp);
>  
> -	if (temp & SMBHSTCFG_SMB_SMI_EN)
> +	if (temp & SMBHSTCFG_SMB_SMI_EN) {
>  		dev_dbg(&dev->dev, "SMBus using interrupt SMI#\n");
> -	else
> +		algo_data->use_irq = false;
> +	} else {
>  		dev_dbg(&dev->dev, "SMBus using PCI Interrupt\n");
> +		if (use_irq) {
> +			if ((request_irq(I801_dev->irq, i801_isr, IRQF_SHARED,
> +					 i801_driver.name, &i801_adapter))) {
> +				dev_err(&dev->dev, "request irq %d failed!\n",
> +						   I801_dev->irq);
> +				algo_data->use_irq = false;
> +			} else {
> +				dev_dbg(&dev->dev, "SMBus base address: "
> +						   "0x%04lx, IRQ: %d\n",
> +						   i801_smba, I801_dev->irq);
> +
> +				algo_data->use_irq = true;
> +				algo_data->status = 0;
> +				init_waitqueue_head(&algo_data->waitq);
> +				spin_lock_init(&algo_data->lock);
> +			}
> +		} else {
> +			algo_data->use_irq = false;
> +			dev_dbg(&dev->dev, "Interrupts disabled.\n");
> +		}
> +	}
>  
>  	/* Clear special mode bits */
>  	if (i801_features & (FEATURE_SMBUS_PEC | FEATURE_BLOCK_BUFFER))
> @@ -674,7 +789,13 @@ exit:
>  
>  static void __devexit i801_remove(struct pci_dev *dev)
>  {
> +	struct i2c_i801_algo_data *algo_data = i801_adapter.algo_data;
> +
>  	i2c_del_adapter(&i801_adapter);
> +
> +	if (algo_data->use_irq)
> +		free_irq(dev->irq, &i801_adapter);
> +
>  	pci_write_config_byte(I801_dev, SMBHSTCFG, i801_original_hstcfg);
>  	pci_release_region(dev, SMBBAR);
>  	/*

All the rest looks fine to me now. I'll do some more testing now.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
