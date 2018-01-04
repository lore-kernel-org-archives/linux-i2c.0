From: Radu Rendec <radu.rendec@gmail.com>
Subject: Re: [1/2] i2c: ismt: 16-byte align the DMA buffer address
Date: Thu, 04 Jan 2018 15:42:09 +0000
Message-ID: <1515080529.3062.26.camel@gmail.com>
References: <20170818160128.21228-2-radu.rendec@gmail.com>
         <20180104134606.GB919@hmswarspite.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40063 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbeADPmO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 4 Jan 2018 10:42:14 -0500
Received: by mail-wm0-f67.google.com with SMTP id f206so4122883wmf.5
        for <linux-i2c@vger.kernel.org>; Thu, 04 Jan 2018 07:42:13 -0800 (PST)
In-Reply-To: <20180104134606.GB919@hmswarspite.think-freely.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linux-i2c@vger.kernel.org

On Thu, 2018-01-04 at 08:46 -0500, Neil Horman wrote:
> On Fri, Aug 18, 2017 at 05:01:27PM +0100, Radu Rendec wrote:
> > Use only a portion of the data buffer for DMA transfers, which is always
> > 16-byte aligned. This makes the DMA buffer address 16-byte aligned and
> > compensates for spurious hardware parity errors that may appear when the
> > DMA buffer address is not 16-byte aligned.
> > 
> > The data buffer is enlarged in order to accommodate any possible 16-byte
> > alignment offset and changes the DMA code to only use a portion of the
> > data buffer, which is 16-byte aligned.
> > 
> > The symptom of the hardware issue is the same as the one addressed in
> > v3.12-rc2-5-gbf41691 and manifests by transfers failing with EIO, with
> > bit 9 being set in the ERRSTS register.
> > 
> > Signed-off-by: Radu Rendec <radu.rendec@gmail.com>
> 
> Why not just use the alligned attribute here for buffer? 
> 
> https://gcc.gnu.org/onlinedocs/gcc-3.3/gcc/Type-Attributes.html
> 
> That would save you over allocation when possible and keep you from needing to
> create a private aligned variable.

First of all, thanks for reviewing this!

I believe the aligned() attribute cannot be used here because the whole
ismt_priv structure is dynamically allocated (the allocation is done at
the beginning of the ismt_probe() function).

Even with a statically allocated structure, aligning the whole
structure does not guarantee the alignment of the dma_buffer field,
because the field offset within the structure can change (e.g. if other
fields are added, removed, moved around etc.).

On the other hand, I realized I could have used the PTR_ALIGN macro to
calculate the aligned address. That would probably make the code less
ugly and more intuitive. So I would at least resubmit the patch using
PTR_ALIGN instead of ALIGN and explicit casts - if you agree to the
current solution, of course.

Thanks,
Radu
