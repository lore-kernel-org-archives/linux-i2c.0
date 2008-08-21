From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH 5/6]: i2c: Add bus addressing support.
Date: Thu, 21 Aug 2008 14:56:37 +0200
Message-ID: <8763pubk6y.fsf@macbook.be.48ers.dk>
References: <20080821.024330.51639001.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080821.024330.51639001.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org> (David Miller's
	message of "Thu\, 21 Aug 2008 02\:43\:30 -0700 \(PDT\)")
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "David" == David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org> writes:

 David> i2c: Add bus addressing support.

 David> Some I2C bus controllers support the driving of multiple I2C bus
 David> segments (think PCI domains).

 David> For example, the pcf8584 variants on some sparc64 boxes can do this.
 David> They have an auxiliary 8-bit register that specifies the I2C bus each
 David> I2C operation acts upon.  In the openfirmware device tree, the I2C
 David> client devices are described using an 8-bit bus address and a 10-bit
 David> I2C device address.

So it's like a bus multiplexer on the SDA / SCL lines? Wouldn't that
be better modelled like multiple I2C adapters talking to the same
chip?

I do something similar on a few embedded platforms with a multiplexer
driver that attaches to an I2C adapter and registers virtual I2C
adapters for each MUX position. This way the multiplexing is
independent of the I2C adapter implementation, but you could ofcause
combine it in a single driver - E.G.:

/*
 * i2c-bcccpmux.c: I2C multiplexer for Barco CCCP boards
 *
 * Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
 *
 * This file is licensed under the terms of the GNU General Public License
 * version 2.  This program is licensed "as is" without any warranty of any
 * kind, whether express or implied.
 */

#include <linux/errno.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/platform_device.h>
#include <linux/i2c.h>
#include <linux/i2c-bcccpmux.h>
#include <asm/io.h>
#include <asm/uaccess.h>


struct bcccpmux_i2c {
	u16 __iomem *base;
	struct i2c_adapter *parent;
	struct i2c_adapter *adap;
	struct bcccpmux_i2c_platform_data data;
};

static int bcccpmux_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
			 int num)
{
	struct bcccpmux_i2c *i2c = i2c_get_adapdata(adap);
	int nr = adap->nr - i2c->data.base_nr;
	u16 val;
	int ret;

	mutex_lock(&i2c->parent->bus_lock);
	val = in_be16(i2c->base) & i2c->data.mask;
	out_be16(i2c->base, val | i2c->data.values[nr]);
	ret = i2c->parent->algo->master_xfer(i2c->parent, msgs, num);
	out_be16(i2c->base, val | i2c->data.idle);
	mutex_unlock(&i2c->parent->bus_lock);

	return ret;
}

static u32 bcccpmux_func(struct i2c_adapter *adap)
{
	struct bcccpmux_i2c *i2c = i2c_get_adapdata(adap);

	return i2c->parent->algo->functionality(i2c->parent);
}

static struct i2c_algorithm bcccpmux_algorithm = {
	.master_xfer	= bcccpmux_xfer,
	.functionality	= bcccpmux_func,
};

static struct i2c_adapter bcccpmux_adapter = {
	.owner		= THIS_MODULE,
	.name		= "bcccpmux",
	.class		= I2C_CLASS_HWMON,
	.algo		= &bcccpmux_algorithm,
	.timeout	= 2,
	.retries	= 1
};

static int __devinit bcccpmux_probe(struct platform_device *pdev)
{
	struct bcccpmux_i2c *i2c;
	struct bcccpmux_i2c_platform_data *pdata;
	struct i2c_adapter *adap;
	struct resource *res;
	u16 __iomem *base;
	int i, j, ret;

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (!res)
		return -ENODEV;

	pdata = pdev->dev.platform_data;
	if (!pdata) {
		dev_err(&pdev->dev, "Missing platform data\n");
		return -ENODEV;
	}

	adap = i2c_get_adapter(pdata->parent);
	if (!adap) {
		dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
			pdata->parent);
		return -ENODEV;
	}

	base = ioremap(res->start, res->end - res->start + 1);
	if (!base) {
		dev_err(&pdev->dev, "Unable to map registers\n");
		ret = -EIO;
		goto map_failed;
	}

	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
	if (!i2c) {
		ret = -ENOMEM;
		goto alloc_failed;
	}

	i2c->adap = kzalloc(sizeof(struct i2c_adapter)*pdata->busses,
			    GFP_KERNEL);
	if (!i2c->adap) {
		ret = -ENOMEM;
		goto alloc_failed2;
	}

	i2c->base = base;
	i2c->parent = adap;
	i2c->data = *pdata;

	for (i=0; i<pdata->busses; i++) {
		i2c->adap[i] = bcccpmux_adapter;
		i2c->adap[i].dev.parent = &adap->dev;
		i2c->adap[i].nr = i + pdata->base_nr;

		snprintf(i2c->adap[i].name, I2C_NAME_SIZE, "%s.%d",
			 bcccpmux_adapter.name, i);
		i2c_set_adapdata(&i2c->adap[i], i2c);
		ret = i2c_add_numbered_adapter(&i2c->adap[i]);
		if (ret) {
			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
			goto add_adapter_failed;
		}
	}

	/* disable parent bus so probes won't find devices on it */
	out_be16(base, pdata->idle);

	dev_info(&pdev->dev, "%d port mux at 0x%lx on %s adapter\n",
		 pdata->busses, (unsigned long)res->start, adap->name);

	platform_set_drvdata(pdev, i2c);

	return 0;

 add_adapter_failed:
	for (j=0; j<i; j++)
		i2c_del_adapter(&i2c->adap[j]);
	kfree(i2c->adap);
 alloc_failed2:
	kfree(i2c);
 alloc_failed:
	iounmap(base);
 map_failed:
	i2c_put_adapter(adap);

	return ret;
}

static int __devexit bcccpmux_remove(struct platform_device *pdev)
{
	struct bcccpmux_i2c *i2c = platform_get_drvdata(pdev);
	int i;

	for (i=0; i<i2c->data.busses; i++)
		i2c_del_adapter(&i2c->adap[i]);
	iounmap(i2c->base);
	platform_set_drvdata(pdev, NULL);
	i2c_put_adapter(i2c->parent);
	kfree(i2c->adap);
	kfree(i2c);

	return 0;
}

static struct platform_driver bcccpmux_driver = {
	.probe  = bcccpmux_probe,
	.remove = __devexit_p(bcccpmux_remove),
	.driver = {
		.owner = THIS_MODULE,
		.name = "bcccpi2cmux",
	},
};

static int __init bcccpmux_init(void)
{
	return platform_driver_register(&bcccpmux_driver);
}

static void __exit bcccpmux_exit(void)
{
	platform_driver_unregister(&bcccpmux_driver);
}

module_init(bcccpmux_init);
module_exit(bcccpmux_exit);

MODULE_DESCRIPTION("Barco CCCP I2C multiplexer driver");
MODULE_AUTHOR("Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>");
MODULE_LICENSE("GPL");

-- 
Bye, Peter Korsgaard

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
