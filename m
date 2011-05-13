From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 09/13] i2c/i2c-nomadik: add code to retry on timeout failure
Date: Fri, 13 May 2011 11:55:20 +0200
Message-ID: <BANLkTi=iioXgeGANQd_vYFGyL72g_wnHng@mail.gmail.com>
References: <1304977099-31694-1-git-send-email-linus.walleij@linaro.org>
	<20110510222338.GB634@freya.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110510222338.GB634-RazCHl0VsYgkUSuvROHNpA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2011/5/11 Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>:

>> @@ -579,63 +576,67 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
(...)

> this code is getting a bit complicated, could some of it be factored
> into a new sub-function?

Yep I have added a new patch on top of this stack breaking out the single
message transfer. Will repost this now including deletion of the runtime PM
quirks.

Linus Walleij
