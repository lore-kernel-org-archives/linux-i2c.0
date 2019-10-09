From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 2/2] dt-bindings: at24: add new compatible
Date: Wed, 9 Oct 2019 18:24:06 -0500
Message-ID: <20191009232406.GA23532@bogus>
References: <20191002072047.20895-1-brgl@bgdev.pl>
 <20191002072047.20895-3-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191002072047.20895-3-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Rosin <peda@axentia.se>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

On Wed,  2 Oct 2019 09:20:47 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> arch/arm/boot/dts/at91-dvk_som60.dt.yaml uses the compatible string
> 'giantec,gt24c32a' for an at24 EEPROM with a fallback to 'atmel,24c32'.
> 
> Add this model as a special case to the binding document.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks.

Rob
