From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [i2c] [RFC PATCH] I2C bus driver for SH7760 SoC, #2
Date: Tue, 26 Feb 2008 08:23:30 +0100
Message-ID: <20080226072330.GB14289@roarinelk.homelinux.net>
References: <20071105172313.GB17951@roarinelk.homelinux.net>
	<20080223171513.678f04d0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20080223171513.678f04d0@hyperion.delvare>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linuxsh-dev>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
Sender: linuxsh-dev-bounces@lists.sourceforge.net
Errors-To: linuxsh-dev-bounces@lists.sourceforge.net
To: Jean Delvare <khali@linux-fr.org>
Cc: linuxsh-dev@lists.sf.net, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

Thanks for looking at it.

> > +
> > +/* NOTE: SMBus QUICK Probe feature is "emulated" by reading 1 byte from
> > + *	 the slave address, because the SH7760 I2C cannot be programmed
> > + *	 to send a stop immediately after receiving the slave ACK/NACK.
> > + *	 If this behavior is not wanted, set platform_data.noquick to 1.
> > + */
> 
> This is not acceptable. This will have to be removed from the driver if
> you want me to take it upstream. The SMBus quick command should no
> longer be needed anyway with the advent of new-style i2c chip drivers.

I wrote that driver for 2.6.12 initially, and it was completely useless
without this hack.  I'm working on implementing zero-byte transfers in a
saner way, but the hardware gives me headaches...
 

> > +	OUT32(id, I2CMSR, 0);
> > +	if (id->msg->flags & I2C_M_NOSTART)
> 
> Do you actually need this? Is there any chip that is connected to this
> bus in practice which needs this flag? Implementing this feature is
> totally optional and should only be done when really needed (this is a
> violation of the I2C standard.)

The i2c header had this define in it, so I implemented it.  I thought
it was pretty useful when splitting an i2c transaction into multiple
i2c_msgs.  Consider it gone.

 
> > +	if (id->msg->flags & I2C_M_NOSTART)
> 
> Ditto.

see above.


> > +
> > +	if (sh7760_i2c_busy_check(id)) {
> > +		pr_debug("sh7760-i2c%d: bus is busy!\n", adap->nr);
> 
> Please use dev_dbg() instead. Or even better dev_err(), as you return
> with an error, the user will want to know.

done.


> > +			if (msg->flags & I2C_M_REV_DIR_ADDR)
> > +				addr ^= 1;
> 
> Again, do you actually need this? If not, please don't implement it.

see above.

 
> > +	for (cdf = 3; cdf >= 0; cdf--) {
> > +		iclk = mck / (1 + cdf);
> > +		/* iclk must not be > 20MHz */
> > +		if (iclk >= 20000000)
> 
> > or >=?
> 
> > +			continue;
> > +		for (scgd = 0; scgd < 63; scgd++) {
> > +			m1 = iclk / (20 + (scgd << 3));
> > +			dff = abs(scl_hz - m1);
> > +			if (dff < odff) {
> > +				odff = dff;
> > +				cdfm = cdf;
> > +				scgdm = scgd;
> > +			}
> > +		}
> > +	}
> 
> These imbricated loops don't look exactly optimal. Is there no way to
> compute the right value right away?

I'm open to suggestions. I just wanted to support (almost) every conceivable
scl clock and module clock.

> > +	printk(KERN_INFO "SH7760 I2C-%d, %d kHz, mmio %08x, irq %d\n",
> > +		id->adap.nr, pd->speed_khz, res->start, id->irq);
> 
> Use dev_info (and you will no longer need to print id->adap.nr).

Oh, neat!
 

I'll resend once I've managed to get zero-byte transfers working without
ugly hacks.

Best regards,
	Manuel Lauss

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
linuxsh-dev mailing list
linuxsh-dev@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linuxsh-dev
