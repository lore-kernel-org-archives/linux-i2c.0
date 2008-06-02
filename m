From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Mon, 2 Jun 2008 18:21:54 +0200
Message-ID: <20080602162154.GA11141@pengutronix.de>
References: <1210883799-25188-1-git-send-email-w.sang@pengutronix.de>
	<20080522222022.68d65cd7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6368319150276277157=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080522222022.68d65cd7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============6368319150276277157==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

some more comments while working on the driver:

> > +static struct i2c_client *at24_ee_address(struct at24_data *at24, u16 =
*addr,
> > +		unsigned *offset)
> > +{
> > +	struct at24_platform_data *chip =3D &at24->chip;
> > +	unsigned i;
> > +
> > +	if (*offset >=3D chip->byte_len)
> > +		return NULL;
> > +
> > +	if (chip->flags & AT24_EE_ADDR2) {
> > +		i =3D *offset >> 16;
> > +		*offset &=3D 0xffff;
> > +	} else {
> > +		i =3D *offset >> 8;
> > +		*offset &=3D 0xff;
> > +	}
> > +
> > +	if (unlikely(i > chip->i2c_addr_mask)) {
> > +		dev_err(&at24->client[0]->dev,
> > +			"requested client %u not available!\n", i);
> > +		return NULL;
> > +	}
>=20
> That's not just unlikely... that would be a bug in the driver, right?
> This could be protected by #ifdef DEBUG, to not slow down the driver
> uselessly.
This error case can happen, if the supplied 'byte_len' and
'i2c_addr_mask' don't fit. I will put this check to the probe-function,
this should also do. Calculating i2c_addr_mask from byte_len still gives
me headaches, although I'd also like this to happen (see later).

> > +	/*
> > +	 * When we have a better choice than SMBus calls, use a combined
> > +	 * I2C message.  Write address; then read up to io_limit data bytes.
> > +	 * Note that read page rollover helps us here (unlike writes).
> > +	 */
> > +	msg[0].buf =3D addr;
> > +	addr[1] =3D (u8) offset;
>=20
> Please use a proper mask instead of a cast, it's clearer what you're
> doing.
>=20
> > +	addr[0] =3D (u8) (offset >> 8);
>=20
> Cast is not needed.

I tend to change it like this:

	offset_be =3D cpu_to_be16(offset);
        msg[0].buf =3D (u8 *) &offset_be;

> > +static ssize_t at24_ee_write(struct at24_data *at24, char *buf,
> > loff_t off, +		size_t count) +{ +	struct
> > i2c_client *client; +	struct i2c_msg  msg;
>=20
> Doubled space.
>=20
> > +	unsigned offset =3D (unsigned) off;
>=20
> Why don't you simply make the offset parameter an unsigned int, if
> that's what you want?
I changed the parameter to unsigned. But I think I need to have another
look, not that we are bitten by some cast-sideeffects.

> > +	/* buffer big enough to stick the address at the beginning */
> > +	at24->writebuf =3D kmalloc(at24->write_max + 2, GFP_KERNEL);
> > +	if (!at24->writebuf) {
> > +		retval =3D -ENOMEM;
> > +		count =3D 0;
> > +	}
>=20
> You could move this to before taking the mutex (using a temporary
> pointer), so that you can return with an error immediately if
> allocation fails. But more importantly: do you really need to allocate
> and free a new buffer for each write? You serialize the writes, and the
> size of the buffer doesn't depend on the actual write operation, so you
> might as well allocate the buffer as part of at24_probe(), this will
> make write operations faster and will avoid useless memory
> fragmentation.
>=20
> If you are really worried about the memory waste in case the user
> doesn't actually write to the EEPROM, you could alternatively allocate
> the buffer on the first write, and free it in the .remove() method.
Now, I allocate it in probe when the EEPROM is selected to be writable.

> > +	/* Use I2C operations unless we're stuck with SMBus extensions. */
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> > +		if (chip->flags & AT24_EE_ADDR2) {
> > +			err =3D -ECOMM;
> > +			goto fail;
> > +		}
> > +		if (!i2c_check_functionality(client->adapter,
> > +				I2C_FUNC_SMBUS_I2C_BLOCK)) {
> > +			err =3D -EBADMSG;
> > +			goto fail;
> > +		}
>=20
> These are definitely not the correct error values. I also see no
> reason to return different error values for the two cases as the
> problem is exactly the same: underlying adapter doesn't support the
> transaction types needed to talk to the EEPROM. What about -EOPNOTSUPP?
> Or -ENODEV.
Ah, errno-fun. -EPFNOSUPPORT?

> > +	/* use dummy devices for multiple-address chips */
> > +	if (chip->i2c_addr_mask) {
> > +		for (i =3D 1; i <=3D chip->i2c_addr_mask; i++) {
> > +			c =3D i2c_new_dummy(client->adapter, client->addr + i);
> > +			if (!c) {
> > +				dev_err(&client->dev, "addr %d unavail\n",
>=20
> Please spell words in error messages completely. Address should be
> printed in hexadecimal, that's what developers and users are used to.
>=20
> > +						client->addr + i);
> > +				err =3D -ENOCSI;
>=20
> Again a funky error value, completely unrelated with the error that
> occurred. -EBUSY?
-EADDRINUSE?

> > +cleanup:
> > +	if (chip->i2c_addr_mask) {
>=20
> Note that this test is not needed: the for loop below won't do anything
> if i2c_addr_mask =3D=3D 0.
I thought it would be cleaner to skip the for-loop if it is not needed.
Otherwise it may look like a bug easily. Then again, a comment would
also help.

>=20
> > +		for (i =3D 1; i <=3D chip->i2c_addr_mask; i++) {
> > +			c =3D at24->client[i];
> > +			if (c)
> > +				i2c_unregister_device(c);
> > + *	- What write page size does it support?
> > + */
> > +
> > +struct at24_platform_data {
> > +	u32		byte_len;		/* size (sum of all addr) */
> > +	u16		page_size;		/* for writes */
> > +	u8		i2c_addr_mask;		/* for multi-addr chips */
>=20
> This notion of i2c_addr_mask seems more restrictive and easy to get
> wrong than it needs to be. What you really have is a number of slave
> I2C addresses, that's more intuitive IMHO, and using this would save a
> couple "+ 1" in the code. As a matter of fact, that's what you
> described in the comment above.
>=20
> Oh, BTW, can't you compute this value yourself from byte_len and (flags
> & AT24_EE_ADDR2)? I think so...
There is at least one exception already (24c00) which covers eight
addresses but actually just needs one. This spoils the calculation of
i2c_addr_mask (and if there is one case, there will be others) :( I
agree, that num_addresses might be more apropriate than i2c_addr_mask.

Kind regards,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIRB4iD27XaX1/VRsRAvA5AJ91il+Cqj2o2pyFio3E8wXBMdxArQCfbOwC
pjSCzFscoP27E0jDwNYmv2M=
=KEBs
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--


--===============6368319150276277157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============6368319150276277157==--
