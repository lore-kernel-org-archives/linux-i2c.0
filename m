From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [sodaville] [PATCH] i2c/i2c-dev: use dynamic minor allocation
Date: Fri, 26 Nov 2010 22:14:09 +0100
Message-ID: <20101126211409.GA743@www.tglx.de>
References: <1290633788-25767-1-git-send-email-bigeasy@linutronix.de> <20101124225745.403d8f5f@endymion.delvare> <4CEE3DEA.7040107@linutronix.de> <20101125225246.59931602@endymion.delvare> <20101126180325.GA27332@www.tglx.de> <20101126204632.6ff96d57@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101126204632.6ff96d57-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

* Jean Delvare | 2010-11-26 20:46:32 [+0100]:

>Hi Sebastian,
Hi Jean,

>Huh? Is pdev a platform device? So you are instantiating platform
>devices off a PCI device, and in turn each platform device gets to
>create an i2c_adapter device?
Yup, exactly.

>Now I understand why you needed to craft a unique id. I don't quite get
>why you came up with such a complicated setup in the first place
>though. What's wrong with just making the i2c_adapter devices direct
>children of the PCI device? Is this a limitation of
>of_i2c_register_devices() that it needs platform devices to operate on?
No. In the end we have one driver which may get probed viaa  PCI device
or a platform device. This leaves me two choices: 
- create a platform device out of the PCI device like I did
- add PCI probing code to the platform driver so it provides two
  interfaces

If you are look at the i2c_pxa_probe() function then you'll notice
that there is no real cut between obtaining ressource informations and
setting up the i2c device. So this would require to split this function
into pieces and share the code between those two interfaces. While
looking at it, I decided against the split.
This way the patch way smaller and simpler. I don't see a disadvantage
with the platform device here. Well maybe the pdev->id problem :)

>Meanwhile I've updated i2c-tools to support dev minors beyond 255. You
>should no longer need this, but at least it's ready if we ever need it.
>Who knows, maybe we'll see a system with more than 255 I2C bus segments
>someday.

Yeah, I don't right now.

Sebastian
