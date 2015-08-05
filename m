From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] i2c: allow specifying separate wakeup interrupt in
 device tree
Date: Wed, 5 Aug 2015 06:33:44 -0700
Message-ID: <20150805133343.GL16878@atomide.com>
References: <20150730201431.GA5255@dtor-ws>
 <55BB54B1.80603@ti.com>
 <20150803102121.GO16878@atomide.com>
 <20150803200246.GB38878@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150803200246.GB38878@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vignesh R <vigneshr@ti.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [150803 13:05]:
> On Mon, Aug 03, 2015 at 03:21:21AM -0700, Tony Lindgren wrote:
> > 
> > Hmm why do we need the check for if (device_can_wakeup(&client->dev)))?
> 
> Because of the code in device_wakeup_attach_irq():
> 
> 	ws = dev->power.wakeup;
> 	if (!ws) {
> 		dev_err(dev, "forgot to call call device_init_wakeup?\n");
> 		return -EINVAL;
> 	}

OK :) 

> > Also wondering about the dev vs &client->dev usage here.. But I take
> > you have checked that we end up calling the runtime PM calls of the
> > client instead of the i2c bus controller :)
> 
> dev *is* clent->dev in this context:
> 
> 	struct i2c_client *client = i2c_verify_client(dev);

OK thanks for confirming that.

Regards,

Tony
