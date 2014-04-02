From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: re: i2c: nomadik: Convert to devm functions
Date: Wed, 2 Apr 2014 14:14:25 +0300
Message-ID: <20140402111425.GB23000@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Ulf Hansson,

The patch 9b2b98a3b4de: "i2c: nomadik: Convert to devm functions"
from Feb 18, 2014, leads to the following static checker warning:

	drivers/i2c/busses/i2c-nomadik.c:1002 nmk_i2c_probe()
	warn: 'dev->virtbase' isn't an ERR_PTR

drivers/i2c/busses/i2c-nomadik.c
   999  
  1000          dev->virtbase = devm_ioremap(&adev->dev, adev->res.start,
  1001                                  resource_size(&adev->res));
  1002          if (IS_ERR(dev->virtbase)) {
                    ^^^^^^^^^^^^^^^^^^^^
devm_ioremap() returns a NULL on error the same as ioremap() does.

  1003                  ret = -ENOMEM;
  1004                  goto err_no_mem;
  1005          }
  1006  
  1007          dev->irq = adev->irq[0];

regards,
dan carpenter
