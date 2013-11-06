From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: re: i2c: pxa: add OF support
Date: Wed, 6 Nov 2013 19:12:17 +0300
Message-ID: <20131106161217.GB15603@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: haojian.zhuang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Haojian Zhuang,

This is a semi-automatic email about new static checker warnings.

The patch 63fe122bce06: "i2c: pxa: add OF support" from Mar 1, 2012, 
leads to the following Smatch complaint:

drivers/i2c/busses/i2c-pxa.c:1272 i2c_pxa_probe()
	 error: we previously assumed 'res' could be null (see line 1161)

drivers/i2c/busses/i2c-pxa.c
  1160		irq = platform_get_irq(dev, 0);
  1161		if (res == NULL || irq < 0) {
                    ^^^^^^^^^^^
Patch introduces a new error path.

  1162			ret = -ENODEV;
  1163			goto eclk;
  1164		}
  1165	

[snip]

  1267  eremap:
  1268          clk_put(i2c->clk);
  1269  eclk:
  1270          kfree(i2c);
  1271	emalloc:
  1272		release_mem_region(res->start, resource_size(res));
                                   ^^^^^^^^^^  ^^^^^^^^^^^^^^^^^
Null dereferences.

Obviously the unwind needs to be fixed so it's a mirror reflection of
the allocation order.  Also the labels are crap.  Label names should be
based on the label location and not the goto location(s).

  1273		return ret;
  1274	}

regards,
dan carpenter
