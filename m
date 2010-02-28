From: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Sun, 28 Feb 2010 15:45:38 +0200
Message-ID: <af0693f01002280545n622b1c41v1f8c104e57fb51b6@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100228120817.275ef279-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,


On Sun, Feb 28, 2010 at 1:08 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
>
> Hi Felix,
>
> Please keep the linux-i2c list in Cc.
>
> On Wed, 24 Feb 2010 01:21:51 +0200, Felix Rubinstein wrote:
> > On Mon, Feb 22, 2010 at 11:58 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>=
 wrote:
> > > Unlikely. If a timeout occurred, the error message would say so.
> > >
> > > What is the exact error message? Can we see your complete code?
> >
> > Sure, I'm not at the office right now, but will post it asap.
> >
> > But hey, I think I've found an issue here.
> > Let's delve into the i801 driver code for a moment please.
> >
> > in i801_transaction:
> > ...
> > /* We will always wait for a fraction of a second! */
> > =A0 =A0 =A0 =A0 =A0do {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msleep(1);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D inb_p(SMBHSTSTS);
> > =A0 =A0 =A0 =A0 =A0} while ((status & SMBHSTSTS_HOST_BUSY) && (time=
out++ < MAX_TIMEOUT));
> > ...
> >
> > The data sheet states for HST_STS reg for HOST_BUSY bit:
> > 1 =3D Indicates that the ICH9 is running a command from the host in=
terface. No SMB
> > registers should be accessed while this bit is set, except the BLOC=
K DATA BYTE
> > Register. The BLOCK DATA BYTE Register can be accessed when this bi=
t is set only
> > when the SMB_CMD bits in the Host Control Register are programmed f=
or Block
> > command or I2C Read command. This is necessary in order to check th=
e
> > DONE_STS bit.
> >
> > Remember my case? I'm issuing plain I2C multi byte (straight I2C wi=
th
> > arbitrary length) transaction, in ICH9 words SMB_CMD is set to Bloc=
k
> > command. Since E32B is enabled, DONE_STS is irrelevant for us in th=
is
> > case.
>
> This is correct, assuming you mean I2C block writes and not reads. I2=
C
> block reads are always done in byte-by-byte mode (E32B not set).
What I mean was that HOST_BUSY bit is relevant during the transaction
in case E32B is _not_ set (since DONE_STS is irrelevant once E32B is
set).
>
> > As I understand, in this case we should relay on interrupts and
> > not on polling, as both: E32B and Block (write) command are enabled=
=2E
> >
> > That is why in my case I'm seeing timeout > MAX_TIMEOUT.
>
> I fail to see any relation between using interrupts and transaction
> types. The i2c-i801 driver does not use interrupts at all at the
> moment, it is always polling.
Meaning we cannot relay on HOST_BUSY bit when we _both_ issue Block
transaction and E32B is set. Since we cannot relay on it, the only
option left is interrupts.
What I'm trying to say is that we cannot relay (and in my case I get
transaction timeout if E32B is set) on HOST_BUSY bit when E32B is
enabled.

BTW, I've posted my code in the previous email posted on the list.

Thanks,
=46elix R.

>
> > As an alternative, I could try without E32B?
> >
> > What do you think?
>
> You could try this, yes. In fact, it might be a good idea to add a
> module parameter to the i2c-i801 driver to let the user disable
> features (PEC, block buffer and I2C block read) to use alternative co=
de
> paths in case the advanced ones don't work for some reason.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
