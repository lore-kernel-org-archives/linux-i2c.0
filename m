From: Robert Norris <robn-4vTceeIZeJ0AvxtiuMwx3w@public.gmane.org>
Subject: Re: PROBLEM: modprobe hang at startup (3.8.x, 3.9.x, IBM x3550)
Date: Fri, 17 May 2013 20:26:27 +1000
Message-ID: <20130517102627.GB28229@pyro.melbourne.osa>
References: <1368408152.29197.140661229821177.2C1CC406@webmail.messagingengine.com>
 <20130514231626.GA12961@pyro.melbourne.osa>
 <20130515112044.753bb7bb@endymion.delvare>
 <20130515112741.GA23766@pyro.melbourne.osa>
 <20130515214923.036dabdb@endymion.delvare>
 <20130516034455.GA19452@pyro.melbourne.osa>
 <20130517103622.5000d277@endymion.delvare>
 <CAGS+omA84dm8QxJS0vdrYkvD0YXshRh4EkQfqVpbwvNVH+HxQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGS+omA84dm8QxJS0vdrYkvD0YXshRh4EkQfqVpbwvNVH+HxQg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, May 17, 2013 at 05:54:33PM +0800, Daniel Kurtz wrote:
> Was Robert able to get the system working without hangs by disabling
> the IRQ feature of i2c-i801 module when it was builtin?

Yes. There are no hangs when interrupts are explicitly disabled with
disable_features=0x10 or when 6676a847 is reverted and the module
rebuilt.

Cheers,
Rob.
