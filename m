From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 3/3] dt-bindings: i2c: eeprom: document
 "start-offset" binding
Date: Thu, 6 Jul 2017 10:45:00 -0500
Message-ID: <20170706154500.d2eyomg5kweunddg@rob-hp-laptop>
References: <1498736351-9021-1-git-send-email-claudiu.beznea@microchip.com>
 <1498736351-9021-4-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1498736351-9021-4-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: mark.rutland@arm.com, nsekhar@ti.com, david@lechnology.com, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, nicolas.ferre@microchip.com
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 29, 2017 at 02:39:11PM +0300, Claudiu Beznea wrote:
> Document "start-offset" binding that will be used by at24
> EEPROM driver.

Why do we need this property?

Seems like this should be handled by defining regions of the EEPROM that 
you care about (or perhaps are reserved and don't want to touch). Just a 
single offset value is not very flexible. 

> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/eeprom/eeprom.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
> index a50dc01..e0bec50 100644
> --- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
> +++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
> @@ -35,10 +35,13 @@ Optional properties:
>  
>    - read-only: this parameterless property disables writes to the eeprom
>  
> +  - start-offset: offset in EEPROM to start reading from
> +
>  Example:
>  
>  eeprom@52 {
>  	compatible = "atmel,24c32";
>  	reg = <0x52>;
>  	pagesize = <32>;
> +	start-offset = /bits/ 8 <0xf8>;

The size of the property is part of the ABI. Unless you *never* need 
offset of more than 256, then this should be 32-bit.

Rob
