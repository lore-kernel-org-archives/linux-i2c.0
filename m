From: alfred steele <alfred.jaquez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: i2c driver for mxc platform
Date: Mon, 15 Mar 2010 13:00:42 -0500
Message-ID: <528f13591003151100q29984964n99828cccad075d41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi ,


Looks like there is some discrepancy with the mxc i2c driver.

In this portion of the mxc_i2c_stop()  routine, the MSTA bit is
cleared(1to 0) to generate a stop condition but there is no  state
check whatsoever before for the IBB bit (bus busy bit is set or not)

while (retry-- && ((sr & MXC_I2SR_IBB))) {
        udelay(3);
        sr = readw(dev->membase + MXC_I2SR);

I am not sure what SCL frequency has been tested with  for the
"udelay(3)". Is that a sufficient wait on busses set to run on the
traditional slow rate(bit rate upto 100 kbps?

I am curious.

Thanks,
Alfred.
