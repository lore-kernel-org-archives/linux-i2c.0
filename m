From: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Tue, 2 Mar 2010 14:53:41 +0200
Message-ID: <af0693f01003020453m7ca6891bjca4833c7fa45f44d@mail.gmail.com>
References: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
	 <20100128105340.41aecf64@hyperion.delvare>
	 <af0693f01002182310i6678e4b5h80feb14b24b37742@mail.gmail.com>
	 <20100219105841.2bd8b16c@hyperion.delvare>
	 <af0693f01002220812n5a6060cejc00d1ebbd7b9424d@mail.gmail.com>
	 <20100222225805.00432574@hyperion.delvare>
	 <af0693f01002231521q4f99eb63ocd607670625fadfa@mail.gmail.com>
	 <20100228120817.275ef279@hyperion.delvare>
	 <af0693f01002280545n622b1c41v1f8c104e57fb51b6@mail.gmail.com>
	 <20100228211949.3297a0ff@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100228211949.3297a0ff-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Sun, Feb 28, 2010 at 10:19 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wro=
te:
>
> On Sun, 28 Feb 2010 15:45:38 +0200, Felix Rubinstein wrote:
> > On Sun, Feb 28, 2010 at 1:08 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> =
wrote:
> > > On Wed, 24 Feb 2010 01:21:51 +0200, Felix Rubinstein wrote:
> > > > But hey, I think I've found an issue here.
> > > > Let's delve into the i801 driver code for a moment please.
> > > >
> > > > in i801_transaction:
> > > > ...
> > > > /* We will always wait for a fraction of a second! */
> > > > =A0 =A0 =A0 =A0 =A0do {
> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msleep(1);
> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D inb_p(SMBHSTSTS);
> > > > =A0 =A0 =A0 =A0 =A0} while ((status & SMBHSTSTS_HOST_BUSY) && (=
timeout++ < MAX_TIMEOUT));
> > > > ...
> > > >
> > > > The data sheet states for HST_STS reg for HOST_BUSY bit:
> > > > 1 =3D Indicates that the ICH9 is running a command from the hos=
t interface. No SMB
> > > > registers should be accessed while this bit is set, except the =
BLOCK DATA BYTE
> > > > Register. The BLOCK DATA BYTE Register can be accessed when thi=
s bit is set only
> > > > when the SMB_CMD bits in the Host Control Register are programm=
ed for Block
> > > > command or I2C Read command. This is necessary in order to chec=
k the
> > > > DONE_STS bit.
> > > >
> > > > Remember my case? I'm issuing plain I2C multi byte (straight I2=
C with
> > > > arbitrary length) transaction, in ICH9 words SMB_CMD is set to =
Block
> > > > command. Since E32B is enabled, DONE_STS is irrelevant for us i=
n this
> > > > case.
> > >
> > > This is correct, assuming you mean I2C block writes and not reads=
=2E I2C
> > > block reads are always done in byte-by-byte mode (E32B not set).
> > What I mean was that HOST_BUSY bit is relevant during the transacti=
on
> > in case E32B is _not_ set (since DONE_STS is irrelevant once E32B i=
s
> > set).
> > >
> > > > As I understand, in this case we should relay on interrupts and
> > > > not on polling, as both: E32B and Block (write) command are ena=
bled.
> > > >
> > > > That is why in my case I'm seeing timeout > MAX_TIMEOUT.
> > >
> > > I fail to see any relation between using interrupts and transacti=
on
> > > types. The i2c-i801 driver does not use interrupts at all at the
> > > moment, it is always polling.
> > Meaning we cannot relay on HOST_BUSY bit when we _both_ issue Block
> > transaction and E32B is set. Since we cannot relay on it, the only
> > option left is interrupts.
>
> Please point me to the part of the datasheet which says this.

Well, this part is quite vague and it's my interpretation however data
sheet states that during polling for HOST_BUSY bit, other registers
could be accesses iff we're executing Block transaction (my case) ...
and I quote: "This is necessary in order to check the DONE_STS bit."
But on the other hand DONE_STS bit, once again quoting : "... has no
meaning for block transfers when the 32-byte buffer is enabled."
In my case I fail to issue I2C write Block transaction iff E32B is
enabled and succeed if it's disabled.

One more thing which popped up recently.
If I work with E32B disabled, I paid attention that msleep(1) in
i801_block_transaction_byte_by_byte makes the write transaction too
long in the scope, i.e. bytes frequency is too long and they are too
far apart which makes them harder to be read. I think they should be
closer together, like this one.

                /* We will always wait for a fraction of a second! */
                timeout =3D 0;
                do {
-                       msleep(1);
+                      udelay(100);
                        status =3D inb_p(SMBHSTSTS);
                }
                while ((!(status & SMBHSTSTS_BYTE_DONE))
                          && (timeout++ < MAX_TIMEOUT));

or something like this.Even if it will timeout for a few times,
MAX_TIMEOUT will take care of the rest. In my case it hasn't even
once. All this, of course, not just for scope :)

Thanks,
=46elix R.

>
> > What I'm trying to say is that we cannot relay (and in my case I ge=
t
> > transaction timeout if E32B is set) on HOST_BUSY bit when E32B is
> > enabled.
>
> And I think you are wrong. The HOST_BUSY bit is perfectly valid for
> block transactions under E32B. It wears off at the end of the block
> transaction, as it does for every other transaction. I can't think of
> any reason why we couldn't use it.
>
> > BTW, I've posted my code in the previous email posted on the list.
>
> I've seen this and will comment on it as my time permits.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
