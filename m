From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: i2c: at91: document optional bus
 recovery properties
Date: Tue, 29 Oct 2019 16:38:57 -0500
Message-ID: <20191029213857.GA13250@bogus>
References: <20191024201302.23376-1-kamel.bouhara@bootlin.com>
 <20191024201302.23376-3-kamel.bouhara@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191024201302.23376-3-kamel.bouhara@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, devicetree@vger.kernel.org, Kamel Bouhara <kamel.bouhara@bootlin.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, 24 Oct 2019 22:12:59 +0200, Kamel Bouhara wrote:
> The at91 I2C controller can support bus recovery by re-assigning SCL
> and SDA to gpios. Add the optional pinctrl and gpio properties to do
> so.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-at91.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
