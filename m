From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v3 02/14] i2c-octeon: Cleanup i2c-octeon driver
Date: Mon, 14 Mar 2016 09:52:19 +0100
Message-ID: <20160314085219.GA2503@hardcore>
References: <cover.1457362545.git.jglauber@cavium.com>
 <aea2307d9ff5295a0041d3a129dd3e95bf3bd04c.1457362545.git.jglauber@cavium.com>
 <20160312153459.GD1661@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2on0054.outbound.protection.outlook.com ([207.46.100.54]:34435
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755329AbcCNIwf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 14 Mar 2016 04:52:35 -0400
Content-Disposition: inline
In-Reply-To: <20160312153459.GD1661@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>

On Sat, Mar 12, 2016 at 04:35:00PM +0100, Wolfram Sang wrote:
> On Mon, Mar 07, 2016 at 04:10:45PM +0100, Jan Glauber wrote:
> > Cleanup only without functional change.
> 
> I like most of the changes, but there are still some functional changes
> left.
> 
> > -static int octeon_i2c_stop(struct octeon_i2c *i2c)
> > +/* send STOP to the bus */
> > +static void octeon_i2c_stop(struct octeon_i2c *i2c)
> >  {
> >  	u8 data;
> >  
> > @@ -266,11 +259,8 @@ static int octeon_i2c_stop(struct octeon_i2c *i2c)
> >  
> >  	data = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
> >  
> > -	if (data != STAT_IDLE) {
> > +	if (data != STAT_IDLE)
> >  		dev_err(i2c->dev, "%s: bad status(0x%x)\n", __func__, data);
> > -		return -EIO;
> > -	}
> > -	return 0;
> 
> Why this change? I don't know what SW_TWSI_EOP_TWSI_STAT tells, but this
> is surely not a cleanup.

It is no functional change because the return value of
octeon_i2c_stop() was ignored anyway. That said, the whole read-back of
the status and the dev_err looks like debug code to me and is removed
in a later patch anyway. I'll incoporate this in the cleanup,
so octeon_i2c_stop() will only do the write.

> >  	octeon_i2c_stop(i2c);
> >  
> > -	return (ret != 0) ? ret : num;
> > +	return ret ? -EAGAIN : num;
> 
> This is also not a cleanup and looks wrong. -EAGAIN is for lost
> arbitration only.

I agree, this looks like an over-simplification and drops
the EINVAL/ETIMEDOUT/EIO errors. I'll drop that completely.

> >  
> > -static struct of_device_id octeon_i2c_match[] = {
> > -	{
> > -		.compatible = "cavium,octeon-3860-twsi",
> > -	},
> > +static const struct of_device_id octeon_i2c_match[] = {
> > +	{	.compatible = "cavium,octeon-3860-twsi",	},
> 
> Nit: I'd prefer no tabs within the curly braces.

Agreed.

thanks, Jan

> Thanks,
> 
>    Wolfram
> 
