From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [lm-sensors] Use the Linux I2C subsystem for a two wire	interface
 protocol
Date: Wed, 15 Jul 2009 07:41:30 +0200
Message-ID: <4A5D6C0A.7030903@gmx.de>
References: <528f13590907140925h7aa36452o60da32d3bf941241@mail.gmail.com>	<4A5CB908.4060404@cam.ac.uk> <528f13590907141358w17869b6fq450bf223e4f54687@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <528f13590907141358w17869b6fq450bf223e4f54687-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alfred steele <alfred.jaquez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

alfred steele said the following:
> To sum it up, the intention is code
> reusablity in the sense that if we move to a different part which sits
> on the I2c bus, we need not have to modify the kernel driver, just
> keep the complexity  in the userspace.

I'd say this is just the wrong way round:
Design goal should be to keep application as is and just load another
driver on H/W change + changing access path in some config file.

Just my 2 cents

Michael
