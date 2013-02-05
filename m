From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v6] i2c: Adding support for Intel iSMT SMBus 2.0 host
 controller
Date: Tue, 5 Feb 2013 08:21:11 +0100
Message-ID: <20130205082111.5d1bba27@endymion.delvare>
References: <1359402232-21369-1-git-send-email-nhorman@tuxdriver.com>
	<1359748083-24423-1-git-send-email-nhorman@tuxdriver.com>
	<20130204104744.5f83541e@endymion.delvare>
	<20130204181902.06c247ad@endymion.delvare>
	<20130204172851.GA24749@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130204172851.GA24749-B26myB8xz7F8NnZeBjwnZQMhkBWG/bsMQH7oEaQurus@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 4 Feb 2013 12:28:51 -0500, Neil Horman wrote:
> I've got the same device on my system here.  Seth, can you elaborate on what it
> is.  FWIW, I took a risk, read a block from that device and wrote the same block
> back to it with my v6 driver, with dyamic debug enabled, and the reported
> printk's indicated it succeded.

That doesn't mean a thing, unfortunately. It is possible that the write
did not work, if you attempted to write the same data as was already
present, you can't tell the difference between success and failure.
Some slave SMBus devices will ack all transactions regardless of
whether they support these transactions or not. As long as we don't
know what is this slave device at 0x54, it's impossible to tell if the
driver really works. I am glad Seth could test it with a different,
known slave device.

>  I'll test out this patch in a bit here, make
> the other requested corrections and repost shortly.

-- 
Jean Delvare
