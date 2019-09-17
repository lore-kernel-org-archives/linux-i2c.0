From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 2/9] dt-bindings: i2c: add bindings for i2c analog and
 digital filter
Date: Tue, 17 Sep 2019 09:28:08 -0500
Message-ID: <20190917142808.GA7900@bogus>
References: <1568189911-31641-1-git-send-email-eugen.hristev@microchip.com>
 <1568189911-31641-3-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1568189911-31641-3-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugen.Hristev@microchip.com
Cc: wsa@the-dreams.de, peda@axentia.se, mark.rutland@arm.com, Ludovic.Desroches@microchip.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com, Nicolas.Ferre@microchip.com
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 11, 2019 at 08:24:20AM +0000, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Some i2c controllers have a built-in digital or analog filter.
> This is specifically required depending on the hardware PCB/board.
> Some controllers also allow specifying the maximum width of the
> spikes that can be filtered for digital filter. The width length can be
> specified in nanoseconds.
> Analog filters can be configured to have a cutoff frequency (low-pass filter).
> This frequency can be specified in Hz.
> Added an optional property for such types of analog filters.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
