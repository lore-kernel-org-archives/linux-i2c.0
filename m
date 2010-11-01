From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v2 0/1] PN544 NFC driver.
Date: Mon, 1 Nov 2010 13:54:31 -0400
Message-ID: <20101101175431.GG24814@opensource.wolfsonmicro.com>
References: <1288333569-19979-1-git-send-email-matti.j.aaltonen@nokia.com>
 <20101029143333.db43953b.akpm@linux-foundation.org>
 <20101029225008.GA17654@sirena.org.uk>
 <1288614325.1603.96.camel@masi.mnp.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1288614325.1603.96.camel-U1ola594hmgZeDAa2SinrdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 01, 2010 at 02:25:25PM +0200, Matti J. Aaltonen wrote:
> On Fri, 2010-10-29 at 23:50 +0100, ext Mark Brown wrote:

> > There's other NFC devices out there being used with Linux.

> But NFC drivers are not easy to find. In the kernel code
> drivers/parisc/pdc_stable.c contains the following line:

...

> The NFC/Mifare DDS product datasheet claims that "The Linux driver is
> already distributed with recent 2.6 series kernels" but it doesn't seem
> to be there...

I said nothing about mainline; I've not noticing anything there.  I was
commenting on the question of needing to have an interface which can be
reused by other devices.  I've never actually worked with such parts so
I've no idea what that would look like.
