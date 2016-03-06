From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v2 01/10] i2c-octeon: Cleanup i2c-octeon driver
Date: Sun, 6 Mar 2016 14:00:38 +0100
Message-ID: <20160306130038.GC4736@hardcore>
References: <cover.1457111728.git.jglauber@cavium.com>
 <4b342427bdf6d7dc7cf9ded9172deadd24a53650.1457111729.git.jglauber@cavium.com>
 <20160305184731.GB1394@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160305184731.GB1394@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>
List-Id: linux-i2c@vger.kernel.org

On Sat, Mar 05, 2016 at 07:47:31PM +0100, Wolfram Sang wrote:
> Hi Jan,
> 
> The description is not enough. A list what kind of changes you applied
> would be nice.

OK.

> I'd like to have these checkpatch issues fixed:
> 
> ERROR: trailing statements should be on next line
> #177: FILE: drivers/i2c/busses/i2c-octeon.c:133:
> +	while ((tmp & SW_TWSI_V) != 0);
> 
> ERROR: trailing statements should be on next line
> #202: FILE: drivers/i2c/busses/i2c-octeon.c:152:
> +	while ((tmp & SW_TWSI_V) != 0);

Fixed. Strange that checkpatch.pl -f (use on file) does not report these
errors though.

> CHECK: Prefer using the BIT_ULL macro
> #52: FILE: drivers/i2c/busses/i2c-octeon.c:39:
> +#define SW_TWSI_V		(1ULL << 63)

OK

> Note: I don't care so much about the 80 char limit as long as the line
> length is not too excessive.

Fine, same opinion here. I'll try to limit the 80 char changes to a
sane minimum then.

>
> > -#define DRV_NAME "i2c-octeon"
> > +#define DRV_NAME		"i2c-octeon"
> 
> I'm in favor for indenting register and bit defines, but other than that
> I think one space is enough. I won't force my opinion on you, though.
> Just wanted to let you know.

OK

> > +#define INT_ENA_ST		0x1
> > +#define INT_ENA_TS		0x2
> > +#define INT_ENA_CORE		0x4
> 
> I assume those are bits? Then, they shouldn't be in the registers
> section.

I'll move them to the thunderx patch.

> > +/* TWSI_INT values */
> > +#define ST_INT			0x01
> > +#define TS_INT			0x02
> > +#define CORE_INT		0x04
> > +#define ST_EN			0x10
> > +#define TS_EN			0x20
> > +#define CORE_EN			0x40
> > +#define SDA_OVR			0x100
> > +#define SCL_OVR			0x200
> > +#define SDA			0x400
> > +#define SCL			0x800
> 
> I think those should have a prefix. SDA and SCL are dangerously generic.

Agreed, I'll make these TWSI_INT_*.

> >  struct octeon_i2c {
> > -	wait_queue_head_t queue;
> > -	struct i2c_adapter adap;
> > -	int irq;
> > -	u32 twsi_freq;
> > -	int sys_freq;
> > -	resource_size_t twsi_phys;
> > -	void __iomem *twsi_base;
> > -	resource_size_t regsize;
> > -	struct device *dev;
> > +	wait_queue_head_t	queue;
> > +	struct i2c_adapter	adap;
> > +	int			irq;
> > +	u32			twsi_freq;
> > +	int			sys_freq;
> > +	void __iomem		*twsi_base;
> > +	struct device		*dev;
> 
> NAK. structs change often, and then one needs to fix the whole
> indentation. One space is enough here.

Not sure I understand your argument. I find this form more readable
but I can change that to one space.

> >  };
> 
> > -static u8 octeon_i2c_read_sw(struct octeon_i2c *i2c, u64 eop_reg)
> > +static u64 octeon_i2c_read_sw64(struct octeon_i2c *i2c, u64 eop_reg)
> ...
> > -	return tmp & 0xFF;
> > +	return tmp;
> > +}
> ...
> > +
> > +/**
> > + * octeon_i2c_read_sw - read lower bits of an I2C core register
> > + * @i2c: The struct octeon_i2c
> > + * @eop_reg: Register selector
> > + *
> > + * Returns the data.
> > + *
> > + * The I2C core registers are accessed indirectly via the SW_TWSI CSR.
> > + */
> > +static u8 octeon_i2c_read_sw(struct octeon_i2c *i2c, u64 eop_reg)
> > +{
> > +	return octeon_i2c_read_sw64(i2c, eop_reg);
> >  }
> 
> This is not a cleanup!

