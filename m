From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/7] dt-bindings: i2c: add support for 'i2c-arb' subnode
Date: Fri, 29 Jul 2016 16:24:52 -0500
Message-ID: <20160729212452.GA7487@rob-hp-laptop>
References: <1469609010-23049-1-git-send-email-peda@axentia.se>
 <1469609010-23049-3-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469609010-23049-3-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Emil Velikov <emil.l.velikov@gmail.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 27, 2016 at 10:43:25AM +0200, Peter Rosin wrote:
> This gets rid of the need for a pointless 'reg' property for i2c
> arbitrators.
> 
> I.e. this new and more compact style
> 
> 	some-arbitrator {
> 		i2c-mux {

You mean i2c-arb here?

> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			some-i2c-device@50 {
> 				reg = <0x50>;
> 			};
> 		};
> 	};
> 
> instead of the old
> 
> 	some-arbitrator {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		i2c@0 {
> 			reg = <0>;
> 
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			some-i2c-device@50 {
> 				reg = <0x50>;
> 			};
> 		};
> 	};
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../bindings/i2c/i2c-arb-gpio-challenge.txt        |  8 ++---
>  Documentation/devicetree/bindings/i2c/i2c-arb.txt  | 35 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  3 files changed, 38 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-arb.txt

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
