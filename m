From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v7 4/4] arm64: dts: sdm845: Add support for an instance of
 I2C controller
Date: Wed, 13 Jun 2018 10:30:35 -0700
Message-ID: <CAD=FV=W05DBCbL9h_40wUJsgjaAxjDbWMp+BUNCkV+GH1JASwQ@mail.gmail.com>
References: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org> <1528823348-30532-5-git-send-email-kramasub@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528823348-30532-5-git-send-email-kramasub@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, Evan Green <evgreen@chromium.org>, acourbot@chromium.org, Stephen Boyd <swboyd@chromium.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Tue, Jun 12, 2018 at 10:09 AM, Karthikeyan Ramasubramanian
<kramasub@codeaurora.org> wrote:
> Add one instance of GENI based I2C master controller to enable testing
> I2C driver using EEPROM slave.
>
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 19 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 28 ++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)

Similar for to patch #3 in this series, let's move the discussion to
<https://patchwork.kernel.org/patch/10462687/> and
<https://patchwork.kernel.org/patch/10462683/>.

-Doug
