From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: Provide option to disable DMA
Date: Thu, 5 Sep 2019 09:04:34 +0100
Message-ID: <CAL_JsqKB1hyJKM6S9cbNptq9kysa4_mgxaby7WmQHMW6d8KX3w@mail.gmail.com>
References: <20190905075213.13260-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190905075213.13260-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Alok Chauhan <alokc@codeaurora.org>, Andy Gross <agross@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Linux I2C <linux-i2c@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Vinod <vkoul@kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 5, 2019 at 8:52 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Used when DMA is not available or the best option.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 1 +
>  1 file changed, 1 insertion(+)

If it was me, I'd just turn off DMA. DMA for typical I2C usage seems
kind of pointless. However:

Acked-by: Rob Herring <robh@kernel.org>
