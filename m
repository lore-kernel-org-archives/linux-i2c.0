From: Enrico Scholz <enrico.scholz-wttK6gPy29v+Hn7q9Vec/7NAH6kLmebB@public.gmane.org>
Subject: Re: [i2c-mxs] Broken DMA operations from within a module
Date: Wed, 13 Feb 2013 13:28:41 +0100
Message-ID: <ly8v6sieiu.fsf@ensc-virt.intern.sigma-chemnitz.de>
References: <lyehgkift9.fsf@ensc-virt.intern.sigma-chemnitz.de>
	<20130213121450.GA17833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130213121450.GA17833-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org> (Russell King's
	message of "Wed, 13 Feb 2013 12:14:50 +0000")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> writes:

>>                .buf = "something",
>> ...
>> random data will be sent because buf is not DMA mapable ("something" is
>> located in the .strtab section within module memory). MXS has a memory
>> layout like
>
> DMA buffers must be located in lowmem *always*.  This means placing them
> in the .data segment does not work.  USB has been through this already
> and it's well known there...

Yes; I know about USB and this requirement is explicitly mentioned in
the 'struct urb' documentation.  But I can not find something similar
for i2c_msg and lot of i2c drivers are working with non DMA mapable
buffers.


Enrico
