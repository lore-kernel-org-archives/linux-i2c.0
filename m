From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH V3 2/8] soc: qcom: geni: Support for ICC voting
Date: Wed, 1 Apr 2020 09:26:15 -0700
Message-ID: <CAE=gft6B2UCBVaKVCJXED8waFWci8WJ+sTM3CT+3e_eYS=-BDQ@mail.gmail.com>
References: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
 <1585652976-17481-3-git-send-email-akashast@codeaurora.org> <20200331233209.GF254911@minitux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20200331233209.GF254911@minitux>
Sender: linux-serial-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Akash Asthana <akashast@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Gross <agross@kernel.org>, wsa@the-dreams.de, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>, Manu Gautam <mgautam@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-serial@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>, Doug Anderson <dianders@chromium.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 31, 2020 at 4:32 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 31 Mar 04:09 PDT 2020, Akash Asthana wrote:
>
> > Add necessary macros and structure variables to support ICC BW
> > voting from individual SE drivers.
> >
> > Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> > ---
> > Changes in V2:
> >  - As per Bjorn's comment dropped enums for ICC paths, given the three
> >    paths individual members
> >
> > Changes in V3:
> >  - Add geni_icc_get, geni_icc_vote_on and geni_icc_vote_off as helper API.
> >  - Add geni_icc_path structure in common header
> >
> >  drivers/soc/qcom/qcom-geni-se.c | 98 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/qcom-geni-se.h    | 36 +++++++++++++++
> >  2 files changed, 134 insertions(+)
> >
> > diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> > index 7d622ea..9344c14 100644
> > --- a/drivers/soc/qcom/qcom-geni-se.c
> > +++ b/drivers/soc/qcom/qcom-geni-se.c
> > @@ -720,6 +720,104 @@ void geni_se_rx_dma_unprep(struct geni_se *se, dma_addr_t iova, size_t len)
> >  }
> >  EXPORT_SYMBOL(geni_se_rx_dma_unprep);
> >
> > +int geni_icc_get(struct geni_se *se, const char *icc_core, const char *icc_cpu,
> > +             const char *icc_ddr)
> > +{
> > +     if (icc_core) {
>
> Afaict it's only this that might be passed as NULL, so please drop these
> conditionals (keep the last one).
>
> > +             se->to_core.path = devm_of_icc_get(se->dev, "qup-core");
> > +             if (IS_ERR(se->to_core.path))
>
> It would be useful to print an error message here (if PTR_ERR(path) !=
> -EPROBE_DEFER).
>
> > +                     return PTR_ERR(se->to_core.path);
> > +     }
> > +
> > +     if (icc_cpu) {
> > +             se->from_cpu.path = devm_of_icc_get(se->dev, "qup-config");
> > +             if (IS_ERR(se->from_cpu.path))
> > +                     return PTR_ERR(se->from_cpu.path);
> > +     }
> > +
> > +     if (icc_ddr) {
> > +             se->to_ddr.path = devm_of_icc_get(se->dev, "qup-memory");
> > +             if (IS_ERR(se->to_ddr.path))
> > +                     return PTR_ERR(se->to_ddr.path);
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(geni_icc_get);
> > +
> > +int geni_icc_vote_on(struct geni_se *se)
> > +{
> > +     int ret;
> > +
> > +     if (se->to_core.path) {
>
> icc_set_bw(NULL, ...) is valid and will return 0, so these checks
> doesn't add any value.
>
> > +             ret = icc_set_bw(se->to_core.path, se->to_core.avg_bw,
> > +                     se->to_core.peak_bw);
> > +             if (ret) {
> > +                     dev_err_ratelimited(se->dev, "%s: ICC BW voting failed for core\n",
> > +                                             __func__);
>
> Please drop the __func__, the message is specific enough.
>
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     if (se->from_cpu.path) {
> > +             ret = icc_set_bw(se->from_cpu.path, se->from_cpu.avg_bw,
> > +                     se->from_cpu.peak_bw);
> > +             if (ret) {
> > +                     dev_err_ratelimited(se->dev, "%s: ICC BW voting failed for cpu\n",
> > +                                             __func__);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     if (se->to_ddr.path) {
> > +             ret = icc_set_bw(se->to_ddr.path, se->to_ddr.avg_bw,
> > +                     se->to_ddr.peak_bw);
> > +             if (ret) {
> > +                     dev_err_ratelimited(se->dev, "%s: ICC BW voting failed for ddr\n",
> > +                                             __func__);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(geni_icc_vote_on);
> > +
> > +int geni_icc_vote_off(struct geni_se *se)
> > +{
> > +     int ret;
> > +
> > +     if (se->to_core.path) {
> > +             ret = icc_set_bw(se->to_core.path, 0, 0);
> > +             if (ret) {
> > +                     dev_err_ratelimited(se->dev, "%s: ICC BW remove failed for core\n",
> > +                                             __func__);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     if (se->from_cpu.path) {
> > +             ret = icc_set_bw(se->from_cpu.path, 0, 0);
> > +             if (ret) {
> > +                     dev_err_ratelimited(se->dev, "%s: ICC BW remove failed for cpu\n",
> > +                                             __func__);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     if (se->to_ddr.path) {
> > +             ret = icc_set_bw(se->to_ddr.path, 0, 0);
> > +             if (ret) {
> > +                     dev_err_ratelimited(se->dev, "%s: ICC BW remove failed for ddr\n",
> > +                                             __func__);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(geni_icc_vote_off);
>
> Given that these two functions only switch the bandwidth request between
> some value and 0, I really think we should carry a "bool enabled" on the
> path and replace these two functions with
> icc_bulk_enable()/icc_bulk_disable().
>
> The added benefit of this would be that you call icc_set_bw() instead of
> changing the geni_icc_path->{avg_bw,peak_bw} and don't need to keep
> track of them here.

Yes yes! I had the same thought here [1].

Georgi, what do you think?
-Evan

[1] https://lore.kernel.org/linux-arm-msm/CAE=gft58QsgTCUHMHKJhcM9ZxAeMiY16CrbNv2HaTCRqwtmt7A@mail.gmail.com/
