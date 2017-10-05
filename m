From: Pontus Andersson <epontan@gmail.com>
Subject: Re: [PATCH] i2c: ismt: Separate I2C block read from SMBus block read
Date: Thu, 5 Oct 2017 16:13:11 +0200
Message-ID: <20171005141311.GA8565@leonis.localdomain>
References: <20171002124519.GA13496@leonis.localdomain>
 <20171005124133.7ue727bib2mlpnyy@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171005124133.7ue727bib2mlpnyy@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, Stephen Douthit <stephend@adiengineering.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 05, 2017 at 02:41:33PM +0200, Wolfram Sang wrote:
> On Mon, Oct 02, 2017 at 02:45:19PM +0200, Pontus Andersson wrote:
> > Commit b6c159a9cb69 ("i2c: ismt: Don't duplicate the receive length for
> > block reads") broke I2C block reads. It aimed to fix normal SMBus block
> > read, but changed the correct behavior of I2C block read in the process.
> > 
> > According to Documentation/i2c/smbus-protocol, one vital difference
> > between normal SMBus block read and I2C block read is that there is no
> > byte count prefixed in the data sent on the wire:
> > 
> >  SMBus Block Read:  i2c_smbus_read_block_data()
> >  S Addr Wr [A] Comm [A]
> >             S Addr Rd [A] [Count] A [Data] A [Data] A ... A [Data] NA P
> > 
> >  I2C Block Read:  i2c_smbus_read_i2c_block_data()
> >  S Addr Wr [A] Comm [A]
> >             S Addr Rd [A] [Data] A [Data] A ... A [Data] NA P
> > 
> > Therefore the two transaction types need to be processed differently in
> > the driver by copying of the dma_buffer as done previously for the
> > I2C_SMBUS_I2C_BLOCK_DATA case.
> > 
> > Fixes: b6c159a9cb69 ("i2c: ismt: Don't duplicate the receive length for block reads")
> > Signed-off-by: Pontus Andersson <epontan@gmail.com>
> > Cc: stable@vger.kernel.org
> 
> Applied to for-current, thanks!

Thank you! Is it safe to asume it will be backported to 4.4 stable
branch and upwards as the problematic commit did (once in mainline)?

> Might have been good to CC the patch author of the problematic commit,
> too.

Yes, of course! Stephen is CC now at least (kept the commit message
quoted at his convenience).
