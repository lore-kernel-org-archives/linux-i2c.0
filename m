From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH i2c-next v3 1/3] dt-bindings: i2c: aspeed: Add 'timeout'
 property as an optional property
Date: Thu, 27 Sep 2018 15:56:10 -0500
Message-ID: <20180927205610.GA29022@bogus>
References: <20180926215842.23125-1-jae.hyun.yoo@linux.intel.com>
 <20180926215842.23125-2-jae.hyun.yoo@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180926215842.23125-2-jae.hyun.yoo@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, Wolfram Sang <wsa@the-dreams.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 26, 2018 at 02:58:40PM -0700, Jae Hyun Yoo wrote:
> This commit adds 'aspeed,timeout' property as an optional property
> which can be used for setting 'timeout' value of
> 'struct i2c_adapter'. With this patch, the timeout value can be
> set through an I2C_TIMEOUT ioctl on cdev, or through this optional
> DT property.

Isn't controlling this from userspace or relying on a default 
sufficient?  I can't see this needing to be highly tuned for each 
platform.

However, if we do have a property, it should be common.

> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-aspeed.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> index 8fbd8633a387..d6965b360fbc 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> @@ -17,6 +17,9 @@ Optional Properties:
>  		  specified
>  - multi-master	: states that there is another master active on this bus.
>  
> +- aspeed,timeout : I2C bus timeout in microseconds defaults to 5 seconds when
> +		   not specified.
> +
>  Example:
>  
>  i2c {
> -- 
> 2.19.0
> 
