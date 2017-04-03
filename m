From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] i2c: add sc18is600 driver
Date: Mon, 3 Apr 2017 09:54:38 -0500
Message-ID: <20170403145438.5lrz3zr2a4qe2ief@rob-hp-laptop>
References: <20170329140339.22501-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170329140339.22501-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 29, 2017 at 04:03:39PM +0200, Sebastian Reichel wrote:
> This adds an I²C master driver for SPI -> I²C bus bridge chips.
> It currently supports NXP's SC18IS600 and SC18IS601, as well as
> Silicon Labs' CP2120. The driver was only tested on SC18IS600.
> 
> Signed-off-By: Sebastian Reichel <sre@kernel.org>
> ---
>  .../devicetree/bindings/i2c/i2c-cp2120.txt         |   1 +
>  .../devicetree/bindings/i2c/i2c-sc18is600.txt      |  62 +++

Acked-by: Rob Herring <robh@kernel.org> 

>  drivers/i2c/busses/Kconfig                         |  10 +
>  drivers/i2c/busses/Makefile                        |   1 +
>  drivers/i2c/busses/i2c-sc18is600.c                 | 572 +++++++++++++++++++++
>  5 files changed, 646 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-cp2120.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sc18is600.txt
>  create mode 100644 drivers/i2c/busses/i2c-sc18is600.c
