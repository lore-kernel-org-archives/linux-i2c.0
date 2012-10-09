From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/11] introduce macros for i2c_msg initialization
Date: Tue, 9 Oct 2012 17:32:37 +0200
Message-ID: <20121009173237.7c1a49e9@endymion.delvare>
References: <1349624323-15584-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1349624323-15584-1-git-send-email-Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Cc: Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shubhrajyoti-l0cyMroinI0@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Julia,

On Sun,  7 Oct 2012 17:38:30 +0200, Julia Lawall wrote:
> This patch set introduces some macros for describing how an i2c_msg is
> being initialized.  There are three macros: I2C_MSG_READ, for a read
> message, I2C_MSG_WRITE, for a write message, and I2C_MSG_OP, for some other
> kind of message, which is expected to be very rarely used.

"Some other kind of message" is actually messages which need extra
flags. They are still read or write messages.

OK, I've read the whole series now and grepped the kernel tree so I
have a better overview. There are a lot more occurrences than what you
converted. I presume the conversions were just an example and you leave
the rest up to the relevant maintainers (e.g. me) if they are
interested?

Given the huge number of affected drivers (a quick grep suggests 230
drivers and more than 300 occurrences), we'd better think twice before
going on as it will be intrusive and hard to change afterward.

So my first question will be: what is your goal with this change? Are
you only trying to save a few lines of source code? Or do you expect to
actually fix/prevent bugs by introducing these macros? Or something
else?

I admit I am not completely convinced by the benefit at the moment. A
number of these drivers should be using i2c_smbus_*() functions instead
of i2c_transfer() for improved compatibility, or i2c_master_send/recv()
for single message transfers (383 occurrences!), so making
i2c_transfer() easier to use isn't at the top of my priority list. And
I see the extra work for the pre-processor, so we need a good reason
for doing that.

-- 
Jean Delvare
