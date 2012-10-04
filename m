From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH resend 2/2] I2C: sis630: Cleaning and cosmetics
Date: Thu, 4 Oct 2012 17:29:39 +0200
Message-ID: <20121004172939.387eb8d1@endymion.delvare>
References: <1346204115-30293-1-git-send-email-amaury.decreme@gmail.com>
	<1346204115-30293-3-git-send-email-amaury.decreme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1346204115-30293-3-git-send-email-amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amaury =?ISO-8859-1?B?RGVjcuptZQ==?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Amaury,

On Wed, 29 Aug 2012 03:35:15 +0200, Amaury Decr=EAme wrote:
> This patch:
> 	- Correct checkpatch errors
> 	- Replaces hexadecimal values by constants

Two patches ;)

>=20
> Signed-off-by: Amaury Decr=EAme <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-sis630.c |  311 ++++++++++++++++++++++-------=
----------
>  1 files changed, 178 insertions(+), 133 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c=
-sis630.c
> index c950397..8dff4b9 100644
> --- a/drivers/i2c/busses/i2c-sis630.c
> +++ b/drivers/i2c/busses/i2c-sis630.c
> @@ -19,7 +19,7 @@
>  /*
>     Changes:
>     24.08.2002
> -   	Fixed the typo in sis630_access (Thanks to Mark M. Hoffman)
> +	Fixed the typo in sis630_access (Thanks to Mark M. Hoffman)
>  	Changed sis630_transaction.(Thanks to Mark M. Hoffman)
>     18.09.2002
>  	Added SIS730 as supported.

I'd rather drop the changelog altogether, we have revision control
systems (svn and git) for that.

> @@ -82,6 +82,32 @@
>  #define SMB_BYTE		0x08	/* ~0x8F data byte field */
>  #define SMB_SAA			0x13	/* host slave alias address */
> =20
> +/* SMB_STS register */
> +#define SMBALT_STS		0x80	/* Slave alert */
> +#define BYTE_DONE_STS		0x10	/* Byte Done Status / Block Array */
> +#define SMBMAS_STS		0x08	/* Host Master */
> +#define SMBCOL_STS		0x04	/* Collision */
> +#define SMBERR_STS		0x02	/* Device error */
> +
> +/* SMB_CNT register */
> +#define MSTO_EN			0x40	/* Host Master Timeout Enable */
> +#define SMBCLK_SEL		0x20	/* Host master clock selection */
> +#define SMB_PROBE		0x02	/* Bus Probe */

Or Slave Busy, depending on the chip.

> +#define SMB_HOSTBUSY		0x01	/* Host Busy */
> +
> +/* SMBHOST_CNT register */
> +#define SMB_KILL		0x20	/* Kill */
> +#define SMB_START		0x10	/* Start */
> +#define SMB_PTL			0x07	/* Command Protocol */

This is a mask, would be good to make it visible in the name. OTOH the
masking is a no-op in practice so I'm not sure it's worth defining.

> +
> +/* SMB_ADDR register */
> +#define SMB_ADDRESS		0xFE	/* Adress */

Spelling: Address

> +#define SMB_RW			0x01	/* Read/Write */

Both of these are no-op in the code anyway so you might as well just
drop them.

> +
> +/* SMB_BYTE register */
> +#define SMB_BYTE0		0xFF	/* Byte 0 */
> +#define SMB_BYTE1		0xFF00	/* Byte 1 */

These are self-explanatory, I don't think you have to define constants.
They are not even hardware-related, and I find the code harder to read
now.

