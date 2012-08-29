From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 1/5] i2c: introduce i2c-cbus driver
Date: Wed, 29 Aug 2012 16:35:17 -0700
Message-ID: <20120829233517.GG1303@atomide.com>
References: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
 <1346189667-32330-2-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1346189667-32330-2-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [120828 14:35]:
> Add i2c driver to enable access to devices behind CBUS on Nokia Internet
> Tablets.

Can you please do also a separate patch for the device tree binding for
getting the GPIO pins for this controller? 

Other than that thanks for doing this and:

Acked-by: Tony Lindgren <tony@atomide.com>
