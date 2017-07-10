From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: i2c: eeprom: document "mac-offset"
 binding
Date: Sun, 9 Jul 2017 22:46:13 -0500
Message-ID: <20170710034613.fc4vj6h22kagce24@rob-hp-laptop>
References: <1499336217-16913-1-git-send-email-claudiu.beznea@microchip.com>
 <1499336217-16913-4-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33643 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753069AbdGJDqQ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 9 Jul 2017 23:46:16 -0400
Content-Disposition: inline
In-Reply-To: <1499336217-16913-4-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: mark.rutland@arm.com, nsekhar@ti.com, david@lechnology.com, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, nicolas.ferre@microchip.com, ludovic.desroches@microchip.com

On Thu, Jul 06, 2017 at 01:16:57PM +0300, Claudiu Beznea wrote:
> Document "mac-offset" binding that will be used by at24 EEPROM driver.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/eeprom/eeprom.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
> index a50dc01..3dd267c 100644
> --- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
> +++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
> @@ -35,10 +35,13 @@ Optional properties:
>  
>    - read-only: this parameterless property disables writes to the eeprom
>  
> +  - mac-offset: offset in EEPROM where MAC address starts
> +

This doesn't scale if you have multiple things you need the offset to, 
and we already have a binding for this. Use the nvmem binding.

Rob
