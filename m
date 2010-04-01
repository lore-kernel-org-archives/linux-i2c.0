From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 12/24] media/video: fix dangling pointers
Date: Thu, 1 Apr 2010 10:32:50 +0200
Message-ID: <201004011032.50117.hverkuil@xs4all.nl>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de> <201003211709.56319.hverkuil@xs4all.nl> <20100330123912.GI29472@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100330123912.GI29472@pengutronix.de>
Sender: linux-media-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jean Delvare <khali@linux-fr.org>, kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 30 March 2010 14:39:12 Wolfram Sang wrote:
> Hans,
> 
> > But this just feels like an i2c core thing to me. After remove() is called
> > the core should just set the client data to NULL. If there are drivers that
> > rely on the current behavior, then those drivers should be reviewed first as
> > to the reason why they need it.
> 
> It will be done this way now. As you have taken part in the discussion, I guess
> the media-subsystem never really considered picking those patches up ;)

I remember that there was one patch in your patch series where the client data
was set after it was freed.

That should still be fixed (by just removing the i2c_set_clientdata).

Can you post that one again?

Regards,

	Hans


> 
> Regards,
> 
>    Wolfram
> 
> 

-- 
Hans Verkuil - video4linux developer - sponsored by TANDBERG
