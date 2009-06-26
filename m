From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/1] I2C: I2C controller driver for Intel Moorestown
 platform
Date: Fri, 26 Jun 2009 09:50:26 +0200
Message-ID: <20090626095026.22c5d6c1@hyperion.delvare>
References: <0A882F4D99BBF6449D58E61AAFD7EDD610424EB0@pdsmsx502.ccr.corp.intel.com>
	<20090416111436.296cdd12@hyperion.delvare>
	<0A882F4D99BBF6449D58E61AAFD7EDD613677A65@pdsmsx502.ccr.corp.intel.com>
	<0A882F4D99BBF6449D58E61AAFD7EDD62876816C@pdsmsx502.ccr.corp.intel.com>
	<0A882F4D99BBF6449D58E61AAFD7EDD628768177@pdsmsx502.ccr.corp.intel.com>
	<20090615135058.1bf40a75@hyperion.delvare>
	<0A882F4D99BBF6449D58E61AAFD7EDD62F26B15F@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0A882F4D99BBF6449D58E61AAFD7EDD62F26B15F-Uz4Je35TzWuiAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Wang, Wen W" <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wen,

On Fri, 26 Jun 2009 10:41:07 +0800, Wang, Wen W wrote:
> Hi Jean,
> 
> Really appreciate your kindly comments on Moorestown I2C driver! I'm really learning a lot from your comments. :)
> 
> Currently I'm working on those comments, but due to other plenty of work, please expect a slow response on that. :(
> 
> Another thing needs your help is, can I replace the module_init() function with subsys_initcall() in Moorestown I2C driver? Is it acceptable for I2C subsystem? 

Yes, using subsys_initcall() is acceptable, a number of i2c bus drivers
for embedded platforms do that already (i2c-pxa and i2c-omap.c for
example.)

> There is a requirement in Moorestown that certain drivers need I2C driver loaded before those drivers. To achieve this, is subsys_initcall() the only way?

I can't say whether this is the only way given than you mentioned no
detail about the requirements, but this is one possible way for sure.

-- 
Jean Delvare
