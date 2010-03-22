From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 12/24] media/video: fix dangling pointers
Date: Mon, 22 Mar 2010 21:36:45 +0100
Message-ID: <20100322213645.34257722@hyperion.delvare>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
	<1269094385-16114-13-git-send-email-w.sang@pengutronix.de>
	<201003202302.49526.hverkuil@xs4all.nl>
	<20100321144655.4747fd2a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100321144655.4747fd2a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Replying to myself...

On Sun, 21 Mar 2010 14:46:55 +0100, Jean Delvare wrote:
> I get the feeling that this would be a job for managed resources as
> some drivers already do for I/O ports and IRQs. Managed resources don't
> care about symmetry of allocation and freeing, by design (so it can
> violate point 1 above.) Aha! Isn't it exactly what devm_kzalloc() is
> all about?

Thinking about it again, this really only addresses the calls to
kfree(), not the calls to i2c_set_clientdata(), so apparently I'm quite
off-topic for this discussion. I still think that moving drivers to
managed resources is the way to go, but that's a different issue.

-- 
Jean Delvare
