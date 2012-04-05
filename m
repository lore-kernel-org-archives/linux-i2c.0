From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-tools: Discussion points about future library
Date: Thu, 5 Apr 2012 09:49:10 +0200
Message-ID: <20120405094910.1dcc4779@endymion.delvare>
References: <20120404160113.2295c636@endymion.delvare>
	<20120404174158.GA19773@sirena.org.uk>
	<20120404212323.59053a1f@endymion.delvare>
	<4F7CA3D4.8000104@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F7CA3D4.8000104-08dBlVkRsZWoiTQjSSYKZesEoJ4y9sgM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Mokrejs <mmokrejs-08dBlVkRsZWoiTQjSSYKZesEoJ4y9sgM@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Aurelien Jarno <aurelien-rXXEIb44qovR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Martin,

Please don't top-post.

On Wed, 04 Apr 2012 21:41:08 +0200, Martin Mokrejs wrote:
> Hi,
>   did you Google for it? Looks "libi2c" is already existing.

Yes I did.

> http://www.rtems.com/ml/rtems-users/2008/march/msg00033.html

RTEMS is an operating system on its own. We don't care what libraries
they have and what they named them, just as they don't care what
libraries Linux has and names them.

> http://packages.ubuntu.com/search?keywords=libi2c-dev

As you know, Ubuntu is derived from Debian, and I did mention in my
original post that Debian had a package named libi2c-dev. Meanwhile
Mark Brown explained that this is the development package for an
hypothetical libi2c package which doesn't (yet exist.) So I am aware of
this one and it is compatible with my effort.

> http://opensource.katalix.com/libi2c/

First time I hear of this. They never contacted me (nor the linux-i2c
list) about it, and more importantly, it doesn't seem to be packaged by
any major Linux distribution. Their API is different from what the
kernel and i2c-tools use. I can understand that they developed
something given the lack of a proper library for the past 10 years, but
they should have discussed it with the community to make it more
visible. I'm not saying Katalix is bad, they did work with the
community on other topics, but in this specific case they did not, and
that's unfortunate.

I'm not sure if they still maintain that code, BTW, this seems to be an
old page, if I go to http://www.katalix.com, I can't return to that
page.

I understand that having two libraries by the same name will cause some
confusion, but OTOH the parallel implementations and resulting
confusion already exist, I'm only making the confusion more formal.

>   I would also search for the header filenames and invent such names
> which will not clash with any existing. Same for "-li2c" or
> whatever will apear on the ld line.

No, sorry. I'm not going to invent a fancy name to make sure it isn't
clashing with something out there. If anyone wanted their code to
become the standard Linux i2c library, they should have pushed it to
major Linux distributions. Nobody did AFAICS.

-- 
Jean Delvare
