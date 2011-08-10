From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: dynamic-debug not built into scx200_acb, scx200_i2c
Date: Wed, 10 Aug 2011 16:50:16 -0700
Message-ID: <1313020216.11924.129.camel@Joe-Laptop>
References: <CAJfuBxwq3xw3MZU01rwzg0NAnnxNoLrC2x0QXnj+2pD-6gkR4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJfuBxwq3xw3MZU01rwzg0NAnnxNoLrC2x0QXnj+2pD-6gkR4g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jim Cromie <jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2011-08-10 at 15:06 -0600, Jim Cromie wrote:
> scx200_acb has several pr_debugs, but theyre not available via dynamic-debug
> 
> Ive been unable to figure out why.
> Any ideas ?

-DDEBUG forces pr_debug to be output and doesn't
allow dynamic_debug for those outputs.

from drivers/i2c/busses/Makefile:

ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG

from printk.h:

/* If you are writing a driver, please use dev_dbg instead */
#if defined(DEBUG)
#define pr_debug(fmt, ...) \
	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
#elif defined(CONFIG_DYNAMIC_DEBUG)
/* dynamic_pr_debug() uses pr_fmt() internally so we don't need it here */
#define pr_debug(fmt, ...) \
	dynamic_pr_debug(fmt, ##__VA_ARGS__)
