From: Jim Broadus <jbroadus@gmail.com>
Subject: Re: [PATCH] i2c: Allow recovery of the initial IRQ by an I2C client device.
Date: Fri, 22 Feb 2019 10:47:32 -0800
Message-ID: <CAKgEEwt6ciUA27+c-v0qjwkGN3gdF95DF9msh4yQVArCCQ+irA@mail.gmail.com>
References: <CAKgEEwsOHqV-PtJnc-5nXAuH3BVitXWt80eoENJa3wZ6vGZDpw@mail.gmail.com>
 <20190219193027.13882-1-jbroadus@gmail.com> <20190221232609.d4vxl3osj6mwooey@katana>
 <CAO-hwJ+4-sxwbdpzjTKyZ10SBv743JUF0sTFPJ4YRXURuR_CNQ@mail.gmail.com>
 <20190222102335.GA1771@kunai> <20190222103019.GD130153@ediswmail.ad.cirrus.com>
 <20190222113159.GB1771@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190222113159.GB1771@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linux I2C <linux-i2c@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 22, 2019 at 3:32 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> > > > But I still have the feeling that the problem is not solved at the
> > > > right place. In i2c_new_device() we are storing parts of the fields of
> > > > struct i2c_board_info, and when resetting the irq we are losing
> > > > information. This patch solves that, but I wonder if the IRQ should
> > > > not be 'simply' set in i2c_device_probe(). This means we also need to
> > > > store the .resources of info, but I have a feeling this will be less
> > > > error prone in the future.
> > > >
> > > > But this is just my guts telling me something is not right. I would
> > > > perfectly understand if we want to get this merged ASAP.
> > > >
> > > > So given that the code is correct, this is my:
> > > > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > >
> > > > But at least I have expressed my feelings :)
> > >
> > > Which I can relate to very much. I see the code solves the issue but my
> > > feeling is that we are patching around something which should be handled
> > > differently in general.
> > >
> > > Is somebody willing to research this further?
> > >
> > > Thanks for your input.
> > >
> >
> > I would be willing to have more of a look at it but am slightly
> > nervous I am not right person as all the systems I currently work
> > with are DT based so don't really exemplify the issue at all.
>
> Thank you! Well, I'll be there, too. Discussing, reviewing, testing. And
> if we have Benjamin for that on board as well, then I think we have a
> good start for that task :) Others are more than welcome to join, too,
> of course.
>

I'm also more familiar with device-tree (just came across this on my personal
laptop) but happy to review and test at the risk of learning something.
