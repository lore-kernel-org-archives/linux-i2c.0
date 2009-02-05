From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2 v2] i2c,algo: cleanup i2c-algo-pcf.c
Date: Thu, 5 Feb 2009 17:11:19 +0100
Message-ID: <20090205171119.22638ff0@hyperion.delvare>
References: <4984688B.2090805@gmail.com>
	<20090201114121.6448a3c9@hyperion.delvare>
	<498760F7.6020005@gmail.com>
	<20090202225309.359e77d6@hyperion.delvare>
	<49883938.9010104@gmail.com>
	<20090204093402.08ddb2e8@hyperion.delvare>
	<4989BD34.9050406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4989BD34.9050406-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Roel,

On Wed, 04 Feb 2009 17:07:16 +0100, Roel Kluin wrote:
> Jean Delvare wrote:
> > It seems you have been a bit overzealous. I now get the following
> > warning when building the i2c-algo-pcf driver:
> > 
> > drivers/i2c/algos/i2c-algo-pcf.c: In function 'pcf_xfer':
> > drivers/i2c/algos/i2c-algo-pcf.c:377: warning: suggest explicit braces to avoid ambiguous 'else'
> > drivers/i2c/algos/i2c-algo-pcf.c:387: warning: suggest explicit braces to avoid ambiguous 'else'
> 
> should be fixed now.
> 
> >> @@ -313,24 +299,26 @@ static int pcf_doAddress(struct i2c_algo_pcf_data *adap,
> >>  	unsigned char addr;
> >>  
> >>  	addr = msg->addr << 1;
> >> +
> >>  	if (flags & I2C_M_RD)
> >>  		addr |= 1;
> >>  	if (flags & I2C_M_REV_DIR_ADDR)
> >>  		addr ^= 1;
> >> +
> >>  	i2c_outb(adap, addr);
> >>  
> >>  	return 0;
> >>  }
> > 
> > Not sure why you want to add blank lines there.
> 
> Ok, removed.
> 
> ------------------>8-----------------8<-------------------------
> cleanup whitespace, fix comments and remove the unused STUB_I2C.
> 
> Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied, thanks.

-- 
Jean Delvare
