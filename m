From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v15] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Date: Thu, 7 Feb 2019 11:29:59 -0600
Message-ID: <CAErSpo5-LAfmoddxT0W_TLryytbKpR694W9dv096=mKGJrL8rw@mail.gmail.com>
References: <20181226232258.GA23526@syn-yoga530> <20190205120545.GA1045@kunai>
 <CAErSpo5kvFVwo-DCLYT_7UmRQKS1jHahFXawvnZUtZ=ApHKz1Q@mail.gmail.com>
 <20190207155326.GC4796@kunai> <8d70ae32-8e4d-d2aa-e213-4b2f678d7da0@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8d70ae32-8e4d-d2aa-e213-4b2f678d7da0@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Elie Morisse <syniurge@gmail.com>, linux-i2c <linux-i2c@vger.kernel.org>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Singh, Sandeep" <Sandeep.Singh@amd.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Bjorn Helgaas <helgaas@kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 7, 2019 at 10:47 AM Shah, Nehal-bakulchandra
<Nehal-bakulchandra.Shah@amd.com> wrote:
>
>
>  Hi Bjorn and Wolfram,
> On 2/7/2019 9:23 PM, Wolfram Sang wrote:
> > Hi Bjorn,
> >
> > thanks a lot for your additional information!
> >
> >> IMHO the split into two drivers is a bit of a mess and doesn't really
> >> correspond with the hardware, as I mentioned at [1].  The PCI device
> >> is the real hardware and the driver should claim that.  AFAICT the
> >> ACPI device exists only to pass some config information to the PCI
> >> driver.  I think the natural approach would be for the PCI driver to
> >> directly search the ACPI namespace for that config information.
> >
> > AFAIR the AMD folks insisted on the two driver setup because they need
> > it in the future? Maybe they can explain again here?
> >
> >> The fact that driver_find_device() is essentially unused except for a
> >> few very special cases is a good clue that there's probably a better
> >> way.
> >
> > Excactly this thinking made me recommend something else, too. Let's see
> > what we can come up with.
>
> First of really thanks for your valuable review. It may seem to be illogical to have two separate drivers, however as explained
> in past we are working on another solution for some upcoming thing. In that case we need MP2-PCI communication driver which will be reused.
> At this point of time i can't talk much about that but once solution is ready, we will be pushing that as well. Hence i sincerely requesting
> to  have two separate driver.

This is not my area and my opinion is by no means definitive.  But
FWIW, I don't think the argument that "a secret project will someday
require the ungainly design currently proposed" is worth very much.
Until we've seen the upcoming project, it's impossible to say whether
this two-driver design is the best approach for it.  I'd say it's
quite likely that people might have alternate proposals.

Bjorn
