From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 2/2] i2c: mv64xxx: Fix clock resource by adding an
 optional bus clock
Date: Wed, 10 Jan 2018 21:32:43 +0100
Message-ID: <20180110203243.GC11260@lunn.ch>
References: <20180110170743.27082-1-gregory.clement@free-electrons.com>
 <20180110170743.27082-3-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180110170743.27082-3-gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Wolfram Sang <wsa@the-dreams.de>, Igal Liberman <igall@marvell.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Omri Itach <omrii@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, linux-i2c@vger.kernel.org, =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>, Hanna Hawa <hannah@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 10, 2018 at 06:07:43PM +0100, Gregory CLEMENT wrote:
> On Armada 7K/8K we need to explicitly enable the bus clock. The bus clock
> is optional because not all the SoCs need them but at least for Armada
> 7K/8K it is actually mandatory.
> 
> The binding documentation is updating accordingly.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/i2c/i2c-mv64xxx.txt          | 20 ++++++++++++++++++++
>  drivers/i2c/busses/i2c-mv64xxx.c                     | 12 +++++++++++-
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> index 5c30026921ae..a835b724c738 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> @@ -25,6 +25,15 @@ default frequency is 100kHz
>                       whenever you're using the "allwinner,sun6i-a31-i2c"
>                       compatible.
>  
> + - clocks:	   : pointers to the reference clocks for this device, the first
> +		     one is the one used for the clock on the i2c bus, the second
> +		     one is the clock used for the functional part of the
> +		     controller
> +
> + - clock-names	   : names of used clocks, mandatory if the second clock is
> +		   : used, the name must be "core", and "axi_clk" (the latter is
> +		     only for Armada 7K/8K).

Hi Gregory

Are these two clocks related?

Ethernet on Dove needs two clocks enabled. 

static const struct clk_gating_soc_desc dove_gating_desc[] __initconst = {
       { "usb0", NULL, 0, 0 },
       { "usb1", NULL, 1, 0 },
       { "ge",	 "gephy", 2, 0 },
       { "sata", NULL, 3, 0 },

ge has a parent clock gephy. When you enable ge, the common clock code
walks up the tree of clocks, so will also turn on gephy.

Does this child/parent relationship exist with these i2c clocks?

     Andrew
