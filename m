From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 3/3] i2c: i2c-core: fix coding style issues in i2c-core.c
Date: Tue, 14 Jan 2014 11:06:37 -0800
Message-ID: <1389726397.24849.47.camel@joe-AO722>
References: <525C0CDB.6020305@gmail.com> <20140114183845.GD10340@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140114183845.GD10340@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: RAGHAVENDRA GANIGA <ravi23ganiga@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2014-01-14 at 19:38 +0100, Wolfram Sang wrote:
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -1737,9 +1737,9 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> >  		for (ret = 0; ret < num; ret++) {
> >  			dev_dbg(&adap->dev, "master_xfer[%d] %c, addr=0x%02x, len=%d%s\n",
> >  				ret,
> > -				((msgs[ret].flags & I2C_M_RD) ? 'R' : 'W'),
> > +				msgs[ret].flags & I2C_M_RD ? 'R' : 'W',
> >  				msgs[ret].addr, msgs[ret].len,
> > -				(msgs[ret].flags & I2C_M_RECV_LEN) ? "+" : "");
> > +				msgs[ret].flags & I2C_M_RECV_LEN ? "+" : "");
> 
> Don't spend time changing too much here like the paranthesis. It will
> probably be removed soon in favour of the tracing approach.

That'd be good.  There are a lot of function tracing style
dev_dbg uses in i2c-core that can be removed.

Just an fyi not to Raghavendra:

This sort of loop could have been further modified removing
the unnecessary #if DEBUG/#endif too

Also, reusing ret for a loop index is efficient, but a bit odd.

Maybe something like:

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index d74c0b3..5ca078e 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1758,14 +1758,13 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	 */
 
 	if (adap->algo->master_xfer) {
-#ifdef DEBUG
-		for (ret = 0; ret < num; ret++) {
-			dev_dbg(&adap->dev, "master_xfer[%d] %c, addr=0x%02x, "
-				"len=%d%s\n", ret, (msgs[ret].flags & I2C_M_RD)
-				? 'R' : 'W', msgs[ret].addr, msgs[ret].len,
-				(msgs[ret].flags & I2C_M_RECV_LEN) ? "+" : "");
-		}
-#endif
+		int i;
+
+		for (i = 0; i < num; i++)
+			dev_dbg(&adap->dev, "master_xfer[%d] %c, addr=0x%02x, len=%d%s\n",
+				ret, msgs[i].flags & I2C_M_RD ? 'R' : 'W',
+				msgs[i].addr, msgs[i].len,
+				msgs[i].flags & I2C_M_RECV_LEN ? "+" : "");
 
 		if (in_atomic() || irqs_disabled()) {
 			ret = i2c_trylock_adapter(adap);
