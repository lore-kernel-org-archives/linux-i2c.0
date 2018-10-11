From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH i2c-next v7 1/5] dt-bindings: i2c: Add 'bus-timeout-ms'
 and '#retries' properties as common optional
Date: Thu, 11 Oct 2018 17:11:48 -0500
Message-ID: <20181011221148.GA31195@bogus>
References: <20181005214507.26315-1-jae.hyun.yoo@linux.intel.com>
 <20181005214507.26315-2-jae.hyun.yoo@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005214507.26315-2-jae.hyun.yoo@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Brendan Higgins <brendanhiggins@google.com>, Wolfram Sang <wsa@the-dreams.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Fri,  5 Oct 2018 14:45:03 -0700, Jae Hyun Yoo wrote:
> This commit adds 'bus-timeout-ms' and '#retries' properties as
> common optional properties that can be used for setting 'timeout'
> and 'retries' values of 'struct i2c_adapter'. With this patch, the
> bus timeout value and the master transfer retries count can be set
> through these properties at the registration time of an adapter.
> Still the values can be set by I2C_TIMEOUT and I2C_RETRIES ioctls
> on cdev at runtime too.
> 
> These properties may not be supported by all drivers. However, if
> a driver wants to support one of them, it should adapt the
> bindings in this document.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
