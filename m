From: Federico Vaga <federico.vaga@cern.ch>
Subject: Re: [PATCH v5 5/5] i2c:ocores: checkpatch fixes
Date: Mon, 11 Feb 2019 17:18:13 +0100
Message-ID: <2547581.38QU9fvyYn@pcbe13614>
References: <20190211160529.23858-1-federico.vaga@cern.ch> <20190211160529.23858-6-federico.vaga@cern.ch> <bbaaa303-75f1-9272-c01f-914175237f05@axentia.se>
Reply-To: <federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bbaaa303-75f1-9272-c01f-914175237f05@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Monday, February 11, 2019 5:12:23 PM CET Peter Rosin wrote:
> On 2019-02-11 17:05, Federico Vaga wrote:
> 
> > Miscellaneous style fixes from checkpatch
> > 
> > Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> > ---
> > 
> >  drivers/i2c/busses/i2c-ocores.c | 30 +++++++++++++++++++-----------
> >  1 file changed, 19 insertions(+), 11 deletions(-)
> > 
> > 
> > diff --git a/drivers/i2c/busses/i2c-ocores.c
> > b/drivers/i2c/busses/i2c-ocores.c
 index 78085a8..54b2156 100644
> > --- a/drivers/i2c/busses/i2c-ocores.c
> > +++ b/drivers/i2c/busses/i2c-ocores.c
> > @@ -179,8 +179,9 @@ static void ocores_process(struct ocores_i2c *i2c, u8
> > stat)
> 
> >  			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
> >  			goto out;
> >  		
> >  		}
> > 
> > -	} else
> > +	} else {
> > 
> >  		msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
> > 
> > +	}
> > 
> >  
> >  
> >  	/* end of msg? */
> >  	if (i2c->pos == msg->len) {
> > 
> > @@ -197,11 +198,11 @@ static void ocores_process(struct ocores_i2c *i2c,
> > u8 stat)
> 
> >  				i2c->state = STATE_START;
> >  
> >  
> >  
> >  				oc_setreg(i2c, OCI2C_DATA, addr);
> > 
> > -				oc_setreg(i2c, OCI2C_CMD,  OCI2C_CMD_START);
> > +				oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
> > 
> >  				goto out;
> > 
> > -			} else
> > -				i2c->state = (msg->flags & I2C_M_RD)
> > -					? STATE_READ : STATE_WRITE;
> > +			}
> > +			i2c->state = (msg->flags & I2C_M_RD)
> > +				? STATE_READ : STATE_WRITE;
> > 
> >  		} else {
> >  		
> >  			i2c->state = STATE_DONE;
> >  			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
> > 
> > @@ -461,13 +462,16 @@ static const struct of_device_id ocores_i2c_match[]
> > = {
> 
> >  MODULE_DEVICE_TABLE(of, ocores_i2c_match);
> >  
> >  #ifdef CONFIG_OF
> > 
> > -/* Read and write functions for the GRLIB port of the controller.
> > Registers are
 +/*
> > + * Read and write functions for the GRLIB port of the controller.
> > Registers are
> 
> >   * 32-bit big endian and the PRELOW and PREHIGH registers are merged into
> >   one
> 
> > - * register. The subsequent registers has their offset decreased
> > accordingly. */
 + * register. The subsequent registers have their
> > offsets decreased accordingly. + */
> > 
> >  static u8 oc_getreg_grlib(struct ocores_i2c *i2c, int reg)
> >  {
> >  
> >  	u32 rd;
> >  	int rreg = reg;
> > 
> > +
> > 
> >  	if (reg != OCI2C_PRELOW)
> >  	
> >  		rreg--;
> >  	
> >  	rd = ioread32be(i2c->base + (rreg << i2c->reg_shift));
> > 
> > @@ -481,6 +485,7 @@ static void oc_setreg_grlib(struct ocores_i2c *i2c,
> > int reg, u8 value)
> 
> >  {
> >  
> >  	u32 curr, wr;
> >  	int rreg = reg;
> > 
> > +
> > 
> >  	if (reg != OCI2C_PRELOW)
> >  	
> >  		rreg--;
> >  	
> >  	if (reg == OCI2C_PRELOW || reg == OCI2C_PREHIGH) {
> > 
> > @@ -569,7 +574,7 @@ static int ocores_i2c_of_probe(struct platform_device
> > *pdev,
> 
> >  	return 0;
> >  
> >  }
> >  #else
> > 
> > -#define ocores_i2c_of_probe(pdev,i2c) -ENODEV
> > +#define ocores_i2c_of_probe(pdev, i2c) -ENODEV
> > 
> >  #endif
> >  
> >  static int ocores_i2c_probe(struct platform_device *pdev)
> > 
> > @@ -686,10 +691,11 @@ err_clk:
> > 
> >  static int ocores_i2c_remove(struct platform_device *pdev)
> >  {
> >  
> >  	struct ocores_i2c *i2c = platform_get_drvdata(pdev);
> > 
> > +	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
> > 
> >  
> >  
> >  	/* disable i2c logic */
> > 
> > -	oc_setreg(i2c, OCI2C_CONTROL, oc_getreg(i2c, OCI2C_CONTROL)
> > -		  & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
> > +	ctrl &= ~(OCI2C_CTRL_EN | OCI2C_CTRL_IEN);
> > +	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
> > 
> >  
> >  
> >  	/* remove adapter & data */
> >  	i2c_del_adapter(&i2c->adap);
> > 
> > @@ -707,7 +713,9 @@ static int ocores_i2c_suspend(struct device *dev)
> > 
> >  	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
> >  
> >  
> >  
> >  	/* make sure the device is disabled */
> > 
> > -	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
> > +	ctrl = oc_getreg(i2c, OCI2C_CONTROL);
> 
> 
> There's a pointless double oc_getreg(i2c, OCI2C_CONTROL).

Very sorry for the waste of time for such a stupid copy&paste error.
V6 is coming.
 
> Cheers,
> Peter
> 
> 
> > +	ctrl &= ~(OCI2C_CTRL_EN | OCI2C_CTRL_IEN);
> > +	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
> > 
> >  
> >  
> >  	if (!IS_ERR(i2c->clk))
> >  	
> >  		clk_disable_unprepare(i2c->clk);
> > 
> > 
> 
> 
