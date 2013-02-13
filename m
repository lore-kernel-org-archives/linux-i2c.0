From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [i2c-mxs] Broken DMA operations from within a module
Date: Wed, 13 Feb 2013 12:14:50 +0000
Message-ID: <20130213121450.GA17833@n2100.arm.linux.org.uk>
References: <lyehgkift9.fsf@ensc-virt.intern.sigma-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <lyehgkift9.fsf-ZECJmDZ6y6nH/BybaBJVFuwNITXz66n+UvKB7fB21xCELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Enrico Scholz <enrico.scholz-wttK6gPy29v+Hn7q9Vec/7NAH6kLmebB@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 13, 2013 at 01:00:50PM +0100, Enrico Scholz wrote:
> E.g. when doing something like
> 
> 	struct i2c_msg xfer = {
>                .buf = "something",
>                ...
>         };
> 
>         ret = i2c_transfer(client->adapter, &xfer, 1);
> 
> random data will be sent because buf is not DMA mapable ("something" is
> located in the .strtab section within module memory). MXS has a memory
> layout like

DMA buffers must be located in lowmem *always*.  This means placing them
in the .data segment does not work.  USB has been through this already
and it's well known there...
