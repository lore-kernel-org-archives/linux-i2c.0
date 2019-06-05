From: Eduardo Valentin <eduval@amazon.com>
Subject: Re: [PATCH 2/3] i2c: slave-mqueue: add a slave backend to receive
 and queue messages
Date: Tue, 4 Jun 2019 20:27:09 -0700
Message-ID: <20190605032709.GA1534@u40b0340c692b58f6553c.ant.amazon.com>
References: <20190531043347.4196-1-eduval@amazon.com>
 <20190531043347.4196-3-eduval@amazon.com>
 <20190604171611.GS9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190604171611.GS9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Eduardo Valentin <eduval@amazon.com>, Wolfram Sang <wsa@the-dreams.de>, Haiyue Wang <haiyue.wang@linux.intel.com>, jarkko.nikula@linux.intel.com, brendanhiggins@google.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hey Andry,

Long time no seeing :-)

On Tue, Jun 04, 2019 at 08:16:11PM +0300, Andy Shevchenko wrote:
> On Thu, May 30, 2019 at 09:33:46PM -0700, Eduardo Valentin wrote:
> > From: Haiyue Wang <haiyue.wang@linux.intel.com>
> > 
> > Some protocols over I2C are designed for bi-directional transferring
> > messages by using I2C Master Write protocol. Like the MCTP (Management
> > Component Transport Protocol) and IPMB (Intelligent Platform Management
> > Bus), they both require that the userspace can receive messages from
> > I2C dirvers under slave mode.
> > 
> > This new slave mqueue backend is used to receive and queue messages, it
> > will exposes these messages to userspace by sysfs bin file.
> > 
> > Note: DT interface and a couple of minor fixes here and there
> > by Eduardo, so I kept the original authorship here.
> 
> > +#define MQ_MSGBUF_SIZE		CONFIG_I2C_SLAVE_MQUEUE_MESSAGE_SIZE
> > +#define MQ_QUEUE_SIZE		CONFIG_I2C_SLAVE_MQUEUE_QUEUE_SIZE
> 
> > +#define MQ_QUEUE_NEXT(x)	(((x) + 1) & (MQ_QUEUE_SIZE - 1))
> 
> Also possible ((x + 1) % ..._SIZE)

Right.. but I suppose the original idea is to avoid divisions on the hotpath.

So, I am actually fine with the limitation of only using power of 2.

> 
> > +	mq = dev_get_drvdata(container_of(kobj, struct device, kobj));
> 
> kobj_to_dev()

Well, yeah, I guess this is a nit, but I can add that in case of a real need for a v7.

> 
> > +static int i2c_slave_mqueue_probe(struct i2c_client *client,
> > +				  const struct i2c_device_id *id)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct mq_queue *mq;
> > +	int ret, i;
> > +	void *buf;
> > +
> > +	mq = devm_kzalloc(dev, sizeof(*mq), GFP_KERNEL);
> > +	if (!mq)
> > +		return -ENOMEM;
> > +
> 
> > +	BUILD_BUG_ON(!is_power_of_2(MQ_QUEUE_SIZE));
> 
> Perhaps start function with this kind of assertions?
> 


same here, in case I see a huge ask for a v7, I can move this up.

> > +
> > +	buf = devm_kmalloc_array(dev, MQ_QUEUE_SIZE, MQ_MSGBUF_SIZE,
> > +				 GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < MQ_QUEUE_SIZE; i++)
> > +		mq->queue[i].buf = buf + i * MQ_MSGBUF_SIZE;
> 
> 
> Just wondering if kfifo API can bring an advantage here?
> 

Well, then again, I suppose the idea is simplify here, not if we need to go
kfifo as the Protocol on top of this is perfectly fine with the current
discipline of just having a simple drop of older messages.


> > +	return 0;
> > +}
> 
> > +static const struct of_device_id i2c_slave_mqueue_of_match[] = {
> > +	{
> > +		.compatible = "i2c-slave-mqueue",
> > +	},
> 
> > +	{ },
> 
> No need for comma here.

It does not hurt to have it either :-)

> 
> > +};
> 
> > +
> > +static struct i2c_driver i2c_slave_mqueue_driver = {
> > +	.driver = {
> > +		.name	= "i2c-slave-mqueue",
> 
> > +		.of_match_table = of_match_ptr(i2c_slave_mqueue_of_match),
> 
> Wouldn't compiler warn you due to unused data?
> Perhaps drop of_match_ptr() for good...


Not sure what you meant here. I dont see any compiler warning.
Also, of_match_ptr seams to be well spread in the kernel.
> 
> > +	},
> > +	.probe		= i2c_slave_mqueue_probe,
> > +	.remove		= i2c_slave_mqueue_remove,
> > +	.id_table	= i2c_slave_mqueue_id,
> > +};
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
All the best,
Eduardo Valentin
