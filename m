From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH 0/4] (Repost) Add reset GPIO support to the pca954x I2C mux
Date: Fri, 29 Nov 2013 01:51:21 +0100
Message-ID: <1385686285-23780-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

This patch set adds DT support for a reset GPIO to the pca954x I2C mux. It
starts by two cleanup patches for the driver, adds missing DT bindings
documentation and finally adds support for the reset GPIO.

(With the devicetree mailing list CC'ed this time, sorry for the noise :-/)

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Laurent Pinchart (4):
  i2c: pca954x: Sort headers alphabetically
  i2c: pca954x: Use devm_kzalloc managed allocator
  i2c: pca954x: Add device tree bindings documentation
  i2c: pca954x: Add reset GPIO support

 .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    | 50 ++++++++++++++++++++++
 drivers/i2c/muxes/i2c-mux-pca954x.c                | 44 ++++++++++++-------
 2 files changed, 78 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt

-- 
Regards,

Laurent Pinchart
