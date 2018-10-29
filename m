From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/3] i3c: master: Add driver for Synopsys DesignWare IP
Date: Mon, 29 Oct 2018 06:41:00 -0700
Message-ID: <20181029134100.GD28520@bombadil.infradead.org>
References: <1540807618-13246-1-git-send-email-soares@synopsys.com>
 <1540807618-13246-2-git-send-email-soares@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1540807618-13246-2-git-send-email-soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitor soares <vitor.soares@synopsys.com>
Cc: boris.brezillon@bootlin.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, linus.walleij@linaro.org, Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se, mshettel@codeaurora.org, swboyd@chromium.org, joao.pinto@synopsys.com, luis
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 29, 2018 at 10:06:56AM +0000, Vitor soares wrote:
> +config DW_I3C_MASTER
> +	tristate "Synospsys DesignWare I3C master driver"
> +	depends on I3C

> +	depends on !(ALPHA || PARISC)

why?

> +	help
> +	  Support·for·Synopsys·DesignWare·MIPI·I3C·Controller.

These strange characters (displayed as a centred dot on my terminal)
should probably be spaces.

> +static struct dw_i3c_xfer *
> +dw_i3c_master_alloc_xfer(struct dw_i3c_master *master, unsigned int ncmds)
> +{
> +	struct dw_i3c_xfer *xfer;
> +
> +	xfer = kzalloc(sizeof(*xfer) + (ncmds * sizeof(*xfer->cmds)),
> +		       GFP_KERNEL);

You should be using struct_size() here.
