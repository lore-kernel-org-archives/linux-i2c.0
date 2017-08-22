From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v2 1/3] dt-bindings: add eeprom "size" property
Date: Tue, 22 Aug 2017 12:11:07 +0300
Message-ID: <20170822091107.uubxhwilkutduou7@valkosipuli.retiisi.org.uk>
References: <1502736119-32084-1-git-send-email-divagar.mohandass@intel.com>
 <1502736119-32084-2-git-send-email-divagar.mohandass@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502736119-32084-2-git-send-email-divagar.mohandass@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Divagar Mohandass <divagar.mohandass@intel.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com
List-Id: linux-i2c@vger.kernel.org

Hi Divagar,

On Tue, Aug 15, 2017 at 12:11:57AM +0530, Divagar Mohandass wrote:
> This adds eeprom "size" as optional property for i2c eeproms.
> 
> "size" should be mentioned in byte and it should refer
> to the eeprom size. This will be read by the driver and
> used to calculating the number of bytes in read/write calls.

Instead of the three lines above, how about:

The "size" property allows explicitly specifying the size of the EEPROM
chip in bytes.

> 
> Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>
> ---
>  Documentation/devicetree/bindings/eeprom/eeprom.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
> index 5696eb5..1436569 100644
> --- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
> +++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
> @@ -32,6 +32,8 @@ Optional properties:
>  
>    - read-only: this parameterless property disables writes to the eeprom
>  
> +  - size: total eeprom size in bytes
> +
>  Example:
>  
>  eeprom@52 {
> -- 
> 1.9.1
> 

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
