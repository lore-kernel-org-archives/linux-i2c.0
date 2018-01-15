From: Radu Rendec <radu.rendec@gmail.com>
Subject: Re: [1/2] i2c: ismt: 16-byte align the DMA buffer address
Date: Mon, 15 Jan 2018 12:33:20 +0000
Message-ID: <1516019600.11739.3.camel@gmail.com>
References: <20170818160128.21228-2-radu.rendec@gmail.com>
         <20180104134606.GB919@hmswarspite.think-freely.org>
         <1515080529.3062.26.camel@gmail.com>
         <20180104162207.GD919@hmswarspite.think-freely.org>
         <1515085276.3062.37.camel@gmail.com>
         <20180105014727.GA18052@neilslaptop.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:46275 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753291AbeAOMda (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 15 Jan 2018 07:33:30 -0500
Received: by mail-wm0-f47.google.com with SMTP id 143so1554754wma.5
        for <linux-i2c@vger.kernel.org>; Mon, 15 Jan 2018 04:33:30 -0800 (PST)
In-Reply-To: <20180105014727.GA18052@neilslaptop.think-freely.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linux-i2c@vger.kernel.org

On Thu, 2018-01-04 at 20:47 -0500, Neil Horman wrote:
> On Thu, Jan 04, 2018 at 05:01:16PM +0000, Radu Rendec wrote:
> > On Thu, 2018-01-04 at 11:22 -0500, Neil Horman wrote:
> > > On Thu, Jan 04, 2018 at 03:42:09PM +0000, Radu Rendec wrote:
> > > > I believe the aligned() attribute cannot be used here because the whole
> > > > ismt_priv structure is dynamically allocated (the allocation is done at
> > > > the beginning of the ismt_probe() function).
> > > > 
> > > > Even with a statically allocated structure, aligning the whole
> > > > structure does not guarantee the alignment of the dma_buffer field,
> > > > because the field offset within the structure can change (e.g. if other
> > > > fields are added, removed, moved around etc.).
> > > 
> > > For reference, you can do it like this:
> > > 
> > > #include <stdlib.h>
> > > #include <stdio.h>
> > > 
> > > 
> > > struct buffer_type { char b[3]; };
> > > struct ubuffer_type { char b[3]; } __attribute__((aligned(16)));
> > > 
> > > struct s1 {
> > >         char foo;
> > >         struct buffer_type bar;
> > > };
> > > 
> > > struct s2 {
> > >         char foo;
> > >         struct ubuffer_type bar;
> > > };
> > > 
> > > int main(int argc, char **argv)
> > > {
> > >         struct s1 *p1;
> > >         struct s2 *p2;
> > > 
> > >         p1 = malloc(sizeof(struct s1));
> > >         p2 = malloc(sizeof(struct s2));
> > > 
> > >         printf("addr of p1->bar = %p\n", &p1->bar);
> > >         printf("addr of p2->bar = %p\n", &p2->bar);
> > > 
> > >         free(p1);
> > >         free(p2);
> > > 
> > >         return 0;
> > > }
> > 
> > Hmm... I just tried this on my workstation (x86, 32bit):
> > 
> > [rrendec@rrendec ~]$ gcc -o align align.c
> > [rrendec@rrendec ~]$ ./align 
> > addr of p1->bar = 0x9358009
> > addr of p2->bar = 0x9358028
> > [rrendec@rrendec ~]$ ./align 
> > addr of p1->bar = 0x856b009
> > addr of p2->bar = 0x856b028
> > 
> > The most significant 4 digits are always different (probably due to
> > address randomization), but the least significant 3 are consistently
> > 0x009 and 0x028, neither of which is 16 byte aligned.
> > 
> > But I think this is normal, because malloc() gets just a size parameter
> > and has no knowledge of the intended data type of the memory area that
> > it allocates. It's probably the same with kmalloc() and friends.
> > 
> 
> Yeah, I was under the impression that malloc provided memory in blocks aligned
> to a maximum arch specific alignment, and then gcc could just pad the struct
> size to guarantee a more granular alignment, but on doing some more reading,
> alignment support only applies to bss and data storage, at least for the gcc
> linker.  PTR_ALIGN is the way to go here.
> 
> > > Though as I look at that, you're probably right, using PTR_ALIGN would probably
> > > be prettier.  I'd be ok with that approach
> > 

Glad that we sorted this out.

> > That's great. I'll prepare an updated patch with PTR_ALIGN and post it
> > shortly.
> > 
> 
> Thanks!

I sent the updated patch with PTR_ALIGN on Jan/4. Have you had a chance
to look at it? Is there anything that can be further improved?

Thanks,
Radu
