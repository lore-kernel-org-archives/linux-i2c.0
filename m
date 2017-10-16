From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/4] i2c: Add Qualcomm Camera Control Interface driver
Date: Mon, 16 Oct 2017 15:58:11 -0700
Message-ID: <20171016225811.GR1165@minitux>
References: <1506953613-23875-1-git-send-email-todor.tomov@linaro.org>
 <1506953613-23875-3-git-send-email-todor.tomov@linaro.org>
 <20171006052040.GB1575@tuxbook>
 <1978f9ea-5b9d-fb16-7758-4b263c787b7f@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:54611 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932444AbdJPW6P (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 16 Oct 2017 18:58:15 -0400
Received: by mail-pg0-f51.google.com with SMTP id l24so7945378pgu.11
        for <linux-i2c@vger.kernel.org>; Mon, 16 Oct 2017 15:58:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1978f9ea-5b9d-fb16-7758-4b263c787b7f@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Todor Tomov <todor.tomov@linaro.org>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu 12 Oct 07:47 PDT 2017, Todor Tomov wrote:

> Hi Bjorn,
> 
> Thank you for the review. There are a lot of important suggestions.
> 
> On  6.10.2017 08:20, Bjorn Andersson wrote:
> > On Mon 02 Oct 07:13 PDT 2017, Todor Tomov wrote:
> >> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
> > [..]
> >> +#define NUM_MASTERS 1
> > 
> > So you will only register one of the masters?
> 
> Yes, in this version of the driver - only one. Probably I will extend the driver later
> to support also the second master on 8096.
> 

That's perfectly fine, as long as there's a plan of how to add the
second master that is backwards compatible (DT wise).

[..]
> >> +static const struct resources res_v1_0_8 = {
> >> +	.clock = { "camss_top_ahb",
> >> +		   "cci_ahb",
> >> +		   "camss_ahb",
> >> +		   "cci" },
> > 
> > The code consuming this will read until NULL, so please add terminator.
> 
> The fields which are not explicitely initialized are set to NULL, right?
> I may add a comment that a space in the array for the terminator must be left.
> 

Right, I didn't think of this list being a statically sized array, then
there are implicit NULLs here.

> > It happens to work as the first clock_rate is 0 in both cases.
> 
> I think that it works because it reaches the terminator.
> 

Adding a NULL after the list will make this more obvious and continue to
work as intended.

[..]
> >> +	if (len > cci->adap.quirks->max_read_len)
> >> +		return -EOPNOTSUPP;
> >> +
> > 
> > The core already checks each entry against the max length quirks.
> > 
> > But are these actually the max amount of data you can read in one
> > operation? Generally one has to drain the fifo but the actual transfers
> > can be larger...
> 
> Yes, the maximum data which you can read in one operation. And this is
> the meaning of quirks->max_read_len, right? Not the i2c transfer size.
> So the check is correct but I'll remove it as it is already done in
> i2c_check_for_quirks(), as you have pointed out.
> 

AFAICT you're doing it correct. I just find it surprising that these
limits are so low (in the hardware) - in the qup driver people
complained that the max is 255.

[..]
> >> +	ret = devm_request_irq(dev, cci->irq, cci_isr,
> >> +			       IRQF_TRIGGER_RISING, cci->irq_name, cci);
> >> +	if (ret < 0) {
> >> +		dev_err(dev, "request_irq failed, ret: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	disable_irq(cci->irq);
> > 
> > The time between devm_request_irq() and disable_irq() is still long
> > enough for cci_isr() to be called, before irq_complete is initialized.
> > 
> > Don't request irqs until you're ready to receive the interrupts.
> 
> This makes sense however at this point the clocks to the device are
> still not enabled, doesn't this avoid any problems?
> 

You're probably right, but unless it's too much hassle it's better to
be on the safe side - if nothing else for the times when someone
copy-paste your code for a new driver that doesn't follow this premise.

> > 
> >> +
> >> +	/* Clocks */
> >> +
> >> +	cci->nclocks = 0;
> >> +	while (res->clock[cci->nclocks])
> >> +		cci->nclocks++;
> >> +
> >> +	cci->clock = devm_kzalloc(dev, cci->nclocks *
> >> +				  sizeof(*cci->clock), GFP_KERNEL);
> > 
> > This can max be CCI_RES_MAX (i.e. 6) so just make the array fixed size
> > and skip the kzalloc().
> 
> Does it matter?
> 

At the cost of making the list statically sized in the struct you can
drop this call and error check. But other than that, no.

> > 
> >> +	if (!cci->clock)
> >> +		return -ENOMEM;
> >> +

Regards,
Bjorn
