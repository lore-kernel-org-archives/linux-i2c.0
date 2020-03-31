From: Akash Asthana <akashast@codeaurora.org>
Subject: Re: [PATCH V2 3/8] soc: qcom-geni-se: Add interconnect support to fix
 earlycon crash
Date: Tue, 31 Mar 2020 16:25:18 +0530
Message-ID: <2d75c2e9-96a7-a503-18a9-f0665bc67973@codeaurora.org>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-4-git-send-email-akashast@codeaurora.org>
 <20200313204441.GJ144492@google.com>
 <1f86fdf0-df7c-4e4a-d4d8-8b0162e52cb4@codeaurora.org>
 <20200317182910.GR144492@google.com>
 <3831b33c-93ee-e5e0-fcfb-530b4738f930@codeaurora.org>
 <20200319194332.GA60149@google.com>
 <a7227a1f-00a1-0818-80f3-904fe264f864@codeaurora.org>
 <CAE=gft6AGkcdUAkoyevZgmtBgaiEkoQzzJcg7sYjbpy5Kh2fyA@mail.gmail.com>
 <20200327232338.GL5063@builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20200327232338.GL5063@builder>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>, Evan Green <evgreen@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Gross <agross@kernel.org>, wsa@the-dreams.de, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>, Manu Gautam <mgautam@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-serial@vger.kernel.org, Doug Anderson <dianders@chromium.org>
List-Id: linux-i2c@vger.kernel.org

Hi Bjorn,

On 3/28/2020 4:53 AM, Bjorn Andersson wrote:
> Note though that the boot console will outlive the real console when the
> kernel is booted with "keep_bootcon" on the command line (something I do
> from time to time).
>
> So rather than relying on "real probe" to signal when we can release the
> earlycon's icc vote I think we should specify dev->con->exit in
> qcom_geni_serial_early

Okay,

Thanks,

Akash

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
