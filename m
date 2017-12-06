From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: add eeprom "at24,no-read-rollover"
 property
Date: Wed, 6 Dec 2017 16:04:04 -0600
Message-ID: <20171206220404.oyqg6ckhdx7jtbxw@rob-hp-laptop>
References: <1512487422-6284-1-git-send-email-svendev@arcx.com>
 <1512487422-6284-3-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35053 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbdLFWEG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 6 Dec 2017 17:04:06 -0500
Content-Disposition: inline
In-Reply-To: <1512487422-6284-3-git-send-email-svendev@arcx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sven Van Asbroeck <svendev@arcx.com>
Cc: mark.rutland@arm.com, wsa@the-dreams.de, brgl@bgdev.pl, nsekhar@ti.com, sakari.ailus@linux.intel.com, david@lechnology.com, javier@dowhile0.org, divagar.mohandass@intel.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

On Tue, Dec 05, 2017 at 10:23:42AM -0500, Sven Van Asbroeck wrote:
> Adds an optional property for at24 eeproms.
> This parameterless property indicates that the multi-address eeprom
> does not automatically roll over reads to the next slave address.
> 
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
> ---
>  Documentation/devicetree/bindings/eeprom/eeprom.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
> index 27f2bc1..5bfc0ac 100644
> --- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
> +++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
> @@ -38,6 +38,11 @@ Optional properties:
>  
>    - size: total eeprom size in bytes
>  
> +  - at24,no-read-rollover:

at24 is not a vendor prefix. Either this is atmel specific and you want 
atmel,no-read-rollover or it is for all vendors at24 compatible eeproms 
and you want at24-no-read-rollover. Or just drop the at24 if this 
binding is in fact for just at24 eeproms as none of the other properties 
has at24 in them.

> +			This parameterless property indicates that the multi-address
> +			eeprom does not automatically roll over reads to the next
> +			slave address. Please consult the manual of your device.
> +
>  Example:
>  
>  eeprom@52 {
> -- 
> 1.9.1
> 
