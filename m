From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Finding 'orphaned' i2c drivers
Date: Mon, 23 Feb 2009 10:24:52 -0500
Message-ID: <9e4733910902230724hcaa2b9by7b324db88eaf186c@mail.gmail.com>
References: <20090223110052.GE15722@buzzloop.caiaq.de>
	 <9e4733910902230638w262cd027pba4b65509e2e8a41@mail.gmail.com>
	 <20090223144300.GA18378@buzzloop.caiaq.de>
	 <9e4733910902230716t39994927i454bceb641c650ed@mail.gmail.com>
	 <9e4733910902230718p1f896e77u9292708b71ab36a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9e4733910902230718p1f896e77u9292708b71ab36a6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is the last piece....

static int __devinit dspeak01_fabric_probe(struct of_device *op,
				      const struct of_device_id *match)
{
	const phandle *handle;
	struct device_node *clock_node;
	unsigned int len;

	handle = of_get_property(op->node, "clock-handle", &len);
	if (!handle || len < sizeof(handle))
		return -ENODEV;

	clock_node = of_find_node_by_phandle(*handle);
	if (!clock_node)
		return -ENODEV;

	fabric.clock = of_find_i2c_device_by_node(clock_node);
	if (!fabric.clock)
		return -ENODEV;

	of_snd_soc_register_machine("DSPEAK01", &dspeak01_fabric_ops);
	return 0;
}


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
