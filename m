From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [v2 1/1] i2c: dev: prevent ZERO_SIZE_PTR deref in
 i2cdev_ioctl_rdwr()
Date: Mon, 30 Apr 2018 09:13:10 +0200
Message-ID: <20180430071310.7s7glgig3cilw4dj@pengutronix.de>
References: <1524140962-25639-1-git-send-email-alex.popov@linux.com>
 <20180427120658.wi32f7margtfazzp@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180427120658.wi32f7margtfazzp@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Alexander Popov <alex.popov@linux.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, sil2review@lists.osadl.org, Dmitry Vyukov <dvyukov@google.com>, syzkaller@googlegroups.com
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 27, 2018 at 02:06:58PM +0200, Wolfram Sang wrote:
> On Thu, Apr 19, 2018 at 03:29:22PM +0300, Alexander Popov wrote:
> > i2cdev_ioctl_rdwr() allocates i2c_msg.buf using memdup_user(), which
> > returns ZERO_SIZE_PTR if i2c_msg.len is zero.
> > 
> > Currently i2cdev_ioctl_rdwr() always dereferences the buf pointer in case
> > of I2C_M_RD | I2C_M_RECV_LEN transfer. That causes a kernel oops in
> > case of zero len.
> > 
> > Let's check the len against zero before dereferencing buf pointer.
> > 
> > This issue was triggered by syzkaller.
> > 
> > Signed-off-by: Alexander Popov <alex.popov@linux.com>
> 
> Applied to for-current with the arithmetic expression changed to '< 1'
> to keep in sync with the previous one. Will push out soon, so you can
> double check if you are interested.

Thanks, I like it. An added bonus is also that you don't need to think
about the type of msgs[i].len and what happens if it is negative.

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
