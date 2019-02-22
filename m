From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] i2c: Allow recovery of the initial IRQ by an I2C client
 device.
Date: Fri, 22 Feb 2019 10:30:19 +0000
Message-ID: <20190222103019.GD130153@ediswmail.ad.cirrus.com>
References: <CAKgEEwsOHqV-PtJnc-5nXAuH3BVitXWt80eoENJa3wZ6vGZDpw@mail.gmail.com>
 <20190219193027.13882-1-jbroadus@gmail.com>
 <20190221232609.d4vxl3osj6mwooey@katana>
 <CAO-hwJ+4-sxwbdpzjTKyZ10SBv743JUF0sTFPJ4YRXURuR_CNQ@mail.gmail.com>
 <20190222102335.GA1771@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190222102335.GA1771@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jim Broadus <jbroadus@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 22, 2019 at 11:23:35AM +0100, Wolfram Sang wrote:
> On Fri, Feb 22, 2019 at 11:15:59AM +0100, Benjamin Tissoires wrote:
> > On Fri, Feb 22, 2019 at 12:26 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> > > On Tue, Feb 19, 2019 at 11:30:27AM -0800, Jim Broadus wrote:
> > > > A previous change allowed I2C client devices to discover new IRQs upon
> > > > reprobe by clearing the IRQ in i2c_device_remove. However, if an IRQ was
> > > > assigned in i2c_new_device, that information is lost.
> > > >
> > > > For example, the touchscreen and trackpad devices on a Dell Inspiron laptop
> > > > are I2C devices whose IRQs are defined by ACPI extended IRQ types. The
> > > > client device structures are initialized during an ACPI walk. After
> > > > removing the i2c_hid device, modprobe fails.
> > > >
> > > > This change caches the initial IRQ value in i2c_new_device and then resets
> > > > the client device IRQ to the initial value in i2c_device_remove.
> > > >
> > > > Fixes: 6f108dd70d30 ("i2c: Clear client->irq in i2c_device_remove")
> > > > Signed-off-by: Jim Broadus <jbroadus@gmail.com>
> > >
> > > Adding Benjamin to CC
> > 
> > Sorry, I should have answered earlier.
> > 
> > I am a little bit hesitant regarding this patch. The effect is
> > correct, and I indeed realized a few weeks ago that something were
> > wrong as we couldn't rmmod/modprobe i2c-hid.
> > 
> > But I still have the feeling that the problem is not solved at the
> > right place. In i2c_new_device() we are storing parts of the fields of
> > struct i2c_board_info, and when resetting the irq we are losing
> > information. This patch solves that, but I wonder if the IRQ should
> > not be 'simply' set in i2c_device_probe(). This means we also need to
> > store the .resources of info, but I have a feeling this will be less
> > error prone in the future.
> > 
> > But this is just my guts telling me something is not right. I would
> > perfectly understand if we want to get this merged ASAP.
> > 
> > So given that the code is correct, this is my:
> > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > 
> > But at least I have expressed my feelings :)
> 
> Which I can relate to very much. I see the code solves the issue but my
> feeling is that we are patching around something which should be handled
> differently in general.
> 
> Is somebody willing to research this further?
> 
> Thanks for your input.
> 

I would be willing to have more of a look at it but am slightly
nervous I am not right person as all the systems I currently work
with are DT based so don't really exemplify the issue at all.

Thanks,
Charles
