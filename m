From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [sodaville] [PATCH] i2c/i2c-dev: use dynamic minor allocation
Date: Fri, 26 Nov 2010 20:46:32 +0100
Message-ID: <20101126204632.6ff96d57@endymion.delvare>
References: <1290633788-25767-1-git-send-email-bigeasy@linutronix.de>
	<20101124225745.403d8f5f@endymion.delvare>
	<4CEE3DEA.7040107@linutronix.de>
	<20101125225246.59931602@endymion.delvare>
	<20101126180325.GA27332@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101126180325.GA27332-Hfxr4Dq0UpYb1SvskN2V4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Sebastian,

On Fri, 26 Nov 2010 19:03:25 +0100, Sebastian Andrzej Siewior wrote:
> * Jean Delvare | 2010-11-25 22:52:46 [+0100]:
> 
> >Hi Sebastian,
> Hi Jean,
> 
> >> > But my main question is: why do you want a unique (or you probably
> >> > meant predictable - adapter numbers are already unique by design)
> >> > adapter number in the first place? Other systems apparently are doing
> >> > just fine without this.
> >>
> >> Both. I use this number for the device id. This one has to remain unique
> >> or sysfs goes crazy.
> >
> >Which "device id" are you talking about, please? Of course sysfs
> The pci driver [0] has in add_i2c_device() the following construct:
> 
>      pdev->id = dev->devfn << 3 | bar;
> 
> I'm talking about this device id. Here I have to remain unique and here I

Huh? Is pdev a platform device? So you are instantiating platform
devices off a PCI device, and in turn each platform device gets to
create an i2c_adapter device?

Now I understand why you needed to craft a unique id. I don't quite get
why you came up with such a complicated setup in the first place
though. What's wrong with just making the i2c_adapter devices direct
children of the PCI device? Is this a limitation of
of_i2c_register_devices() that it needs platform devices to operate on?

> though using the pci id would be a good idea. There should be no other
> device using "pxa2xx-i2c" as the device name so I should be safe here.

Correct.

> >doesn't accept duplicate entries, but as I said already, uniqueness is
> >
> >Precisions, please. "Match my board description" is awfully vague.
> >Don't hesitate to be technical, I'm sure I can understand you ;)
> Sorry didn't meant to. As you probably know, by "board description" I
> meant struct i2c_board_info & i2c_register_board_info(). This is now
> covered by of_i2c_register_devices(&i2c->adap)

OK, it's clearer now, thanks.

> >> > Fixed i2c adapter numbers are already supported, but it's up to the
> >> > platform initialization code to define them, not the i2c adapter driver.
> >>
> >> I don't want platform init code.
> >
> >Why? This is what (almost) everybody does when predictable i2c adapter
> >numbers are needed. And you said you have platform data, so presumably
> >you already have some form of platform init code (even if it's generic
> >code with a custom device tree.)
> 
> This sounds good. So I get "pdev->id" from the device tree which should
> solve my trouble I have so far.

Sounds good. And now you no longer care about i2c adapter numbers -
they don't have to be correlated to your platform device numbers.

Meanwhile I've updated i2c-tools to support dev minors beyond 255. You
should no longer need this, but at least it's ready if we ever need it.
Who knows, maybe we'll see a system with more than 255 I2C bus segments
someday.

-- 
Jean Delvare
