From: Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] i2c: acorn: add MODULE_LICENSE tag
Date: Mon, 15 Jan 2018 17:19:20 +0000
Message-ID: <20180115171920.GA32698@flint.armlinux.org.uk>
References: <20180111103751.1506236-1-arnd@arndb.de>
 <20180115171027.ynorej3x7nal7ttj@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51880 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932872AbeAORTb (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 15 Jan 2018 12:19:31 -0500
Content-Disposition: inline
In-Reply-To: <20180115171027.ynorej3x7nal7ttj@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 15, 2018 at 06:10:28PM +0100, Wolfram Sang wrote:
> On Thu, Jan 11, 2018 at 11:37:45AM +0100, Arnd Bergmann wrote:
> > As of v4.15, Kbuild warns about missing MODULE_LICENSE tags:
> > 
> > WARNING: modpost: missing MODULE_LICENSE() in drivers/i2c/busses/i2c-acorn.o
> > 
> > This adds a license, author and description tag, matching the
> > comment at the start of the acorn i2c driver.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Looks good, but since rmk is still around, let's add him to CC...
> 
> > ---
> >  drivers/i2c/busses/i2c-acorn.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/i2c/busses/i2c-acorn.c b/drivers/i2c/busses/i2c-acorn.c
> > index 9d7be5af2bf2..6463189ca183 100644
> > --- a/drivers/i2c/busses/i2c-acorn.c
> > +++ b/drivers/i2c/busses/i2c-acorn.c
> > @@ -94,3 +94,7 @@ static int __init i2c_ioc_init(void)
> >  }
> >  
> >  module_init(i2c_ioc_init);
> > +
> > +MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");

linux@armlinux.org.uk please - dspam on _this_ account files such mails
into the spam mailbox.

Thanks.

> > +MODULE_DESCRIPTION("ARM IOC/IOMD i2c driver");
> > +MODULE_LICENSE("GPL v2");
> > -- 
> > 2.9.0
> > 

-- 
Russell King
ARM architecture Linux Kernel maintainer
