From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 2/2] i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface) controller support
Date: Tue, 10 Jun 2014 15:54:56 +0200
Message-ID: <6454089.IP8IFVsofj@wuerfel>
References: <1402408036-5235-1-git-send-email-boris.brezillon@free-electrons.com> <1402408036-5235-3-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1402408036-5235-3-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-doc-owner@vger.kernel.org
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Randy Dunlap <rdunlap@infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Hans de Goede <hdegoede@redhat.com>, Shuge <shuge@allwinnertech.com>, kevin@allwinnertech.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 10 June 2014 15:47:16 Boris BREZILLON wrote:
> 
> +config I2C_SUN6I_P2WI
> +       tristate "Allwinner sun6i internal P2WI controller"
> +       depends on ARCH_SUNXI
> +       help
> +         If you say yes to this option, support will be included for the
> +         P2WI (Push/Pull 2 Wire Interface) controller embedded in some sunxi
> +         SOCs.
> +         The P2WI looks like an SMBus controller (which supports only byte
> +         accesses), except that it only supports one slave device.
> +         This interface is used to connect to specific PMIC devices (like the
> +         AXP221).
> +

Sorry for the stupid question, but why is this an i2c driver if the
hardware protocol is completely different?

I understand that a lot of devices can be driven using either spi or
i2c, and we have two sets of {directories,maintainers,bus_types,...}
for them. Your description sounds like this is a separate option
that isn't any closer to i2c than it is to spi.

Would it perhaps be better to expose it only as a regmap rather than
an i2c host?

	Arnd
