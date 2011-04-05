From: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [RFC][PATCH] Enable async suspend/resume of i2c devices
Date: Mon, 4 Apr 2011 20:47:01 -0700
Message-ID: <BANLkTik7i0VQpJb+enUd9c4-XvZQ1S57fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This improves our resume time when we have devices on an i2c bus
that are slow to resume.  In particular we have a light sensor that
adds about 50ms of resume time on one device. We have to enable it
both on the i2c master and i2c client side and then we get fully async
suspend/resume.  I suspect we'll see nice gains on systems with more
i2c devices and will test that out soon.

Signed-off-by: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index e5f76a0..bbe7569 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -547,6 +547,7 @@ i2c_new_device(struct i2c_adapter *adap, struct
i2c_board_info const *info)

        dev_dbg(&adap->dev, "client [%s] registered with bus id %s\n",
                client->name, dev_name(&client->dev));
+       device_enable_async_suspend(&client->dev);

        return client;

@@ -857,6 +858,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
                dev_warn(&adap->dev,
                         "Failed to create compatibility class link\n");
 #endif
+       device_enable_async_suspend(&adap->dev);

        /* create pre-declared device nodes */
        if (adap->nr < __i2c_first_dynamic_bus_num)
-- 
1.7.3.1
