From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: i2c imx: suspicious use of runtime PM calls
Date: Sat, 22 Aug 2015 23:42:18 +0200
Message-ID: <55D8ECBA.6050505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Just by chance I stumbled across this driver and the recently added runtime PM code.
Two things in i2c_imx_probe look suspicious to me:

- You activate the I2C clock and then initialize runtime PM with

    pm_runtime_enable(&pdev->dev);
    pm_runtime_set_autosuspend_delay(&pdev->dev, I2C_PM_TIMEOUT);
    pm_runtime_use_autosuspend(&pdev->dev);

  Seems like a call to pm_runtime_set_active is missing to tell runtime PM
  that the device is in status "active" now.

- You use pm_runtime_put_autosuspend (which decrements the ref count) but you don't
  get a reference before. I think you would have to use pm_runtime_get_... before
  or use pm_runtime_autosuspend.

Regards, Heiner
