From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH] i2c: virtual i2c adapter support.
Date: Sun, 22 Jun 2008 21:48:39 +0200
Message-ID: <87hcblqmi0.fsf@macbook.be.48ers.dk>
References: <1213895701-9872-1-git-send-email-giometti@linux.it>
	<1213895701-9872-2-git-send-email-giometti@linux.it>
	<87fxr5sw5f.fsf@macbook.be.48ers.dk>
	<20080622085206.GM10695@enneenne.com>
	<87bq1tsue5.fsf@macbook.be.48ers.dk>
	<20080622093939.GO10695@enneenne.com>
	<8763s1spuw.fsf@macbook.be.48ers.dk>
	<20080622125010.GP10695@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080622125010.GP10695-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org> (Rodolfo Giometti's message
	of "Sun\, 22 Jun 2008 14\:50\:10 +0200")
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Cc: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "Rodolfo" == Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org> writes:

 Rodolfo> On Sun, Jun 22, 2008 at 12:53:11PM +0200, Peter Korsgaard wrote:
 >> >>>>> "Rodolfo" == Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org> writes:
 >> 
 Rodolfo> Maybe if you provide a littke code I may understand exactly
 Rodolfo> what you mean. ;)
 >> 
 >> But I did?!

 Rodolfo> I mean the code that shows how you wish adding your i2c mux
 Rodolfo> by using i2c_add_virt_adapter(). :)

Pretty much like the pcf driver, E.G. something like (not compile
tested):

#define THINLITEMUX_BUSSES 6
#define THINLITEMUX_IDLE   7

struct thinlitemux_i2c {
	u16 __iomem *base;
	struct i2c_adapter *parent;
	struct i2c_adapter *adap{TINLITEMUX_BUSSES];
};

static int thinlitemux_select(struct i2c_adapter *adap,
			      struct i2c_client *client, u32 chan)
{
        struct thinlitemux_i2c *i2c = (struct thinlitemux_i2c*)client;

        out_be16(i2c->base, chan);
}

static int thinlitemux_deselect(struct i2c_adapter *adap,
				struct i2c_client *client, u32 value)
{
        struct thinlitemux_i2c *i2c = (struct thinlitemux_i2c*)client;

        out_be16(i2c->base, THINLITEMUX_IDLE);
}

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

	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
	if (!i2c) {
		ret = -ENOMEM;
		goto alloc_failed;
	}

	i2c->parent = i2c_get_adapter((int)pdev->dev.platform_data);
	if (!i2c->parent) {
		dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
			(int)pdev->dev.platform_data);
		ret = -ENODEV;
                goto no_parent;
	}

	i2c->base = ioremap(res->start, res->end - res->start + 1);
	if (!i2c->base) {
		dev_err(&pdev->dev, "Unable to map registers\n");
		ret = -EIO;
		goto map_failed;
	}

	/* disable parent bus so probes won't find devices on it */
        thinlitemux_deselect(i2c->parent, NULL, 0);

	for (i=0; i<THINLITEMUX_BUSSES; i++) {
                i2c->adap[i]   = i2c_add_virt_adapter(i2c->parent, i2c, 0, i,
                              &thinlitemux_select, &thinlitemux_deselect);
                if (!i2c->adap[i]) {
			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
			goto add_adapter_failed;
		}
	}

	dev_info(&pdev->dev, "%d port mux at 0x%lx on %s adapter\n",
		 THINLITEMUX_BUSSES, (unsigned long)res->start, parent->name);

	platform_set_drvdata(pdev, i2c);

	return 0;

 add_adapter_failed:
	for (j=0; j<i; j++)
		i2c_del_virt_adapter(&i2c->adap[j]);
 alloc_failed:
	iounmap(i2c->base);
 map_failed:
	i2c_put_adapter(i2c->parent);
 no_parent
	kfree(i2c);

	return ret;
}

static int __devexit thinlitemux_remove(struct platform_device* pdev)
{
	struct thinlitemux_i2c *i2c = platform_get_drvdata(pdev);
	int i;

	for (i=0; i<THINLITEMUX_BUSSES; i++)
		i2c_del_virt_adapter(&i2c->adap[i]);
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

 Rodolfo> However, we also should make attention at
 Rodolfo> i2c_del_virt_adapter() which must call (new)
 Rodolfo> i2c_del_adapter_nolock() since the core_lock is hold by
 Rodolfo> i2c_del_driver() when the mux is an i2c device.

 Rodolfo> If you define a virtual adapter as a non-i2c device I
 Rodolfo> suppose we should use the lock...

I guess we could do:

	if (mutex_is_locked(&core_lock))
		ret = i2c_del_adapter_nolock(adap);
	else
		ret = i2c_del_adapter(adap);

Except that core_lock is static in i2c-core.c.

-- 
Bye, Peter Korsgaard

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
