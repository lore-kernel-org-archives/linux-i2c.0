From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [Patch v2] MPC Adapter: read class attribute from device tree
Date: Wed, 22 Apr 2009 09:45:22 +0200
Message-ID: <49EECB12.9000106@grandegger.com>
References: <49EEC50A.4050707@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49EEC50A.4050707-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Michael Lawnick wrote:
> For MPC adapter there is no class assigned as it is done in other
> adapters. This way no new-style client will ever be instantiated, if not
> noted in device tree or forced. With this patch class assignment is read
> from device tree.
> If class assignment is not set in device tree .class stays default (0)
> 
> Necessary device tree entry:
> linux,i2c-class = <1>; /* I2C_CLASS_HWMON (iic.h) */
> 
> Based on kernel 2.6.29
> 
> Signed-off-by: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Sang, Wolfram <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>

Please document the new device tree binding in
"Documentation/powerpc/dts-bindings/fsl/i2c.txt", send a CC to
"devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org", use an up-to-date version of the
linux-2.6 tree (there are some patches for i2c-mpc.c pending) and fix
the coding style issues.

Wolfgang.
