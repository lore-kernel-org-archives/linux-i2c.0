From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Consolidate polling
Date: Wed, 4 Jul 2012 09:49:10 +0200
Message-ID: <20120704094910.7e077e2d@endymion.delvare>
References: <20120703101927.63336e65@endymion.delvare>
	<CAGS+omDC7voaYU2w1zZjCBmXssPQVdp_7YOH+Lgvv5=XTU0fzg@mail.gmail.com>
	<20120703153959.0e760660@endymion.delvare>
	<CAGS+omAT0G=BBGRs9H91ah=oZnaY-MHbvbADGOKTES_FbCjLjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGS+omAT0G=BBGRs9H91ah=oZnaY-MHbvbADGOKTES_FbCjLjA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Daniel,

Thanks again for the continued feedback.

On Wed, 4 Jul 2012 14:12:26 +0800, Daniel Kurtz wrote:
> On Tue, Jul 3, 2012 at 9:39 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > On Tue, 3 Jul 2012 17:50:13 +0800, Daniel Kurtz wrote:
> > > On Tue, Jul 3, 2012 at 4:19 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > > > -/* wait for INTR bit as advised by Intel */
> > > > -static void i801_wait_intr(struct i801_priv *priv)
> > > > +/* Wait for BUSY being cleared and either INTR or an error flag being set */
> > > > +static int i801_wait_intr(struct i801_priv *priv)
> > > >  {
> > > >         int timeout = 0;
> > > >         int status;
> > > >
> > > > +       /* We will always wait for a fraction of a second! */
> > > >         do {
> > > >                 usleep_range(250, 500);
> > > >                 status = inb_p(SMBHSTSTS(priv));
> > > > -       } while ((!(status & SMBHSTSTS_INTR)) && (timeout++ < MAX_RETRIES));
> > > > +       } while (((status & SMBHSTSTS_HOST_BUSY) ||
> > > > +                 !(status & (STATUS_ERROR_FLAGS | SMBHSTSTS_INTR))) &&
> > > > +                (timeout++ < MAX_RETRIES));
> > >
> > > From your experiments, I think you saw that the final status (ERROR |
> > > INTR) will be set before or at the same time as HOST_BUSY -> 0, so the
> > > loop need only check HOST_BUSY, and then just return the final status
> > > bits of the transfer (ie, ERROR_FLAGS | INTR).  So, the function name
> > > could be something like:
> > >
> > >   i801_wait_xfer_status()
> >
> > You're right. But I did these tests out of curiosity, maybe I shouldn't
> > have published the results, because now I feel reluctant to use the
> > results. The reason is that this is not specified in the datasheet, so
> > I have no guarantee that the same holds for all chips or all
> > transaction types.
> >
> > Furthermore, I see no reason to not play it safe. What costs time and
> > CPU here is the sleep and the inb_p. The extra test is pretty cheap
> > IMHO.
> 
> Sorry, I forgot to make my actual point last time.  This loop actually
> terminates *early* now, since it ends when an error occur, without
> waiting for the transaction to finish.

This wasn't my intent, and also not what my code is doing, unless I am
reading it wrong.

> I think it would be safer to
> wait for the transaction to finish (HOST_BUSY -> 0) first, and then
> return the status.  

Which is what I'm doing, as far as I can see. Leaving the timeout case
aside for a moment, the loop keeps running if the following condition
is met:

	(status & SMBHSTSTS_HOST_BUSY) || !(status & (STATUS_ERROR_FLAGS | SMBHSTSTS_INTR))

Which, per De Morgan's laws [1], means the loop _exit_ condition is:

	!(status & SMBHSTSTS_HOST_BUSY) && (status & (STATUS_ERROR_FLAGS | SMBHSTSTS_INTR))

That is, we only exit the loop if the BUSY bit is cleared _and_ either
INTR or an error flag is set. In other words this is a late exit. Are
you OK with it now, or am I really missing something?

[1] http://en.wikipedia.org/wiki/De_Morgan%27s_laws

