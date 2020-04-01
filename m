From: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH V3 3/8] soc: qcom-geni-se: Add interconnect support to
 fix earlycon crash
Date: Wed, 1 Apr 2020 12:46:48 -0700
Message-ID: <20200401194648.GM199755@google.com>
References: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
 <1585652976-17481-4-git-send-email-akashast@codeaurora.org>
 <20200331182457.GH199755@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200331182457.GH199755-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 31, 2020 at 11:24:57AM -0700, Matthias Kaehlcke wrote:
> Hi Akash,
> 
> On Tue, Mar 31, 2020 at 04:39:31PM +0530, Akash Asthana wrote:
> > QUP core clock is shared among all the SE drivers present on particular
> > QUP wrapper, the system will reset(unclocked access) if earlycon used after
> > QUP core clock is put to 0 from other SE drivers before real console comes
> > up.
> > 
> > As earlycon can't vote for it's QUP core need, to fix this add ICC
> > support to common/QUP wrapper driver and put vote for QUP core from
> > probe on behalf of earlycon and remove vote during earlycon exit call.
> > 
> > Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > Reported-by: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > ---
> > Change is V3:
> >  - Add geni_remove_earlycon_icc_vote API that will be used by earlycon
> >    exit function to remove ICC vote for earlyconsole.
> >  - Remove suspend/resume hook for geni-se driver as we are no longer
> >    removing earlyconsole ICC vote from system suspend, we are removing
> >    from earlycon exit.
> > 
> >  drivers/soc/qcom/qcom-geni-se.c       | 51 +++++++++++++++++++++++++++++++++++
> >  drivers/tty/serial/qcom_geni_serial.c |  7 +++++
> >  include/linux/qcom-geni-se.h          |  2 ++
> >  3 files changed, 60 insertions(+)
> > 
> > diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> > index 9344c14..d30c282 100644
> > --- a/drivers/soc/qcom/qcom-geni-se.c
> > +++ b/drivers/soc/qcom/qcom-geni-se.c
> > @@ -90,8 +90,11 @@ struct geni_wrapper {
> >  	struct device *dev;
> >  	void __iomem *base;
> >  	struct clk_bulk_data ahb_clks[NUM_AHB_CLKS];
> > +	struct geni_icc_path to_core;
> >  };
> >  
> > +struct geni_wrapper *earlycon_wrapper;
> 
> should be static
> 
> > +
> >  #define QUP_HW_VER_REG			0x4
> >  
> >  /* Common SE registers */
> > @@ -818,6 +821,26 @@ int geni_icc_vote_off(struct geni_se *se)
> >  }
> >  EXPORT_SYMBOL(geni_icc_vote_off);
> >  
> > +void geni_remove_earlycon_icc_vote(void)
> > +{
> > +	struct geni_wrapper *wrapper = earlycon_wrapper;
> > +	struct device_node *parent = of_get_next_parent(wrapper->dev->of_node);
> > +	struct device_node *child;
> > +
> > +	for_each_child_of_node(parent, child) {
> > +		if (of_device_is_compatible(child, "qcom,geni-se-qup")) {
> > +			wrapper = platform_get_drvdata(of_find_device_by_node(
> > +					child));
> > +			icc_put(wrapper->to_core.path);
> > +			wrapper->to_core.path = NULL;
> > +		}
> > +	}
> > +	of_node_put(parent);
> > +
> > +	earlycon_wrapper = NULL;
> > +}
> > +EXPORT_SYMBOL(geni_remove_earlycon_icc_vote);
> 
> I didn't know that consoles have an exit handler, this is way nicer than
> the miscellaneous triggers we discussed earlier :)

No wonder I 'missed' this when looking at the console code for possible
triggers, it is brand new and as of now only exists in -next:

commit ed31685c96e18f773ca11dd1a637974d62130673
Author: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date:   Mon Feb 3 15:31:30 2020 +0200

    console: Introduce ->exit() callback


sharp timing!
