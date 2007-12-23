From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2.6.24-rc5-mm 3/3] gpiolib: obsolete drivers/i2c/chips/pca9539.c
Date: Sun, 23 Dec 2007 10:32:02 -0800
Message-ID: <200712231032.02438.david-b@pacbell.net>
References: <f17812d70712142016q73abffc2w99174c40f847152c@mail.gmail.com> <20071219100101.26e10ab3@hyperion.delvare> <f17812d70712190132j31d22070rae986f2ed31d3634@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756409AbXLWScU@vger.kernel.org>
In-Reply-To: <f17812d70712190132j31d22070rae986f2ed31d3634@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: eric miao <eric.y.miao@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, i2c@lm-sensors.org, bgardner@wabtec.com
List-Id: linux-i2c@vger.kernel.org


> From: eric miao <eric.miao@marvell.com>
> Date: Wed, 19 Dec 2007 16:40:04 +0800
> Subject: [PATCH] gpiolib: mark drivers/i2c/chips/pca9539.c as deprecated
> 
> use drivers/gpio/pca9539.c instead.
> 
> Signed-off-by: eric miao <eric.miao@marvell.com>
> Acked-by: Ben Gardner <bgardner@wabtec.com>
> Acked-by: Jean Delvare <khali@linux-fr.org>
> ---
>  Documentation/i2c/chips/pca9539 |    3 +++
>  drivers/i2c/chips/Kconfig       |    7 +++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)

Yeah, this version looks unlikely to break anyone's systems.


> @@ -75,6 +75,9 @@ config SENSORS_PCA9539
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called pca9539.
> 
> +	  This driver is deprecated and will be dropped soon. Use
> +	  drivers/gpio/pca9539.c instead.
> +
>  config SENSORS_PCF8591
>  	tristate "Philips PCF8591"
>  	depends on EXPERIMENTAL
>

I suggest defining a date, such as "will be removed in the 2.6.26
kernel", and adding it to Documentation/feature-removal-schedule.txt ...
