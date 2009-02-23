From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Clarification on i2c-pca-platform driver timeout
Date: Mon, 23 Feb 2009 15:23:08 +0100
Message-ID: <20090223152308.1db394a6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

I would like you to clarify the situation when it comes to the value of
the timeout field of struct i2c_pca9564_pf_platform_data:

struct i2c_pca9564_pf_platform_data {
	(...)
	int timeout;		/* timeout = this value * 10us */
};

The only user, board-sh7785lcr.c, sets this value to 100, resulting in
a 1 ms timeout. This seems really short. Is this really intended?

Why is the timeout value defined in such a strange unit?

In the i2c-pca-platform driver, I then see:

static int __devinit i2c_pca_pf_probe(struct platform_device *pdev)
{
	struct i2c_pca_pf_data *i2c;
	(...)
	struct i2c_pca9564_pf_platform_data *platform_data =
				pdev->dev.platform_data;
	(...)
	i2c->adap.timeout = platform_data->timeout;

The problem is that i2c->adap.timeout is supposed to be expressed in
jiffies, not units of 10 us. So there is a conversion missing.

Lastly, you define a timeout value but never use it. Shouldn't you use
wait_event_interruptible_timeout() instead of
wait_event_interruptible() in i2c_pca_pf_waitforcompletion?

An upcoming patch will add code which handles a timeout at i2c-core
level, so it matters to get all i2c bus drivers right first.

Thanks,
-- 
Jean Delvare
