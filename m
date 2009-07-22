From: "Dongsoo, Nathaniel Kim" <dongsoo.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: About a suspicious msleep during doxfer in s3c2410 i2c bus driver
Date: Wed, 22 Jul 2009 17:12:17 +0900
Message-ID: <5e9665e10907220112m1dbf4975icf1511bc4ac3a1bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?B?66+867OR7Zi4?= <bhmin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dongsoo Kim <dongsoo45.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, jsgood.yang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

Since I was working on S3C64XX and C1XX, I found something weird on
I2C bus device.
The thing is that when I try to write multiple registers through I2C
bus, it takes much more time for multiple registers to be written than
any other processor's i2c bus device.
I tracked down for which point does it take and finally found out that
following msleep was making a tremendous delay when I try to write
thousands of registers through I2C bus. Please look at this.

481 static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
482                               struct i2c_msg *msgs, int num)
483 {

<snip>

521         /* ensure the stop has been through the bus */
522
523         msleep(1);


With several different target boards using s3c64xx and s5pc1xx, it
went good without that msleep(). And of course it is working great
with multiple i2c device attached as well.
So, I want to ask Ben and anyone else using I2C device about removing
that msleep might be ok or not. In my case, it went ok. Please let me
know your opinion.
Cheers,

Nate

-- 
=
DongSoo, Nathaniel Kim
Engineer
Mobile S/W Platform Lab.
Digital Media & Communications R&D Centre
Samsung Electronics CO., LTD.
e-mail : dongsoo.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
          dongsoo45.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
