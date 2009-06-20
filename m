From: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Subject: Re: [RFC] Fix stuck on cpm-i2c driver
Date: Sat, 20 Jun 2009 16:40:51 +0200
Message-ID: <4A3CF4F3.4030002@scram.de>
References: <20090619125002.GA17067@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090619125002.GA17067-f9ZlEuEWxVeACYmtYXMKmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Trimarchi <michael-YOzL5CV4y4YG1A2ADO40+w@public.gmane.org>
Cc: bruno-YOzL5CV4y4YG1A2ADO40+w@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trimarchi-f9ZlEuEWxVeACYmtYXMKmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

> This happen because though the wait_event_interruptible_timeout takes the
> signals into account, the driver does not handle them.
> We propose to change the wait_event_interruptible_timeout with
> wait_event_timeout, leaving the signals to be handled in other points
> on the upper layers.

Makes sense. I2C transactions better shouldn't be interrupted or
data loss might happen.

> Signed-off-by: Bruno Morelli <bruno-YOzL5CV4y4YG1A2ADO40+w@public.gmane.org>
> Signed-off-by: Michael Trimarchi <michael-YOzL5CV4y4YG1A2ADO40+w@public.gmane.org>

Acked-by: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>

Thanks,
Jochen
