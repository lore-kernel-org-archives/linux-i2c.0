From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH i2c-next v7 3/5] dt-bindings: i2c: aspeed: Add
 'bus-timeout-ms' property as an optional property
Date: Thu, 11 Oct 2018 17:12:19 -0500
Message-ID: <20181011221219.GA31991@bogus>
References: <20181005214507.26315-1-jae.hyun.yoo@linux.intel.com>
 <20181005214507.26315-4-jae.hyun.yoo@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005214507.26315-4-jae.hyun.yoo@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Brendan Higgins <brendanhiggins@google.com>, Wolfram Sang <wsa@the-dreams.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Fri,  5 Oct 2018 14:45:05 -0700, Jae Hyun Yoo wrote:
> This commit adds 'bus-timeout-ms' property as an optional property
> which can be used for setting the bus timeout value of an adapter.
> With this patch, the bus timeout value can be set through this
> property at the probing time of this module. Still the bus timeout
> value can be set by an I2C_TIMEOUT ioctl on cdev at runtime too.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-aspeed.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
