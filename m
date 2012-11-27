From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c: Add support for device-tree based chip
 initialization
Date: Mon, 26 Nov 2012 16:41:40 -0800
Message-ID: <20121127004140.GA2599@roeck-us.net>
References: <1353905636-6697-1-git-send-email-linux@roeck-us.net>
 <20121126201346.4E8963E095F@localhost>
 <50B408BF.8050508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50B408BF.8050508-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 26, 2012 at 04:26:39PM -0800, David Daney wrote:
> On 11/26/2012 12:13 PM, Grant Likely wrote:
> >On Sun, 25 Nov 2012 20:53:56 -0800, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
> >>Some I2C devices are not or not correctly initialized by the firmware.
> >>Configuration would be possible via platform data, but that would require
> >>per-driver platform data and a lot of code, and changing it would not be
> >>possible without re-compiling the kernel. It is more elegant to do it
> >>generically via devicetree properties.
> >>
> >>Add a generic I2C devicetree property named "reg-init". This property provides
> >>a sequence of device initialization commands to be executed prior to calling
> >>the probe function for a given device.
> >>
> >>Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> >
> >This is a very similar problem to the power sequences series that was
> >recently posted to this list. I would like that feature and this
> >mechanism use the same approach.
> 
> 
> I haven't fully studied the power sequencing thing, but just to play
> Devil's Advocate, there is precedence for the "reg-init" style in
> some of the Ethernet PHY drivers.
> 
That is where I took it from.

> Perhaps the "reg-init" should be used as one of the steps in the
> sequence, and if there was only a single step it would be
> functionally equivalent to the "reg-init" proposal.
> 
My thought is along the same line. I'll have to study the power sequencing
proposal a bit more to see if that would work.

Guenter
