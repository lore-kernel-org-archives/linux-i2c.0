From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: piix4: Disable completely the IMC during
  SMBUS_BLOCK_DATA
Date: Thu, 5 Oct 2017 13:23:37 +0200
Message-ID: <20171005112337.ucu6x2y5a4gjntds@ninjato>
References: <20170921073743.3052-1-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rzbkcivhqg7ekqe4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170921073743.3052-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--rzbkcivhqg7ekqe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2017 at 09:37:43AM +0200, Ricardo Ribalda Delgado wrote:
> SMBUS_BLOCK_DATA transactions might fail due to a race condition with
> the IMC, even when the IMC semaphore is used.
>=20
> This bug has been reported and confirmed by AMD, who suggested as a
> solution an IMC firmware upgrade (obtained via BIOS update) and
> disabling the IMC during SMBUS_BLOCK_DATA transactions.
>=20
> Even without the IMC upgrade, the smbus is much more stable with this
> patch.
>=20
> Tested on a Bettong-alike board.
>=20
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

I would very much like a review from Jean for this.

> ---
>  drivers/i2c/busses/i2c-piix4.c | 89 ++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 82 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix=
4.c
> index 0ecdb47a23ab..3b8a5eaad956 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -85,6 +85,8 @@
>  /* SB800 constants */
>  #define SB800_PIIX4_SMB_IDX		0xcd6
> =20
> +#define IMC_SMB_IDX			0x3e
> +
>  /*
>   * SB800 port is selected by bits 2:1 of the smb_en register (0x2c)
>   * or the smb_sel register (0x2e), depending on bit 0 of register 0x2f.
> @@ -160,6 +162,8 @@ struct i2c_piix4_adapdata {
>  	/* SB800 */
>  	bool sb800_main;
>  	u8 port;		/* Port number, shifted */
> +
> +	bool notify_imc;
>  };
> =20
>  static int piix4_setup(struct pci_dev *PIIX4_dev,
> @@ -572,6 +576,50 @@ static s32 piix4_access(struct i2c_adapter * adap, u=
16 addr,
>  	return 0;
>  }
> =20
> +static uint8_t piix4_imc_read(uint8_t idx)
> +{
> +	outb_p(idx, IMC_SMB_IDX);
> +	return inb_p(IMC_SMB_IDX + 1);
> +}
> +
> +static void piix4_imc_write(uint8_t idx, uint8_t value)
> +{
> +	outb_p(idx, IMC_SMB_IDX);
> +	outb_p(value, IMC_SMB_IDX + 1);
> +}
> +
> +int piix4_imc_sleep(void)
> +{
> +	int timeout =3D MAX_TIMEOUT;
> +
> +	piix4_imc_write(0x82, 0x00);
> +	piix4_imc_write(0x83, 0xB4);
> +	piix4_imc_write(0x80, 0x96);
> +
> +	while (timeout--) {
> +		if (piix4_imc_read(0x82) =3D=3D 0xfa)
> +			return 0;
> +		usleep_range(1000, 2000);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +void piix4_imc_wakeup(void)
> +{
> +	int timeout =3D MAX_TIMEOUT;
> +
> +	piix4_imc_write(0x82, 0x00);
> +	piix4_imc_write(0x83, 0xB5);
> +	piix4_imc_write(0x80, 0x96);
> +
> +	while (timeout--) {
> +		if (piix4_imc_read(0x82) =3D=3D 0xfa)
> +			break;
> +		usleep_range(1000, 2000);
> +	}
> +}
> +
>  /*
>   * Handles access to multiple SMBus ports on the SB800.
>   * The port is selected by bits 2:1 of the smb_en register (0x2c).
> @@ -586,7 +634,7 @@ static s32 piix4_access_sb800(struct i2c_adapter *ada=
p, u16 addr,
>  {
>  	struct i2c_piix4_adapdata *adapdata =3D i2c_get_adapdata(adap);
>  	unsigned short piix4_smba =3D adapdata->smba;
> -	int retries =3D MAX_TIMEOUT;
> +	int retries =3D adapdata->notify_imc ? MAX_TIMEOUT * 2 : MAX_TIMEOUT;
>  	int smbslvcnt;
>  	u8 smba_en_lo;
>  	u8 port;
> @@ -612,6 +660,15 @@ static s32 piix4_access_sb800(struct i2c_adapter *ad=
ap, u16 addr,
>  		return -EBUSY;
>  	}
> =20
> +	/* Block data transfers require disabling the imc */
> +	if ((size =3D=3D I2C_SMBUS_BLOCK_DATA) && adapdata->notify_imc)
> +		/* If IMC communication fails do not retry*/
> +		if (piix4_imc_sleep()) {
> +			dev_warn(&adap->dev,
> +				 "Failed to communicate with the IMC, enable it and/or upgrade your =
BIOS.\n");
> +			adapdata->notify_imc =3D false;
> +		}
> +
>  	outb_p(piix4_port_sel_sb800, SB800_PIIX4_SMB_IDX);
>  	smba_en_lo =3D inb_p(SB800_PIIX4_SMB_IDX + 1);
> =20
> @@ -628,6 +685,9 @@ static s32 piix4_access_sb800(struct i2c_adapter *ada=
p, u16 addr,
>  	/* Release the semaphore */
>  	outb_p(smbslvcnt | 0x20, SMBSLVCNT);
> =20
> +	if ((size =3D=3D I2C_SMBUS_BLOCK_DATA) && adapdata->notify_imc)
> +		piix4_imc_wakeup();
> +
>  	mutex_unlock(&piix4_mutex_sb800);
> =20
>  	return retval;
> @@ -679,7 +739,7 @@ static struct i2c_adapter *piix4_main_adapters[PIIX4_=
MAX_ADAPTERS];
>  static struct i2c_adapter *piix4_aux_adapter;
> =20
>  static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
> -			     bool sb800_main, u8 port,
> +			     bool sb800_main, u8 port, bool notify_imc,
>  			     const char *name, struct i2c_adapter **padap)
>  {
>  	struct i2c_adapter *adap;
> @@ -707,6 +767,7 @@ static int piix4_add_adapter(struct pci_dev *dev, uns=
igned short smba,
>  	adapdata->smba =3D smba;
>  	adapdata->sb800_main =3D sb800_main;
>  	adapdata->port =3D port << 1;
> +	adapdata->notify_imc =3D notify_imc;
> =20
>  	/* set up the sysfs linkage to our parent device */
>  	adap->dev.parent =3D &dev->dev;
> @@ -728,14 +789,15 @@ static int piix4_add_adapter(struct pci_dev *dev, u=
nsigned short smba,
>  	return 0;
>  }
> =20
> -static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned short =
smba)
> +static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned short =
smba,
> +				    bool notify_imc)
>  {
>  	struct i2c_piix4_adapdata *adapdata;
>  	int port;
>  	int retval;
> =20
>  	for (port =3D 0; port < PIIX4_MAX_ADAPTERS; port++) {
> -		retval =3D piix4_add_adapter(dev, smba, true, port,
> +		retval =3D piix4_add_adapter(dev, smba, true, port, notify_imc,
>  					   piix4_main_port_names_sb800[port],
>  					   &piix4_main_adapters[port]);
>  		if (retval < 0)
> @@ -769,6 +831,7 @@ static int piix4_probe(struct pci_dev *dev, const str=
uct pci_device_id *id)
>  	     dev->device =3D=3D PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
>  	     dev->revision >=3D 0x40) ||
>  	    dev->vendor =3D=3D PCI_VENDOR_ID_AMD) {
> +		bool notify_imc =3D false;
>  		is_sb800 =3D true;
> =20
>  		if (!request_region(SB800_PIIX4_SMB_IDX, 2, "smba_idx")) {
> @@ -778,6 +841,18 @@ static int piix4_probe(struct pci_dev *dev, const st=
ruct pci_device_id *id)
>  			return -EBUSY;
>  		}
> =20
> +		if (dev->vendor =3D=3D PCI_VENDOR_ID_AMD &&
> +		    dev->device =3D=3D PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
> +			if (!devm_request_region(&dev->dev, IMC_SMB_IDX, 2,
> +						 "kerncz_imc_idx")) {
> +				dev_warn(&dev->dev,
> +					"IMC base address index region 0x%x already in use!\n",
> +					SB800_PIIX4_SMB_IDX);
> +			} else {
> +				notify_imc =3D true;
> +			}
> +		}
> +
>  		/* base address location etc changed in SB800 */
>  		retval =3D piix4_setup_sb800(dev, id, 0);
>  		if (retval < 0) {
> @@ -789,7 +864,7 @@ static int piix4_probe(struct pci_dev *dev, const str=
uct pci_device_id *id)
>  		 * Try to register multiplexed main SMBus adapter,
>  		 * give up if we can't
>  		 */
> -		retval =3D piix4_add_adapters_sb800(dev, retval);
> +		retval =3D piix4_add_adapters_sb800(dev, retval, notify_imc);
>  		if (retval < 0) {
>  			release_region(SB800_PIIX4_SMB_IDX, 2);
>  			return retval;
> @@ -800,7 +875,7 @@ static int piix4_probe(struct pci_dev *dev, const str=
uct pci_device_id *id)
>  			return retval;
> =20
>  		/* Try to register main SMBus adapter, give up if we can't */
> -		retval =3D piix4_add_adapter(dev, retval, false, 0, "",
> +		retval =3D piix4_add_adapter(dev, retval, false, 0, false, "",
>  					   &piix4_main_adapters[0]);
>  		if (retval < 0)
>  			return retval;
> @@ -827,7 +902,7 @@ static int piix4_probe(struct pci_dev *dev, const str=
uct pci_device_id *id)
>  	if (retval > 0) {
>  		/* Try to add the aux adapter if it exists,
>  		 * piix4_add_adapter will clean up if this fails */
> -		piix4_add_adapter(dev, retval, false, 0,
> +		piix4_add_adapter(dev, retval, false, 0, false,
>  				  is_sb800 ? piix4_aux_port_name_sb800 : "",
>  				  &piix4_aux_adapter);
>  	}
> --=20
> 2.14.1
>=20

--rzbkcivhqg7ekqe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnWFjkACgkQFA3kzBSg
KbZa3A//XshuHMYl65BcUGnjBPp7CeKIGevEdlUvwDb45/KVNsAkq9LhfUjRVZos
qdGdGttUbs5Zg1hieiXbqf8t8EokGjCuuUsIFfa7ZN5A1EjAd6p8DXZxhW0fh6hC
xXWRGi7xssHk3aDIl8y93QA9p3LAHha3LQ8dVqXgOiDoxYUw+DVvENTLkWnXT1KR
jYbGeZRqXekvDU/LUwA3TkWvREL1Qv8magRkA63hxJFn4o62FG3nSxDZXlyjs+OB
9fLeZZMG4/DmR9pALeQKEsjWlM8ZopHEKQ1ivXR1tJg1yEpVKHbp73S+UoXulAZ/
P8B6mI6x81JibCFGg96xk/I8nKhL/Sn9UlUwHd8gEW3uDPIqDO+6YWVCM5Q0wXBX
YY5Br/T4hjW+rYMAgQXD4LATdA0rh4lSJjnEliWQf0lZUVc7KW14SMxdS3GAsrfu
1UyspjWI/h9h50lxx/ns5nWbfy2kIz0hMing6ojcQs4lbx+PFqmvukk1WOit+wUM
UOejuoSKfCCm2n/PQq6R61PGYQwESSkTCQgidfwumICCFJB51JfiT9Ui5P7CmVAE
fcy5+i08GOmQvQcRZr6aCTb1RpUCE6zB+r2oR2LCCfz7pfoBekXmzx3oq3TKK6pf
96QhVaVwiy7qDBZyGXt3Mc7BautCf+giwbgdZ15AvDyYxsQmtTs=
=87gg
-----END PGP SIGNATURE-----

--rzbkcivhqg7ekqe4--
