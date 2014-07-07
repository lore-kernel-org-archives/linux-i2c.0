From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [RFC PATCH] i2c: stub: Add support for SMBus block commands
Date: Mon, 7 Jul 2014 16:04:40 +0200
Message-ID: <20140707160440.042fda11@endymion.delvare>
References: <1404705312-27633-1-git-send-email-linux@roeck-us.net>
	<20140707102711.1b630fe2@endymion.delvare>
	<53BAA152.9040002@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53BAA152.9040002-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 07 Jul 2014 06:32:02 -0700, Guenter Roeck wrote:
> On 07/07/2014 01:27 AM, Jean Delvare wrote:
> > On Sun,  6 Jul 2014 20:55:12 -0700, Guenter Roeck wrote:
> >>   			chip->words[command] &= 0xff00;
> >>   			chip->words[command] |= data->byte;
> >>   			dev_dbg(&adap->dev,
> >>   				"smbus byte data - addr 0x%02x, wrote 0x%02x at 0x%02x.\n",
> >>   				addr, data->byte, command);
> >>   		} else {
> >> -			data->byte = chip->words[command] & 0xff;
> >> +			if (b)
> >> +				data->byte = b->len;
> >> +			else
> >> +				data->byte = chip->words[command] & 0xff;
> >
> > You could avoid this conditional (and the same below in case
> > I2C_SMBUS_WORD_DATA) by writing to chip->words at the same time you
> > write to b->block. Block transfers being rare and reads occurring more
> > frequently than writes, I think the performance benefit is clear.
>
> Makes sense, I'll do that. Great idea.
> 
> Question is if I should cover attempts to write a byte or word into block data.
> I don't think it is worth the effort, as drivers won't usually do that.
> My take is that we could add it later if really needed.
> What do you think ?

I agree. The i2c-stub driver can't possibly cover every use case
anyway, so let's keep it simple and only emulate behaviors we need for
real.

-- 
Jean Delvare
SUSE L3 Support
