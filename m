From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 4/5] dt-bindings: at25: add reference for the wp-gpios
 property
Date: Wed, 8 Jan 2020 14:54:47 -0600
Message-ID: <20200108205447.GA16981@bogus>
References: <20200107092922.18408-1-ktouil@baylibre.com>
 <20200107092922.18408-5-ktouil@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200107092922.18408-5-ktouil@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: bgolaszewski@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, srinivas.kandagatla@linaro.org, baylibre-upstreaming@groups.io, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linus.walleij@linaro.org, Khouloud Touil <ktouil@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

On Tue,  7 Jan 2020 10:29:21 +0100, Khouloud Touil wrote:
> As the at25 uses the NVMEM subsystem, and the property is now being
> handled, adding reference for it in the device tree binding document,
> which allows to specify the GPIO line to which the write-protect pin
> is connected.
> 
> Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
> ---
>  Documentation/devicetree/bindings/eeprom/at25.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
