From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/1] i2c: qcom-geni: Provide an option to disable DMA
 processing
Date: Thu, 5 Sep 2019 15:33:45 +0100
Message-ID: <20190905143345.GF26880@dell>
References: <20190905102247.27583-1-lee.jones@linaro.org>
 <20190905134941.GG1157@kunai>
 <3458ed2a-ae49-b46b-3e89-ce039a2749b4@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3458ed2a-ae49-b46b-3e89-ce039a2749b4@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, "alokc@codeaurora.org" <alokc@codeaurora.org>, "agross@kernel.org" <agross@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>, "vkoul@kernel.org" <vkoul@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 05 Sep 2019, Peter Rosin wrote:

> On 2019-09-05 15:49, Wolfram Sang wrote:
> > Hi Lee,
> > 
> > I understand you are in a hurry, but please double check before
> > sending...
> 
> Linus indicated that an rc8 is coming up, which should provide an extra week.
> https://lwn.net/Articles/798152/

That is good news.

> > On Thu, Sep 05, 2019 at 11:22:47AM +0100, Lee Jones wrote:
> >> We have a production-level laptop (Lenovo Yoga C630) which is exhibiting
> >> a rather horrific bug.  When I2C HID devices are being scanned for at
> >> boot-time the QCom Geni based I2C (Serial Engine) attempts to use DMA.
> >> When it does, the laptop reboots and the user never sees the OS.
> >>
> >> The beautiful thing about this approach is that, *if* the Geni SE DMA
> >> ever starts working, we can remove the C code and any old properties
> >> left in older DTs just become NOOP.  Older kernels with newer DTs (less
> >> of a priority) *still* will not work - but they do not work now anyway.
> > 
> > ... becasue this paragraph doesn't fit anymore. Needs to be reworded.

Yes, you're right.  I noticed almost the moment I pressed send. :(

> >> Fixes: 8bc529b25354 ("soc: qcom: geni: Add support for ACPI")
> > 
> > As said in the other thread, I don't get it, but this is not a show
> > stopper for me.

Ah wait.  Yes, this is applied against the wrong patch.

Please ignore.

> WAG: because ACPI made some driver load at all, and when it
> did it something started happening which crashed some machines.

I'm not sure I understand this sentence.

... resending now.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
