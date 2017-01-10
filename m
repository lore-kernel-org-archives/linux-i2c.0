From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH linux 2/6] hwmon: occ: Add sysfs interface
Date: Tue, 10 Jan 2017 11:41:44 -0600
Message-ID: <1484070104.21117.29.camel@kernel.crashing.org>
References: <1483120568-21082-1-git-send-email-eajames.ibm@gmail.com>
         <1483120568-21082-3-git-send-email-eajames.ibm@gmail.com>
         <20161230193404.GB8516@roeck-us.net>
         <OFA812992D.D19B1368-ON002580A0.007A2966-862580A0.007A72F0@notes.na.collabserv.com>
         <8b182766-32a0-9eb1-7917-14abf811cef5@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <8b182766-32a0-9eb1-7917-14abf811cef5@roeck-us.net>
Sender: linux-doc-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Edward James <eajames@us.ibm.com>
Cc: andrew@aj.id.au, corbet@lwn.net, devicetree@vger.kernel.org, eajames.ibm@gmail.com, jdelvare@suse.com, joel@jms.id.au, linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, wsa@the-dreams.de
List-Id: linux-i2c@vger.kernel.org

On Sat, 2017-01-07 at 09:15 -0800, Guenter Roeck wrote:
> > Instead of the "online" attribute, what do you think about using the
> > "bind"/"unbind" API to probe the device from user space once the system
> > is powered on? All the hwmon registration would take place in the probe
> > function, it would just occur some time after boot.
> > 
> 
> A more common approach would be to have a platform driver. That platform
> driver would need a means to detect if the OCC is up and running, and
> instantiate everything else once it is.
> 
> A trigger from user space is problematic because there is no guarantee
> that the OCC is really up (or that it even exists).
> 
> An alternative might be to have the hwmon driver poll for the OCC,
> but that would be a bit more difficult and might require a kernel thread
> or maybe asynchronous probing.

Hi Guenter !

I'm not sure I agree with you here ;-)

I'm don't know how much background you got (I missed the beginning of
the discussion) but basically this driver runs on the BMC (system
controller) of the POWER9 server, the OCC is inside the POWER9 chip
itself.

So the presence/power state of the OCC doesn't depend on the BMC
platform kernel code. The BMC userspace controls power up and down to the POWER9, and thus it's the one to know whether the remote is up.

If we were to create a "platform driver", all it would do is get input
from userspace exactly like that sysfs file :-)

So if you don't like the sysfs file that registers/de-registers, which
I sort-of understand, it's a bit of a hack (though a rather efficient
one), I think the bind/unbind approach makes sense. However, I wonder
whether the simplest and most efficient (remember this BMC has a really
slow CPU) is an "online" file sysfs file, though rather than
registering/de-registering the hwmon it would simply make it stop
accessing the HW (and return some known "offline" values).

Cheers,
Ben.

