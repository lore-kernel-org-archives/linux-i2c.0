From: Robert Abel <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Subject: Re: [PATCH 0/6] i2c: Xilinx IIC: rework driver
Date: Mon, 3 Aug 2015 09:56:56 +0200
Message-ID: <CAMdRc4FMO2ZknwJLgU6yAP-1kqFh45knCu=i48Z5ujKF0H54Yg@mail.gmail.com>
References: <1438344034-20211-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<55BEFB87.1090909@xilinx.com>
	<CAMdRc4EKRQki+Pm-Et29FyaKARkiCeNGsGYMAQFVyYyvxW2EOg@mail.gmail.com>
	<55BF1BF5.4010809@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55BF1BF5.4010809-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Michal,

On Mon, Aug 3, 2015 at 9:44 AM, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org> wrote:
> yes we are sync with mainline. And make no sense to point to our SoC
> tree if you target mainline and ask them for review.

As I see it, Xilinx is the maintainer/contant of the Xilinx drivers,
so I doubt the I2C subsystem maintainer would ACK something that
wasn't ACKed by you in the first place.
I can obviously rebase onto mainline and resend all the patches, but
that won't make the maintainers and the people who have to merge
linux-xlnx changes and my changes any happier at the end of the day.

I also see linux-i2c as a general way to let interested people know
that this patchset is going on. That's also a reason why I posted the
patches to the public list.

Ideally, we'd get my changes in to your linux-xlnx tree, you send a
pull request in the next merge window and we're done.
If that's not acceptable, I'll rebase to mainline, resend the patches,
hopefully get ACKed by I2C subsystem maintainer, changes in their tree
make it into next merge window, so do yours, Linus or whoever has to
merge by hand. :-/

Regards

Robert
