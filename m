From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [v2 1/1] i2c: dev: prevent ZERO_SIZE_PTR deref in
 i2cdev_ioctl_rdwr()
Date: Fri, 20 Apr 2018 07:58:22 +0200
Message-ID: <20180420055822.qjs2hpkik5dr2fnp@pengutronix.de>
References: <1524140962-25639-1-git-send-email-alex.popov@linux.com>
 <20180419134902.6l5jsf4wpqfiaskj@pengutronix.de>
 <22fe9bbe-f1d7-3a92-9528-df66c34816a5@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <22fe9bbe-f1d7-3a92-9528-df66c34816a5@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Popov <alex.popov@linux.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, sil2review@lists.osadl.org, Dmitry Vyukov <dvyukov@google.com>, syzkaller@googlegroups.com
List-Id: linux-i2c@vger.kernel.org

Hello,

On Thu, Apr 19, 2018 at 08:01:46PM +0300, Alexander Popov wrote:
> On 19.04.2018 16:49, Uwe Kleine-König wrote:
> >> @@ -280,6 +280,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
> >>  		 */
> >>  		if (msgs[i].flags & I2C_M_RECV_LEN) {
> >>  			if (!(msgs[i].flags & I2C_M_RD) ||
> >> +			    !msgs[i].len ||
> > 
> > I'd prefer
> > 
> > 			msgs[i].len > 0
> 
> Excuse me, it will be wrong. We stop if len is 0 to avoid the following
> ZERO_SIZE_PTR dereference.

right you are. I missed the negation.
 
> > here instead of
> > 
> > 			!msgs[i].len
> 
> I can change it to "msgs[i].len == 0". But is it really important?
> 
> I've carefully tested the current version with the original repro. It works correct.

I don't doubt it, and the code generated is maybe even the same. The
point I wanted to make is that

	!len

is harder to read for a human than

	len < 1

(or another suitable arithmetic expression). But feel free to disagree
and keep the code as is.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
