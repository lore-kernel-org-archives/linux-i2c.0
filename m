From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: driver for the Synopsys DesignWare I2C controller
Date: Tue, 2 Jun 2009 08:57:32 +0200
Message-ID: <63386a3d0906012357u398748efo925bfd801ad5ca50@mail.gmail.com>
References: <1242725005-6431-1-git-send-email-baruch@tkos.co.il>
	 <63386a3d0905271223k470bb89elbbb566b68c0d7cd7@mail.gmail.com>
	 <20090528041051.GB4855@tarshish>
	 <63386a3d0905280032x7f427213t2b9b027d5be2a472@mail.gmail.com>
	 <20090531052345.GB14148@tarshish>
	 <20090601225354.GB18453@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090601225354.GB18453-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

2009/6/2 Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>:

>> > I don't think any platform_device tagged with __devinit is
>> > correct really, platform_device:s cannot  be hotplugged that's
>> > against the definition of a platform_device.
>
> I disagree, just beucase they aren't in general doesn't mean they
> cannot be. I have been looking at an implementation which uses
> hotplug to generate devices from a board description file.

OK I stand corrected!

Linus Walleij
