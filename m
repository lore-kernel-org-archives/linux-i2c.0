From: Matthew Karas <mkarascybi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Fwd: Initializing drivers for i2c devices that use reserved i2c
 addresses ( as1115 default i2c address of 0x00)
Date: Wed, 22 Apr 2015 08:16:19 -0400
Message-ID: <CADu_VSa35-yiNGYVukKyN9ks9OLJ=q8D9xPgvLaXhTiJT5WW7w@mail.gmail.com>
References: <CADu_VSZf58F_dJJCnuca-S1ismJX56aHBJ5rkqAdZOgXH+ojhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CADu_VSZf58F_dJJCnuca-S1ismJX56aHBJ5rkqAdZOgXH+ojhg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I am writing a device driver for the as1115.  It is the only device on
the bus I am using. The part powers up with a default address of 0x00.
I've added the as1115 into the device tree.

Due to i2c_check_addr_validity checking and seeing that the as1115's
boot address is invalid when it's running the probe.  The
i2c_check_addr_validity function states that parts that use reserved
addresses shouldn't be probed.

I was wondering how I would be able to initialize the device without
using the probe function which provides the i2c_client pointer that
that I need and actually write to the device, and also I can use to
setup the irq.

Link to part info:
http://ams.com/eng/Products/Lighting-Management/LED-Driver-ICs/AS1115

Many thanks
