From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] i2c: add irq_flags to board info
Date: Wed, 20 Oct 2010 19:59:25 +0100
Message-ID: <20101020185924.GA7721@sirena.org.uk>
References: <1287359019-1476-1-git-send-email-vapier@gentoo.org> <20101018103610.77b7e605@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101018103610.77b7e605-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, device-drivers-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 18, 2010 at 10:36:10AM +0200, Jean Delvare wrote:
> On Sun, 17 Oct 2010 19:43:39 -0400, Mike Frysinger wrote:

> > This allows us to avoid having to add dedicated platform init code just
> > to call set_irq_type()

> Do you have examples of this? Can we see a preview of the amount of
> cleanups this patch would allow?

wm831x has platform data for this.  It doesn't actually call
set_irq_type(), it parses the platform data before calling
request_threaded_irq(), but the principle is the same.
