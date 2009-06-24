From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Looking for help writing an i2c client for i2c-core
Date: Wed, 24 Jun 2009 10:37:45 +0200
Message-ID: <63386a3d0906240137r5f30b242q5526ac926526fcd6@mail.gmail.com>
References: <Acnztit3TDXTYlAdQgGYzwdBmb7Njg==>
	 <7BD054A954B148E7B69442B1AC498484@footfall>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7BD054A954B148E7B69442B1AC498484@footfall>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Tompson <brian.tompson-4c4C/Gi1/tVWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

2009/6/23 Brian Tompson <brian.tompson-4c4C/Gi1/tVWk0Htik3J/w@public.gmane.org>:

> I am trying to write an i2c client driver for the i2c core, using the Linux
> Driver Model (new style driver).

I don't get the whole view of what you actually want to do but you
might be wanting to create a "MFD" multi-functional device driver.

Look at e.g. drivers/mfd/wm8350-core.c and how that driver
spawns a number of sub-platform devices which are then used
by e.g. drivers/regulator/wm8350-regulator.c

Linus
