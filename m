From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH 2/2] i2c: New bus driver for the QUP I2C controller
Date: Wed, 11 Sep 2013 10:46:35 +0300
Message-ID: <1378885595.960.54.camel@iivanov-dev.int.mm-sol.com>
References: <1377782873-31931-1-git-send-email-iivanov@mm-sol.com>
	 <1377782873-31931-2-git-send-email-iivanov@mm-sol.com>
	 <20130910134650.GO808@joshc.qualcomm.com>
	 <1378825856.960.47.camel@iivanov-dev.int.mm-sol.com>
	 <20130910153612.GQ808@joshc.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20130910153612.GQ808@joshc.qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Josh Cartwright <joshc@codeaurora.org>
Cc: wsa@the-dreams.de, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, grant.likely@linaro.org, gavidov@codeaurora.org, sdharia@codeaurora.org, alokc@codeaurora.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel, linux-arm-msm@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi, 

On Tue, 2013-09-10 at 10:36 -0500, Josh Cartwright wrote: 
> On Tue, Sep 10, 2013 at 06:10:56PM +0300, Ivan T. Ivanov wrote:
> > On Tue, 2013-09-10 at 08:46 -0500, Josh Cartwright wrote: 
> > > Hey Ivan-
> > > 
> > > Some nits below.
> > > 
> > > On Thu, Aug 29, 2013 at 04:27:53PM +0300, Ivan T. Ivanov wrote:
> [..]
> > > > +static int qup_i2c_probe(struct platform_device *pdev)
> > > > +{
> > > [..]
> > > > +
> > > > +	ret = devm_request_irq(qup->dev, qup->irq, qup_i2c_interrupt,
> > > > +			       IRQF_TRIGGER_HIGH, "i2c_qup", qup);
> > > > +	if (ret) {
> > > > +		dev_err(qup->dev, "Request %d IRQ failed\n", qup->irq);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	disable_irq(qup->irq);
> > > 
> > > How is this not racy, in the case where a pending interrupt is left from
> > > the bootloader (which seems to be possible based on the comments below)?
> > 
> > Yes it looks weird. Interrupt handler will check and exit if there
> > is no message for transfer. I am looking for better way to handle this.
> 
> Below in probe() it looks like a controller reset is issued.  I'm
> wondering if the best way to fix this is to move that up so it happens
> sooner (so we can assume here that the controller is in a
> non-interrupting state).

Thanks, sound reasonable.

Ivan
