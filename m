From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: nvmem: new optional property wp-gpios
Date: Wed, 8 Jan 2020 14:54:01 -0600
Message-ID: <20200108205401.GA15674@bogus>
References: <20200107092922.18408-1-ktouil@baylibre.com>
 <20200107092922.18408-2-ktouil@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200107092922.18408-2-ktouil@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: bgolaszewski@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, srinivas.kandagatla@linaro.org, baylibre-upstreaming@groups.io, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linus.walleij@linaro.org, Khouloud Touil <ktouil@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

On Tue,  7 Jan 2020 10:29:18 +0100, Khouloud Touil wrote:
> Several memories have a write-protect pin, that when pulled high, it
> blocks the write operation.
> 
> On some boards, this pin is connected to a GPIO and pulled high by
> default, which forces the user to manually change its state before
> writing.
> 
> Instead of modifying all the memory drivers to check this pin, make
> the NVMEM subsystem check if the write-protect GPIO being passed
> through the nvmem_config or defined in the device tree and pull it
> low whenever writing to the memory.
> 
> Add a new optional property to the device tree binding document, which
> allows to specify the GPIO line to which the write-protect pin is
> connected.
> 
> Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
> ---
>  Documentation/devicetree/bindings/nvmem/nvmem.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
