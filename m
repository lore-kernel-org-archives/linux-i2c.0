From: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH v5] i2c: Adding support for Intel iSMT SMBus 2.0 host
 controller
Date: Wed, 30 Jan 2013 09:15:04 -0500
Message-ID: <20130130141504.GA2968@neilslaptop.think-freely.org>
References: <20121218150337.5b861ae3@endymion.delvare>
 <1359402232-21369-1-git-send-email-nhorman@tuxdriver.com>
 <20130129150551.498b2a9b@endymion.delvare>
 <20130129153253.GA14044@hmsreliant.think-freely.org>
 <20130129231028.41b04fc9@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130129231028.41b04fc9-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 29, 2013 at 11:10:28PM +0100, Jean Delvare wrote:
> On Tue, 29 Jan 2013 10:32:53 -0500, Neil Horman wrote:
> > On Tue, Jan 29, 2013 at 03:05:51PM +0100, Jean Delvare wrote:
> > > On Mon, 28 Jan 2013 14:43:52 -0500, Neil Horman wrote:
> > > > +		if (size != I2C_SMBUS_QUICK)
> > > > +			memcpy(data, dma_buffer,
> > > > +			       min(sizeof(*data), (size_t)I2C_SMBUS_BLOCK_MAX));
> > > 
> > > This computation looks wrong. We already know that sizeof(*data) ==
> > > sizeof(union i2c_smbus_data) > I2C_SMBUS_BLOCK_MAX, so the min() above
> > > will always return I2C_SMBUS_BLOCK_MAX. Which may be insufficient as
> > > the first byte holds the length, and at the same time it will be more
> > > than needed in most cases.
> > 
> > Gah!  Sorry, you're right, I wasn't paying attention and though that data was
> > just an allocated buffer, I need to fix that.
> > 
> > > My original suggestion to limit the size of the copy was meant as a
> > > run-time optimization, i.e. copying exactly the number of bytes that
> > > were received from the slave. That would be 1 or 2 for non-block reads,
> > > and the block length for block reads. Unfortunately I'm not sure is the
> > > block length is available. See my comment about this below in
> > > ismt_access().
> > 
> > We don't currently have the dma_size, no, but the only calling function computes
> > it (either from the block header or sets it appropriately for non-block
> > transfers).  We can pass that into the process_desc function and fix this.
> 
> This won't fix it, unless the hardware happens to update dma_size when
> receiving a block from a slave. If not then dma_size will always be
> I2C_SMBUS_BLOCK_MAX, while what we need is the number of bytes actually
> received.
> 
I'm sorry, I misspoke.  Its the rxbytes field in the descriptor that we need to use.  I
believe that field gets updated by the firmware on dmas from the device to the
cpu.

> > > > +static int ismt_access(struct i2c_adapter *adap, u16 addr,
> > > > +		       unsigned short flags, char read_write, u8 command,
> > > > +		       int size, union i2c_smbus_data *data)
> > > > +{
> > > > +	int ret;
> > > > +	dma_addr_t dma_addr = 0; /* address of the data buffer */
> > > > +	u8 dma_size = 0;
> > > > +	enum dma_data_direction dma_direction = 0;
> > > > +	struct ismt_desc *desc;
> > > > +	struct ismt_priv *priv = i2c_get_adapdata(adap);
> > > > +	struct device *dev = &priv->pci_dev->dev;
> > > > +
> > > > +	desc = &priv->hw[priv->head];
> > > > +
> > > > +	/* Initialize the descriptor */
> > > > +	memset(desc, 0, sizeof(struct ismt_desc));
> > > > +	desc->tgtaddr_rw = ISMT_DESC_ADDR_RW(addr, read_write);
> > > > +
> > > > +	/* Create a temporary buffer for the DMA transaction */
> > > > +	/* and insert the command at the beginning of the buffer */
> > > > +	if ((read_write == I2C_SMBUS_WRITE) &&
> > > > +	    (size != I2C_SMBUS_QUICK)) {
> > > 
> > > If I read the code below properly, this can be skipped for size ==
> > > I2C_SMBUS_BYTE too, right?
> > I don't think so.  The command field contains the data, and that is right below
> > the memcpy in that if clause.  We can certainly optimize this however, given
> > that I need to fix the memcpy sizes anyway.
> 
> Precisely, I'm not sure the priv->dma_buffer[0] = command is needed in
> this specific case, because later on we have:
> 
> 			desc->control |= ISMT_DESC_CWRL;
> 			desc->wr_len_cmd = command;
> 
Yeah, and I cant quite glean from the datasheet what the requirement is.  Seth,
do you have any insight on this?

> and dma_size isn't set, which suggests that priv->dma_buffer won't even
> be used. Honestly this "presetting" of priv->dma_buffer causes more
> confusion than it helps, and performance-wise it makes little sense, so
> I wouldn't object to you exploding it to the relevant code paths in the
> switch statement.
> 
I might do that.  I'm geting my hands on a system with this hardware in it, so I
can experiment a bit with the best way to do it.

> I'll take a look at the datasheet tomorrow to check if I got it right
> or you did. Or neither of us ^^ I'll also look for test hardware, I
> don't have that at home obviously, but at work maybe.
> 
I'll have some tomorrow.  I've got all your trivial changes fixed up, and will
hopefully be able to sort out the convoluted stuff with you and Seth in the next
few days

Neil

> -- 
> Jean Delvare
> 
