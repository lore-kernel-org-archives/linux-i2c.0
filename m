From: Frank Bormann <fbormann-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: platform_data in i2c device drivers
Date: Wed, 19 Mar 2014 18:32:50 -0400
Message-ID: <532A1B12.8080400@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Everyone,

I am looking at the i2c_pca954x i2c bus mux driver in linux-stable. My goal is 
to have the slave buses show up in Linux with static bus numbers. Ideally, I 
want to define the first bus number to use in the dtb.

It seems, the driver has already some support for static bus numbers as its 
probe function checks for the existence of a struct pca954x_platform_data 
instance in client->dev.platform_data and pca954x_platform_mode struct it points 
to has a member adap_id that seems to be doing exactly that judging by its 
documentation. However, calls made to pca954x_probe always have to platform_data 
pointer being passed in through client set to null.

In addition to that, the recent addition to the driver of a reset gpio to be 
configured reads directly from the dtb in the probe function.

I am unsure about how to set this up properly. On one hand, platform_data is 
being passed in to the probe function, which seem to indicate, there may be some 
generic place in the i2c core code to set driver-specific configuration, on the 
other hand, the recent reset gpio addition to the driver seems to indicate that 
the driver's probe function is in fact the right place to read additional 
configuration from the dtb.

Any help is greatly appreciated.

Thanks,
Frank
