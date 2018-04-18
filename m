From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/1] i2c: dev: check i2c_msg len before memdup_user() to
 prevent ZERO_SIZE_PTR deref
Date: Wed, 18 Apr 2018 09:07:04 +0200
Message-ID: <20180418070704.35zj5chpdkirnmdt@pengutronix.de>
References: <1524010605-21552-1-git-send-email-alex.popov@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524010605-21552-1-git-send-email-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Popov <alex.popov@linux.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, sil2review@lists.osadl.org, Dmitry Vyukov <dvyukov@google.com>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Wed, Apr 18, 2018 at 03:16:45AM +0300, Alexander Popov wrote:
> Currently i2cdev_ioctl_rdwr() doesn't check i2c_msg len against zero
> before calling memdup_user(). If this len is zero memdup_user() returns
> ZERO_SIZE_PTR, which is later considered as valid since
> IS_ERR(ZERO_SIZE_PTR) is false. That causes ZERO_SIZE_PTR deref oops.

You're saying that

	memdup_user(ptr, 0)

reads from *ptr? I'd say this is a bug in memdup_user, not its user.

If however the problem only happens later in

	if (msgs[i].flags & I2C_M_RECV_LEN) {
		if (!(msgs[i].flags & I2C_M_RD) || msgs[i].buf[0] < 1 || ...)

Your commit log is wrong (and I think the patch, too).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
