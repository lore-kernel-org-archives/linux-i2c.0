From: Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: New bus driver for the QUP I2C controller
Date: Tue, 10 Sep 2013 10:36:12 -0500
Message-ID: <20130910153612.GQ808@joshc.qualcomm.com>
References: <1377782873-31931-1-git-send-email-iivanov@mm-sol.com>
 <1377782873-31931-2-git-send-email-iivanov@mm-sol.com>
 <20130910134650.GO808@joshc.qualcomm.com>
 <1378825856.960.47.camel@iivanov-dev.int.mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1378825856.960.47.camel-yvhxILDKWb8ylMT5ByZ5bDRGLm/uyL/D0E9HWUfgJXw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gavidov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TZUIDd8j+nm9g@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 10, 2013 at 06:10:56PM +0300, Ivan T. Ivanov wrote:
> On Tue, 2013-09-10 at 08:46 -0500, Josh Cartwright wrote: 
> > Hey Ivan-
> > 
> > Some nits below.
> > 
> > On Thu, Aug 29, 2013 at 04:27:53PM +0300, Ivan T. Ivanov wrote:
[..]
> > > +static int qup_i2c_probe(struct platform_device *pdev)
> > > +{
> > [..]
> > > +
> > > +	ret = devm_request_irq(qup->dev, qup->irq, qup_i2c_interrupt,
> > > +			       IRQF_TRIGGER_HIGH, "i2c_qup", qup);
> > > +	if (ret) {
> > > +		dev_err(qup->dev, "Request %d IRQ failed\n", qup->irq);
> > > +		return ret;
> > > +	}
> > > +
> > > +	disable_irq(qup->irq);
> > 
> > How is this not racy, in the case where a pending interrupt is left from
> > the bootloader (which seems to be possible based on the comments below)?
> 
> Yes it looks weird. Interrupt handler will check and exit if there
> is no message for transfer. I am looking for better way to handle this.

Below in probe() it looks like a controller reset is issued.  I'm
wondering if the best way to fix this is to move that up so it happens
sooner (so we can assume here that the controller is in a
non-interrupting state).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
