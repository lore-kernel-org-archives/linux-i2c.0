From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH i2c-next 1/2] dt-bindings: i2c: aspeed: add hardware
 timeout support
Date: Mon, 21 Oct 2019 21:05:30 +0000
Message-ID: <0a629f7b-b829-c332-27d8-dc825205ff72@axentia.se>
References: <20191021202414.17484-1-jae.hyun.yoo@linux.intel.com>
 <20191021202414.17484-2-jae.hyun.yoo@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191021202414.17484-2-jae.hyun.yoo@linux.intel.com>
Content-Language: en-US
Content-ID: <08F8C0D291CEAA46A8C814AED28C379A@eurprd02.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, Brendan Higgins <brendanhiggins@google.com>, Wolfram Sang <wsa@the-dreams.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>, Tao Ren <taoren@fb.com>, Cedric Le Goater <clg@kaod.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
List-Id: linux-i2c@vger.kernel.org

On 2019-10-21 22:24, Jae Hyun Yoo wrote:
> Append a binding to support hardware timeout feature.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-aspeed.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> index b47f6ccb196a..133bfedf4cdd 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> @@ -17,6 +17,8 @@ Optional Properties:
>  - bus-frequency	: frequency of the bus clock in Hz defaults to 100 kHz when not
>  		  specified
>  - multi-master	: states that there is another master active on this bus.
> +- aspeed,hw-timeout-ms	: Hardware timeout in milliseconds. If it's not
> +			  specified, the H/W timeout feature will be disabled.
>  
>  Example:
>  
> 

Some SMBus clients support a smbus-timeout-disable binding for disabling
timeouts like this, for cases where the I2C adapter in question on occasion
is unable to keep the pace. Adding that property thus avoids undesired
timeouts when the client is SMBus conformant without it. Your new binding
is the reverse situation, where you want to add a timeout where one is
otherwise missing.

Anyway, since I2C does not have a specified lowest possible frequency, this
feels like something that is more in the SMBus arena. Should the property
perhaps be a generic property named smbus-timeout-ms, or something like
that?

If the above is not wanted or appropriate, then I would personally prefer
aspeed,bus-timeout-ms over aspeed,hw-timeout-ms. To me, hw-timeout-ms sounds
like a (more serious) timeout between the CPU and the I2C peripheral unit
or something like that. But I don't care deeply...

Cheers,
Peter
