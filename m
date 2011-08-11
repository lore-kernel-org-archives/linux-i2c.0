From: Jason Baron <jbaron-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RFC: Use dynamic-debug with pr_debug when -DDEBUG is set
Date: Wed, 10 Aug 2011 20:20:40 -0400
Message-ID: <20110811002039.GA3552@redhat.com>
References: <CAJfuBxwq3xw3MZU01rwzg0NAnnxNoLrC2x0QXnj+2pD-6gkR4g@mail.gmail.com>
 <1313020216.11924.129.camel@Joe-Laptop>
 <1313020897.11924.137.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1313020897.11924.137.camel@Joe-Laptop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: Jim Cromie <jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 10, 2011 at 05:01:37PM -0700, Joe Perches wrote:
> On Wed, 2011-08-10 at 16:50 -0700, Joe Perches wrote:
> > On Wed, 2011-08-10 at 15:06 -0600, Jim Cromie wrote:
> > > scx200_acb has several pr_debugs, but theyre not available via dynamic-debug
> > > Ive been unable to figure out why.
> > > Any ideas ?
> > -DDEBUG forces pr_debug to be output and doesn't
> > allow dynamic_debug for those outputs.
> > from drivers/i2c/busses/Makefile:
> > ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
> > from printk.h:
> > /* If you are writing a driver, please use dev_dbg instead */
> > #if defined(DEBUG)
> > #define pr_debug(fmt, ...) \
> > 	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> > #elif defined(CONFIG_DYNAMIC_DEBUG)
> > /* dynamic_pr_debug() uses pr_fmt() internally so we don't need it here */
> > #define pr_debug(fmt, ...) \
> > 	dynamic_pr_debug(fmt, ##__VA_ARGS__)
> 
> Perhaps another way to enable pr_debug use
> is to reverse the order of dynamic_pr_debug
> defines.
> 
> ie:  change printk.h:
> 
> #if defined(CONFIG_DYNAMIC_DEBUG)
> /* dynamic_pr_debug() uses pr_fmt() internally so we don't need it here */
> #define pr_debug(fmt, ...) \
> 	dynamic_pr_debug(fmt, ##__VA_ARGS__)
> #elif defined(DEBUG)
> #define pr_debug(fmt, ...) \
> 	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> 
> and change dynamic_debug.h:
> 
> #define DPRINTK_FLAGS_DEFAULT 0
> 
> to:
> 
> #if defined DEBUG
> #define DPRINTK_FLAGS_DEFAULT DPRINTK_FLAGS_PRINT
> #else
> #define DPRINT_FLAGS_DEFAULT 0
> #endif
> 
> That seems pretty sensible to me.  Jason?
> 

cool idea. I like it.

-Jason
