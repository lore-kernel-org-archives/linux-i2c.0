From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 2/9] i2c: add generic routine to parse DT for timing
 information
Date: Tue, 8 Dec 2015 15:03:46 +0200
Message-ID: <20151208130346.GO1766@lahna.fi.intel.com>
References: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
 <1449567473-2084-3-git-send-email-wsa@the-dreams.de>
 <20151208110944.GH1766@lahna.fi.intel.com>
 <20151208125307.GA3359@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1905 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbbLHNGI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 8 Dec 2015 08:06:08 -0500
Content-Disposition: inline
In-Reply-To: <20151208125307.GA3359@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Tue, Dec 08, 2015 at 01:53:07PM +0100, Wolfram Sang wrote:
> 
> > I wonder if it makes sense to add "i2c-sda-hold-time-ns" (taken from the
> > designware driver DT binding) to the timings structure? It is tHD;DAT
> > parameter in the I2C bus specification.
> 
> It totally makes sense. I just didn't need it for the RCar driver and
> didn't want to implement something which isn't actually used. So feel
> free to add it, or ask me to do it, if you promise to use it in the
> designware driver :)

I can add it in a separate patch later on. Thanks!
