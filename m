From: Andreas Werner <wernerandy-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH v2] I2C: busses: i2c-eg20t Do not print error message in
 syslog if no ACK received
Date: Sun, 17 Nov 2013 13:39:02 +0100
Message-ID: <20131117123902.GA3834@awedesk.fritz.box>
References: <1384678731-10399-1-git-send-email-wernerandy@gmx.de>
 <20131117110846.GA3093@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131117110846.GA3093@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Nov 17, 2013 at 12:08:46PM +0100, Wolfram Sang wrote:
> On Sun, Nov 17, 2013 at 09:58:51AM +0100, Andreas Werner wrote:
> > Revision 2:
> > 	- delete the pch_err completly instead of changing to pch_dbg
> > 	  because there is already a pch_dbg at the function who calls
> > 	  pch_i2c_getack.
> > 	- Fixed message line issue
> 
> I prefer this below "---" after Signed-off.
Ok i will change it next time.
> 
> > 
> > diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
> > index 0f37529..5c39f90 100644
> > --- a/drivers/i2c/busses/i2c-eg20t.c
> > +++ b/drivers/i2c/busses/i2c-eg20t.c
> > @@ -321,10 +321,8 @@ static s32 pch_i2c_getack(struct i2c_algo_pch_data *adap)
> >  	void __iomem *p = adap->pch_base_address;
> >  	reg_val = ioread32(p + PCH_I2CSR) & PCH_GETACK;
> >  
> > -	if (reg_val != 0) {
> > -		pch_err(adap, "return%d\n", -EPROTO);
> > +	if (reg_val != 0)
> >  		return -EPROTO;
> 
> That could be fixed to -ENXIO according to
> Documentation/i2c/fault-codes.
Yes you are right -ENXIO should returned if no ACK was received.
Is there another reason why pch_i2c_getack returned EPROTO?
May be ENXIO was introduced later?
> 
> > @@ -367,8 +365,7 @@ static int pch_i2c_wait_for_check_xfer(struct i2c_algo_pch_data *adap)
> >  	adap->pch_event_flag = 0;
> >  
> >  	if (pch_i2c_getack(adap)) {
> > -		pch_dbg(adap, "Receive NACK for slave address"
> > -			"setting\n");
> > +		pch_dbg(adap, "Receive NACK for slave address setting\n");
> >  		return -EIO;
> 
> What about returning the value we got from pch_i2c_getack?
> 
EIO is almost ok, because EIO means something went wrong when performing
an I/O operation, but yes we can return the value from pch_i2c_getack (ENXIO)
to get more detailed informations whats going wrong exactly (no ACK reveiced).

I think we can just replace the -EIO with -ENXIO or do you want to pick up the return
vale of pch_i2c_getack and return that ?

Regards

Andy


> Regards,
> 
>    Wolfram
> 
