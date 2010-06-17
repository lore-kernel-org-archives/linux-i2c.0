From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] hmc6352: Add driver for the HMC6352 compass
Date: Thu, 17 Jun 2010 14:26:08 +0200
Message-ID: <201006171426.08442.oneukum@suse.de>
References: <20100616121534.26294.12540.stgit@localhost.localdomain> <201006161443.45375.oneukum@suse.de> <20100617122048.142def43@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100617122048.142def43-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Am Donnerstag, 17. Juni 2010 13:20:48 schrieb Alan Cox:
> On Wed, 16 Jun 2010 14:43:45 +0200
> Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org> wrote:
> 
> > Am Mittwoch, 16. Juni 2010 14:16:14 schrieb Alan Cox:
> > > +       msleep(10); /* sending 0x41 cmd we need to wait for 7-10 milli seconds */
> > > +       ret = i2c_transfer(client->adapter, msg1, 1);
> > > +       if (ret != 1) {
> > > +               dev_warn(dev, "i2c read data cmd failed\n");
> > > +               return ret;
> > > +       }
> > > +       ret_val = i2c_data[0];
> > > +       ret_val = ((ret_val << 8) | i2c_data[1]);
> > 
> > Please use the correct macro for this conversion.
> 
> Its an array anyway - there isn't as such a 'correct macro' nor does it
> need to be using one.

So why does he use this unstructured data? Do we just hope the compiler
is good enough on big endian architectures?

	Regards
		Oliver