> +
>  /* register count for request_region
>   * As we don't use SMB_PCOUNT, 20 is ok for SiS630 and SiS964
>   */
> @@ -136,23 +162,26 @@ static inline void sis630_write(u8 reg, u8 data=
)
>  	outb(data, smbus_base + reg);
>  }
> =20
> -static int sis630_transaction_start(struct i2c_adapter *adap, int si=
ze, u8 *oldclock)
> +static int sis630_transaction_start(struct i2c_adapter *adap, int si=
ze,
> +					u8 *oldclock)
>  {
> -        int temp;
> +	int tmp;

I can't see the rationale for changing this variable name. temp was
just fine. Changing it makes the patch larger for no good reason. Same
later below.

> =20
>  	/* Make sure the SMBus host is ready to start transmitting. */
> -	if ((temp =3D sis630_read(SMB_CNT) & 0x03) !=3D 0x00) {
> -		dev_dbg(&adap->dev, "SMBus busy (%02x).Resetting...\n",temp);
> +	tmp =3D sis630_read(SMB_CNT);
> +	if ((tmp & (SMB_PROBE | SMB_HOSTBUSY)) !=3D 0x00) {
> +		dev_dbg(&adap->dev, "SMBus busy (%02x). Resetting...\n", tmp);
>  		/* kill smbus transaction */
> -		sis630_write(SMBHOST_CNT, 0x20);
> +		sis630_write(SMBHOST_CNT, SMB_KILL);
> =20
> -		if ((temp =3D sis630_read(SMB_CNT) & 0x03) !=3D 0x00) {
> -			dev_dbg(&adap->dev, "Failed! (%02x)\n", temp);
> +		tmp =3D sis630_read(SMB_CNT);
> +		if (tmp & (SMB_PROBE | SMB_HOSTBUSY)) {
> +			dev_dbg(&adap->dev, "Failed! (%02x)\n", tmp);
>  			return -EBUSY;
> -                } else {
> +		} else {
>  			dev_dbg(&adap->dev, "Successful!\n");
>  		}
> -        }
> +	}
> =20
>  	/* save old clock, so we can prevent machine for hung */
>  	*oldclock =3D sis630_read(SMB_CNT);
> @@ -160,45 +189,46 @@ static int sis630_transaction_start(struct i2c_=
adapter *adap, int size, u8 *oldc
>  	dev_dbg(&adap->dev, "saved clock 0x%02x\n", *oldclock);
> =20
>  	if (clock_sel)
> -		sis630_write(SMB_CNT, 0x20);
> +		sis630_write(SMB_CNT, SMBCLK_SEL);
>  	else
> -		sis630_write(SMB_CNT, (*oldclock & ~0x40));
> +		sis630_write(SMB_CNT, (*oldclock & ~MSTO_EN));
> =20
>  	/* clear all sticky bits */
> -	temp =3D sis630_read(SMB_STS);
> -	sis630_write(SMB_STS, temp & 0x1e);
> +	tmp =3D sis630_read(SMB_STS);
> +	sis630_write(SMB_STS, tmp & (BYTE_DONE_STS | SMBMAS_STS
> +					| SMBCOL_STS | SMBERR_STS));
> =20
>  	/* start the transaction by setting bit 4 and size */
> -	sis630_write(SMBHOST_CNT,0x10 | (size & 0x07));
> +	sis630_write(SMBHOST_CNT, SMB_START | (size & SMB_PTL));
> =20
>  	return 0;
>  }
> =20
>  static int sis630_transaction_wait(struct i2c_adapter *adap, int siz=
e)
>  {
> -	int temp, result =3D 0, timeout =3D 0;
> +	int tmp, timeout =3D 0;
> =20
>  	/* We will always wait for a fraction of a second! */
>  	do {
>  		msleep(1);
> -		temp =3D sis630_read(SMB_STS);
> +		tmp =3D sis630_read(SMB_STS);
>  		/* check if block transmitted */
> -		if (size =3D=3D SIS630_BLOCK_DATA && (temp & 0x10))
> -			break;
> -	} while (!(temp & 0x0e) && (timeout++ < MAX_TIMEOUT));
> +	} while (!(size =3D=3D SIS630_BLOCK_DATA && (tmp & BYTE_DONE_STS))
> +		&& !(tmp & (SMBMAS_STS | SMBCOL_STS | SMBERR_STS))
> +		&& (timeout++ < MAX_TIMEOUT));

This is an actual code change. You just can't do that in a cleanup
patch, sorry. I don't even see the benefit, this makes the logic harder
to understand.

> =20
>  	/* If the SMBus is still busy, we give up */
>  	if (timeout > MAX_TIMEOUT) {
>  		dev_dbg(&adap->dev, "SMBus Timeout!\n");
> -		result =3D -ETIMEDOUT;
> +		return -ETIMEDOUT;
>  	}
> =20
> -	if (temp & 0x02) {
> +	if (tmp & SMBERR_STS) {
>  		dev_dbg(&adap->dev, "Error: Failed bus transaction\n");
> -		result =3D -ENXIO;
> +		return -ENXIO;
>  	}

This again is a code change. It subtly changes the behavior of the
driver if several errors are reported at the same time. You can't do
that in a cleanup patch! If you really want to do it, make it a
separate patch, so that you can properly describe the change and the
reasons why you think it is good.

> =20
> -	if (temp & 0x04) {
> +	if (tmp & SMBCOL_STS) {
>  		dev_err(&adap->dev, "Bus collision!\n");
>  		/* Datasheet:
>  		 * SMBus Collision (SMBCOL_STS)
> @@ -206,11 +236,11 @@ static int sis630_transaction_wait(struct i2c_a=
dapter *adap, int size)
>  		 * SMBus Host loses in the bus arbitration. The software should
>  		 * clear this bit and re-start SMBus operation.
>  		 */
> -		sis630_write(SMB_STS, temp & ~0x04);
> +		sis630_write(SMB_STS, tmp & ~SMBCOL_STS);

Unrelated with this patch, but I think the above is wrong. The
datasheet says to write 1 to clear bits in the SMB_STS register, so the
above is clearing all bits _except_ SMBCOL_STS. Not good. OTOH we will
end up clearing all bits in sis630_transaction_end() anyway, so there's
no point in doing it already here.

>  		return -EAGAIN;
>  	}
> =20
> -	return result;
> +	return 0;
>  }
> =20
>  static void sis630_transaction_end(struct i2c_adapter *adap, u8 oldc=
lock)
> @@ -223,38 +253,41 @@ static void sis630_transaction_end(struct i2c_a=
dapter *adap, u8 oldclock)
>  	 */
>  	sis630_write(SMB_STS, 0xFF);
> =20
> -	dev_dbg(&adap->dev, "SMB_CNT before clock restore 0x%02x\n", sis630=
_read(SMB_CNT));
> +	dev_dbg(&adap->dev, "SMB_CNT before clock restore 0x%02x\n",
> +		sis630_read(SMB_CNT));
> =20
> -	if (clock_sel && !(oldclock & 0x20))
> -		sis630_write(SMB_CNT,(sis630_read(SMB_CNT) & ~0x20));
> +	if (clock_sel && !(oldclock & SMBCLK_SEL))
> +		sis630_write(SMB_CNT, sis630_read(SMB_CNT) & ~SMBCLK_SEL);
> =20
> -	dev_dbg(&adap->dev, "SMB_CNT after clock restore 0x%02x\n", sis630_=
read(SMB_CNT));
> +	dev_dbg(&adap->dev, "SMB_CNT after clock restore 0x%02x\n",
> +		sis630_read(SMB_CNT));
>  }
> =20
>  static int sis630_transaction(struct i2c_adapter *adap, int size)
>  {
> -	int result =3D 0;
> +	int tmp;

Another gratuitous variable change, which I do not like. "result" was
the right name for what it is used for. The only thing that can be
cleaned up is the useless initialization.

>  	int timeout =3D 0;
>  	u8 oldclock =3D 0;
> =20
>  	/* We loop in case of collisions */
>  	do {
> -		result =3D sis630_transaction_start(adap, size, &oldclock);
> -		if (!result) {
> -			result =3D sis630_transaction_wait(adap, size);
> +		tmp =3D sis630_transaction_start(adap, size, &oldclock);
> +		if (!tmp) {
> +			tmp =3D sis630_transaction_wait(adap, size);
>  			sis630_transaction_end(adap, oldclock);
>  		}
> -	} while (result =3D=3D -EAGAIN && timeout++ < MAX_TIMEOUT);
> +	} while (tmp =3D=3D -EAGAIN && timeout++ < MAX_TIMEOUT);
> =20
>  	if (timeout > MAX_TIMEOUT) {
>  		dev_dbg(&adap->dev, "Too many collisions !\n");
>  		return -ETIMEDOUT;
>  	}
> =20
> -	return result;
> +	return 0;
>  }
> =20
> -static int sis630_block_data(struct i2c_adapter *adap, union i2c_smb=
us_data *data, int read_write)
> +static int sis630_block_data(struct i2c_adapter *adap,
> +				union i2c_smbus_data *data, int read_write)
>  {
>  	int i, len =3D 0, rc =3D 0;
>  	u8 oldclock =3D 0;
> @@ -266,39 +299,43 @@ static int sis630_block_data(struct i2c_adapter=
 *adap, union i2c_smbus_data *dat
>  		else if (len > 32)
>  			len =3D 32;
>  		sis630_write(SMB_COUNT, len);
> -		for (i=3D1; i <=3D len; i++) {
> -			dev_dbg(&adap->dev, "set data 0x%02x\n", data->block[i]);
> +		for (i =3D 1; i <=3D len; i++) {
> +			dev_dbg(&adap->dev, "set data 0x%02x\n",
> +				data->block[i]);
>  			/* set data */
>  			sis630_write(SMB_BYTE+(i-1)%8, data->block[i]);
> -			if (i=3D=3D8 || (len<8 && i=3D=3Dlen)) {
> -				dev_dbg(&adap->dev, "start trans len=3D%d i=3D%d\n",len ,i);
> +			if (i =3D=3D 8 || (len < 8 && i =3D=3D len)) {
> +				dev_dbg(&adap->dev, "start trans len=3D%d i=3D%d\n",
> +					len, i);
>  				/* first transaction */
>  				rc =3D sis630_transaction_start(adap,
>  						SIS630_BLOCK_DATA, &oldclock);
>  				if (rc)
>  					return rc;
> -			}
> -			else if ((i-1)%8 =3D=3D 7 || i=3D=3Dlen) {
> -				dev_dbg(&adap->dev, "trans_wait len=3D%d i=3D%d\n",len,i);
> -				if (i>8) {
> -					dev_dbg(&adap->dev, "clear smbary_sts len=3D%d i=3D%d\n",len,i)=
;
> +			} else if ((i-1)%8 =3D=3D 7 || i =3D=3D len) {

Spaces around "-" and "%" would be appreciated.

> +				dev_dbg(&adap->dev, "trans_wait len=3D%d i=3D%d\n",
> +					len, i);
> +				if (i > 8) {
> +					dev_dbg(&adap->dev,
> +						"clr smbary_sts len=3D%d i=3D%d\n",

Please leave "clear" as it was, it is much more readable. Remember you
do not have to care about the 80 column limit for strings.

> +						len, i);
>  					/*
>  					   If this is not first transaction,
>  					   we must clear sticky bit.
>  					   clear SMBARY_STS
>  					*/
> -					sis630_write(SMB_STS,0x10);
> +					sis630_write(SMB_STS, BYTE_DONE_STS);
>  				}
>  				rc =3D sis630_transaction_wait(adap,
>  						SIS630_BLOCK_DATA);
>  				if (rc) {
> -					dev_dbg(&adap->dev, "trans_wait failed\n");
> +					dev_dbg(&adap->dev,
> +						"trans_wait failed\n");
>  					break;
>  				}
>  			}
>  		}
> -	}
> -	else {
> +	} else {
>  		/* read request */
>  		data->block[0] =3D len =3D 0;
>  		rc =3D sis630_transaction_start(adap,
> @@ -319,18 +356,21 @@ static int sis630_block_data(struct i2c_adapter=
 *adap, union i2c_smbus_data *dat
>  			if (data->block[0] > 32)
>  				data->block[0] =3D 32;
> =20
> -			dev_dbg(&adap->dev, "block data read len=3D0x%x\n", data->block[0=
]);
> +			dev_dbg(&adap->dev, "block data read len=3D0x%x\n",
> +				data->block[0]);
> =20
> -			for (i=3D0; i < 8 && len < data->block[0]; i++,len++) {
> -				dev_dbg(&adap->dev, "read i=3D%d len=3D%d\n", i, len);
> +			for (i =3D 0; i < 8 && len < data->block[0]; i++, len++) {
> +				dev_dbg(&adap->dev, "read i=3D%d len=3D%d\n", i,
> +					len);
>  				data->block[len+1] =3D sis630_read(SMB_BYTE+i);

Spaces can be added around "+"s too.

>  			}
> =20
> -			dev_dbg(&adap->dev, "clear smbary_sts len=3D%d i=3D%d\n",len,i);
> +			dev_dbg(&adap->dev, "clear smbary_sts len=3D%d i=3D%d\n",
> +				len, i);
> =20
>  			/* clear SMBARY_STS */
> -			sis630_write(SMB_STS,0x10);
> -		} while(len < data->block[0]);
> +			sis630_write(SMB_STS, BYTE_DONE_STS);
> +		} while (len < data->block[0]);
>  	}
> =20
>  	sis630_transaction_end(adap, oldclock);
> @@ -346,42 +386,48 @@ static s32 sis630_access(struct i2c_adapter *ad=
ap, u16 addr,
>  	int status;
> =20
>  	switch (size) {
> -		case I2C_SMBUS_QUICK:
> -			sis630_write(SMB_ADDR, ((addr & 0x7f) << 1) | (read_write & 0x01)=
);
> -			size =3D SIS630_QUICK;
> -			break;
> -		case I2C_SMBUS_BYTE:
> -			sis630_write(SMB_ADDR, ((addr & 0x7f) << 1) | (read_write & 0x01)=
);
> -			if (read_write =3D=3D I2C_SMBUS_WRITE)
> -				sis630_write(SMB_CMD, command);
> -			size =3D SIS630_BYTE;
> -			break;
> -		case I2C_SMBUS_BYTE_DATA:
> -			sis630_write(SMB_ADDR, ((addr & 0x7f) << 1) | (read_write & 0x01)=
);
> -			sis630_write(SMB_CMD, command);
> -			if (read_write =3D=3D I2C_SMBUS_WRITE)
> -				sis630_write(SMB_BYTE, data->byte);
> -			size =3D SIS630_BYTE_DATA;
> -			break;
> -		case I2C_SMBUS_PROC_CALL:
> -		case I2C_SMBUS_WORD_DATA:
> -			sis630_write(SMB_ADDR,((addr & 0x7f) << 1) | (read_write & 0x01))=
;
> -			sis630_write(SMB_CMD, command);
> -			if (read_write =3D=3D I2C_SMBUS_WRITE) {
> -				sis630_write(SMB_BYTE, data->word & 0xff);
> -				sis630_write(SMB_BYTE + 1,(data->word & 0xff00) >> 8);
> -			}
> -			size =3D (size =3D=3D I2C_SMBUS_PROC_CALL ? SIS630_PCALL : SIS630=
_WORD_DATA);
> -			break;
> -		case I2C_SMBUS_BLOCK_DATA:
> -			sis630_write(SMB_ADDR,((addr & 0x7f) << 1) | (read_write & 0x01))=
;
> +	case I2C_SMBUS_QUICK:
> +		sis630_write(SMB_ADDR, ((addr << 1) & SMB_ADDRESS) |
> +							(read_write & SMB_RW));

As said earlier, the masks can go away, they are no-ops.

> +		size =3D SIS630_QUICK;
> +		break;
> +	case I2C_SMBUS_BYTE:
> +		sis630_write(SMB_ADDR, ((addr << 1) & SMB_ADDRESS) |
> +							(read_write & SMB_RW));
> +		if (read_write =3D=3D I2C_SMBUS_WRITE)
>  			sis630_write(SMB_CMD, command);
> -			size =3D SIS630_BLOCK_DATA;
> -			return sis630_block_data(adap, data, read_write);
> -		default:
> -			dev_warn(&adap->dev, "Unsupported transaction %d\n",
> -				 size);
> -			return -EOPNOTSUPP;
> +		size =3D SIS630_BYTE;
> +		break;
> +	case I2C_SMBUS_BYTE_DATA:
> +		sis630_write(SMB_ADDR, ((addr << 1) & SMB_ADDRESS) |
> +							(read_write & SMB_RW));
> +		sis630_write(SMB_CMD, command);
> +		if (read_write =3D=3D I2C_SMBUS_WRITE)
> +			sis630_write(SMB_BYTE, data->byte);
> +		size =3D SIS630_BYTE_DATA;
> +		break;
> +	case I2C_SMBUS_PROC_CALL:
> +	case I2C_SMBUS_WORD_DATA:
> +		sis630_write(SMB_ADDR, ((addr << 1) & SMB_ADDRESS) |
> +							(read_write & SMB_RW));
> +		sis630_write(SMB_CMD, command);
> +		if (read_write =3D=3D I2C_SMBUS_WRITE) {
> +			sis630_write(SMB_BYTE, data->word & SMB_BYTE0);
> +			sis630_write(SMB_BYTE + 1,
> +						(data->word & SMB_BYTE1) >> 8);
> +		}
> +		size =3D (size =3D=3D I2C_SMBUS_PROC_CALL ?
> +				SIS630_PCALL : SIS630_WORD_DATA);
> +		break;
> +	case I2C_SMBUS_BLOCK_DATA:
> +		sis630_write(SMB_ADDR, ((addr << 1) & SMB_ADDRESS) |
> +							(read_write & SMB_RW));
> +		sis630_write(SMB_CMD, command);
> +		size =3D SIS630_BLOCK_DATA;
> +		return sis630_block_data(adap, data, read_write);
> +	default:
> +		dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
> +		return -EOPNOTSUPP;
>  	}
> =20
>  	status =3D sis630_transaction(adap, size);
> @@ -393,15 +439,16 @@ static s32 sis630_access(struct i2c_adapter *ad=
ap, u16 addr,
>  		return 0;
>  	}
> =20
> -	switch(size) {
> -		case SIS630_BYTE:
> -		case SIS630_BYTE_DATA:
> -			data->byte =3D sis630_read(SMB_BYTE);
> -			break;
> -		case SIS630_PCALL:
> -		case SIS630_WORD_DATA:
> -			data->word =3D sis630_read(SMB_BYTE) + (sis630_read(SMB_BYTE + 1)=
 << 8);
> -			break;
> +	switch (size) {
> +	case SIS630_BYTE:
> +	case SIS630_BYTE_DATA:
> +		data->byte =3D sis630_read(SMB_BYTE);
> +		break;
> +	case SIS630_PCALL:
> +	case SIS630_WORD_DATA:
> +		data->word =3D sis630_read(SMB_BYTE) +
> +				(sis630_read(SMB_BYTE + 1) << 8);
> +		break;
>  	}
> =20
>  	return 0;
> @@ -409,9 +456,9 @@ static s32 sis630_access(struct i2c_adapter *adap=
, u16 addr,
> =20
>  static u32 sis630_func(struct i2c_adapter *adapter)
>  {
> -	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_=
BYTE_DATA |
> -		I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_PROC_CALL |
> -		I2C_FUNC_SMBUS_BLOCK_DATA;
> +	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
> +		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
> +		I2C_FUNC_SMBUS_PROC_CALL | I2C_FUNC_SMBUS_BLOCK_DATA;
>  }
> =20
>  static int __devinit sis630_setup(struct pci_dev *sis630_dev)
> @@ -423,19 +470,19 @@ static int __devinit sis630_setup(struct pci_de=
v *sis630_dev)
>  	static unsigned short acpi_base;
> =20
>  	/* check for supported SiS devices */
> -	for (i=3D0; supported[i] > 0 ; i++) {
> -		if ((dummy =3D pci_get_device(PCI_VENDOR_ID_SI, supported[i], dumm=
y)))
> +	for (i =3D 0; supported[i] > 0; i++) {
> +		dummy =3D pci_get_device(PCI_VENDOR_ID_SI, supported[i], dummy);
> +		if (dummy)
>  			break; /* found */
>  	}
> =20
>  	if (dummy) {
>  		pci_dev_put(dummy);
> -	}
> -        else if (force) {
> -		dev_err(&sis630_dev->dev, "WARNING: Can't detect SIS630 compatible=
 device, but "
> +	} else if (force) {
> +		dev_err(&sis630_dev->dev,
> +			"WARNING: Can't detect SIS630 compatible device, but "
>  			"loading because of force option enabled\n");
> - 	}
> -	else {
> +	} else {
>  		return -ENODEV;
>  	}
> =20
> @@ -443,24 +490,23 @@ static int __devinit sis630_setup(struct pci_de=
v *sis630_dev)
>  	   Enable ACPI first , so we can accsess reg 74-75
>  	   in acpi io space and read acpi base addr
>  	*/
> -	if (pci_read_config_byte(sis630_dev, SIS630_BIOS_CTL_REG,&b)) {
> +	if (pci_read_config_byte(sis630_dev, SIS630_BIOS_CTL_REG, &b)) {
>  		dev_err(&sis630_dev->dev, "Error: Can't read bios ctl reg\n");
> -		retval =3D -ENODEV;
> -		goto exit;
> +		return -ENODEV;
>  	}
>  	/* if ACPI already enabled , do nothing */

Space before comma could be removed.

>  	if (!(b & 0x80) &&
>  	    pci_write_config_byte(sis630_dev, SIS630_BIOS_CTL_REG, b | 0x80=
)) {
>  		dev_err(&sis630_dev->dev, "Error: Can't enable ACPI\n");
> -		retval =3D -ENODEV;
> -		goto exit;
> +		return -ENODEV;
>  	}
> =20
>  	/* Determine the ACPI base address */
> -	if (pci_read_config_word(sis630_dev,SIS630_ACPI_BASE_REG,&acpi_base=
)) {
> -		dev_err(&sis630_dev->dev, "Error: Can't determine ACPI base addres=
s\n");
> -		retval =3D -ENODEV;
> -		goto exit;
> +	if (pci_read_config_word(sis630_dev, SIS630_ACPI_BASE_REG,
> +								&acpi_base)) {
> +		dev_err(&sis630_dev->dev,
> +				"Error: Can't determine ACPI base address\n");
> +		return -ENODEV;
>  	}
> =20
>  	dev_dbg(&sis630_dev->dev, "ACPI base at 0x%04x\n", acpi_base);
> @@ -474,8 +520,10 @@ static int __devinit sis630_setup(struct pci_dev=
 *sis630_dev)
> =20
>  	retval =3D acpi_check_region(smbus_base + SMB_STS, SIS630_SMB_IOREG=
ION,
>  				   sis630_driver.name);
> -	if (retval)
> -		goto exit;
> +	if (retval) {
> +		smbus_base =3D 0;
> +		return retval;
> +	}
> =20
>  	/* Everything is happy, let's grab the memory and set things up. */
>  	if (!request_region(smbus_base + SMB_STS, SIS630_SMB_IOREGION,
> @@ -483,16 +531,10 @@ static int __devinit sis630_setup(struct pci_de=
v *sis630_dev)
>  		dev_err(&sis630_dev->dev,
>  			"SMBus registers 0x%04x-0x%04x already in use!\n",
>  			smbus_base + SMB_STS, smbus_base + SMB_SAA);
> -		retval =3D -EBUSY;
> -		goto exit;
> +		return -EBUSY;
>  	}
> =20
> -	retval =3D 0;
> -
> -exit:
> -	if (retval)
> -		smbus_base =3D 0;
> -	return retval;
> +	return 0;
>  }
> =20
> =20
> @@ -511,15 +553,18 @@ static DEFINE_PCI_DEVICE_TABLE(sis630_ids) =3D =
{
>  	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_964) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_LPC) },
> -	{ 0, }
> +	{ 0 }
>  };
> =20
> -MODULE_DEVICE_TABLE (pci, sis630_ids);
> +MODULE_DEVICE_TABLE(pci, sis630_ids);
> =20
> -static int __devinit sis630_probe(struct pci_dev *dev, const struct =
pci_device_id *id)
> +static int __devinit sis630_probe(struct pci_dev *dev,
> +					const struct pci_device_id *id)
>  {
>  	if (sis630_setup(dev)) {
> -		dev_err(&dev->dev, "SIS630 comp. bus not detected, module not inse=
rted.\n");
> +		dev_err(&dev->dev,
> +			"SIS630 compatible bus not detected, "
> +			"module not inserted.\n");

You can keep the string on a single line.

>  		return -ENODEV;
>  	}
> =20


--=20
Jean Delvare
