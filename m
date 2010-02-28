From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Sun, 28 Feb 2010 21:19:49 +0100
Message-ID: <20100228211949.3297a0ff@hyperion.delvare>
References: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
	<20100128085904.4e202de1@hyperion.delvare>
	<af0693f01001280132l4002af0fgf3137fa27ce8555e@mail.gmail.com>
	<20100128105340.41aecf64@hyperion.delvare>
	<af0693f01002182310i6678e4b5h80feb14b24b37742@mail.gmail.com>
	<20100219105841.2bd8b16c@hyperion.delvare>
	<af0693f01002220812n5a6060cejc00d1ebbd7b9424d@mail.gmail.com>
	<20100222225805.00432574@hyperion.delvare>
	<af0693f01002231521q4f99eb63ocd607670625fadfa@mail.gmail.com>
	<20100228120817.275ef279@hyperion.delvare>
	<af0693f01002280545n622b1c41v1f8c104e57fb51b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <af0693f01002280545n622b1c41v1f8c104e57fb51b6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 28 Feb 2010 15:45:38 +0200, Felix Rubinstein wrote:
> On Sun, Feb 28, 2010 at 1:08 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wr=
ote:
> > On Wed, 24 Feb 2010 01:21:51 +0200, Felix Rubinstein wrote:
> > > But hey, I think I've found an issue here.
> > > Let's delve into the i801 driver code for a moment please.
> > >
> > > in i801_transaction:
> > > ...
> > > /* We will always wait for a fraction of a second! */
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do {
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msl=
eep(1);
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sta=
tus =3D inb_p(SMBHSTSTS);
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} while ((status & SMBHSTSTS_HO=
ST_BUSY) && (timeout++ < MAX_TIMEOUT));
> > > ...
> > >
> > > The data sheet states for HST_STS reg for HOST_BUSY bit:
> > > 1 =3D Indicates that the ICH9 is running a command from the host =
interface. No SMB
> > > registers should be accessed while this bit is set, except the BL=
OCK DATA BYTE
> > > Register. The BLOCK DATA BYTE Register can be accessed when this =
bit is set only
> > > when the SMB_CMD bits in the Host Control Register are programmed=
 for Block
> > > command or I2C Read command. This is necessary in order to check =
the
> > > DONE_STS bit.
> > >
> > > Remember my case? I'm issuing plain I2C multi byte (straight I2C =
with
> > > arbitrary length) transaction, in ICH9 words SMB_CMD is set to Bl=
ock
> > > command. Since E32B is enabled, DONE_STS is irrelevant for us in =
this
> > > case.
> >
> > This is correct, assuming you mean I2C block writes and not reads. =
I2C
> > block reads are always done in byte-by-byte mode (E32B not set).
> What I mean was that HOST_BUSY bit is relevant during the transaction
> in case E32B is _not_ set (since DONE_STS is irrelevant once E32B is
> set).
> >
> > > As I understand, in this case we should relay on interrupts and
> > > not on polling, as both: E32B and Block (write) command are enabl=
ed.
> > >
> > > That is why in my case I'm seeing timeout > MAX_TIMEOUT.
> >
> > I fail to see any relation between using interrupts and transaction
> > types. The i2c-i801 driver does not use interrupts at all at the
> > moment, it is always polling.
> Meaning we cannot relay on HOST_BUSY bit when we _both_ issue Block
> transaction and E32B is set. Since we cannot relay on it, the only
> option left is interrupts.

Please point me to the part of the datasheet which says this.

> What I'm trying to say is that we cannot relay (and in my case I get
> transaction timeout if E32B is set) on HOST_BUSY bit when E32B is
> enabled.

And I think you are wrong. The HOST_BUSY bit is perfectly valid for
block transactions under E32B. It wears off at the end of the block
transaction, as it does for every other transaction. I can't think of
any reason why we couldn't use it.

> BTW, I've posted my code in the previous email posted on the list.

I've seen this and will comment on it as my time permits.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html
