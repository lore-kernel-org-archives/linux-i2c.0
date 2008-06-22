From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH] i2c: virtual i2c adapter support.
Date: Sun, 22 Jun 2008 10:37:16 +0200
Message-ID: <87fxr5sw5f.fsf@macbook.be.48ers.dk>
References: <1213895701-9872-1-git-send-email-giometti@linux.it>
	<1213895701-9872-2-git-send-email-giometti@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1213895701-9872-2-git-send-email-giometti-k2GhghHVRtY@public.gmane.org> (Rodolfo
	Giometti's message of "Thu\, 19 Jun 2008 19\:14\:59 +0200")
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Cc: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "Rodolfo" == Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org> writes:

Hi,

 Rodolfo> +
 Rodolfo> +struct i2c_adapter *i2c_add_virt_adapter(struct i2c_adapter *parent,
 Rodolfo> +				struct i2c_client *client,
 Rodolfo> +				u32 force_nr, u32 mux_val,
 Rodolfo> +				int (*select_cb) (struct i2c_adapter *,
 Rodolfo> +						struct i2c_client *, u32),
 Rodolfo> +				int (*deselect_cb) (struct i2c_adapter *,
 Rodolfo> +						struct i2c_client *, u32))
 Rodolfo> +{

How about changing the struct i2c_client to an anonymous void *data
instead so it can be used for systems where the multiplexing hardware
isn't a i2c device? E.G. I have a driver (currently not in mainline)
for a I2C multiplexer implemented in a FPGA together with the
opencores I2C controller:

/*
 * i2c-thinlitemux.c: I2C multiplexer on Barco Thinlite board.
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
#include <asm/io.h>
#include <asm/uaccess.h>

#define THINLITEMUX_BUSSES 6
#define THINLITEMUX_IDLE   7

struct thinlitemux_i2c {
	u16 __iomem *base;
	struct i2c_adapter *parent;
	struct i2c_adapter adap;
	int pos;
};

static int thinlitemux_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
			int num)
{
	struct thinlitemux_i2c *i2c = i2c_get_adapdata(adap);
	int ret;

	mutex_lock(&i2c->parent->bus_lock);
	out_be16(i2c->base, i2c->pos);
	ret = i2c->parent->algo->master_xfer(i2c->parent, msgs, num);
	out_be16(i2c->base, THINLITEMUX_IDLE);
	mutex_unlock(&i2c->parent->bus_lock);

	return ret;
}

static u32 thinlitemux_func(struct i2c_adapter *adap)
{
	struct thinlitemux_i2c *i2c = i2c_get_adapdata(adap);

	return i2c->parent->algo->functionality(i2c->parent);
}

static struct i2c_algorithm thinlitemux_algorithm = {
	.master_xfer	= thinlitemux_xfer,
	.functionality	= thinlitemux_func,
};

static struct i2c_adapter thinlitemux_adapter = {
	.owner		= THIS_MODULE,
	.name		= "thinlitemux",
	.class		= I2C_CLASS_HWMON,
	.algo		= &thinlitemux_algorithm,
	.timeout	= 2,
	.retries	= 1
};

static int __devinit thinlitemux_probe(struct platform_device *pdev)
{
	struct thinlitemux_i2c *i2c;
	struct i2c_adapter *adap;
	struct resource *res;
	u16 __iomem *base;
	int i, j, ret;

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (!res)
		return -ENODEV;

	adap = i2c_get_adapter((int)pdev->dev.platform_data);
	if (!adap) {
		dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
			(int)pdev->dev.platform_data);
		return -ENODEV;
	}

	base = ioremap(res->start, res->end - res->start + 1);
	if (!base) {
		dev_err(&pdev->dev, "Unable to map registers\n");
		ret = -EIO;
		goto map_failed;
	}

	i2c = kzalloc(sizeof(*i2c)*THINLITEMUX_BUSSES, GFP_KERNEL);
	if (!i2c) {
		ret = -ENOMEM;
		goto alloc_failed;
	}

	for (i=0; i<THINLITEMUX_BUSSES; i++) {
		i2c[i].base   = base;
		i2c[i].pos    = i;
		i2c[i].parent = adap;
		i2c[i].adap   = thinlitemux_adapter;
		i2c[i].adap.dev.parent = &adap->dev;
		i2c[i].adap.nr = i+1;

		snprintf(i2c[i].adap.name, I2C_NAME_SIZE, "%s.%d",
			 thinlitemux_adapter.name, i);
		i2c_set_adapdata(&i2c[i].adap, &i2c[i]);
		ret = i2c_add_numbered_adapter(&i2c[i].adap);
		if (ret) {
			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
			goto add_adapter_failed;
		}
	}

	/* disable parent bus so probes won't find devices on it */
	out_be16(base, THINLITEMUX_IDLE);

	dev_info(&pdev->dev, "%d port mux at 0x%lx on %s adapter\n",
		 THINLITEMUX_BUSSES, (unsigned long)res->start, adap->name);

	platform_set_drvdata(pdev, i2c);

	return 0;

 add_adapter_failed:
	for (j=0; j<i; j++)
		i2c_del_adapter(&i2c[j].adap);
 alloc_failed:
	iounmap(base);
 map_failed:
	i2c_put_adapter(adap);

	return ret;
}

static int __devexit thinlitemux_remove(struct platform_device* pdev)
{
	struct thinlitemux_i2c *i2c = platform_get_drvdata(pdev);
	int i;

	for (i=0; i<THINLITEMUX_BUSSES; i++)
		i2c_del_adapter(&i2c[i].adap);
	iounmap(i2c->base);
	platform_set_drvdata(pdev, NULL);
	i2c_put_adapter(i2c->parent);
	kfree(i2c);

	return 0;
}

static struct platform_driver thinlitemux_driver = {
	.probe  = thinlitemux_probe,
	.remove = __devexit_p(thinlitemux_remove),
	.driver = {
		.owner = THIS_MODULE,
		.name = "thinlitei2cmux",
	},
};

static int __init thinlitemux_init(void)
{
	return platform_driver_register(&thinlitemux_driver);
}

static void __exit thinlitemux_exit(void)
{
	platform_driver_unregister(&thinlitemux_driver);
}

module_init(thinlitemux_init);
module_exit(thinlitemux_exit);

MODULE_DESCRIPTION("Barco ThinLite I2C multiplexer driver");
MODULE_AUTHOR("Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>");
MODULE_LICENSE("GPL");

It would be nice to be able to use the i2c-virtual stuff for it.

-- 
Bye, Peter Korsgaard

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
