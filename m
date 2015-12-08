From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 2/9] i2c: add generic routine to parse DT for timing
 information
Date: Tue, 8 Dec 2015 13:09:44 +0200
Message-ID: <20151208110944.GH1766@lahna.fi.intel.com>
References: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
 <1449567473-2084-3-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449567473-2084-3-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 08, 2015 at 10:37:46AM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Inspired from the i2c-rk3x driver (thanks guys!) but refactored and
> extended. See built-in docs for further information.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Looks good. I think we can take advantage of this in the designware
driver as well.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

I wonder if it makes sense to add "i2c-sda-hold-time-ns" (taken from the
designware driver DT binding) to the timings structure? It is tHD;DAT
parameter in the I2C bus specification.
