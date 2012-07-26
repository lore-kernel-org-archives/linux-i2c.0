From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-mux-gpio platform device ID issue
Date: Thu, 26 Jul 2012 09:28:14 +0200
Message-ID: <20120726092814.2689a30f@endymion.delvare>
References: <20120725144409.1e47bd95@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120725144409.1e47bd95-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi again Peter and Mark,

On Wed, 25 Jul 2012 14:44:09 +0200, Jean Delvare wrote:
> If a per-driver IDA isn't acceptable, then we can go for a global IDA,
> but then we can't re-use pdev->id == -1 for it. We'd have to introduce
> pdev->id == -2 for drivers which want a dynamically allocated unique
> ID. Actually this might be a better approach, as it's less intrusive.

I slept on it and came up with what I think is an easier and more
elegant solution. We could simply agree on using GPIO pin numbers as
platform device IDs, as two i2c-gpio-mux instances can't control the
same GPIO pin.

* * * * *

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c-mux-gpio: Document what device ID to use

We need a convention for i2c-mux-gpio platform device IDs so that they
do not collide.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
---
 Documentation/i2c/muxes/i2c-mux-gpio |    7 +++++++
 1 file changed, 7 insertions(+)

--- linux-3.5.orig/Documentation/i2c/muxes/i2c-mux-gpio	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.5/Documentation/i2c/muxes/i2c-mux-gpio	2012-07-26 08:41:23.291014194 +0200
@@ -63,3 +63,10 @@ static struct platform_device myboard_i2
 		.platform_data	= &myboard_i2cmux_data,
 	},
 };
+
+Device Registration
+-------------------
+
+When registering your i2c-gpio-mux device, you should pass the number
+of any GPIO pin it uses as the device ID. This guarantees that every
+instance has a different ID.


-- 
Jean Delvare
