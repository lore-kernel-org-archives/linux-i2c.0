From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: how to gracefully unload an i2c driver if chip not detected?
Date: Tue, 9 Apr 2013 11:26:25 +0200
Message-ID: <20130409092625.GD3624@the-dreams.de>
References: <931575758.126890.1363615027376.JavaMail.root@mail>
 <35709576.270615.1363618046395.JavaMail.root@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <35709576.270615.1363618046395.JavaMail.root@mail>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-15?Q?=C9meric?= Vigier <emeric.vigier-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


> I recently changed the sensor on my board. Leading to kernel crash
> when entering suspend. Thanks to "no_console_suspend" cmdline
> argument, I found out that the suspend function of the "absent" chip
> gets called. It tries to take a mutex which has been freed in probe's
> "device not found" fallback code. Leading to kernel panic.

Can we have the full driver? The snipplet is not enough.
