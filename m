From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 6/7] dt-bindings: i2c: i2c-gpio: Add support for named
 gpios
Date: Wed, 20 Sep 2017 15:53:04 -0500
Message-ID: <20170920205304.shkguzlqco3m6weu@rob-hp-laptop>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-7-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20170917093906.16325-7-linus.walleij@linaro.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, adi-buildroot-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, geert.renesas@glider.be, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-i2c@vger.kernel.org

On Sun, Sep 17, 2017 at 11:39:05AM +0200, Linus Walleij wrote:
> From: Geert Uytterhoeven <geert+renesas () glider ! be>
> 
> The current i2c-gpio DT bindings use a single unnamed "gpios" property
> to refer to the SDA and SCL signal lines by index.  This is error-prone
> for the casual DT writer and reviewer, as one has to look up the order
> in the DT bindings.
> 
> Fix this by amending the DT bindings to use two separate named gpios
> properties, and deprecate the old unnamed variant.
> 
> Take this opportunity to clearly deprecate the "i2c-gpio,sda-open-drain"
> and "i2c-gpio,scl-open-drain" flags as well. The commit describes
> in detail what these flags actually mean, and why they should not be
> used in new device trees.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> [Augmented to what I and Rob would like]
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Create a special section for the deprecated bindings
> - Also deprecate the open drain bool properties
> - Update the example to use the new style of bindings
> ---
>  Documentation/devicetree/bindings/i2c/i2c-gpio.txt | 32 ++++++++++++++++------
>  1 file changed, 23 insertions(+), 9 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
