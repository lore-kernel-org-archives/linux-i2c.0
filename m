From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: Supporting new features in I2C
Date: Fri, 12 Sep 2008 17:35:35 +0100
Message-ID: <20080912163534.GD1916@fluff.org.uk>
References: <863377.52660.qm@web57102.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757237AbYILQje@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <863377.52660.qm@web57102.mail.re3.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vidhumouli hunsigida <hv_mouli@yahoo.com>
Cc: i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 12, 2008 at 06:35:43AM -0700, vidhumouli hunsigida wrote:
> The I2C host controller chip has two features named
> HOLD and Slave Monitor.
> 
> HOLD is the typical feature of holding the clock low to support for the slow devices.
> It can be enabled or disabled through software control by writing a bit in the registor.

This should be normal behaviour for an i2c bus, some controllers
can support it, but there is no need to add any extra functionality
to the i2c layer for this. The driver is free to do it or not do it.

If you want to driver to do either, then you can either have it as a
module parameter and/or have some configuration file in sysfs to change
the state.
 
> I am writing a bus driver for this core.
> I am not sure where and how this provision is to be added in the I2C adapter code.
> 
> I could not find any such provision in the exising bus drivers.
> I could not find any related information in the Linux kernel documentation.
> 
> Can any one give me how can this be done?
> 
> Similarly for Slave Monitor, where a host monitors for the ack received from the slave device.
> This can also be enabled/disabled by setting a bit in the register. How is this to be handled in the current i2c adapter code?

I suggest you have a look at the drivers in drivers/i2c/busses and
also include/linux/i2c.h (pay particual attention to 'struct i2c_algorithm'
which can be used to add new bus drivers).

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
