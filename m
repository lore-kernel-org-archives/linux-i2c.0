From: Andy Gross <agross@codeaurora.org>
Subject: Re: [PATCH v3 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
Date: Tue, 25 Feb 2014 10:56:07 -0600
Message-ID: <20140225165607.GA5723@qualcomm.com>
References: <1392943090-30556-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
 <20140221110637.GG7541@e106331-lin.cambridge.arm.com>
 <CAJAp7OhGkr04smJv3iizBBjz7k4Oik=uxUdC_JD2+0D6VDSybg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJAp7OhGkr04smJv3iizBBjz7k4Oik=uxUdC_JD2+0D6VDSybg@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Bjorn Andersson <bjorn@kryo.se>
Cc: Mark Rutland <mark.rutland@arm.com>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Wolfram Sang <wsa@the-dreams.de>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, "Ivan T. Ivanov" <iivanov@mm-sol.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 25, 2014 at 08:07:13AM -0800, Bjorn Andersson wrote:

[snip]

> The v2 model will get BAM (DMAEngine) support soon, v1 uses an
> older DMA core. So there's a difference. I'm not aware what differences
> there are between 2.1.1 and 2.2.1.

Difference between 2.1.1 and 2.2.1:
 - high speed support, up to 3.4MHz
 - reconfiguration during run state
 - READ_AND_NACK, STOP tag support
 - some h/w bug fixes that don't involve software changes.

 
> Question is if next change will be called v3, as we then could skip the
> reset of the version.

Next version is 2.4.

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
