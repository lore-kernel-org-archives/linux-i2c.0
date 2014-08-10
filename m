From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ddc/ci over i2c
Date: Sun, 10 Aug 2014 11:05:28 +0200
Message-ID: <20140810110528.1b5a825f@endymion.delvare>
References: <53BBC97B.5020805@minsoft.com>
	<20140709002017.4c2b332e@endymion.delvare>
	<53BD6E61.8070101@minsoft.com>
	<20140728125248.5bbc0f89@endymion.delvare>
	<53E6902B.9000104@minsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53E6902B.9000104-9+fK6rGKj7RBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sanford Rockowitz <rockowitz-9+fK6rGKj7RBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Sanford,

Thanks for all the explanations.

On Sat, 09 Aug 2014 14:18:35 -0700, Sanford Rockowitz wrote:
> Lastly, a question.  I have one monitor, a relatively recent 
> "professional" quality Dell P2411H, which has a propensity to return 
> duplicated bytes on read(), .e.g.  0x01020203 instead of 0x010203. The 
> DDC protocol works, but has high retry counts.   Any thoughts on what I 
> might do here as a workaround?

I'm a bit confused by the question, as I don't understand how you could
read more bytes than you actually decided. Or do you mean that, when
reading for example six bytes, you get "1, 2, 2, 3, 4, 5" instead of
the expected "1, 2, 3, 4, 5, 6", i.e. the byte count is good but you're
missing the last one (and you have one duplicate)?

I have two Dell monitors here, U2312HM and P2414H, I can try to
reproduce the problem if you give me the code to run.

I can't remember seeing this before, so I have no immediate explanation.
However some I2C chips use an internal pointer register to select which
register is being read. Whenever you read a byte, the pointer gets
increased to point to the next register. I can imagine that, if the
master reads faster than the slave is able to process, then maybe the
next read could happen before the pointer register is actually
increased. That being said, with such a race condition, I'd expect the
pointer to eventually catch up so you'd get something like "1, 2, 2, 4,
5, 6". Is the duplicate byte always early in the sequence, or can it be
anywhere?

I suggest that you verify that the master properly handles clock
stretching (to give the slave the opportunity to slow down the
transfer.) Or simply lower the DDC bus clock speed and see if it helps.

-- 
Jean Delvare
SUSE L3 Support
