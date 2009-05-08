From: Jamie Lokier <jamie-yetKDKU6eevNLxjTenLetw@public.gmane.org>
Subject: Re: [PATCH] ST DDC I2C bus driver v1
Date: Fri, 8 May 2009 18:19:33 +0100
Message-ID: <20090508171933.GC8681@shareable.org>
References: <63386a3d0905050452v5ade99cav7265c38d74699a8c@mail.gmail.com> <20090505134002.GO32548@trinity.fluff.org> <63386a3d0905051404oc7f4688j6b9219b3a9201172@mail.gmail.com> <20090506083800.64de0104@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090506083800.64de0104-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, andrea.gallo-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> > By setting bit 7 resp bit 4 of I2C_CR it will be switched from
> > plain I2C to DDC1 or DDC2 respectively.
> > 
> > I didn't add code for it since it cannot be tested on this
> > reference hardware, but if you like I can try to add that
> > in anyway. Would be a module parameter to select mode
> > plain I2C/DDC1/DDC2. Would that be nice?
> 
> I am totally lost. To the best of my knowledge, DDC1 and DDC2 are
> protocols on top of I2C. Other I2C controllers don't have anything like
> a "DDC mode", they just do I2C and you can connect monitors if such is
> your desire.

No.  (I really should finish and post my generic DDC driver at some point...)

The E-DDC specification *says* it's just an I2C bus, but that is not
reality if you want to work with real hardware of all ages and be robust.

DDC1 is not I2C at all, and it's not compatible with I2C.

DDC2 (actually it's DDC2B) and E-DDC are I2C, but both can get
confused when talking to a DDC1 or dual-mode device.  The very first
data read over DDC2 can easily fail when it's to a dual-mode device.
Same if there has been no activity for 2 seconds.

With some devices and cables, DDC2 needs slower timings than I2C.

And you can (rarely but possibly) corrupt a monitor if you plug/unplug
it in the middle of a DDC2 transaction - something which is not
allowed for in true I2C - so all future attempts to read that
monitor's info fail the checksum.  This is probably the reason for one
of the quirk workarounds in Linux's EDID code.

-- Jamie
