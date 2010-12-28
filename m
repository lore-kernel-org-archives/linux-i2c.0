From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: soc_camera Client Driver with Multiple I2C Addresses
Date: Tue, 28 Dec 2010 08:55:41 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1012280810140.21647@axis700.grange>
References: <E58C9D0E73364C3EB14B6D0A0EBB5433@RSI50>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E58C9D0E73364C3EB14B6D0A0EBB5433@RSI50>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Charles D. Krebs" <ckrebs-2y/nJPa2at/U1o9X0QyN+VaTQe2KTcn/@public.gmane.org>
Cc: Linux Media Mailing List <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Charles

(linux-i2c added to cc)

On Mon, 27 Dec 2010, Charles D. Krebs wrote:

> Guennadi,
> 
> I'm developing a driver for a video receiver chip that has register 
> banks on multiple I2C addresses on the same bus.  The data output is 
> parallel and I will be connecting it to the sh host interface.  
> Overall, the device appears to be suitable as a client driver to 
> soc_camera.
> 
> I'm following the model for the MT9T112 driver, and this works just fine 
> for communicating to any one of the device's I2C addresses.
> 
> How would you recommend registering more than one I2C address to an 
> soc_camera client driver?

Honestly - don't know. The soc-camera model for now is pretty simple and 
in some senses restrictive. But in principle, it should be possible to 
code your case within its scope too. One of the possibilities would be to 
register your platform data with one "main" i2c unit / address, and then 
let the sensor register the rest in its probe. Is your chip configuration 
fixed? Always the same number of i2c units with the same addresses? Or can 
it vary? Maybe something like a multi-function device (drivers/mfd) would 
suit your purpose well?

In fact, I think, it shouldn't be too complicated. As suggested above, 
provide (but don't register, just follow other soc-camera platforms) one 
main i2c device in the platform data, register the rest in your main 
probe(), which will call your further probe()s. The easiest would be to 
keep just one soc-camera instance and one v4l2-subdeice, but if you want, 
you can explore the possibility of creating several v4l2-subdevices.

Hope, this helps.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
