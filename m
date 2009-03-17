From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: [Q] i2c_new_device vs i2c_del_driver
Date: Tue, 17 Mar 2009 18:24:49 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0903171710350.5318@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

I have a question regarding dynimically created i2c devices. If I have a 
card with an i2c device on it. Once I load a driver for that card, it uses 
its knowledge of the hardware and registers a new i2c device using 
i2c_new_device. Then at some point a driver for that i2c device is loaded, 
it calls i2c_add_driver, then its probe() method is called with the 
dynamically created device. So far so good. Now I unload the i2c driver, 
it calls i2c_del_driver(), and then, IIUC, __detach_adapter will be called 
for all devices attached to this driver, including our device from above, 
then i2c_unregister_device will be called for it, a comment to which says

"reverse effect of i2c_new_device()"

So, our newly created device is gone, and loading the i2c driver again 
will not find it any more?... This doesn't seem to be the case, so, I 
think, the comment is wrong and has to be fixed.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
