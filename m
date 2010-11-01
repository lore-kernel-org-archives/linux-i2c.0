From: "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/1] PN544 NFC driver.
Date: Mon, 01 Nov 2010 14:25:25 +0200
Message-ID: <1288614325.1603.96.camel@masi.mnp.nokia.com>
References: <1288333569-19979-1-git-send-email-matti.j.aaltonen@nokia.com>
	 <20101029143333.db43953b.akpm@linux-foundation.org>
	 <20101029225008.GA17654@sirena.org.uk>
Reply-To: matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101029225008.GA17654-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 2010-10-29 at 23:50 +0100, ext Mark Brown wrote:
> On Fri, Oct 29, 2010 at 02:33:33PM -0700, Andrew Morton wrote:
> 
> > Another consideration here is that if we do expect more NFC devices and
> > drivers for them, then we should aim for some standardisation of the
> > interface, from day one.  Some discussion of this would also be helpful
> > for reviewers.
> 
> There's other NFC devices out there being used with Linux.

But NFC drivers are not easy to find. In the kernel code
drivers/parisc/pdc_stable.c contains the following line:

{ USB_DEVICE(0x10C4, 0x8115) }, /* Arygon NFC/Mifare Reader */

That's the only reference to NFC I found.

The NFC/Mifare DDS product datasheet claims that "The Linux driver is
already distributed with recent 2.6 series kernels" but it doesn't seem
to be there...

B.R.
Matti
