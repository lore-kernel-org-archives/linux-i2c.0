From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: New home for i2c-tools (RFC)
Date: Thu, 29 Jan 2009 10:37:17 +0100
Message-ID: <20090129103717.025661db@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, Paul Goyette <paul-3orOWTcw9wBWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

I am in the process of moving i2c-tools away from lm-sensors.org to a
new home. My reasons for doing this are:
* The i2c tools are useful way beyond lm-sensors, and on the other hand
  lm-sensors works fine on many recent systems without I2C support at
  all. There has been a lot of confusion about i2c and lm-sensors in
  the past and I hope that moving i2c-tools somewhere else will help
  put an end to it.
* Administration of lm-sensors.org isn't always as good as I would
  like. I am not blaming our host, we get everything for free and it
  isn't that bad, but apparently our admin is busy with more important
  things so I don't want to put additional load on him.
* I hope that a clean, simple, standalone project will more easily
  attract extra developers.

Now the question is: where do we go? At first I had considered Savannah
[1], essentially because I have other projects hosted there. One
problem though is that they are rather strict when it comes to
licenses. In particular, GPL v2 only code isn't good enough for them,
while one piece of i2c-tools is released under that license.

[1] https://savannah.nongnu.org/

An alternative I have considered since then is to put the code on
kernel.org. After all, i2c-tools are tightly linked to the Linux
kernel at the moment.

There are pros and cons both ways. At Savannah we'd have a Subversion
tree, which is what we already have for i2c-tools at the moment so
importing the code should be easy. Creating accounts for extra
contributors is easy. We get a bug tracking system and web space.

At kernel.org, we would have a git tree. More powerful than Subversion,
but also a little more complicated, and we probably don't need that
much power for such a small project. I'm not sure how easy it is to
import a Subversion repository into a git tree. No bug tracking system.
No accounts for contributors. The web pages would probably go in
i2c.wiki.kernel.org. Might become a little confusing if i2c-tools ever
supports another OS than Linux.

And there are other options available, such as Gna! or BerliOS. Never
used these myself though.

[2] https://gna.org/
[3] http://developer.berlios.de/

As far as I am concerned, I can live with all options, but what I
really want to know is: which option would potential future
contributors prefer? Please speak up if you care!

Thanks,
-- 
Jean Delvare
