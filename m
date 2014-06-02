From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/3] i2c: Relax requirement for I2C Device ID tables
Date: Mon,  2 Jun 2014 14:41:00 +0100
Message-ID: <1401716463-23457-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

After this patch-set, it should become possible to start stripping out
those unnecessary I2C Device ID tables that are currently lurking around,
mostly redundantly.  Firstly, we create a look-up function whose job it
is to match I2C device name to a Device Tree node.  Then we add some
extra protection in i2c_match_id(), so that we can call the function with
a NULL parameter. This in turn aids to the elegance of the final change
which relaxes the requirement of a populated .id_table.

Kind regards,
Lee
