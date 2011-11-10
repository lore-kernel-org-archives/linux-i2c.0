From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: 10-bit address support
Date: Thu, 10 Nov 2011 16:07:39 +0100
Message-ID: <20111110160739.540cda37@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "Jeffrey (Sheng-Hui) Chu" <jeffchu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

After Sheng-Hui's fix to i2c-algo-bit, it would seem that we are almost
there with 10-bit slave address support. There's one remaining thing
that worries me though: the 7-bit and 10-bit address spaces overlap.
>From Documentation/i2c/ten-bit-addresses:

"The sets of addresses do not intersect: the 7 bit address 0x10 is not
the same as the 10 bit address 0x10 (though a single device could
respond to both of them)."

So for example, if on a given system you have two devices on I2C bus
segment 0, one responding to 7-bit address 0x2d and another responding
to 10-bit address 0x2d, they will have the same device name 0-002d,
meaning that instantiating the second one will fail.

Now I agree that this is extremely unlikely to happen, considering how
rare 10-bit addresses are in the first place. Still I think we should
fix this now, before the first 10-bit address I2C device gets supported
by the Linux kernel.

I can think of 2 different ways of addressing the problem.

First way is to use a different device name format for 10-bit address
devices, for example %d-10bit-%04x. This has the drawback that some
user-space applications and libraries may not recognize these as valid
i2c device names. libsensors and sensors-detect would be amongst these.

Second way is to add an offset to the 10-bit addresses, to avoid the
overlap. The minimum offset is 0x80, but that would translate for
example 0x2d to 0xad, which is not obviously "10-bit address 0x2d". So
I'd rather go with a larger offset such as 0x1000. This translates 0x2d
to 0x102d which is more obviously "10-bit address 0x2d". We have 16
bits to store the address so it shouldn't be an issue. Another possible
offset would be 0xa000 (as 0xa is 10.)

Given how rare 10-bit addresses are, the second option has my favors.
So my plan is to apply the following fix:

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c: Fix device name for 10-bit slave address

10-bit addresses overlap with traditional 7-bit addresses, leading in
device name collisions. Add an arbitrary offset to 10-bit addresses to
prevent this collision. The offset was chosen so that the address is
still easily recognizable.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-3.2-rc1.orig/drivers/i2c/i2c-core.c	2011-10-28 15:45:15.000000000 +0200
+++ linux-3.2-rc1/drivers/i2c/i2c-core.c	2011-11-10 14:45:05.000000000 +0100
@@ -539,8 +539,10 @@ i2c_new_device(struct i2c_adapter *adap,
 	client->dev.type = &i2c_client_type;
 	client->dev.of_node = info->of_node;
 
+	/* For 10-bit clients, add an arbitrary offset to avoid collisions */
 	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
-		     client->addr);
+		     client->addr | ((client->flags & I2C_CLIENT_TEN)
+				     ? 0x1000 : 0));
 	status = device_register(&client->dev);
 	if (status)
 		goto out_err;

Anyone please let me know quickly if you have any objection.

Individual bus drivers may still need to be fixed to properly support
10-bit addresses, and user-space tools as well as they currently don't
support them at all, but this can be added later on as needed.

-- 
Jean Delvare
