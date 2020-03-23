From: Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH v5 1/3] i2c: Add Qualcomm CCI I2C driver
Date: Mon, 23 Mar 2020 13:08:49 +0100
Message-ID: <CAMZdPi9U5Ls7dRQfxWsaZJtYpKGXUsPEpCvWbDz_LQUSKPDp1Q@mail.gmail.com>
References: <1583770998-25449-1-git-send-email-loic.poulain@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1583770998-25449-1-git-send-email-loic.poulain@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: Vinod Koul <vkoul@kernel.org>, Robert Foss <robert.foss@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-i2c@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Todor Tomov <todor.tomov@linaro.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, 9 Mar 2020 at 17:19, Loic Poulain <loic.poulain@linaro.org> wrote:
>
> This commit adds I2C bus support for the Camera Control Interface
> (CCI) I2C controller found on the Qualcomm SoC processors. This I2C
> controller supports two masters and they are registered to the core.
>
> CCI versions supported in the driver are msm8916, msm8996 and sdm845.
>
> This is a rework of the patch posted by Vinod:
> https://patchwork.kernel.org/patch/10569961/
>
> With additional fixes + most of the comments addressed.
>
> Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Tested-by: Robert Foss <robert.foss@linaro.org>

Is there anything more I can do on my side to help you review this?

Regards,
Loic
