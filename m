From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c multiplexer driver for Proliant microserver N36L
Date: Wed, 29 Aug 2012 19:44:25 +0200
Message-ID: <20120829194425.31dc3500@endymion.delvare>
References: <CAKdnbx7xeygkOK=BR+3vUrWT3GEt=PZrxgrEMvEB5nkOfAF0bg@mail.gmail.com>
	<20111127225514.GO19115@trinity.fluff.org>
	<CAKdnbx4u6+_WJjjMJ3jnDLSU8eJ0yXX0Mg-dcr=3F4FaOd2R=g@mail.gmail.com>
	<20111203162757.GA24302@ericsson.com>
	<CAKdnbx54R9t-mS9-EvyT-618wVp-YH0YDO++=m5t-JqR6h=GCw@mail.gmail.com>
	<20111203180819.2ddbcb3a@endymion.delvare>
	<CAKdnbx5V=qfa5dshRudHx+M3o8Eb6qJXCVG+ZBaBwCeKaoQYNA@mail.gmail.com>
	<20111206093906.21dccf8d@endymion.delvare>
	<loom.20120215T165236-509@post.gmane.org>
	<CAM5MpD5R4xde4Li1NCDoErisXs7oRMAgW7swuCwga80MkU3VMw@mail.gmail.com>
	<CAM5MpD46pT1N2f5yZb0yW1O8CjH7B969TmvxDZztMfwBoyom3g@mail.gmail.com>
	<CAKdnbx7tiMaU1c971a+P2vhE_owO_zd8EXhKR7cAwrH=evVQ6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKdnbx7tiMaU1c971a+P2vhE_owO_zd8EXhKR7cAwrH=evVQ6g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddi De Pieri <eddi-soWH+0lSOSbR7s880joybQ@public.gmane.org>
Cc: Thomas Brandon <tbrandonau-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Eddi, Thomas,

On Wed, 14 Mar 2012 09:28:54 +0100, Eddi De Pieri wrote:
> Hi Thomas,
> 
> > With the updated patch and the modified sensors-detect I have been
> > able to probe all ports and have not encountered the power issue
> > again. If no further issues are identified I will seperate the patch
> > into stages and submit for review.
> 
> I confirm that your patch works well on my proliant n36l and solve the
> power issue.
> 
> Thank you for rewrote my patch.

Recent mainline changes to the i2c-piix4 driver make the patch no
longer apply, so I can't push it upstream. Can either of you please
rebase the patch on top of Linus' latest kernel and resubmit?

Thanks,
-- 
Jean Delvare
