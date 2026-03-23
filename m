Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA193248883;
	Mon, 23 Mar 2026 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278789; cv=none; b=Ol2En8nRMqEfHrw+vziD7FMjywIJUb2/IExNkfJEdTaxPADJOQ9SRTx1QXtm/FPqkl5dKst01qEm0da5fU02GtBAqhsPwUheRutG7NWleTaUR/C5F+Bo0E/xLX4oTlFcK6VQfOvGI78Gytgyq+Y8oWPDW9vREeJnCphgTuNbybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278789; c=relaxed/simple;
	bh=YrwBeaSkjW0aQ+HR5m3NpAVYwdYTxZBdjzf4P2otFpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzjDX6T/tDhFWvlIROHagV8Kj0s8WxAoHZpcdKu6Kz3uqTPdkEo803UqaYFsWDOQ6ndMERR1k/E/0ZlA+fp29D+u0aOZwhvv1m2yAXhXA8iv1509t3Q42ZS1i4f+nfz280IuMTXp6Vyf4krX6QqGffQxnY2/z4FZ5+QhEf5jOZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dqhAi0xJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dqhAi0xJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1kLPOsQyh75i84wj1wbQK13zqndKEg5i3OC3tZ1395Y=; b=dqhAi0xJvXNDIF9GpcoIn0Skxs
	r8yKxs2pnUCWIxvLchoZG9WOPoiKuP+bTWVjhF0rzKpeQqhabjSLUD1QjcsRN8MfMJzOXiqWRfb7c
	XGjJC12ebPtRDC5xcIPdCNaHI36cb6QdFW8e9MU8yAT/HnlHPIo67QRO+M3og1nI0m8w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w4gxc-00Cx1N-Ht; Mon, 23 Mar 2026 16:12:56 +0100
Date: Mon, 23 Mar 2026 16:12:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Martin Aberer <martin.aberer@bachmann.info>, peter@korsgaard.com,
	andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: ocores: re-check status after poll timeout to avoid
 false errors
Message-ID: <cbf91ba0-06e8-4ead-91dc-7213035c1a81@lunn.ch>
References: <20260323135249.550925-1-martin.aberer@bachmann.info>
 <CAH9NwWdLtaSsS=B-hq1WV2RF81o6NcO4mai9M0ts+fuq-YkH+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH9NwWdLtaSsS=B-hq1WV2RF81o6NcO4mai9M0ts+fuq-YkH+Q@mail.gmail.com>

On Mon, Mar 23, 2026 at 03:34:24PM +0100, Christian Gmeiner wrote:
> Hey Martin
> 
> > The polling task can be preempted at any point inside ocores_wait(),
> > including just before the time_after() check. If the scheduler does
> > not resume the task until after the 1ms deadline, ocores_wait()
> > returns -ETIMEDOUT even though the hardware already cleared the
> > status bit.
> >
> > Re-read the status register after a timeout before declaring failure.
> > This avoids spurious timeout warnings under high CPU load.
> >
> > Signed-off-by: Martin Aberer <martin.aberer@bachmann.info>
> > ---
> >  drivers/i2c/busses/i2c-ocores.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> > index 0f67e57cdeff..6f5aece94d57 100644
> > --- a/drivers/i2c/busses/i2c-ocores.c
> > +++ b/drivers/i2c/busses/i2c-ocores.c
> > @@ -313,12 +313,24 @@ static int ocores_poll_wait(struct ocores_i2c *i2c)
> >         /*
> >          * once we are here we expect to get the expected result immediately
> >          * so if after 1ms we timeout then something is broken.
> > +        *
> > +        * The polling task can be preempted at any point inside ocores_wait(),
> > +        * including just before the time_after() check. If the scheduler does
> > +        * not resume the task until after the 1ms deadline, ocores_wait()
> > +        * returns -ETIMEDOUT even though the hardware already cleared the
> > +        * status bit.
> > +
> > +        * Re-read the status register after a timeout before declaring failure.
> > +        * This avoids spurious timeout warnings under high CPU load.
> >          */
> >         err = ocores_wait(i2c, OCI2C_STATUS, mask, 0, msecs_to_jiffies(1));
> > -       if (err)
> > +       if (err) {
> > +               if ((oc_getreg(i2c, OCI2C_STATUS) & mask) == 0)
> > +                       return 0;
> >                 dev_warn(i2c->adap.dev.parent,
> >                          "%s: STATUS timeout, bit 0x%x did not clear in 1ms\n",
> >                          __func__, mask);
> > +       }
> >         return err;
> >  }
> >
> 
> In my view, a proper fix would be to switch to read_poll_timeout_atomic().
> Something like this - untested:
> 
> ---8<----
> 
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> index 0f67e57cdeff..df6ebf32d6e8 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -24,6 +24,7 @@
> #include <linux/io.h>
> #include <linux/log2.h>
> #include <linux/spinlock.h>
> +#include <linux/iopoll.h>
> #include <linux/jiffies.h>
> /*
> @@ -258,7 +259,7 @@ static void ocores_process_timeout(struct ocores_i2c *i2c)
> * @reg: register to query
> * @mask: bitmask to apply on register value
> * @val: expected result
> - * @timeout: timeout in jiffies
> + * @timeout_us: timeout in microseconds
> *
> * Timeout is necessary to avoid to stay here forever when the chip
> * does not answer correctly.
> @@ -267,21 +268,14 @@ static void ocores_process_timeout(struct ocores_i2c *i2c)
> */
> static int ocores_wait(struct ocores_i2c *i2c,
> int reg, u8 mask, u8 val,
> - const unsigned long timeout)
> + unsigned long timeout_us)
> {
> - unsigned long j;
> + u8 status;

Hi Christian

It looks like your email client has corrupted the patch, messing up
the white space.

Please post a real patch.

FYI: I agree iopoll.h is the way to go, i keep pointing out this class
a bugs in various places and always point developers at those macros.

  Andrew
