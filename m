From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: RFC: Use dynamic-debug with pr_debug when -DDEBUG is set
Date: Wed, 10 Aug 2011 23:06:54 -0700
Message-ID: <1313042814.11924.164.camel@Joe-Laptop>
References: <CAJfuBxwq3xw3MZU01rwzg0NAnnxNoLrC2x0QXnj+2pD-6gkR4g@mail.gmail.com>
	 <1313020216.11924.129.camel@Joe-Laptop>
	 <1313020897.11924.137.camel@Joe-Laptop> <20110811002039.GA3552@redhat.com>
	 <1313024628.11924.139.camel@Joe-Laptop>
	 <CAJfuBxyNBxs0hcTV=0N1UBYWnuXKsMUq3DC3GDgedRL5YX+34A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJfuBxyNBxs0hcTV=0N1UBYWnuXKsMUq3DC3GDgedRL5YX+34A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jim Cromie <jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jason Baron <jbaron-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2011-08-10 at 23:44 -0600, Jim Cromie wrote:
> On Wed, Aug 10, 2011 at 7:03 PM, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org> wrote:
> > On Wed, 2011-08-10 at 20:20 -0400, Jason Baron wrote:
> >> On Wed, Aug 10, 2011 at 05:01:37PM -0700, Joe Perches wrote:
> >> > Perhaps another way to enable pr_debug use
> >> > is to reverse the order of dynamic_pr_debug
> >> > defines.
> >> > ie:  change printk.h:
> >> > #if defined(CONFIG_DYNAMIC_DEBUG)
> >> > /* dynamic_pr_debug() uses pr_fmt() internally so we don't need it here */
> >> > #define pr_debug(fmt, ...) \
> >> >     dynamic_pr_debug(fmt, ##__VA_ARGS__)
> >> > #elif defined(DEBUG)
> >> > #define pr_debug(fmt, ...) \
> >> >     printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> >> > and change dynamic_debug.h:
> >> > #define DPRINTK_FLAGS_DEFAULT 0
> >> > to:
> >> > #if defined DEBUG
> >> > #define DPRINTK_FLAGS_DEFAULT DPRINTK_FLAGS_PRINT
> >> > #else
> >> > #define DPRINT_FLAGS_DEFAULT 0
> >> > #endif
> >> > That seems pretty sensible to me.  Jason?
> >> cool idea. I like it.
> > You've got a bunch of patches ready to
> > be pulled/queued, so I think you should
> > do it.
[]
> Ive just added this.  It works nicely, with one trivial change
> to add MODNAME, imitating the common non-dynamic-debug usage:
> #if defined DEBUG
> #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT |
> _DPRINTK_FLAGS_INCL_MODNAME

Right now, I think you should _not_ 
add DPRINTK_FLAGS_INCL_MODNAME to the
DEBUG DPRINTK_FLAGS_DEFAULT nor should
INCL_MODNAME  be added to any default output
style.

Look for things like:
	pr_debug(PFX "foo...");
and
	pr_debug("some_prefix: foo...");

For instance:

$ grep -rP --include=*.[ch] "pr_debug\s*\(\s*\"\w+:" *

There are just too many uses of pr_debug where
defaulting KBUILD_MODNAME on will just cause some
unnecessary duplication of output.

Maybe do this in a year or two when more of
the current printks are sifted.
