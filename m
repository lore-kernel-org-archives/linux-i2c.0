From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [1/2] i2c: ismt: 16-byte align the DMA buffer address
Date: Thu, 4 Jan 2018 11:22:07 -0500
Message-ID: <20180104162207.GD919@hmswarspite.think-freely.org>
References: <20170818160128.21228-2-radu.rendec@gmail.com>
 <20180104134606.GB919@hmswarspite.think-freely.org>
 <1515080529.3062.26.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58]:56441 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752344AbeADQWn (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 4 Jan 2018 11:22:43 -0500
Content-Disposition: inline
In-Reply-To: <1515080529.3062.26.camel@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Radu Rendec <radu.rendec@gmail.com>
Cc: linux-i2c@vger.kernel.org

On Thu, Jan 04, 2018 at 03:42:09PM +0000, Radu Rendec wrote:
> On Thu, 2018-01-04 at 08:46 -0500, Neil Horman wrote:
> > On Fri, Aug 18, 2017 at 05:01:27PM +0100, Radu Rendec wrote:
> > > Use only a portion of the data buffer for DMA transfers, which is always
> > > 16-byte aligned. This makes the DMA buffer address 16-byte aligned and
> > > compensates for spurious hardware parity errors that may appear when the
> > > DMA buffer address is not 16-byte aligned.
> > > 
> > > The data buffer is enlarged in order to accommodate any possible 16-byte
> > > alignment offset and changes the DMA code to only use a portion of the
> > > data buffer, which is 16-byte aligned.
> > > 
> > > The symptom of the hardware issue is the same as the one addressed in
> > > v3.12-rc2-5-gbf41691 and manifests by transfers failing with EIO, with
> > > bit 9 being set in the ERRSTS register.
> > > 
> > > Signed-off-by: Radu Rendec <radu.rendec@gmail.com>
> > 
> > Why not just use the alligned attribute here for buffer? 
> > 
> > https://gcc.gnu.org/onlinedocs/gcc-3.3/gcc/Type-Attributes.html
> > 
> > That would save you over allocation when possible and keep you from needing to
> > create a private aligned variable.
> 
> First of all, thanks for reviewing this!
> 
No problem!

> I believe the aligned() attribute cannot be used here because the whole
> ismt_priv structure is dynamically allocated (the allocation is done at
> the beginning of the ismt_probe() function).
> 
> Even with a statically allocated structure, aligning the whole
> structure does not guarantee the alignment of the dma_buffer field,
> because the field offset within the structure can change (e.g. if other
> fields are added, removed, moved around etc.).
> 
> On the other hand, I realized I could have used the PTR_ALIGN macro to
> calculate the aligned address. That would probably make the code less
> ugly and more intuitive. So I would at least resubmit the patch using
> PTR_ALIGN instead of ALIGN and explicit casts - if you agree to the
> current solution, of course.
> 
> Thanks,
> Radu
> 
> 

For reference, you can do it like this:

#include <stdlib.h>
#include <stdio.h>


struct buffer_type { char b[3]; };
struct ubuffer_type { char b[3]; } __attribute__((aligned(16)));

struct s1 {
        char foo;
        struct buffer_type bar;
};

struct s2 {
        char foo;
        struct ubuffer_type bar;
};

int main(int argc, char **argv)
{
        struct s1 *p1;
        struct s2 *p2;

        p1 = malloc(sizeof(struct s1));
        p2 = malloc(sizeof(struct s2));

        printf("addr of p1->bar = %p\n", &p1->bar);
        printf("addr of p2->bar = %p\n", &p2->bar);

        free(p1);
        free(p2);

        return 0;
}



Though as I look at that, you're probably right, using PTR_ALIGN would probably
be prettier.  I'd be ok with that approach

Best
Neil
