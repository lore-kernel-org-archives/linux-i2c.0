From: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Add possibility for user-defined (i2c-)devices
 for bus-drivers.
Date: Thu, 15 Nov 2012 12:44:59 +0100
Message-ID: <50A4D5BB.6010301@ahsoftware.de>
References: <1352829968-4908-1-git-send-email-holler@ahsoftware.de> <1352920954.19432.2.camel@Nokia-N900> <50A42A91.2000202@ahsoftware.de> <1639554.ZUOmHr6Yka@lxtiha>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1639554.ZUOmHr6Yka@lxtiha>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Till Harbaum <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

Am 15.11.2012 12:04, schrieb Till Harbaum:

> There's actually one thing you can do: You device doesn't seem to expose
> the i2c bus, anyway. What you have is an rtc connected via usb. So why not
> move all the i2c intelligence into the device? Do pure usb-rtc's exist?
> Could you perhaps even make your device compatible to one of these?
> Then a driver for this would imho have good chances to find their way into
> the kernel.

Sorry, but I'm satisfied with what I've done and I didn't do it just to 
get "something" into the kernel. I don't need my patches to become part 
of in the kernel, I can handle them by myself. And my free resources to 
submit patches just became exhausted (again). Maybe in some weeks or 
month ..., I don't know.

Regards,

Alexander
