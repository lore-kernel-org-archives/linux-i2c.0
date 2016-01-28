From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V7 0/6] i2c: qup: Add support for v2 tags and bam dma
Date: Thu, 28 Jan 2016 10:57:51 +0530
Message-ID: <001d01d1598c$a6dc1630$f4944290$@codeaurora.org>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org> <000101d152a2$23bb1da0$6b3158e0$@codeaurora.org> <20160124113318.GB1775@katana>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160124113318.GB1775@katana>
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Wolfram Sang' <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, agross@codeaurora.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, galak@codeaurora.org, andy.gross@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces@lists.infradead.org] On Behalf Of Wolfram Sang
> Sent: Sunday, January 24, 2016 5:03 PM
> To: Sricharan
> Cc: devicetree@vger.kernel.org; architt@codeaurora.org; linux-arm-
> msm@vger.kernel.org; ntelkar@codeaurora.org; agross@codeaurora.org;
> linux-kernel@vger.kernel.org; dmaengine@vger.kernel.org; linux-
> i2c@vger.kernel.org; iivanov@mm-sol.com; galak@codeaurora.org;
> andy.gross@linaro.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH V7 0/6] i2c: qup: Add support for v2 tags and bam dma
> 
> > > Sricharan R (6):
> > >   i2c: qup: Change qup_wait_writeready function to use for all
timeouts
> > >   i2c: qup: Add V2 tags support
> > >   i2c: qup: Transfer each i2c_msg in i2c_msgs without a stop bit
> > >   i2c: qup: Add bam dma capabilities
> > >   dts: msm8974: Add blsp2_bam dma node
> > >   dts: msm8974: Add dma channels for blsp2_i2c1 node
> > >
> >  Wolfram,  Does the first 4 patches looks good to be picked up  ?
> 
> Except for patch 3 (I replied seperately), the rest looks okay to me. I
> wondered a little if it would make sense to make a new driver for v2 +
DMA,
> because the additions were quite massive. But I'll leave it up to you if
there is
> enough shared code between the two versions, so that a single driver will
be
> better.
     Hmm,  addition of V2 reused code, more than 50% addition of new loc in
this series, lot of it from DMA,
     but at this point it feels ok to have it in a single driver. 

Regards,
 Sricharan
