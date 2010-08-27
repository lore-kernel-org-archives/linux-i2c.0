From: "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFC 1/1] MISC: Broadcom BCM4751 GPS driver
Date: Fri, 27 Aug 2010 10:17:39 +0300
Message-ID: <1282893459.14489.268.camel@masi.mnp.nokia.com>
References: <1282572026-14905-1-git-send-email-matti.j.aaltonen@nokia.com>
	 <1282572026-14905-2-git-send-email-matti.j.aaltonen@nokia.com>
	 <20100825060704.GA1578@ucw.cz>
	 <1282815075.14489.249.camel@masi.mnp.nokia.com>
	 <20100826200905.GB20776@elf.ucw.cz>
Reply-To: matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100826200905.GB20776-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "akpm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <akpm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2010-08-26 at 22:09 +0200, ext Pavel Machek wrote:
> On Thu 2010-08-26 12:31:15, Matti J. Aaltonen wrote:
> > Hello.
> > 
> > On Wed, 2010-08-25 at 08:07 +0200, ext Pavel Machek wrote:
> > > On Mon 2010-08-23 17:00:26, Matti J. Aaltonen wrote:
> > > > Driver for Broadcom BCM4751 GPS chip.
> > > 
> > > 
> > > Uhuh. Tell us more... like what's the interface to userspace? NMEA
> > > data over char device?
> > 
> > The interface to user space is MEIF data over a char device. Something
> > about MEIF can be found at
> > 
> > http://www.forum.nokia.com/info/sw.nokia.com/id/b265d3aa-8198-4eb0-a0e3-077748ccea40/MEIF_Specification_License.pdf.html
> > 
> 
> Umm, that contains some legaleese, but nothing useful...?

MEIF is a Nokia proprietary protocol. The link above points to a page,
which describes how you can get hold of the MEIF specification.

Regards,
Matti A.

> 
> 