> > (...)
> > @@ -272,7 +272,7 @@ static int i801_wait_intr(struct i801_pr
> 
> "i801_wait_intr()" isn't such a good name anymore.  I recommend
> i801_wait_xfer_status(), or i801_wait_host_idle().

i801_wait_intr() isn't such a bad name IMHO, we are still ideally hoping
that INTR will be set, as this means the transaction will be
successful. The name has the advantage of being symmetric with
i801_wait_byte_done(), so it's clear which one of the status bits we
are expecting.

"i801_wait_host_idle" would be a good name too, but the actual name
doesn't really matter anyway, as the next patch merges both functions
into a single one. I had written this patch before you posted your
proposed changes, but it can still be applied on top of these (with the
usual context adjustment.) Unless you really don't like it? If so,
please tell me why.

> >                 dev_dbg(&priv->pci_dev->dev, "INTR Timeout!\n");
> 
> "Timed out waiting for transaction to complete!\n"

My next patch already changes this to:

		dev_err(&priv->pci_dev->dev,
			"Timeout waiting for %02x! (%02x)\n", wait_set, status);

My message is more generic because the function is now generic, but the
information provided is more or less the same. If you think wording can
be improved, just let me know.

---
 drivers/i2c/busses/i2c-i801.c |   50 ++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

--- linux-3.5-rc5.orig/drivers/i2c/busses/i2c-i801.c	2012-07-03 16:49:42.000000000 +0200
+++ linux-3.5-rc5/drivers/i2c/busses/i2c-i801.c	2012-07-03 17:10:37.062356531 +0200
@@ -254,29 +254,16 @@ static int i801_check_post(struct i801_p
 	return result;
 }
 
-/* Wait for BUSY being cleared and either INTR or an error flag being set */
-static int i801_wait_intr(struct i801_priv *priv)
-{
-	int timeout = 0;
-	int status;
-
-	/* We will always wait for a fraction of a second! */
-	do {
-		usleep_range(250, 500);
-		status = inb_p(SMBHSTSTS(priv));
-	} while (((status & SMBHSTSTS_HOST_BUSY) ||
-		  !(status & (STATUS_ERROR_FLAGS | SMBHSTSTS_INTR))) &&
-		 (timeout++ < MAX_RETRIES));
-
-	if (timeout > MAX_RETRIES) {
-		dev_dbg(&priv->pci_dev->dev, "INTR Timeout!\n");
-		return -ETIMEDOUT;
-	}
-	return status & (STATUS_ERROR_FLAGS | SMBHSTSTS_INTR);
-}
-
-/* Wait for either BYTE_DONE or an error flag being set */
-static int i801_wait_byte_done(struct i801_priv *priv)
+/*
+ * Wait for some status register bits being cleared and others being set.
+ * Typical usage:
+ *  - Wait for BUSY being cleared and either INTR or an error flag being set
+ *    (end of transaction)
+ *  - Wait for either BYTE_DONE or an error flag being set (step of
+ *    byte-by-byte block transaction)
+ * Return the status flags which should be cleared automatically.
+ */
+static int i801_wait(struct i801_priv *priv, int wait_cleared, int wait_set)
 {
 	int timeout = 0;
 	int status;
@@ -285,14 +272,17 @@ static int i801_wait_byte_done(struct i8
 	do {
 		usleep_range(250, 500);
 		status = inb_p(SMBHSTSTS(priv));
-	} while (!(status & (STATUS_ERROR_FLAGS | SMBHSTSTS_BYTE_DONE)) &&
+	} while (((status & wait_cleared) ||
+		  !(status & (STATUS_ERROR_FLAGS | wait_set))) &&
 		 (timeout++ < MAX_RETRIES));
 
-	if (timeout > MAX_RETRIES) {
-		dev_dbg(&priv->pci_dev->dev, "BYTE_DONE Timeout!\n");
+	if (unlikely(timeout > MAX_RETRIES)) {
+		dev_err(&priv->pci_dev->dev,
+			"Timeout waiting for %02x! (%02x)\n", wait_set, status);
 		return -ETIMEDOUT;
 	}
-	return status & STATUS_ERROR_FLAGS;
+	status &= ~SMBHSTSTS_BYTE_DONE;	/* Must be cleared explicitly */
+	return status & (STATUS_ERROR_FLAGS | wait_set);
 }
 
 static int i801_transaction(struct i801_priv *priv, int xact)
@@ -308,7 +298,7 @@ static int i801_transaction(struct i801_
 	 * SMBSCMD are passed in xact */
 	outb_p(xact | SMBHSTCNT_START, SMBHSTCNT(priv));
 
-	status = i801_wait_intr(priv);
+	status = i801_wait(priv, SMBHSTSTS_HOST_BUSY, SMBHSTSTS_INTR);
 	return i801_check_post(priv, status);
 }
 
@@ -387,7 +377,7 @@ static int i801_block_transaction_byte_b
 			outb_p(inb(SMBHSTCNT(priv)) | SMBHSTCNT_START,
 			       SMBHSTCNT(priv));
 
-		status = i801_wait_byte_done(priv);
+		status = i801_wait(priv, 0, SMBHSTSTS_BYTE_DONE);
 		if (status)
 			goto exit;
 
@@ -419,7 +409,7 @@ static int i801_block_transaction_byte_b
 		outb_p(SMBHSTSTS_BYTE_DONE, SMBHSTSTS(priv));
 	}
 
-	status = i801_wait_intr(priv);
+	status = i801_wait(priv, SMBHSTSTS_HOST_BUSY, SMBHSTSTS_INTR);
 exit:
 	return i801_check_post(priv, status);
 }


-- 
Jean Delvare
