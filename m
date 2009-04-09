From: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
Subject: Re: Handling of i2c arbitration loss
Date: Thu, 9 Apr 2009 10:35:53 +0200
Message-ID: <20090409083553.GA20058@clifford.at>
References: <200901081155.27866.david-b@pacbell.net> <20090109100145.GA12376@clifford.at> <20090214121745.39dfddf9@hyperion.delvare> <20090214180014.GA19352@clifford.at> <20090215113122.5bcc3f3d@hyperion.delvare> <20090216131026.GA17437@clifford.at> <20090219172605.7e70a797@hyperion.delvare> <20090219212325.GC16107@clifford.at> <20090220124546.193e49f2@hyperion.delvare> <20090409084726.3f2bd193@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090409084726.3f2bd193-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Thu, Apr 09, 2009 at 08:47:26AM +0200, Jean Delvare wrote:
> Clifford, any news? I didn't get any update for this patch. If I don't
> get one soon, I'll have to just discard it.

oops. has been pretty busy the last weeks...

here is an updated version of the patch (based on the current linus git
tree). The only change is that I have moved the initialization of the
orig_jiffies variables. Afair we agreed on having adapter->timeout in
jiffies and I remeber that you also have made already a patch to unify this
for the entire i2c subsystem..

I can't test it until next week, but the changes are trivial. I also have
on my todo list for next week to cleanup my i2c-mpc patches and send those
parts which are still required after the changes in i2c-core again (I think
they have all been removed from the -mm tree already)..

yours,
 - clifford

--snip--

i2c: Retry automatically on arbitration loss

some small changes in i2c core to retry i2c xfers until eighter the
maximum number of retries or the timeout is hit.

Signed-of-by: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index b6f3a0d..de8a0bf 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1023,7 +1023,8 @@ module_exit(i2c_exit);
  */
 int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
-	int ret;
+	unsigned long orig_jiffies;
+	int ret, try;
 
 	/* REVISIT the fault reporting model here is weak:
 	 *
@@ -1061,7 +1062,15 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 			mutex_lock_nested(&adap->bus_lock, adap->level);
 		}
 
-		ret = adap->algo->master_xfer(adap,msgs,num);
+		/* Retry automatically on arbitration loss */
+		orig_jiffies = jiffies;
+		for (ret = 0, try = 0; try <= adap->retries; try++) {
+			ret = adap->algo->master_xfer(adap, msgs, num);
+			if (ret != -EAGAIN)
+				break;
+			if (time_after(jiffies, orig_jiffies + adap->timeout))
+				break;
+		}
 		mutex_unlock(&adap->bus_lock);
 
 		return ret;
@@ -1996,14 +2005,26 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
 		   char read_write, u8 command, int protocol,
 		   union i2c_smbus_data *data)
 {
+	unsigned long orig_jiffies;
+	int try;
 	s32 res;
 
 	flags &= I2C_M_TEN | I2C_CLIENT_PEC;
 
 	if (adapter->algo->smbus_xfer) {
 		mutex_lock(&adapter->bus_lock);
-		res = adapter->algo->smbus_xfer(adapter,addr,flags,read_write,
-						command, protocol, data);
+
+		/* Retry automatically on arbitration loss */
+		orig_jiffies = jiffies;
+		for (res = 0, try = 0; try <= adapter->retries; try++) {
+			res = adapter->algo->smbus_xfer(adapter, addr, flags,
+							read_write, command,
+							protocol, data);
+			if (res != -EAGAIN)
+				break;
+			if (time_after(jiffies, orig_jiffies + adapter->timeout))
+				break;
+		}
 		mutex_unlock(&adapter->bus_lock);
 	} else
 		res = i2c_smbus_xfer_emulated(adapter,addr,flags,read_write,
-- 
1.5.6.1
