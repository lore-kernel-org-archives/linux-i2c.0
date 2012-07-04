From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Consolidate polling
Date: Wed, 4 Jul 2012 14:12:26 +0800
Message-ID: <CAGS+omAT0G=BBGRs9H91ah=oZnaY-MHbvbADGOKTES_FbCjLjA@mail.gmail.com>
References: <20120703101927.63336e65@endymion.delvare> <CAGS+omDC7voaYU2w1zZjCBmXssPQVdp_7YOH+Lgvv5=XTU0fzg@mail.gmail.com>
 <20120703153959.0e760660@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120703153959.0e760660-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 3, 2012 at 9:39 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote=
:
>
> Hi Daniel,
>
> Thanks for the feedback.
>
> On Tue, 3 Jul 2012 17:50:13 +0800, Daniel Kurtz wrote:
> > On Tue, Jul 3, 2012 at 4:19 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> w=
rote:
> > >
> > > Come up with a consistent, driver-wide strategy for event polling=
=2E For
> > > intermediate steps of byte-by-byte block transactions, check for
> > > BYTE_DONE or any error flag being set. At the end of every
> > > transaction,
> > > check for both BUSY being cleared and INTR or any error flag bein=
g
> > > set.
> > > This avoids having to wait twice for the same event.
> > >
> > > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > > Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > > ---
> > > Daniel, this is what I had in mind. This applies on top of your f=
irst
> > > 6
> > > patches (i.e. all the preliminary cleanup patches, not the interr=
upt
> > > patches.) It solves the performance regression problem and makes =
the
> > > code look better IMHO. Tested OK on ICH10 and ICH3-M. What do you
> > > think? Comments and suggestions for improvements are very welcome=
=2E
> > >
> > > It may be possible to combine i801_wait_intr() and
> > > i801_wait_byte_done() into a single function, as they do pretty m=
uch
> > > the same, but I'll only do that if it doesn't hurt readability. M=
y
> > > first attempt was horrible.
> > >
> > >  drivers/i2c/busses/i2c-i801.c |   88
> > > ++++++++++++++++++++---------------------
> > >  1 file changed, 43 insertions(+), 45 deletions(-)
> > >
> > > --- linux-3.5-rc5.orig/drivers/i2c/busses/i2c-i801.c    2012-07-0=
2
> > > 18:09:59.000000000 +0200
> > > +++ linux-3.5-rc5/drivers/i2c/busses/i2c-i801.c 2012-07-03
> > > 10:07:42.254632389 +0200
> > > (...)
> > > @@ -245,42 +245,60 @@ static int i801_check_post(struct i801_p
> > >                 dev_dbg(&priv->pci_dev->dev, "Lost arbitration\n"=
);
> > >         }
> > >
> > > -       if (result) {
> > > -               /* Clear error flags */
> > > -               outb_p(status & STATUS_FLAGS, SMBHSTSTS(priv));
> > > -               status =3D inb_p(SMBHSTSTS(priv)) & STATUS_FLAGS;
> > > -               if (status) {
> > > -                       dev_warn(&priv->pci_dev->dev, "Failed cle=
aring
> > > status "
> > > -                                "flags at end of transaction
> > > (%02x)\n",
> > > -                                status);
> > > -               }
> > > -       }
> > > +       /* Clear status flags except BYTE_DONE, to be cleared by
> > > caller */
> > > +       clear =3D STATUS_ERROR_FLAGS;
> > > +       if (!(status & SMBHSTSTS_BYTE_DONE))
> > > +               clear |=3D SMBHSTSTS_INTR;
> > > +       outb_p(status & clear, SMBHSTSTS(priv));
> >
> > This becomes simpler (see below...), since status is already masked=
 by
> > (STATUS_ERROR_FLAGS | SMBHSTSTS_INTR).
> >
> > +       outb_p(status, SMBHSTSTS(priv));
>
> You're correct, I had not thought of doing it this way.
>
> > >
> > >         return result;
> > >  }
> > >
> > > -/* wait for INTR bit as advised by Intel */
> > > -static void i801_wait_intr(struct i801_priv *priv)
> > > +/* Wait for BUSY being cleared and either INTR or an error flag =
being
> > > set */
> > > +static int i801_wait_intr(struct i801_priv *priv)
> > >  {
> > >         int timeout =3D 0;
> > >         int status;
> > >
> > > +       /* We will always wait for a fraction of a second! */
> > >         do {
> > >                 usleep_range(250, 500);
> > >                 status =3D inb_p(SMBHSTSTS(priv));
> > > -       } while ((!(status & SMBHSTSTS_INTR)) && (timeout++ <
> > > MAX_RETRIES));
> > > +       } while (((status & SMBHSTSTS_HOST_BUSY) ||
> > > +                 !(status & (STATUS_ERROR_FLAGS | SMBHSTSTS_INTR=
)))
> > > &&
> > > +                (timeout++ < MAX_RETRIES));
> >
> >
> > From your experiments, I think you saw that the final status (ERROR=
 |
> > INTR) will be set before or at the same time as HOST_BUSY -> 0, so =
the
> > loop need only check HOST_BUSY, and then just return the final stat=
us
> > bits of the transfer (ie, ERROR_FLAGS | INTR).  So, the function na=
me
> > could be something like:
> >
> >   i801_wait_xfer_status()
>
> You're right. But I did these tests out of curiosity, maybe I shouldn=
't
> have published the results, because now I feel reluctant to use the
> results. The reason is that this is not specified in the datasheet, s=
o
> I have no guarantee that the same holds for all chips or all
> transaction types.
>
> Furthermore, I see no reason to not play it safe. What costs time and
> CPU here is the sleep and the inb_p. The extra test is pretty cheap
> IMHO.

