From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH v3 2/2] i2c: New bus driver for the Qualcomm QUP I2C controller
Date: Tue, 25 Feb 2014 08:07:13 -0800
Message-ID: <CAJAp7OhGkr04smJv3iizBBjz7k4Oik=uxUdC_JD2+0D6VDSybg@mail.gmail.com>
References: <1392943090-30556-1-git-send-email-bjorn.andersson@sonymobile.com>
	<1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
	<20140221110637.GG7541@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140221110637.GG7541@e106331-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Wolfram Sang <wsa@the-dreams.de>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, "Ivan T. Ivanov" <iivanov@mm-sol.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 21, 2014 at 3:06 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Feb 21, 2014 at 12:38:10AM +0000, Bjorn Andersson wrote:
[...]
>
>> +static const struct of_device_id qup_i2c_dt_match[] = {
>> +       { .compatible = "qcom,i2c-qup-v1.1.1" },
>> +       { .compatible = "qcom,i2c-qup-v2.1.1" },
>> +       { .compatible = "qcom,i2c-qup-v2.2.1" },
>
> The all seem to be handled the same.
>
> Are they all compatible with the "qcom,i2c-qup-v1.1.1" programming
> model, such that it could be used as a fallback in the compatible list
> (and the driver would only need to look for it for now)?

The v2 model will get BAM (DMAEngine) support soon, v1 uses an
older DMA core. So there's a difference. I'm not aware what differences
there are between 2.1.1 and 2.2.1.

Question is if next change will be called v3, as we then could skip the
reset of the version.

We could probably skip 2.1.1 as that's supposed to be the first revision
of 8x74, with all the expected HW quirks...I.e. not sure if anyone should
use that.

Regards,
Bjorn
