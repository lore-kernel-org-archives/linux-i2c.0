From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V7 5/6] dts: msm8974: Add blsp2_bam dma node
Date: Mon, 28 Mar 2016 18:29:32 +0530
Message-ID: <000d01d188f1$b150e660$13f2b320$@codeaurora.org>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org> <1453197766-18976-6-git-send-email-sricharan@codeaurora.org> <CAJAp7Oi33=kraAiU337JdFJZbuKZEVoCtY4FfAv_RgiWVmz+sw@mail.gmail.com> <20160326022612.GA3764@hector.attlocal.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50587 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbcC1M7n (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 28 Mar 2016 08:59:43 -0400
In-Reply-To: <20160326022612.GA3764@hector.attlocal.net>
Content-Language: en-us
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: 'Andy Gross' <andy.gross@linaro.org>, 'Bjorn Andersson' <bjorn@kryo.se>
Cc: devicetree@vger.kernel.org, 'Archit Taneja' <architt@codeaurora.org>, 'Wolfram Sang' <wsa@the-dreams.de>, 'linux-arm-msm' <linux-arm-msm@vger.kernel.org>, ntelkar@codeaurora.org, 'Kumar Gala' <galak@codeaurora.org>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, "'Ivan T. Ivanov'" <iivanov@mm-sol.com>, 'Andy Gross' <agross@codeaurora.org>, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> On Fri, Mar 25, 2016 at 04:17:30PM -0700, Bjorn Andersson wrote:
> > On Tue, Jan 19, 2016 at 2:02 AM, Sricharan R <sricharan@codeaurora.org>
> wrote:
> > > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > > Reviewed-by: Andy Gross <andy.gross@linaro.org>
> 
> <snip>
> 
> > > +               blsp2_dma: dma-controller@f9944000 {
> > > +                       compatible = "qcom,bam-v1.4.0";
> > > +                       reg = <0xf9944000 0x19000>;
> > > +                       interrupts = <GIC_SPI 239
IRQ_TYPE_LEVEL_HIGH>;
> > > +                       clocks = <&gcc GCC_BLSP2_AHB_CLK>;
> > > +                       clock-names = "bam_clk";
> > > +                       #dma-cells = <1>;
> > > +                       qcom,ee = <0>;
> >
> > Without "qcom,bam_ctrl_remote;" and
> > https://patchwork.kernel.org/patch/8639181/ the Xperia Honami board
> > fails to boot with this patch included.
> 
> Ouch.  At least one set of pipes must be used by some other processor and
> TZ has locked down that BLSP.

 Hmm, this was not the case atleast on the apq8074DB board that I tested
this on.

Regards,
 Sricharan
