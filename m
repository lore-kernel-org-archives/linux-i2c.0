From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: at24: convert the binding document
 to yaml
Date: Wed, 9 Oct 2019 18:23:54 -0500
Message-ID: <20191009232354.GA23030@bogus>
References: <20191002072047.20895-1-brgl@bgdev.pl>
 <20191002072047.20895-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191002072047.20895-2-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Rosin <peda@axentia.se>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

On Wed,  2 Oct 2019 09:20:46 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Convert the binding document for at24 EEPROMs from txt to yaml. The
> compatible property uses a regex pattern to address all the possible
> combinations of "vendor,model" strings.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> [robh: rework compatible schema, fix missing allOf for $ref, fix errors in example]
> Signed-off-by: Rob Herring <robh@kernel.org>
> [Bartosz: added comments explaining the compatible property]
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../devicetree/bindings/eeprom/at24.txt       |  90 +--------
>  .../devicetree/bindings/eeprom/at24.yaml      | 185 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 187 insertions(+), 90 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/eeprom/at24.yaml
> 

Applied, thanks.

Rob
