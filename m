From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: i2c: add binding for Socionext
 SynQuacer I2C
Date: Thu, 1 Mar 2018 10:44:56 -0600
Message-ID: <CAL_JsqLXaf0ROpNbdhn1+SQ+P6sF_6FqqAnbnjJ=9+EKzy3gyQ@mail.gmail.com>
References: <20180301163815.30595-1-ard.biesheuvel@linaro.org> <20180301163815.30595-2-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180301163815.30595-2-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Linux I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Jassi Brar <jassisinghbrar@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 1, 2018 at 10:38 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Add a binding for the I2C controller that can be found in the Socionext
> SynQuacer SoC.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-synquacer.txt | 29 ++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
