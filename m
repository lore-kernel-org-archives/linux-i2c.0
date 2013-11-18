From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PULL REQUEST] i2c for 3.13
Date: Mon, 18 Nov 2013 15:46:34 -0800
Message-ID: <CA+55aFxZaC=beR+dN36Sv==6fjY7SdOdwXaSHU+wnk+-oDJp4g@mail.gmail.com>
References: <20131118193802.GA14925@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131118193802.GA14925@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 18, 2013 at 11:38 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
> here is the pull request from the i2c subsystem for 3.13:

So while resolving some fairly trivial conflicts here, I noticed that
commit a76e9bd89ae7 ("i2c: attach/detach I2C client device to the ACPI
power domain") that I got earlier through the ACPI/PM tree calls
acpi_dev_pm_detach() even when the device "->remove()" function fails.
But it only sets clientdata to NULL if it succeeds.

That looks a bit odd.

I didn't try to fix it, though. I just thought I'd point out the oddity.

                 Linus
