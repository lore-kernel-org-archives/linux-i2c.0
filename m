From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c: introduce i2c helper i2c_find_client_by_name()
Date: Fri, 12 Jul 2013 13:54:20 +0300
Message-ID: <CAHp75VeasHGariq=v005NSUTe_+e471NYbEoSzPJXcFNgsfKNQ@mail.gmail.com>
References: <20130606183346.GA13259@bingao-desk1.fm.intel.com>
	<20130705195512.GJ27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130705195512.GJ27646-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Bin Gao <bin.gao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 5, 2013 at 10:55 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Jun 06, 2013 at 11:33:46AM -0700, Bin Gao wrote:
>
>> A good example is that an ISP(Imaging Signal Processor) driver needs
>> register i2c camera sensor devices via v4l2, so it has to unregister
>> all i2c clients that were previously registered by calling
>> i2c_register_board_info(), and then re-register. For this case we
>> can use this helper to get i2c_client by passing the client name.
>
> Please look at the work that IIRC Laurent Pichart (CCed) was doing on
> developing generic DT bindings for v4l in embedded systems,

I couldn't find anything related to OF except v4l2-of.c in the v4l2-core.
Is that what you mentioned?

> it sounds
> like you're working on similar hardware here.  The general ideas should
> apply to any enumeration mechanism, not just DT.

Briefly looking into ACPI tables we have and mechanisms that we can
use in ACPI case, I doubt we may apply all the ideas, probably some of
them, though I didn't get yet where to read about in details. What I
could say now is that the patch provided by Bin Gao is definitely no
go.

--
With Best Regards,
Andy Shevchenko
