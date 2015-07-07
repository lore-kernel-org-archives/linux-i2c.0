From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: i801: add support of Host Notify
Date: Tue, 7 Jul 2015 23:00:19 +0200
Message-ID: <20150707230019.5d70c26a@endymion.delvare>
References: <1435085899-11017-1-git-send-email-benjamin.tissoires@redhat.com>
	<1435085899-11017-3-git-send-email-benjamin.tissoires@redhat.com>
	<20150707201125.66b2b5b9@endymion.delvare>
	<20150707201638.GK18484@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150707201638.GK18484-/m+UfqrgI5QNLKR9yMNcA1aTQe2KTcn/@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 7 Jul 2015 16:16:38 -0400, Benjamin Tissoires wrote:
> On Jul 07 2015 or thereabouts, Jean Delvare wrote:
> > So you use the same driver callback for SMBus Alert and SMBus Host
> > Notify. This makes some sense, but if a given driver supports both, how
> > does it know which event happened? The data is completely different and
> > most probably the action required from the driver as well.
> 
> Yeah, this gets messy. I re-used the .alert() callback because of the
> documentation:  "Alert callback, for example for the SMBus alert protocol".
> It would seem that the alert is generic and could be re-used. But OTOH,
> it is not prepared to receive anything else than a SMBus Alert.
> 
> Given that I had a toggle_host_notify() call, I figured that this was
> not a problem unless you write a driver which implements both (I can not
> find a sane use case for this though).
> 
> But now that this call has disappeared, we would need a way to
> differentiate the too of them.
> 
> I can see two solutions out of my head right now:
> - add a "protocol" parameter (with an enum) to .alert()
> - add a new callback .host_notify() in struct i2c_driver.

I came to the same conclusion.

> I think I like the second option more given that it will allow to not
> touch the current code in i2c_smbus.

No strong preference so do it the way you prefer.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
