From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v7 03/15] i2c: octeon: Remove I2C_FUNC_SMBUS_QUICK support
Date: Tue, 26 Apr 2016 07:58:45 +0200
Message-ID: <20160426055845.GB5758@hardcore>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
 <1461594824-7215-4-git-send-email-jglauber@cavium.com>
 <20160425221621.GI1550@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2on0083.outbound.protection.outlook.com ([65.55.169.83]:43040
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751027AbcDZF7A (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Apr 2016 01:59:00 -0400
Content-Disposition: inline
In-Reply-To: <20160425221621.GI1550@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>

On Tue, Apr 26, 2016 at 12:16:22AM +0200, Wolfram Sang wrote:
> On Mon, Apr 25, 2016 at 04:33:32PM +0200, Jan Glauber wrote:
> > SMBUS QUICK never worked for the read case, because EINVAL was returned
> > for a zero length message. The hardware does not support SMBUS QUICK
> > messages so disable the support and remove the zero length check.
> > 
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> 
> I see better now and I think we need to drop this patch. It looks like
> the driver supports only SMBUS_QUICK_WRITE which can be used for
> scanning devices. The driver probably works with 'i2cdetect -q'. This
> will regress if I apply the patch.
> 
> It seems it can't do SMBUS_QUICK_READ thus the extra check in the code.
> 
> I2C_FUNC_SMBUS_QUICK should have been split up in READ and WRITE to
> support this scenario.
> 
> Are my assumptions correct?

Yes, I thought briefly about splitting SMBUS_QUICK into read-write
variants too. To me the question is if this feature is still used on modern
devices or if this is more a relict of the past. I don't know enough
about SMBUS to answer that.

Also, the ThunderX documentation does not mention that it is supported.
The read case would be forbidden by the documentation (that was probably
the reason for adding the read EINVAL). The write case is kind of a grey
area, it might or might not work.

I'll see what i2cdetect does.

Thanks,
Jan

> 
> > ---
> >  drivers/i2c/busses/i2c-octeon.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
> > index 0f536a1..ad563cf 100644
> > --- a/drivers/i2c/busses/i2c-octeon.c
> > +++ b/drivers/i2c/busses/i2c-octeon.c
> > @@ -459,9 +459,6 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
> >  	int i, result, length = *rlength;
> >  	bool final_read = false;
> >  
> > -	if (length < 1)
> > -		return -EINVAL;
> > -
> >  	octeon_i2c_data_write(i2c, (target << 1) | 1);
> >  	octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
> >  
> > @@ -597,7 +594,7 @@ static struct i2c_bus_recovery_info octeon_i2c_recovery_info = {
> >  
> >  static u32 octeon_i2c_functionality(struct i2c_adapter *adap)
> >  {
> > -	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
> > +	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK) |
> >  	       I2C_FUNC_SMBUS_READ_BLOCK_DATA | I2C_SMBUS_BLOCK_PROC_CALL;
> >  }
> >  
> > -- 
> > 1.9.1
> > 
