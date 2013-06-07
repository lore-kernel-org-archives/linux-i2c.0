From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 2/2] ARM: dts: mvebu: Add the i2c-bridge capability to
 the mv64xxx-i2c
Date: Fri, 7 Jun 2013 20:50:15 +0200
Message-ID: <20130607205015.0a6d6bfd@skate>
References: <1370619743-15245-1-git-send-email-gregory.clement@free-electrons.com>
	<1370619743-15245-3-git-send-email-gregory.clement@free-electrons.com>
	<20130607180941.GW23859@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130607180941.GW23859@titan.lakedaemon.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Chris Van Hoof <vanhoof@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Dear Jason Cooper,

On Fri, 7 Jun 2013 14:09:41 -0400, Jason Cooper wrote:

> > +- i2c,i2c-bridge : This flag indicate that the i2c controller have the
> > +  Transaction Generator support and we want to use it. Not all the
> > +  mv64xxx controller have this feature.
> 
> Do you have a list of which controllers definitely do, or definitely
> don't?  That would be helpful for folks adding new boards.

As mentioned in the first commit log:

""
This feature is currently only available on Armada XP, so usage of
this mechanism is activated through device tree.
""

So Armada XP is the only to have that, for now. We can probably assume
future Marvell SoC may also have this feature, but we don't know for
sure.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
