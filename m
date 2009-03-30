From: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] I2C driver for MXC
Date: Mon, 30 Mar 2009 12:11:45 +0300
Message-ID: <49D08CD1.4080901@gmail.com>
References: <49C89E13.7040801@gmail.com> <20090324094215.GA3471@pengutronix.de>  <49C8ABE5.40408@gmail.com> <20090325092625.GA3029@pengutronix.de>  <49CA017D.20005@gmail.com> <20090325104357.GB3029@pengutronix.de>  <Pine.LNX.4.64.0903282207480.9903@axis700.grange> <d7f267fd0903300048p7caee6e0ne63916b986b132b@mail.gmail.com> <Pine.LNX.4.64.0903301124040.4455@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0903301124040.4455-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guennadi Liakhovetski <public-g.liakhovetski-Mmb7MZpHnFY-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>
Cc: Darius Augulis <public-augulis.darius-Re5JQEeQqe8AvxtiuMwx3w-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>, Wolfram Sang <public-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>, public-linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org, public-linux-i2c-u79uwXL29TY76Z2rM5mHXA-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org, Sascha Hauer <public-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



Guennadi Liakhovetski wrote:
 > Hi Darius,
 >
 > On Mon, 30 Mar 2009, Darius Augulis wrote:
 >
 >> I tested your driver on i.MXL with OV7670 and MT9V111 cameras. I confirm it
 >> works.
 >
 > Thanks for testing!
 >
 >> In otherside, my driver is also tested with OV7670, MT9V111, OV7720 cameras,
 >> PCF8575 expander and NT7651 LCD controller. All these devices work connected
 >> to i.MXL.
 >> If you have problems on MX3 only with single device, it may be caused by
 >> some specific conditions.
 >> I don't know it is good idea to replace one driver by another, because we
 >> don't know where is the problem exactly.
 >> Of course would be fine to watch your I2C bus with oscilloscope. So you
 >> could see what is wrong.
 >> IMO we should find what is wrong in my driver, to have good working driver
 >> for all MXC SoC's.
 >> If we replace it by your driver, we miss lot of ML comments fixed and
 >> probably we will receive errors and problems in some different situation.
 >
 > Well, I have been able to get your driver to at least pass the
 > initialisation with mt9t031 (other parts are missing yet for a complete
 > test). For that I used this silly patch:
 >
 > diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
 > index 3296380..46e1033 100644
 > --- a/drivers/i2c/busses/i2c-imx.c
 > +++ b/drivers/i2c/busses/i2c-imx.c
 > @@ -371,6 +371,8 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 >  	if (result)
 >  		goto fail0;
 >
 > +	msleep(2);
 > +
 >  	/* Start I2C transfer */
 >  	i2c_imx_start(i2c_imx);
 >
 > As you understand, this cannot be the final fix. We have to understand why
 > a delay is needed there and how long it actually has to be...

It's strange. You delay the beginning of I2C transfer.
It is only one thing, which makes my driver working in your application?


 >
 > Thanks
 > Guennadi
 > ---
 > Guennadi Liakhovetski, Ph.D.
 > Freelance Open-Source Software Developer
