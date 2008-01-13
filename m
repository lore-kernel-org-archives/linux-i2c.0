From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH] update module-init-tools to support the i2c subsystem
Date: Sun, 13 Jan 2008 13:04:13 -0500
Message-ID: <9e4733910801131004i669276e2pde04b195dd10bd90@mail.gmail.com>
References: <9e4733910712171839h214e0bc3q179266c86e5987b1@mail.gmail.com>
	 <20080113152735.5dca46a1@hyperion.delvare>
	 <9e4733910801130714m1be16826jf240171972324d16@mail.gmail.com>
	 <20080113163543.16e3d26b@hyperion.delvare>
	 <9e4733910801130826l799e4897pe7380ccb973b5fd0@mail.gmail.com>
	 <20080113184337.5d4cd546@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753984AbYAMSEZ@vger.kernel.org>
In-Reply-To: <20080113184337.5d4cd546@hyperion.delvare>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 1/13/08, Jean Delvare <khali@linux-fr.org> wrote:
> On Sun, 13 Jan 2008 11:26:07 -0500, Jon Smirl wrote:
> > On 1/13/08, Jean Delvare <khali@linux-fr.org> wrote:
> > > On Sun, 13 Jan 2008 10:14:14 -0500, Jon Smirl wrote:
> > > > On 1/13/08, Jean Delvare <khali@linux-fr.org> wrote:
> > > > > On Mon, 17 Dec 2007 21:39:37 -0500, Jon Smirl wrote:
> > > > > > Follow on to: "Series to add device tree naming to i2c"
> > > > > > Teach module-init-tools about the i2c subsystem.
> > > > >
> > > > > Can you please explain what this patch does and why it is needed?
> > > >
> > > > It generates the entries needed for the user space module tools to
> > > > work with the aliases. For example modprobe/depmod. It is a standard
> > > > part of the kernel module system.
> > >
> > > What entries, where? What can you do after applying your patch that you
> > > couldn't do before?
> >
> > The drivers you are testing with don't depend on other drivers.
>
> They do. I'm testing with the lm90 driver, which depends on the hwmon
> driver. Both load automatically when the underlying i2c-parport driver
> instantiate an "adm1032" i2c device.

I don't know exactly what those modules tables are used for. I just
copied what the other subsystems do. Maybe they are used when you make
an initrd to know which drivers to copy into the image.

-- 
Jon Smirl
jonsmirl@gmail.com
