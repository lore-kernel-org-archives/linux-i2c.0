From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] V4L/DVB: Use custom I2C probing function mechanism
Date: Mon, 5 Apr 2010 10:30:32 +0200
Message-ID: <20100405103032.6cbf3572@hyperion.delvare>
References: <20100404161454.0f99cc06@hyperion.delvare>
	<1270432479.3506.31.camel@palomino.walls.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1270432479.3506.31.camel-xioobY1GIEhKttHedORAlB2eb7JE58TQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Walls <awalls-Xoej9cPu4Z+RGvkDC/A1pg@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LMML <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Andy,

On Sun, 04 Apr 2010 21:54:39 -0400, Andy Walls wrote:
> On Sun, 2010-04-04 at 16:14 +0200, Jean Delvare wrote:
> > Now that i2c-core offers the possibility to provide custom probing
> > function for I2C devices, let's make use of it.
> > 
> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > ---
> > I wasn't too sure where to put the custom probe function: in each driver,
> > in the ir-common module or in the v4l2-common module. I went for the
> > second option as a middle ground, but am ready to discuss it if anyone
> > objects.
> 
> With respect to cx23885, could you comment on the interaction of this
> patch with some patches of yours that are not merged yet:
> 
> http://linuxtv.org/hg/~awalls/cx23885-ir2/rev/b39f8849a35b
> http://linuxtv.org/hg/~awalls/cx23885-ir2/rev/3cf1ac545ca5
> http://linuxtv.org/hg/~awalls/cx23885-ir2/rev/ef5d2c08106f
> 
> Are they related to the IR microcontroller not being probed properly?

No, I don't expect any interaction between this new patch and the older
patchset. The older patchset would let the cx23885 I2C implementation
properly report slave nacks, but a successful IR device probing
wouldn't return a nack.

So, the patches can be merged in any order, nothing wrong will happen
either way.

> (I tried to get these patches merged, but didn't due to problems with
> other patches in my PULL request, and then a severe shortage of time.)

Thanks,
-- 
Jean Delvare
