From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] i2c: omap: fix OOPS in omap_i2c_unidle() during probe
Date: Wed, 31 Mar 2010 15:27:00 +0300
Message-ID: <20100331152700.17695375.jhnikula@gmail.com>
References: <1269339176-17479-1-git-send-email-ext-mika.1.westerberg@nokia.com>
	<alpine.DEB.2.00.1003310427180.14436@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1003310427180.14436@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Cory Maccarrone <darkstar6262@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, 31 Mar 2010 04:27:41 -0600 (MDT)
Paul Walmsley <paul@pwsan.com> wrote:

> > This patch moves register shift setting before any register accesses are done.
> > 
> > Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> > Cc: Cory Maccarrone <darkstar6262@gmail.com>
> 
> Tested-by: Paul Walmsley <paul@pwsan.com>
> 
BTW, Tony had the same fix buried in an another thread:

http://marc.info/?l=linux-omap&m=126826012627677&w=2

You could add my tested by as well to which one goes in but the fix
should go for 2.6.34 as the mainline doesn't boot otherwise on OMAP.

Tested-by: Jarkko Nikula <jhnikula@gmail.com>
