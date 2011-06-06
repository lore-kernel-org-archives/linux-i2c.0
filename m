From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Mon, 6 Jun 2011 22:50:00 +0200
Message-ID: <20110606205000.GB2880@sortiz-mobl>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110325142648.GC3879@sortiz-mobl>
 <99B09243E1A5DA4898CDD8B7001114481085E2375D@EXMB04.eu.tieto.com>
 <201103291305.02293.arnd@arndb.de>
 <20110331141650.GB2704@sortiz-mobl>
 <99B09243E1A5DA4898CDD8B7001114481085F0FE7C@EXMB04.eu.tieto.com>
 <20110331153010.GD2704@sortiz-mobl>
 <BANLkTimsZeqvSWj+kKWLSmFOQc70KWodcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BANLkTimsZeqvSWj+kKWLSmFOQc70KWodcw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavan Savoy <pavan_savoy-OuV/mKzhOIQ@public.gmane.org>
Cc: Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org, Sebastian.Chlad-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Pavan,

On Mon, Jun 06, 2011 at 03:22:01PM -0500, Pavan Savoy wrote:
> On Thu, Mar 31, 2011 at 9:30 AM, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > On Thu, Mar 31, 2011 at 06:24:50PM +0300, Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org wrote:
> >> Hi Samuel,
> >>
> >> >That's the Bluetooth approach, and it works just fine as well.
> >> >However, the netlink option for sending commands and receiving
> >> >answers to/from a subsystem sounds more appropriate, at least to me.
> >>
> >> I haven't used netlink in practice, so just wondering why netlink. I assume, then, it's more suitable :)
> >>
> > Have a look at the wireless nl80211.c implementation. It's a good example for
> > that sort of usage.
> 
> So, why was the network interface 'ala eth0 or the netlink interface dropped?
The netlink interface was not dropped. See:
http://marc.info/?l=linux-wireless&m=130705125228073&w=2

> I saw these patches recently "NFC: add nfc subsystem core" - which
> seem to add just the device /dev/nfc - am I correct ?
No, the /dev/nfc interface is gone with this subsystem. Instead you will talk
to an AF_NFC socket, or to the NFC generic netlink socket for some NFC high
level commands and events. See:
http://marc.info/?l=linux-wireless&m=130705125728090&w=2

for more details.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
