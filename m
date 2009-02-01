From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] saa7146_i2c: saa7146_i2c_transfer() wrong?
Date: Sun, 1 Feb 2009 11:55:14 +0100
Message-ID: <20090201115514.380984b7@hyperion.delvare>
References: <498481B5.4030702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <498481B5.4030702-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 31 Jan 2009 17:52:05 +0100, Roel Kluin wrote:
> vi drivers/media/common/saa7146_i2c.c +292
> 
> in saa7146_i2c_transfer(..., int retries) 
> {
> 	int address_err = 0;
> 	do {
> 		...
> 		if (...)
> 			address_err++;
> 		...
> 	} while (retries--);
> 
> 	/* if every retry had an address error, exit right away */
>         if (address_err == retries) {
>                 goto out;
>         }
> 	...
> }
> this is wrong, isn't it?

Yes, it looks pretty wrong, however the linux-i2c list isn't the right
place to discuss this.

-- 
Jean Delvare
