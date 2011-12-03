From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c multiplexer driver for Proliant  microserver N36L
Date: Sat, 3 Dec 2011 18:08:19 +0100
Message-ID: <20111203180819.2ddbcb3a@endymion.delvare>
References: <CAKdnbx7xeygkOK=BR+3vUrWT3GEt=PZrxgrEMvEB5nkOfAF0bg@mail.gmail.com>
	<20111127225514.GO19115@trinity.fluff.org>
	<CAKdnbx4u6+_WJjjMJ3jnDLSU8eJ0yXX0Mg-dcr=3F4FaOd2R=g@mail.gmail.com>
	<20111203162757.GA24302@ericsson.com>
	<CAKdnbx54R9t-mS9-EvyT-618wVp-YH0YDO++=m5t-JqR6h=GCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKdnbx54R9t-mS9-EvyT-618wVp-YH0YDO++=m5t-JqR6h=GCw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddi De Pieri <eddi-soWH+0lSOSbR7s880joybQ@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Eddi,

On Sat, 3 Dec 2011 17:42:16 +0100, Eddi De Pieri wrote:
> Actually I don't have a development system with latest git. I build my
> patch on my debian with 2.6.32 kernel..
> 
> The patch is based on i2c-amd756-s4882.c and adapted to work with sb8xx...
> 
> i2c-amd756-s4882.c is still present and don't use i2c-mux infrastructure.

That's because i2c-amd756-s4882.c was written before the i2c-mux
infrastructure was available. Ideally SMBus multiplexing support on the
Tyan S4882 would be converted to i2c-mux (i.e. i2c-amd756-s4882.c would
be deleted and the multiplexer would be instantiated in i2c-amd756.c
itself, based on DMI data.) This shouldn't be particularly difficult,
the real difficulty is to find someone with one of these boards to test
the changes.

> However if you are interested in porting my work to latest git, you
> will be welcome!

That's not how it works, sorry. Submissions must be based on a recent
kernel in order to be accepted upstream. If you want SMBus multiplexing
support on your system, it will have to be based on i2c-mux, because
that's how things work now. Otherwise I will not accept your code.

-- 
Jean Delvare
