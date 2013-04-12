From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: I2C_M_RECV_LEN for i2c-mxs
Date: Fri, 12 Apr 2013 20:26:11 +0200
Message-ID: <20130412182611.GG30416@pengutronix.de>
References: <20130412093003.GE30416@pengutronix.de>
 <20130412153757.GA10241@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130412153757.GA10241-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 12, 2013 at 05:37:57PM +0200, Wolfram Sang wrote:
> please prefer wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org for kernel stuff.
The reason I used wolfram@... is probably:

	$ for addr in sa olfram; do printf "%s: " $addr; git log --oneline --g=
rep=3Dw$addr-z923LK4zBo2bacvFa/9K2g@public.gmane.org v3.9-rc6 | wc -l; done
	sa: 7
	olfram: 35

But I see the recent commits use "sa" so probably I will do that next
time, too.

> >  - Is it correct to have I2C_FUNC_SMBUS_EMUL in .functionality with=
out
> >    supporting I2C_M_RECV_LEN?
>=20
> Yes. Check the #define and you'll see that it does not contain
> BLOCK_READ and BLOCK_PROC_CALL.
Ah, ok. But then there is a different problem: Even though "my" driver
only advertises I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL calling
i2c_smbus_read_block_data in userspace results in .master_xfer being
called with I2C_M_RECV_LEN set.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
