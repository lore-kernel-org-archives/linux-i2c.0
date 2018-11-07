From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/3] i3c: master: Add driver for Synopsys DesignWare IP
Date: Wed, 7 Nov 2018 09:05:53 -0800
Message-ID: <20181107170553.GJ3074@bombadil.infradead.org>
References: <1540807618-13246-1-git-send-email-soares@synopsys.com>
 <1540807618-13246-2-git-send-email-soares@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1540807618-13246-2-git-send-email-soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitor soares <vitor.soares@synopsys.com>
Cc: boris.brezillon@bootlin.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, linus.walleij@linaro.org, Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se, mshettel@codeaurora.org, swboyd@chromium.org, joao.pinto@synopsys.com, luis
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 29, 2018 at 10:06:56AM +0000, Vitor soares wrote:
> Add driver for Synopsys DesignWare I3C master IP

The so-called "data sheet" (actually just an advertising brochure)
on your website claims DMA support.  I don't see that support
anywhere in this driver.
