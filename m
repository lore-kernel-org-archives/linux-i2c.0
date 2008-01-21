From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [PATCH 1/2] I2C: ISP1301_OMAP: New-style i2c driver updates, part 1
Date: Mon, 21 Jan 2008 20:37:20 +0200
Message-ID: <31e679430801211037j6b7f06bdr5d36c39f79c337ab@mail.gmail.com>
References: <1199379597-6273-1-git-send-email-me@felipebalbi.com>
	 <1199379597-6273-2-git-send-email-me@felipebalbi.com>
	 <20080121181500.48b3a3d2@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755808AbYAUShf@vger.kernel.org>
In-Reply-To: <20080121181500.48b3a3d2@hyperion.delvare>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-kernel@vger.kernel.org, david-b@pacbell.net, tony@atomide.com, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

On Jan 21, 2008 7:15 PM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Felipe,
>
> On Thu,  3 Jan 2008 11:59:56 -0500, Felipe Balbi wrote:
> > Based on David Brownell's patch for tps65010, this patch
> > starts converting isp1301_omap.c to new-style i2c driver.
> >
> > Signed-off-by: Felipe Balbi <me@felipebalbi.com>
> > ---
> >  drivers/i2c/chips/isp1301_omap.c |   60 +++++++++++++++++++------------------
> >  1 files changed, 31 insertions(+), 29 deletions(-)
> >
>
> Next time, please send this patch to the i2c mailing list instead of
> LKML if you want to get some attention.

Ok, i'll do it.
Sorry for missing i2c mailing list.

-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
