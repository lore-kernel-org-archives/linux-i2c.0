From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 1/3] i2c: Add Qualcomm CCI I2C driver
Date: Tue, 18 Feb 2020 09:57:55 +0530
Message-ID: <20200218042755.GZ2618@vkoul-mobl>
References: <1577784397-28682-1-git-send-email-loic.poulain@linaro.org>
 <CAMZdPi_CYWgCjCLW3TCCAPFnbmn3LYGrzrah+p-_+xZkYbmTPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgBRE2A (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 17 Feb 2020 23:28:00 -0500
Content-Disposition: inline
In-Reply-To: <CAMZdPi_CYWgCjCLW3TCCAPFnbmn3LYGrzrah+p-_+xZkYbmTPQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, Loic Poulain <loic.poulain@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, todor.too@gmail.com, linux-i2c@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Todor Tomov <todor.tomov@linaro.org>

Hi Wolfram,

On 24-01-20, 09:13, Loic Poulain wrote:
> On Tue, 31 Dec 2019 at 10:23, Loic Poulain <loic.poulain@linaro.org> wrote:
> >
> > This commit adds I2C bus support for the Camera Control Interface
> > (CCI) I2C controller found on the Qualcomm SoC processors. This I2C
> > controller supports two masters and they are registered to the core.
> >
> > CCI versions supported in the driver are MSM8916 and MSM8996.
> >
> > This is a rework of the patch posted by Vinod:
> > https://patchwork.kernel.org/patch/10569961/
> >
> > With additional fixes + most of the comments addressed.
> >
> > Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > ---
> >  v2: Remove clock rates config from driver (done via assigned clock)
> >      Added CCI timeout recovery from Ricardo's patch:
> >         https://www.spinics.net/lists/linux-i2c/msg36973.html
> 
> Any feedback on this series?

Can you please take some time and review the series and provide feedback
to Loic, this series has been pending for a long time now

Thanks
-- 
~Vinod
