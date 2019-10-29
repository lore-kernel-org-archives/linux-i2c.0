From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: i2c: meson: convert to yaml
Date: Tue, 29 Oct 2019 11:26:24 -0500
Message-ID: <20191029162624.GA1057@bogus>
References: <20191021140053.9525-1-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191021140053.9525-1-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Beniamino Galvani <b.galvani@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, 21 Oct 2019 16:00:53 +0200, Neil Armstrong wrote:
> Now that we have the DT validation in place, let's convert the device tree
> bindings for the Amlogic I2C Controller over to YAML schemas.
> 
> Cc: Beniamino Galvani <b.galvani@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/i2c/amlogic,meson6-i2c.yaml      | 53 +++++++++++++++++++
>  .../devicetree/bindings/i2c/i2c-meson.txt     | 30 -----------
>  2 files changed, 53 insertions(+), 30 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-meson.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
