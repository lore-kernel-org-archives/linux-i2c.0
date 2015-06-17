From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c_imc: New driver for Intel's iMC, found on
 LGA2011 chips
Date: Wed, 17 Jun 2015 08:12:51 -0700
Message-ID: <20150617151251.GA1043@roeck-us.net>
References: <cover.1425934386.git.luto@amacapital.net>
 <86c8b4d72f76cfdb7f76ad48825fb10e51634429.1425934386.git.luto@amacapital.net>
 <5503B59B.2020502@roeck-us.net>
 <CALCETrXvBxcZCyupHM6trb2Gv99MH9-HVG7ZuNGE2OPMZ7d7hA@mail.gmail.com>
 <20150617131841.GI13393@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150617131841.GI13393@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, Boaz Harrosh <boaz-/8YdC2HfS5554TAoqtyWWQ@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Rui Wang <ruiv.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Alun Evans <alun-eX+YDEU5biwsV2N9l4h3zg@public.gmane.org>, Robert Elliott <Elliott-VXdhtT5mjnY@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 17, 2015 at 03:18:42PM +0200, Wolfram Sang wrote:
> 
> > > Having said that, I am still not convinced that the driver should be in the kernel
> > > to start with. Browsing through Intel's datasheets, the registers are supported
> > > in E5-2600 v1, v2, and v3. However, in v3 Intel added a note saying that the registers
> > > should not be accessed by the OS directly, but only through the bios. Given that,
> > > and if that is possible, it might make more sense to rely on ACPI. It would then
> > > be up to the board and/or BIOS vendor to decide if the information should be available
> > > to the OS or not.
> > 
> > I think the plan is to add something to ACPI to tell us when we can
> > use these registers.  Unfortunately I'm not privy to whatever the ACPI
> > committee is doing.
> 
> Coming from the embedded world and not knowing much about this, I tend
> to wait until the above issue is clear, meaning when and how this driver
> is safe to be used. I hope you don't mind. Keeping your code up to date
> and sharing it is much appreciated, though! As well as Guenter's comments.
> 
When I suggested that we should rely on ACPI, I meant through ACPI SMBus CMI
(i2c-scmi), not through some ACPI properties which would permit direct access.

Thanks,
Guenter
