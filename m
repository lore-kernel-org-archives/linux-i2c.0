From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/4] i2c bus recovery for Microchip SoCs.
Date: Tue, 15 Oct 2019 14:10:48 -0500
Message-ID: <20191015191048.GA32065@bogus>
References: <20191002144658.7718-1-kamel.bouhara@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191002144658.7718-1-kamel.bouhara@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 02, 2019 at 04:46:54PM +0200, Kamel Bouhara wrote:
> This patch series introduce the kernel i2c-gpio bus recovery mechanism
> for the Microchip SoCs. Updated the corresponding dts to add i2c
> gpio pinctrl. The bus recovery is configured for the sama5d3/4 xplained
> boards in dts.

Now we have 2 drivers with the same binding and code for using GPIO for 
bus recovery. Perhaps all this should be common.

Rob
