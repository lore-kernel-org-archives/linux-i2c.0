From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: I2C_M_RECV_LEN for i2c-mxs
Date: Tue, 16 Apr 2013 09:59:44 +0200
Message-ID: <20130416075944.GK30416@pengutronix.de>
References: <20130412093003.GE30416@pengutronix.de>
 <20130412153757.GA10241@the-dreams.de>
 <20130412182611.GG30416@pengutronix.de>
 <20130414115757.GA9013@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130414115757.GA9013-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Sun, Apr 14, 2013 at 01:57:58PM +0200, Wolfram Sang wrote:
> > Ah, ok. But then there is a different problem: Even though "my" dri=
ver
> > only advertises I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL calling
> > i2c_smbus_read_block_data in userspace results in .master_xfer bein=
g
> > called with I2C_M_RECV_LEN set.
>=20
> From Documentation/i2c/functionality:
>=20
> Because not every I2C or SMBus adapter implements everything in the=20
> I2C specifications, a client can not trust that everything it needs
> is implemented when it is given the option to attach to an adapter:
> the client needs some way to check whether an adapter has the needed
> functionality...
While add support for I2C_M_RECV_LEN I forgot to write the length data
to the first byte in the message buffer which happend to be initialized
with 0xff. This made i2c_smbus_xfer_emulated copy 255 bytes to
data->block overflowing the array and so resulting in stack curruption.
I think the same could be accomplished with a non-broken driver (e.g. b=
y
calling i2c_smbus_read_block_data for an eeprom that is interpreted as =
a
1 byte read by the i2c bus driver. If the read byte is big enough the
same stack curruption occurs). So IMHO the i2c core should be a bit mor=
e
careful here and either not let i2c_smbus_xfer_emulated call the xfer
callback of a driver that is not capable to handle I2C_M_RECV_LEN with =
a
message that has this bit set or at least assert that data->block isn't
written to out of bounds.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
