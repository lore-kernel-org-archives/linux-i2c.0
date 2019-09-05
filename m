From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] i2c: qcom-geni: Provide an option to select FIFO
 processing
Date: Thu, 5 Sep 2019 10:34:44 +0100
Message-ID: <20190905093444.GE26880@dell>
References: <20190904113613.14997-1-lee.jones@linaro.org>
 <20190904203548.GC580@tuxbook-pro>
 <20190904212337.GF23608@ninjato>
 <20190905071103.GX26880@dell>
 <20190905091617.GC1157@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190905091617.GC1157@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, alokc@codeaurora.org, agross@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 05 Sep 2019, Wolfram Sang wrote:
> > > It looks like a workaround to me. It would be interesting to hear which
> > > I2C client breaks with DMA and if it's driver can't be fixed somehow
> > > instead. But even if we agree on a workaround short term, adding a
> 
> So, are there investigations running why this reboot happens?

Yes, but they have been running for months, literally.

Unfortunately, since these are production level platforms, all of the
usual low-level debugging avenues (JTAG) have been closed off.  Also,
only a very small number of people have access to documentation, but
even those who are in possession are stumped.

Andy Gross did have one idea as to what might be happening, but it
turned out to be a red herring.

> > > Is there no other way to disable DMA which is local to this driver so we
> > > can easily revert the workaround later?
> > 
> > This is the most local low-impact solution (nomenclature aside).
> 
> I disagree. You could use of_machine_is_compatible() and disable DMA for
> that machine. Less impact because we save the workaround binding.

That could also work.

> > The beautiful thing about this approach is that, *if* the Geni SE DMA
> 
> I'd say 'advantage' instead of 'beautiful' ;)

Okay, "the advantage thing about ..." ;)

> > ever starts working, we can remove the C code and any old properties
> > left in older DTs just become NOOP.  Older kernels with newer DTs
> > (less of a priority) *still* won't work, but they don't work now
> > anyway.
> 
> Which is a clear disadvantage of that solution. It won't fix older
> kernels. My suggestion above should fix them, too.

Not sure how this is possible.  Unless you mean LTS?

> > The offending line can be found at [0].  There is no obvious bug to
> > fix and this code obviously works well on some of the hardware
> > platforms using it.  But on our platform (Lenovo Yoga C630 - QCom
> > SMD850) that final command, which initiates the DMA transaction, ends
> > up rebooting the machine.
> 
> Unless we know why the reboot happens on your platform, I'd be careful
> with saying "work obviously well" on other platforms.

Someone must have tested it?  Surely ... ;)

> > With regards to the nomenclature, my original suggestion was
> > 'qcom,geni-se-no-dma'.  Would that better suit your request?
> 
> My suggestion:
> 
> For 5.3, use of_machine_is_compatible() and we backport that. For later,
> try to find out the root cause and fix it. If that can't be done, try to
> set up a generic "disable-dma" property and use it.
> 
> What do you think about that?

Sounds okay to me.  Let me code that up.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
