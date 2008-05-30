From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Fri, 30 May 2008 11:15:34 +0200
Message-ID: <20080530091534.GB727@pengutronix.de>
References: <1210883799-25188-1-git-send-email-w.sang@pengutronix.de>
	<20080522222022.68d65cd7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8253168945120311407=="
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


--===============8253168945120311407==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

thanks for your review! Just a few comments from me, otherwise I'll
change the things as suggested by you or David.

> > As we now support device_ids, probably most of the chip data will
> > come back into the driver. This is yet to be done. Tested on two
> > platforms by me and another one by David. Builds also on x86.
> We have to make a decision about the strategy now, and stick to it.
> Changing it after the driver is upstream will cause a lot of
> confusion.
ACK. I was thinking about the following way to support the standard
eeprom sizes without bloating the driver too much with chip data: In a
MODULE_DEVICE_TABLE, we have a kernel_ulong_t available for each entry
of a supported device. All parameters of the standard eeprom chips are
powers of 2. If we use log2 of these parameters, they will easily fit
into a kernel_ulong_t. We'd need one macro to create these magic numbers
=66rom the provided chip data (AT24_DATA_*) and just a tiny bit of code to
create a proper platform_data struct from it.
A general "at24" entry will expect the platform data to be provided, of
course.

> > +	struct i2c_client *client[];
> Isn't this supposed to be
> 	struct i2c_client *client[0];
IIRC I found both versions in kernel code and chose this because of
ANSI-C.

> > +	at24->bin.attr.name =3D "eeprom";
> > +	at24->bin.attr.mode =3D S_IRUSR;
> This makes the data only readable by root, as the comment says. The
> eeprom driver makes (most of) the data world-readable. I think it would
> be good to at least have the option to make the data world-readable,
> for example for SPD or EDID data. Otherwise we will never be able to
> drop the eeprom driver.
I'd go for David's solution here to introduce another flag for this
purpose.

> > +	u8		i2c_addr_mask;		/* for multi-addr chips */
> This notion of i2c_addr_mask seems more restrictive and easy to get
> wrong than it needs to be. What you really have is a number of slave
> I2C addresses, that's more intuitive IMHO, and using this would save a
> couple "+ 1" in the code. As a matter of fact, that's what you
> described in the comment above.
> Oh, BTW, can't you compute this value yourself from byte_len and (flags
> & AT24_EE_ADDR2)? I think so...
I was about to address this issue in the next version. Still need to
think about side-effects and corner-cases in a quiet minute.

I guess some more comments will arise while updating the driver...

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIP8W2D27XaX1/VRsRAs57AJ9fWYGhJxBPvfhpoWFOIQPVDedAuACfbC/z
T3cxb0YXlLRu56qvxK17tdA=
=AxeU
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--


--===============8253168945120311407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============8253168945120311407==--
