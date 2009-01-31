From: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] saa7146_i2c: saa7146_i2c_transfer() wrong?
Date: Sat, 31 Jan 2009 17:52:05 +0100
Message-ID: <498481B5.4030702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

vi drivers/media/common/saa7146_i2c.c +292

in saa7146_i2c_transfer(..., int retries) 
{
	int address_err = 0;
	do {
		...
		if (...)
			address_err++;
		...
	} while (retries--);

	/* if every retry had an address error, exit right away */
        if (address_err == retries) {
                goto out;
        }
	...
}
this is wrong, isn't it?
