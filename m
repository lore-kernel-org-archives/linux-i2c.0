From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Minor fixes to upgrading-clients document
Date: Sun, 20 Feb 2011 15:04:08 +0100
Message-ID: <20110220150408.03e9a674@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

* Typical legacy drivers implemented method .detach_client, not
  .detach_adapter.
* Drop all references to __devexit, as i2c drivers shouldn't use it.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
---
 Documentation/i2c/upgrading-clients |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- linux-2.6.38-rc5.orig/Documentation/i2c/upgrading-clients	2010-08-02 00:11:14.000000000 +0200
+++ linux-2.6.38-rc5/Documentation/i2c/upgrading-clients	2011-02-20 14:57:57.000000000 +0100
@@ -61,7 +61,7 @@ static int example_attach(struct i2c_ada
 	return 0;
 }
 
-static int __devexit example_detach(struct i2c_client *client)
+static int example_detach(struct i2c_client *client)
 {
 	struct example_state *state = i2c_get_clientdata(client);
 
@@ -81,7 +81,7 @@ static struct i2c_driver example_driver
 		.name		= "example",
 	},
 	.attach_adapter = example_attach_adapter,
-	.detach_client	= __devexit_p(example_detach),
+	.detach_client	= example_detach,
 	.suspend	= example_suspend,
 	.resume		= example_resume,
 };
@@ -93,7 +93,7 @@ Updating the client
 The new style binding model will check against a list of supported
 devices and their associated address supplied by the code registering
 the busses. This means that the driver .attach_adapter and
-.detach_adapter methods can be removed, along with the addr_data,
+.detach_client methods can be removed, along with the addr_data,
 as follows:
 
 - static struct i2c_driver example_driver;
@@ -110,14 +110,14 @@ as follows:
 
  static struct i2c_driver example_driver = {
 -	.attach_adapter = example_attach_adapter,
--	.detach_client	= __devexit_p(example_detach),
+-	.detach_client	= example_detach,
  }
 
 Add the probe and remove methods to the i2c_driver, as so:
 
  static struct i2c_driver example_driver = {
 +	.probe		= example_probe,
-+	.remove		= __devexit_p(example_remove),
++	.remove		= example_remove,
  }
 
 Change the example_attach method to accept the new parameters
@@ -199,8 +199,8 @@ to delete the i2c_detach_client call. It
 can also remove the ret variable as it is not not needed for
 any of the core functions.
 
-- static int __devexit example_detach(struct i2c_client *client)
-+ static int __devexit example_remove(struct i2c_client *client)
+- static int example_detach(struct i2c_client *client)
++ static int example_remove(struct i2c_client *client)
 {
 	struct example_state *state = i2c_get_clientdata(client);
 
@@ -253,7 +253,7 @@ static int example_probe(struct i2c_clie
 	return 0;
 }
 
-static int __devexit example_remove(struct i2c_client *client)
+static int example_remove(struct i2c_client *client)
 {
 	struct example_state *state = i2c_get_clientdata(client);
 
@@ -275,7 +275,7 @@ static struct i2c_driver example_driver
 	},
 	.id_table	= example_idtable,
 	.probe		= example_probe,
-	.remove		= __devexit_p(example_remove),
+	.remove		= example_remove,
 	.suspend	= example_suspend,
 	.resume		= example_resume,
 };


-- 
Jean Delvare
