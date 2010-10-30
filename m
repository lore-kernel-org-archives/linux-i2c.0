From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-i801: Handle multiple instances instead of
 keeping  global state
Date: Sat, 30 Oct 2010 19:34:23 -0400
Message-ID: <1288481663.4570.19.camel@macbook.infradead.org>
References: <alpine.LFD.2.00.1010301445490.7306@dwoodhou-mobl2.ger.corp.intel.com>
	 <20101030182458.0849f295@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101030182458.0849f295-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 2010-10-30 at 18:24 +0200, Jean Delvare wrote:
> An explanation why this change is needed would be nice.

Um, does it really need explaining? It's really poor form to keep drive=
r
state in global variables rather than per-instance, even if you *don't*
actually have more than one device.

> Note that the patch got corrupted on the way: all leading spaces have
> been doubled. I had to fix it.

Sorry about that. Was sending from my phone, as I said before.

> > +    Copyright =C2=A9 2010         Intel Corporation
> > +                             David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
>=20
> I'd rather stick to (C). Using non-ASCII characters is asking for
> trouble, and this doesn't add value.

It really isn't trouble. We're well into the 21st century now =E2=80=94=
 even
akpm can cope with UTF-8 :)
=20
> > @@ -429,22 +439,23 @@ static int i801_block_transaction(union i2c_s=
mbus_data *data, char read_write,
> >   	/* Experience has shown that the block buffer can only be used f=
or
> >   	   SMBus (not I2C) block transactions, even though the datasheet
> >   	   doesn't mention this limitation. */
> > -	if ((i801_features & FEATURE_BLOCK_BUFFER)
> > -	 && command !=3D I2C_SMBUS_I2C_BLOCK_DATA
> > -	 && i801_set_block_buffer_mode() =3D=3D 0)
> > -		result =3D i801_block_transaction_by_block(data, read_write,
> > -							 hwpec);
> > +	if ((priv->features & FEATURE_BLOCK_BUFFER)
> > +	    && command !=3D I2C_SMBUS_I2C_BLOCK_DATA
> > +	    && i801_set_block_buffer_mode(priv) =3D=3D 0)
>=20
> Gratuitous reindentation of code.

The two continuation lines? I just fixed them to conform to the normal
kernel indentation, while I was modifying the lines before and after.
That's entirely normal practice, and not particularly gratuitous,
surely?

> > @@ -457,81 +468,83 @@ static s32 i801_access(struct i2c_adapter *ad=
ap, u16 addr,
> >   	int hwpec;
> >   	int block =3D 0;
> >   	int ret, xact =3D 0;
> > +	struct i801_priv *priv =3D (void *)adap;
>=20
> This is horrible and only works by accident (or misdesign if you
> prefer). Please don't do this. I'm glad I insisted to review this
> patch...
>=20
> We have i2c_set/get_adapdata() for this. If you really care about the
> extra cost, please use the proper container_of() construct. But I don=
't
> think the cost is problematic.

It wasn't the cost I was thinking of; it was the simplicity. One
allocation, one failure case, one error path. That's why this method is
fairly common within the kernel.

However, I have no particular objection to doing separate allocations,
even though it's not what I'd normally do. I'll send another version.

> >   	switch (xact & 0x7f) {
> >   	case I801_BYTE:	/* Result put in SMBHSTDAT0 */
> >   	case I801_BYTE_DATA:
> > -		data->byte =3D inb_p(SMBHSTDAT0);
> > +		data->byte =3D inb_p(SMBHSTDAT0(priv));
> >   		break;
> >   	case I801_WORD_DATA:
> > -		data->word =3D inb_p(SMBHSTDAT0) + (inb_p(SMBHSTDAT1) << 8);
> > +		data->word =3D inb_p(SMBHSTDAT0(priv)) +
> > +			(inb_p(SMBHSTDAT1(priv)) << 8);
>=20
> Please align.

Yeah, I remember wondering why emacs put it there, but figured I'd trus=
t
it :)

> > +	priv->features =3D 0;
>=20
> You just kzalloc'd the structure, so features are already 0.

True.

> > @@ -801,27 +821,32 @@ static int __devinit i801_probe(struct pci_de=
v *dev,
> >   		memset(&info, 0, sizeof(struct i2c_board_info));
> >   		info.addr =3D apanel_addr;
> >   		strlcpy(info.type, "fujitsu_apanel", I2C_NAME_SIZE);
> > -		i2c_new_device(&i801_adapter, &info);
> > +		i2c_new_device(&priv->adapter, &info);
> >   	}
> >   #endif
> >   #if defined CONFIG_SENSORS_FSCHMD || defined CONFIG_SENSORS_FSCHM=
D_MODULE
> >   	if (dmi_name_in_vendors("FUJITSU"))
> > -		dmi_walk(dmi_check_onboard_devices, &i801_adapter);
> > +		dmi_walk(dmi_check_onboard_devices, &priv->adapter);
> >   #endif
> > -
>=20
> Please leave this blank line in place.

Um, OK.

> Patch tested OK on ICH10.

Cool, thanks. I'll send an updated patch; hopefully later this evening.

--=20
David Woodhouse                            Open Source Technology Centr=
e
David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org                              Intel Corporatio=
n
