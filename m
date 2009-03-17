From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Q] i2c_new_device vs i2c_del_driver
Date: Tue, 17 Mar 2009 18:38:09 +0100
Message-ID: <20090317183809.55320908@hyperion.delvare>
References: <Pine.LNX.4.64.0903171710350.5318@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0903171710350.5318-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Guennadi,

On Tue, 17 Mar 2009 18:24:49 +0100 (CET), Guennadi Liakhovetski wrote:
> I have a question regarding dynimically created i2c devices. If I have a 
> card with an i2c device on it. Once I load a driver for that card, it uses 
> its knowledge of the hardware and registers a new i2c device using 
> i2c_new_device. Then at some point a driver for that i2c device is loaded, 
> it calls i2c_add_driver, then its probe() method is called with the 
> dynamically created device. So far so good. Now I unload the i2c driver, 
> it calls i2c_del_driver(), and then, IIUC, __detach_adapter will be called 
> for all devices attached to this driver,

Actually,  __detach_adapter will be called for all *adapters* on the
system. Then in turn __detach_adapter does a number of actions on
devices present on said adapters.

> including our device from above, 

No. Your driver is a new-style one (otherwise you couldn't use
i2c_new_device) which means that __detach_adapter returns relatively
quickly. The only part of __detach_adapter which is run is the one
which removes auto-instantiated devices. This isn't the case of your
device (you instantiated it explicitly) so __detach_adapter is a no-op
for you.

> then i2c_unregister_device will be called for it, a comment to which says
> 
> "reverse effect of i2c_new_device()"
> 
> So, our newly created device is gone, and loading the i2c driver again 
> will not find it any more?... This doesn't seem to be the case, so, I 
> think, the comment is wrong and has to be fixed.

The comment is correct. What isn't is your understanding of the
(admittedly complex and often confusing) i2c-core code. But I hope to
solve it soon, by killing the legacy binding model altogether.

In the meantime, if you have more questions, I will be pleased to
answer them.

-- 
Jean Delvare
