From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] at91: i2c-at91: improve time-out handling
Date: Tue, 13 Jan 2015 16:27:52 +0100
Message-ID: <20150113152752.GK7660@katana>
References: <54A58BA5.3080003@interlog.com>
 <20150107103113.GA30897@ldesroches-Latitude-E6320>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DozTQjXnjm3C9Xhk"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150107103113.GA30897@ldesroches-Latitude-E6320>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Douglas Gilbert <dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--DozTQjXnjm3C9Xhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2015 at 11:31:14AM +0100, Ludovic Desroches wrote:
> Hi Douglas,
>=20
> On Thu, Jan 01, 2015 at 01:02:13PM -0500, Douglas Gilbert wrote:
> > With lk 3.19.0-rc2 and a at91sam9g25 (9x5) based system I
> > connected a NXP SC16IS750 I2C to serial bridge. After
> > routing the 750's IRQ back to the sc16is7xx driver and some
> > simple successful test, it was time for some intense testing:
> > Tx looped back to Rx on the 750, open picocom on /dev/ttySC0
> > at 38400, and use hexdump to blast a binary file (in hex) at
> > ttySC0. The I2C SCL speed was 200,000 Hz.
> >=20
> > It worked as expected for a few seconds then it wedged the
> > I2C bus. That was repeatable. In the cases that I checked SCL
> > was high, SDA was low (driven by _both_ the G25's macrocell
> > and the 750!!) and IRQ was active (low). This patch stopped
> > the G25 macrocell from driving SDA low in the above wedge
> > (and stopped copious error reports going to the log). I was
> > surprised that a NXP I2C chip got into this situation, IMO
> > SDA on a slave should have a driven low timeout. IMO all
> > I2C master drivers should have provision to drive a gpio
> > connected to a (or all the) slave's RESET line(s).
> >=20
> >=20
> > ChangeLog:
> >    when handling an I2C bus time-out, first clean-up the
> >    DMA transfer, then do an I2C macrocell software reset
> >    and restore some registers, including the interrupt
> >    mask
> >=20
>=20
> I am wondering why you need to call at91_twi_irq_save() and
> at91_twi_irq_restore(). The interrupts enabled in the driver are
> AT91_TWI_TXCOMP, AT91_TWI_RXRDY and AT91_TWI_TXRDY and they are managed
> in at91_do_twi_transfer() so they would be set correctly for the next
> transfer.

Douglas, any more info you could provide?

>=20
> Regards
>=20
> Ludovic
>=20
> > Signed-off-by: Douglas Gilbert <dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
>=20
> > diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at9=
1.c
> > index 636fd2e..4d78708 100644
> > --- a/drivers/i2c/busses/i2c-at91.c
> > +++ b/drivers/i2c/busses/i2c-at91.c
> > @@ -382,6 +382,7 @@ static int at91_do_twi_transfer(struct at91_twi_dev=
 *dev)
> >  {
> >  	int ret;
> >  	bool has_unre_flag =3D dev->pdata->has_unre_flag;
> > +	bool timed_out =3D false;
> > =20
> >  	dev_dbg(dev->dev, "transfer: %s %d bytes.\n",
> >  		(dev->msg->flags & I2C_M_RD) ? "read" : "write", dev->buf_len);
> > @@ -440,7 +441,7 @@ static int at91_do_twi_transfer(struct at91_twi_dev=
 *dev)
> >  					     dev->adapter.timeout);
> >  	if (ret =3D=3D 0) {
> >  		dev_err(dev->dev, "controller timed out\n");
> > -		at91_init_twi_bus(dev);
> > +		timed_out =3D true;
> >  		ret =3D -ETIMEDOUT;
> >  		goto error;
> >  	}
> > @@ -471,6 +472,11 @@ static int at91_do_twi_transfer(struct at91_twi_de=
v *dev)
> > =20
> >  error:
> >  	at91_twi_dma_cleanup(dev);
> > +	if (timed_out) {
> > +		at91_twi_irq_save(dev);
> > +		at91_init_twi_bus(dev);
> > +		at91_twi_irq_restore(dev);
> > +	}
> >  	return ret;
> >  }
> > =20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--DozTQjXnjm3C9Xhk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtTl4AAoJEBQN5MwUoCm2C18P/jSy6Kr05PDMyB8zQjrlYH/e
DcqFI4+31GvEjJYfpwSOyBHL6EOfAH9mGnMY+WKcBSo7wSqLj+xtisX1jxl8IHTN
+fbXpTDApGIqSMpDO1nSbQ+CbQ/pM6hpbl/HIQKaMAKwHUIrexuq7m44ytITwkQN
7+Dr23aoWWMo04f8XnhrTO7HVwTIiIzjbwU7LCpOBQp+3XlSsA+csB1fNFvbZLxp
9za+m9hJy4RdcqDqxHLiDwRob/oI61zjFruvJuJ9UwcB2B6DFWk+o43L+muhRt+U
KVIVkQ3fVZ0Np5vpNy5O7PKqHAhSL6AdUll/1cB0gQVRT+b0FDVl0nk/MLjtta4C
P36oA/S9GzpYfbv4pTxnvyRn+oeKUa4EJwuOxPY09GfGDB+1f03ubLkkDu9PY3FC
TnKZ1e4UGDLFqMUYJoEcCG9eJWFts4Wa96D6cF0QwNiBQ5quHIoXdUf9sYySgzvq
y2uPS45T/g8cE+ISKPlb43HV2KUjJLLd7B6QkrYVhbRvmztVsjNZB1jid/iQiF4c
RoCzX68fPfaF9KYl+ZBTSXuZTdJliO4YTPCsgwbHX8o/jjCU7lZS2pE3u8HMnLd9
Vd81BPiBA1dlJ3f40QBshFWbVVZKr6tM0V5ge/NQmy+Ta8GLIZSJjyEzCsn++jeL
jLDV+2jLSTPb7AxdniBz
=KlJq
-----END PGP SIGNATURE-----

--DozTQjXnjm3C9Xhk--
