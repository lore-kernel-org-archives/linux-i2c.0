From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Don't depend on other kernel driver config
 options
Date: Sun, 15 May 2011 13:12:28 +0200
Message-ID: <20110515131228.59e14178@endymion.delvare>
References: <20110513120100.4d47410a@endymion.delvare>
 <1305282187.30435.343.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1305282187.30435.343.camel-W2I5cNIroUsVm/YvaOjsyQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Woodhouse, David" <david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Fri, 13 May 2011 11:23:06 +0100, Woodhouse, David wrote:
> On Fri, 2011-05-13 at 11:01 +0100, Jean Delvare wrote:
> > Don't let other driver config options influence us, as it makes the
> > code more complex and fragile for a small benefit. There's nothing
> > wrong with instantiating I2C devices even if they don't have a driver.
> > And we're talking about 835 extra bytes in the binary on x86-64,
> > that's hardly worth arguing about. 
> 
> Looks sane to me; thanks. Should it be CONFIG_DMI instead of (or in
> addition to) CONFIG_X86?

Instead of, no. IA64 has DMI but doesn't want this code.

In addition to, yes, that would make sense. I expected the extra code to
transparently vanish when CONFIG_DMI isn't set, but gcc is apparently
not smart enough for this, so it could use some help.

BTW, it may be desirable to make the apanel part depend on DMI, even if
DMI is technically not needed to find the slave address. Scanning the
BIOS memory for an arbitrary string is costly (a minimum of 4096 calls
to check_signature(), which in turn calls readb() at least once, in the
negative case.) Checking for the DMI vendor first should be way less
costly for the negative case.

I'll submit a new patch set later today, thanks for the suggestions.

-- 
Jean Delvare
