From: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c-ismt: add Initialize DMA buffer code
 ismt_access()
Date: Thu, 26 Sep 2013 10:41:15 -0400
Message-ID: <20130926144115.GB12301@hmsreliant.think-freely.org>
References: <1380066475-2119-1-git-send-email-james.d.ralston@intel.com>
 <20130926084032.GB3057@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130926084032.GB3057@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 26, 2013 at 10:40:32AM +0200, Wolfram Sang wrote:
> On Tue, Sep 24, 2013 at 04:47:55PM -0700, James Ralston wrote:
> > This patch adds code to Initialize the DMA buffer to compensate for possible hardware data corruption.
> 
> Take care of the line width here.
> 
> > Signed-off-by: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-ismt.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
> > index 8ed79a0..d3f30ea 100644
> > --- a/drivers/i2c/busses/i2c-ismt.c
> > +++ b/drivers/i2c/busses/i2c-ismt.c
> > @@ -393,6 +393,9 @@ static int ismt_access(struct i2c_adapter *adap, u16 addr,
> >  
> >  	desc = &priv->hw[priv->head];
> >  
> > +	/* Initialize the DMA buffer */
> > +	memset(priv->dma_buffer, 0, (I2C_SMBUS_BLOCK_MAX+1));
> 
> sizeof()?
> 
Agreed.
Neil

> > +
> >  	/* Initialize the descriptor */
> >  	memset(desc, 0, sizeof(struct ismt_desc));
> >  	desc->tgtaddr_rw = ISMT_DESC_ADDR_RW(addr, read_write);
> > -- 
> > 1.7.7.6
> > 
