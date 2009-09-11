From: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] I2C: add driver for SMBus Control Method Interface
Date: Fri, 11 Sep 2009 16:27:40 +0800
Message-ID: <20090911082740.GC22058@crane-desktop>
References: <20090827022958.GA18079@crane-desktop> <20090909180431.5253d624@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090909180431.5253d624-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Wed, Sep 09, 2009 at 06:04:31PM +0200, Jean Delvare wrote:
> Hi Crane,
> 
> On Thu, 27 Aug 2009 10:29:58 +0800, Crane Cai wrote:
> > This driver supports the SMBus Control Method Interface. It needs BIOS declare
> > ACPI control methods via SMBus Control Method Interface Spec.
> > http://smbus.org/specs/smbus_cmi10.pdf
> > 
> > Hi Jean,
> > This driver can give BIOS a chance to avoid SMBus access conflicts on runtime.
> > And it obeys the SMBus CMI spec.
> > Please apply.
> 
> This is very interesting. Do you happen to have, or know, systems which
> actually implement this? Were you able to test your code?
Till now I only know our internal BIOS implement this control method. 
The code has been tested.
> 
> How can I check if any of my systems do implement this?
Now BIOS team give us an option to let these control methods exported.
> 
> Full review below, inline. I had many comments but they are really
> small things, overall your code is very good and getting the driver in
> shape for 2.6.32 seems totally feasible.
Thanks, these comments are very important to me. I will rework my code on them
and retest and resubmit a new version. It needs some days.
> 

-- 
Best Regards,
- Crane
