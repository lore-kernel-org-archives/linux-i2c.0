From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c/i2c-dev: use dynamic minor allocation
Date: Wed, 24 Nov 2010 22:57:45 +0100
Message-ID: <20101124225745.403d8f5f@endymion.delvare>
References: <1290633788-25767-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1290633788-25767-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Sebastian,

On Wed, 24 Nov 2010 22:23:08 +0100, Sebastian Andrzej Siewior wrote:
> Right now i2c adapter 5 becomes minor 5 allocated. This is fine as long
> as no adapter becomes a number > 256 allocated.

Why would it be a problem to have a minor number > 256 (or more likely
you meant > 255)? Minors beyond 8 bit are supported since quite some
time, aren't they?

> The Sodavile PCI driver uses (devfn << 3 | pci_bar) to come up with an
> unique adapter number. So the first i2c adapter has the number 720.

If you know that the first adapter has the number 720, then you could
simply use (devfn << 3 | pci_bar) - 720 as the adapter number. I don't
know how many such PCI devices a system can have, but presumably the
256 minor limit would be sufficient.

But my main question is: why do you want a unique (or you probably
meant predictable - adapter numbers are already unique by design)
adapter number in the first place? Other systems apparently are doing
just fine without this.

Also, what if another i2c adapter driver comes up with its own idea of how
adapters should be numbered, and its numbering scheme collides with
your driver?

Fixed i2c adapter numbers are already supported, but it's up to the
platform initialization code to define them, not the i2c adapter driver.

> This patch introduces dynamic minor allocation so the minor first
> registered i2c adapter will be zero, next one one and so on. The name
> which is exported to userland remains the same i.e. /dev/i2c-10 for
> adapter number 10 (but its minor number may be zero and not 10).

Are there other subsystems doing this already?

> I don't consider this as an ABI change however if someone does I could
> add make this a CONFIG_ option and migrate in a year or so. i2c-tools
> for instance abort on adapter number > 255 so we have to change this
> in order to get the big numbers working.

i2c-tools could be updated if needed. As for a CONFIG option,
CONFIG_I2C_COMPAT could be used for this. But at this point I still
need to be convinced that there's a need at all.

> Since the minors are not allocated dynamically I lowered the number of
> max i2c devices to 32 so I don't waste much memory for the allocation.
> If one has more than 32 devices then we could increase this again :)

Systems with more than 32 I2C adapters already exist, so lowering to 32
is not acceptable.

-- 
Jean Delvare
