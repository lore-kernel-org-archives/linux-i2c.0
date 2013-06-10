From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] i2c: vt8500: Add support for I2C bus on Wondermedia
	SoCs
Date: Tue, 11 Jun 2013 00:31:12 +0100
Message-ID: <20130610233112.GJ18614@n2100.arm.linux.org.uk>
References: <1368350634-12654-1-git-send-email-linux@prisktech.co.nz> <20130610160328.GG2987@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130610160328.GG2987@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Tony Prisk <linux@prisktech.co.nz>, vt8500-wm8505-linux-kernel@googlegroups.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 10, 2013 at 06:03:29PM +0200, Wolfram Sang wrote:
> Hi Tony,
> 
> > +static int wmt_i2c_wait_bus_not_busy(struct wmt_i2c_dev *i2c_dev)
> > diff --git a/drivers/i2c/busses/i2c-wmt.c b/drivers/i2c/busses/i2c-wmt.c
> > new file mode 100644
> > index 0000000..5cebb29
> > --- /dev/null
> > +++ b/drivers/i2c/busses/i2c-wmt.c
> 
> ...
> 
> > +{
> > +	u16 val;
> > +	int i;
> > +	int ret = 0;
> > +
> > +	for (i = 0; i < 100000; i++) {
> > +		val = readw(i2c_dev->base + REG_CSR);
> > +		if (val & CSR_READY_MASK)
> > +			break;
> > +
> > +		udelay(1);
> > +	}
> > +	if (i >= 9999999)
> > +		ret = -EBUSY;
> 
> What about using time_after and usleep_range?

And in any case this is not the correct way to check for success or
failure.

Failure is defined by readw(i2c_dev->base + REG_CSR) & CSR_READY_MASK
being false.  The above does not check it after the final 1us delay.
You might as well not wait for that final 1us because it's literally
just wasting time the way you've coded it.

Or fix it to re-check for success after the loop completes.