Sorry, I forgot to make my actual point last time.  This loop actually
terminates *early* now, since it ends when an error occur, without
waiting for the transaction to finish.  I think it would be safer to
wait for the transaction to finish (HOST_BUSY -> 0) first, and then
return the status.  Otherwise, you might end up trying to clear the
error status while HOST_BUSY is set, which is technically a violation
of the spec:

=46rom ICH 10 datasheet:

HOST_BUSY =97 R/WC.
0 =3D Cleared by the ICH10 when the current transaction is completed.
1 =3D Indicates that the ICH10 is running a command from the host
interface. No SMB registers should be accessed while this bit is set,
except the BLOCK DATA BYTE Register. The BLOCK DATA BYTE Register can
be accessed when this bit is set only when the SMB_CMD bits in the
Host Control Register are programmed for Block command or I2C Read
command. This is necessary in order to check the DONE_STS bit.

>
> > > (...)
> > > +/* Wait for either BYTE_DONE or an error flag being set */
> > > +static int i801_wait_byte_done(struct i801_priv *priv)
> > > +{
> > > +       int timeout =3D 0;
> > > +       int status;
> > > +
> > > +       /* We will always wait for a fraction of a second! */
> > > +       do {
> > > +               usleep_range(250, 500);
> > > +               status =3D inb_p(SMBHSTSTS(priv));
> > > +       } while (!(status & (STATUS_ERROR_FLAGS |
> > > SMBHSTSTS_BYTE_DONE)) &&
> > > +                (timeout++ < MAX_RETRIES));
> > > +
> > > +       if (timeout > MAX_RETRIES) {
> > > +               dev_dbg(&priv->pci_dev->dev, "BYTE_DONE Timeout!\=
n");
> > > +               return -ETIMEDOUT;
> > > +       }
> > > +       return status;
> > >  }
> >
> > For i801_wait_byte_done(), on success I would return 0, if an error
> > was set, return (status & ERROR_FLAG), and of course return -ETIMED=
OUT
> > on timeout.
> > Then, we only need to call i801_check_post() if i801_wait_byte_done=
()
> > !=3D 0... see below...
>
> Good idea, yes, this simplifies the code somewhat.
>
> > >
> > >  static int i801_transaction(struct i801_priv *priv, int xact)
> > >  {
> > >         int status;
> > >         int result;
> > > -       int timeout =3D 0;
> > >
> > >         result =3D i801_check_pre(priv);
> > >         if (result < 0)
> > > @@ -290,19 +308,8 @@ static int i801_transaction(struct i801_
> > >          * SMBSCMD are passed in xact */
> > >         outb_p(xact | SMBHSTCNT_START, SMBHSTCNT(priv));
> > >
> > > -       /* We will always wait for a fraction of a second! */
> > > -       do {
> > > -               usleep_range(250, 500);
> > > -               status =3D inb_p(SMBHSTSTS(priv));
> > > -       } while ((status & SMBHSTSTS_HOST_BUSY) && (timeout++ <
> > > MAX_RETRIES));
> > > -
> > > -       result =3D i801_check_post(priv, status, timeout > MAX_RE=
TRIES);
> > > -       if (result < 0)
> > > -               return result;
> > > -
> > > -       i801_wait_intr(priv);
> > > -
> > > -       return 0;
> > > +       status =3D i801_wait_intr(priv);
> > > +       return i801_check_post(priv, status);
> > >  }
> > >
> > >  static int i801_block_transaction_by_block(struct i801_priv *pri=
v,
> > > @@ -353,7 +360,6 @@ static int i801_block_transaction_byte_b
> > >         int smbcmd;
> > >         int status;
> > >         int result;
> > > -       int timeout;
> > >
> > >         result =3D i801_check_pre(priv);
> > >         if (result < 0)
> > > @@ -381,15 +387,8 @@ static int i801_block_transaction_byte_b
> > >                         outb_p(inb(SMBHSTCNT(priv)) | SMBHSTCNT_S=
TART,
> > >                                SMBHSTCNT(priv));
> > >
> > > -               /* We will always wait for a fraction of a second=
! */
> > > -               timeout =3D 0;
> > > -               do {
> > > -                       usleep_range(250, 500);
> > > -                       status =3D inb_p(SMBHSTSTS(priv));
> > > -               } while (!(status & (SMBHSTSTS_BYTE_DONE |
> > > STATUS_ERROR_FLAGS))
> > > -                        && (timeout++ < MAX_RETRIES));
> > > -
> > > -               result =3D i801_check_post(priv, status, timeout =
>
> > > MAX_RETRIES);
> >
> > +               status =3D i801_wait_byte_done(priv);
> > +                 if (status)
> > +                         goto done;
>
> That's not really different from my own code, I guess it depends if o=
ne
> likes gotos or not.
>
> > > @@ -421,9 +420,8 @@ static int i801_block_transaction_byte_b
> > >                 outb_p(SMBHSTSTS_BYTE_DONE, SMBHSTSTS(priv));
> > >         }
> > >
> > > -       i801_wait_intr(priv);
> > > -
> > > -       return 0;
> > > +       status =3D i801_wait_intr(priv);
> >
> > done:
> > > +       return i801_check_post(priv, status);
> > >  }
> > >
> > >  static int i801_set_block_buffer_mode(struct i801_priv *priv)
> >
> > While we are at this, let's clean up the "Illegal SMBus block read
> > size" error path, as well.
> > Why not use the "KILL" bit to terminate the transaction?
>
> I have no idea why it was done that way, although I have to admit I'm
> the author of the code (commit cf898dc5.) If using KILL works too and
> this makes the core more simple, I'm all for it. This is easy enough =
to
> test.
>
> With your suggested changes, I have the following (tested) incrementa=
l
> changes which I could merge into my patch. Please let me know if I
> missed or misunderstood anything.
>
> ---
>  drivers/i2c/busses/i2c-i801.c |   22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> --- linux-3.5-rc5.orig/drivers/i2c/busses/i2c-i801.c    2012-07-03
> 15:00:21.000000000 +0200
> +++ linux-3.5-rc5/drivers/i2c/busses/i2c-i801.c 2012-07-03
> 15:25:50.759652731 +0200
> @@ -206,11 +206,14 @@ static int i801_check_pre(struct i801_pr
>         return 0;
>  }
>
> -/* Convert the status register to an error code, and clear it. */
> +/*
> + * Convert the status register to an error code, and clear it.
> + * Note that status only contains the bits we want to clear, not the
> + * actual register value.
> + */
>  static int i801_check_post(struct i801_priv *priv, int status)
>  {
>         int result =3D 0;
> -       int clear;
>
>         /* If the SMBus is still busy, we give up */
>         if (unlikely(status < 0)) {
> @@ -246,10 +249,7 @@ static int i801_check_post(struct i801_p
>         }
>
>         /* Clear status flags except BYTE_DONE, to be cleared by call=
er */
> -       clear =3D STATUS_ERROR_FLAGS;
> -       if (!(status & SMBHSTSTS_BYTE_DONE))
> -               clear |=3D SMBHSTSTS_INTR;
> -       outb_p(status & clear, SMBHSTSTS(priv));
> +       outb_p(status, SMBHSTSTS(priv));
>
>         return result;
>  }
> @@ -272,7 +272,7 @@ static int i801_wait_intr(struct i801_pr

"i801_wait_intr()" isn't such a good name anymore.  I recommend
i801_wait_xfer_status(), or i801_wait_host_idle().

>                 dev_dbg(&priv->pci_dev->dev, "INTR Timeout!\n");

"Timed out waiting for transaction to complete!\n"

>                 return -ETIMEDOUT;
>         }
> -       return status;
> +       return status & (STATUS_ERROR_FLAGS | SMBHSTSTS_INTR);
>  }
>
>  /* Wait for either BYTE_DONE or an error flag being set */
> @@ -292,7 +292,7 @@ static int i801_wait_byte_done(struct i8
>                 dev_dbg(&priv->pci_dev->dev, "BYTE_DONE Timeout!\n");
>                 return -ETIMEDOUT;
>         }
> -       return status;
> +       return status & STATUS_ERROR_FLAGS;
>  }
>
>  static int i801_transaction(struct i801_priv *priv, int xact)
> @@ -388,9 +388,8 @@ static int i801_block_transaction_byte_b
>                                SMBHSTCNT(priv));
>
>                 status =3D i801_wait_byte_done(priv);
> -               result =3D i801_check_post(priv, status);
> -               if (result < 0)
> -                       return result;
> +               if (status)
> +                       goto exit;
>
>                 if (i =3D=3D 1 && read_write =3D=3D I2C_SMBUS_READ
>                  && command !=3D I2C_SMBUS_I2C_BLOCK_DATA) {
> @@ -421,6 +420,7 @@ static int i801_block_transaction_byte_b
>         }
>
>         status =3D i801_wait_intr(priv);
> +exit:
>         return i801_check_post(priv, status);
>  }
>
>
>
> --
> Jean Delvare
