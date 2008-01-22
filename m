From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2/2] I2C: ISP1301_OMAP: New-style i2c driver updates,
 part 2
Date: Tue, 22 Jan 2008 18:56:15 +0100
Message-ID: <20080122185615.4a8ebbea@hyperion.delvare>
References: <1199379597-6273-1-git-send-email-me@felipebalbi.com>
	<1199379597-6273-2-git-send-email-me@felipebalbi.com>
	<1199379597-6273-3-git-send-email-me@felipebalbi.com>
	<20080122130158.4d4d44dc@hyperion.delvare>
	<31e679430801220413j763589b0j171873c9a90a3cb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757079AbYAVR4d@vger.kernel.org>
In-Reply-To: <31e679430801220413j763589b0j171873c9a90a3cb3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net, tony@atomide.com, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 22 Jan 2008 14:13:58 +0200, Felipe Balbi wrote:
> On Jan 22, 2008 2:01 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > On Thu,  3 Jan 2008 11:59:57 -0500, Felipe Balbi wrote:
> > > -     if (machine_is_omap_h2())
> > > -             omap_free_gpio(2);
> > > -
> >
> > Why?
> 
> Board specific code should go to board files. I'll try to find a
> better way of doing this. Maybe using a private_data.
> Ditto to all cases below.

I agree that board code should ideally not be there, however you can't
just drop it and hope nobody will notice. It needs to be done in such a
way that everything still works afterwards. IMHO it is better move such
changes to a later patch so as to not make this one needlessly complex.

> > (Did you test you patch on OMAP H2?)
> 
> Can't remember anymore, but before applying these patches isp1301 was
> crashing the kernel on H2 and H3.

That's bad, this should be fixed, if possible even before applying your
patches.

Thanks,
-- 
Jean Delvare
