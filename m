From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c multiplexer driver for Proliant microserver N36L
Date: Wed, 13 Jun 2012 09:47:39 +0200
Message-ID: <20120613094739.360967aa@endymion.delvare>
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
	<CAKdnbx4MUfU086F7navt52WaoF4q_+3G+DHn7u2qic+FU50OiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKdnbx4MUfU086F7navt52WaoF4q_+3G+DHn7u2qic+FU50OiA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddi De Pieri <eddi-soWH+0lSOSbR7s880joybQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Brandon <tbrandonau-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Armenia <andrew-Lwj1yN59in/Ib2jZbfQ/kQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Eddi,

On Wed, 13 Jun 2012 07:44:34 +0200, Eddi De Pieri wrote:
> It works for me too
> 
> What about including this patch in the mainline?

Yesterday I reviewed a patch set adding support for the auxiliary SMBus
controller on the SB600/SB700:
http://marc.info/?t=133886124500001&r=1&w=2
http://marc.info/?t=133886124300004&r=1&w=2
http://marc.info/?t=133886124300003&r=1&w=2

It touches the exact same area as touched by your patch, so they will
conflict. Best would be to rebase the SB800 multiport support patch on
top of the other patch set.

Andrew, do you think you can update per my comments and resubmit your
patch set quickly, so that we can then proceed with the SB800 multiport
support before the next merge window?

Thanks,
-- 
Jean Delvare
