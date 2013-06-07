From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 1/2] i2c-mv64xxx: Fix timing issue on Armada XP (errata
 FE-8471889)
Date: Fri, 7 Jun 2013 18:25:00 +0200
Message-ID: <20130607182500.10593e73@skate>
References: <1370620140-17177-1-git-send-email-gregory.clement@free-electrons.com>
	<1370620140-17177-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370620140-17177-2-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Chris Van Hoof <vanhoof@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>, linux-kernel@vger.kernel.org, Zbigniew Bodek <zbb@semihalf.com>
List-Id: linux-i2c@vger.kernel.org

Dear Gregory CLEMENT,

On Fri,  7 Jun 2013 17:48:59 +0200, Gregory CLEMENT wrote:

> +/*
> + * 5us delay in order to avoid repeated start
> + * timing violation on Armada XP SoC.
> + */
> +static int mv64xxx_i2c_errata_delay;

This should probably be a per-I2C controller variable, i.e in
mv64xxx_i2c_data.


> +	if (!mv64xxx_i2c_errata_delay &&
> +	    of_machine_is_compatible("marvell,armadaxp"))
> +		mv64xxx_i2c_errata_delay = 1;

I am wondering whether it should be done this way, or using a separate
DT property.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
