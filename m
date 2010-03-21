From: matthieu castet <castet.matthieu@free.fr>
Subject: i2c interface bugs in dvb drivers
Date: Sun, 21 Mar 2010 15:02:50 +0100
Message-ID: <4BA6270A.4050703@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070503020102010101070801"
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--------------070503020102010101070801
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

some dvb driver that export a i2c interface contains some mistakes because they mainly used by driver (frontend, tuner) wrote for them.
But the i2c interface is exposed to everybody.

One mistake is expect msg[i].addr with 8 bits address instead of 7 bits address. This make them use eeprom address at 0xa0 instead of 0x50. Also they shift tuner address (qt1010 tuner is likely to be at address 0x62, but some put it a 0xc4 (af9015, af9005, dtv5100)).

Other mistakes is in xfer callback. Often the controller support a limited i2c support (n bytes write then m bytes read). The driver try to convert the linux i2c msg to this pattern, but they often miss cases :
- msg[i].len can be null
- msg write are not always followed by msg read

And this can be dangerous if these interfaces are exported to userspace via i2c-dev :
- some scanning program avoid eeprom by filtering 0x5x range, but now it is at 0xax range (well that should happen because scan limit should be 0x77)
- some read only command can be interpreted as write command.


What should be done ?
Fix the drivers.
Have a mode where i2c interface are not exported to everybody.
Don't care.

First why does the i2c stack doesn't check that the address is on 7 bits (like the attached patch) ?

Also I believe a program for testing i2c interface corner case should catch most of these bugs :
- null msg[i].len
- different transactions on a device :
 - one write/read transaction
 - one write transaction then one read transaction
[...]

Does a such program exist ?


Matthieu

PS : please keep me in CC


--------------070503020102010101070801
Content-Type: text/x-diff;
 name="i2c_check.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_check.diff"

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 3202a86..91e63ea 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1150,6 +1150,17 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 				(msgs[ret].flags & I2C_M_RECV_LEN) ? "+" : "");
 		}
 #endif
+		for (ret = 0; ret < num; ret++) {
+			if (msgs[ret].flags & I2C_M_TEN) {
+				/* XXX what"s I2C_M_TEN range */
+				if (msgs[ret].addr < 0x03 || msgs[ret].addr > 0x377)
+					return -EINVAL;
+			}
+			else {
+				if (msgs[ret].addr < 0x03 || msgs[ret].addr > 0x77)
+					return -EINVAL;
+			}
+		}
 
 		if (in_atomic() || irqs_disabled()) {
 			ret = rt_mutex_trylock(&adap->bus_lock);

--------------070503020102010101070801--
