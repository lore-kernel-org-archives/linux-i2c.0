From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] media: video: do not clear 'driver' from an i2c_client
Date: Tue, 16 Nov 2010 11:34:18 +0100
Message-ID: <20101116113418.5c4ee813@endymion.delvare>
References: <1289398455-21949-1-git-send-email-w.sang@pengutronix.de>
	<20101115222815.GB25167@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101115222815.GB25167-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Sergio Aguirre <saaguirre-l0cyMroinI0@public.gmane.org>, Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Philipp Wiesner <p.wiesner-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>, =?ISO-8859-1?B?TeFydG9uIE7pbWV0aA==?= <nm127-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Sorry for the late answer.

On Mon, 15 Nov 2010 23:28:15 +0100, Wolfram Sang wrote:
> On Wed, Nov 10, 2010 at 03:14:13PM +0100, Wolfram Sang wrote:
> > The i2c-core does this already.
> > 
> > Reported-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> > 
> > Not sure if this should go via i2c or media?
> 
> Okay, as Jean did not pick it up in his latest pull request, I guess this means
> it shall go via the media-tree? :) Mauro, will you pick it up?

Yes I think it should go through Mauro's tree. I was simply waiting for
your other patch to get merged first (which happened yesterday),
because this patch depended on that one.

So:

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

and Mauro please pick the patch in your tree.

Thanks,
-- 
Jean Delvare
