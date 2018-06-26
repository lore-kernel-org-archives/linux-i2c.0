From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: at24: Add address-width property
Date: Tue, 26 Jun 2018 09:49:20 +0300
Message-ID: <20180626064920.65atfoengymu5yjg@kekkonen.localdomain>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
 <1529994128-26770-2-git-send-email-alanx.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1529994128-26770-2-git-send-email-alanx.chiang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alanx.chiang@intel.com
Cc: linux-i2c@vger.kernel.org, andy.yeh@intel.com, andriy.shevchenko@intel.com, rajmohan.mani@intel.com, andy.shevchenko@gmail.com, brgl@bgdev.pl, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Alan,

On Tue, Jun 26, 2018 at 02:22:07PM +0800, alanx.chiang@intel.com wrote:
> From: "alanx.chiang" <alanx.chiang@intel.com>
> 
> The AT24 series chips use 8-bit address by default. If some
> chips would like to support more than 8 bits, should add the compatible
> field for specfic chips in the driver.
> 
> Provide a flexible way to determine the addressing bits through
> address-width in this patch.
> 
> Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> Signed-off-by: Andy Yeh <andy.yeh@intel.com>
> 
> ---
> since v1:
> -- Remove the address-width field in the example.
> 
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> index 61d833a..9467482 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> @@ -72,6 +72,8 @@ Optional properties:
>  
>    - wp-gpios: GPIO to which the write-protect pin of the chip is connected.
>  
> +  - address-width : number of address bits (one of 8, 16).

Please remove the space before the colon; that way it looks the same as the
rest.

> +
>  Example:
>  
>  eeprom@52 {

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
