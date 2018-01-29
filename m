From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: at24: add compatible for nxp,se97b
Date: Mon, 29 Jan 2018 10:18:19 -0600
Message-ID: <20180129161819.fznydwb2jo6z2koj@rob-hp-laptop>
References: <20180116160618.27859-1-peda@axentia.se>
 <20180116160618.27859-3-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180116160618.27859-3-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Russell King <linux@armlinux.org.uk>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 16, 2018 at 05:06:16PM +0100, Peter Rosin wrote:
> The datasheet talks about the chip being an spd, but the chip is writable
> so atmel,24c02 is more appropriate as fallback.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
