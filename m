From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 3/5] dt-bindings: at24: make wp-gpios a reference to
 the property defined by nvmem
Date: Wed, 8 Jan 2020 14:54:19 -0600
Message-ID: <20200108205419.GA16184@bogus>
References: <20200107092922.18408-1-ktouil@baylibre.com>
 <20200107092922.18408-4-ktouil@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200107092922.18408-4-ktouil@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: bgolaszewski@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, srinivas.kandagatla@linaro.org, baylibre-upstreaming@groups.io, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linus.walleij@linaro.org, Khouloud Touil <ktouil@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

On Tue,  7 Jan 2020 10:29:20 +0100, Khouloud Touil wrote:
> NVMEM framework is an interface for the at24 EEPROMs as well as for
> other drivers, instead of passing the wp-gpios over the different
> drivers each time, it would be better to pass it over the NVMEM
> subsystem once and for all.
> 
> Making wp-gpios a reference to the property defined by nvmem.
> 
> Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.yaml | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