OK, I'll move that to the patch where it's used.

> > +/* disable the CORE interrupt */
> >  static void octeon_i2c_int_disable(struct octeon_i2c *i2c)
> >  {
> > -	octeon_i2c_write_int(i2c, 0);
> > +	/* clear TS/ST/IFLG events */
> > +	octeon_i2c_write_int(i2c, TS_INT | ST_INT);
> >  }
> 
> Isn't this a functional change?

Looks like a bug, I'll drop that.

> >  /**
> > - * octeon_i2c_unblock - unblock the bus.
> > - * @i2c: The struct octeon_i2c.
> > + * bitbang_unblock - unblock the bus
> > + * @i2c: The struct octeon_i2c
> >   *
> > - * If there was a reset while a device was driving 0 to bus,
> > - * bus is blocked. We toggle it free manually by some clock
> > - * cycles and send a stop.
> > + * If there was a reset while a device was driving 0 to bus, bus is blocked.
> > + * We toggle it free manually by some clock cycles and send a stop.
> >   */
> > -static void octeon_i2c_unblock(struct octeon_i2c *i2c)
> > +static void bitbang_unblock(struct octeon_i2c *i2c)
> 
> I dunno understand the change of the function name. However, this should
> be refactored to use the i2c_bus_recovery infrastructure anyhow.

I'll leave the function name as it is. Would it be possbile to address
the refactoring in a follow-up patch after this series is finished?

> > -	result = wait_event_timeout(i2c->queue,
> > -					octeon_i2c_test_iflg(i2c),
> > -					i2c->adap.timeout);
> > -
> > +	result = wait_event_timeout(i2c->queue, octeon_i2c_test_iflg(i2c),
> > +				    i2c->adap.timeout);
> 
> You could rename this variable to 'time_left' to make the code even
> easier to read.

Agreed.

> >  static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
> > -			    const u8 *data, int length)
> > +			    u8 *data, int length)
> 
> Why this change?
> 
> >  {
> > -	int i, result;
> > +	int result, i;
> 
> And this?

I'll drop these two, just noise from merging back and forth.

> > -static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
> > -			   u8 *data, int length)
> > +static int octeon_i2c_read(struct octeon_i2c *i2c, int target, u8 *data,
> > +			   u16 *rlength)
> >  {
> > +	int length = *rlength;
> 
> And this?

I'll move this to the patch where it's used.

> > @@ -353,15 +411,14 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
> >  	if (result)
> >  		return result;
> >  
> > -	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, (target<<1) | 1);
> > -	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
> > -
> > +	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, TWSI_CTL_ENAB);
> 
> Is this really the same?

I'll move this to a later patch.

> >  static u32 octeon_i2c_functionality(struct i2c_adapter *adap)
> > @@ -435,13 +490,10 @@ static struct i2c_adapter octeon_i2c_ops = {
> >  	.owner = THIS_MODULE,
> >  	.name = "OCTEON adapter",
> >  	.algo = &octeon_i2c_algo,
> > -	.timeout = HZ / 50,
> 
> This is a functional change, or?

Hmm, it isn't for arm64 (HZ 250) but it would be for MIPS (HZ 100). I'll make it
a seperate patch then.

> > -	i2c->twsi_phys = res_mem->start;
> > -	i2c->regsize = resource_size(res_mem);
> 
> Those are removed which is okay in general, but should be in a seperate
> patch.

OK

> This patch was hard to review because so many changes were overlapping.
> It really  should have been broken out. Like one patch only removing the
> trailing "." in the kernel-doc. One fixing the indentation issues. One
> removing the now superfluous fields in struct octeon_i2c, etc...

I'll split it into several patches then.

Thanks for reviewing,
Jan

>    Wolfram
> 
