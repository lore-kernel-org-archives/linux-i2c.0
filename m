From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: move of_i2c_register_devices call into core
Date: Fri, 2 Sep 2011 11:23:08 +0200
Message-ID: <20110902112308.70745cc0@endymion.delvare>
References: <1312579468-19365-1-git-send-email-robherring2@gmail.com>
	<1312579468-19365-2-git-send-email-robherring2@gmail.com>
	<20110805225435.GA6404@ponder.secretlab.ca>
	<4E3C7B3C.1090100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E3C7B3C.1090100-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Rob, Grant,

On Fri, 05 Aug 2011 18:22:36 -0500, Rob Herring wrote:
> Grant,
> 
> On 08/05/2011 05:54 PM, Grant Likely wrote:
> > On Fri, Aug 05, 2011 at 04:24:26PM -0500, Rob Herring wrote:
> >> From: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> >>
> >> All callers of of_i2c_register_devices are immediately preceded by a call
> >> to i2c_add_adapter or i2c_add_numbered_adapter. Add call to
> >> of_i2c_register_devices and remove all other callers.
> >>
> >> This causes a module dependency loop that is resolved by the next commit.
> > 
> > Wrong way around.  Don't break bisectability.  I'll leave it up to Ben
> > and Jean on weather or not they want to move this code.  I intend to
> > do the same thing for spi/gpio, but I maintain those subsystems so I
> > get to choose.  i2c is not up to me.
> 
> Well, I know, but it's only broken for bisect in the case of both being
> modules. So it's only run-time brokenness. That's better than the 3
> months it was broken before. I couldn't come up with a better way. The
> choices I thought of were:
> 
> -temporarily exporting and adding of_i2c_register_devices to i2c.h and
> then removing it. I'm not a fan of adding that churn.
> -just combining it all into 1 patch.

That would have been the right thing to do, yes. The two patches are
not so large, so the resulting merged patch would still be reasonable.
There's no point in splitting patches if they can't be applied in
sequence, bisected, and rejected, reverted or backported individually;
which is clearly not the case here.

But anyway, I don't buy the whole thing. We currently have a nice
separation between OF and the underlying bus types. Breaking it all
just for the sake of saving one call in 4 drivers (out of ~70 in the
current kernel tree) doesn't seem worth it, at all. It would make
things harder to maintain, too (I definitely do not want to maintain
OF-specific code).

If you are really worried about the extra call to
of_i2c_register_devices(), then maybe the of_i2c implementation is
incorrect, and you should rework it to build on top of
i2c_register_board_info() rather than i2c_new_device().

> -reverse the order and leave i2c device registration broken for 1
> commit. Thinking some more about it, perhaps that is a bit better than
> broken module loading. Guess it depends if you are doing modules or
> built-in.

-- 
Jean Delvare
