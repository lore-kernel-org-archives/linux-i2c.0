From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v7 3/4] arm64: dts: sdm845: Add serial console support
Date: Wed, 13 Jun 2018 10:28:26 -0700
Message-ID: <CAD=FV=Uv6t0aqbpFojgg6Y1EGc1VA0aRsPMqhThJEok6PK0P2w@mail.gmail.com>
References: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org> <1528823348-30532-4-git-send-email-kramasub@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528823348-30532-4-git-send-email-kramasub@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, Evan Green <evgreen@chromium.org>, acourbot@chromium.org, Stephen Boyd <swboyd@chromium.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Tue, Jun 12, 2018 at 10:09 AM, Karthikeyan Ramasubramanian
<kramasub@codeaurora.org> wrote:
> From: Rajendra Nayak <rnayak@codeaurora.org>
>
> Add the qup uart node and geni se instance needed to
> support the serial console on the MTP.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 41 +++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 39 +++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)

I've posted <https://patchwork.kernel.org/patch/10462687/> which
already includes these nodes plus ones for other QUP peripherals.
Please feel free to comment on that patch.  A few notes about that
patch compared to this one:

1. Label is uart9, not uart2.  No idea where the 2 came from.

2. No sleep pinconf states.  For SPI they were definitely causing
problems.  When I looked deeper into it it became unclear to me what
the point of all this remuxing is.  Right now you are selecting the
"sleep" state in the geni code for runtime PM but nothing (yet) is
actually power gating the QUPs, so the pinmux isn't doing a whole lot.
Even if you power gate the QUPs there shouldn't be any reason (that
I'm aware of) to remux.

-Doug
