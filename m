From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: Compatibles for i2c muxes nxp,pca954x and ti,tca954x
Date: Thu, 3 Aug 2017 15:44:01 +0200
Message-ID: <20170803134401.GG15018@lunn.ch>
References: <62519d0b-0b7b-9124-8481-9ef8de24eaf6@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:50698 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbdHCNoF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 3 Aug 2017 09:44:05 -0400
Content-Disposition: inline
In-Reply-To: <62519d0b-0b7b-9124-8481-9ef8de24eaf6@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org

On Thu, Aug 03, 2017 at 12:00:27PM +0200, Peter Rosin wrote:
> Hi!
> 
> Texas has apparently made copies for some of the NXP devices
> handled by the drivers/i2c/muxes/i2c-mux-pca954x.c driver.

This happens a lot in the i2c space. Look at all the at24 EEPROM
clones. Yet they all use the same compatible string.

	Andrew
