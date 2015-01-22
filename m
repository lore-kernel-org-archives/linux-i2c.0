From: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>
Subject: Re: [PATCH] i2c-ocores: add common clock support
Date: Thu, 22 Jan 2015 19:28:21 +0100
Message-ID: <87wq4e7jqy.fsf@dell.be.48ers.dk>
References: <1421230899-7843-1-git-send-email-jcmvbkbc@gmail.com>
	<20150122144522.GF3413@katana>
	<CAMo8Bf+XJY_bY+OB2i_SZQmAavwERG39BR8FVj202V-E3UidPg@mail.gmail.com>
	<20150122150717.GJ3413@katana>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150122150717.GJ3413@katana> (Wolfram Sang's message of "Thu,
	22 Jan 2015 16:07:17 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "Wolfram" == Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> writes:

 >> The clock here is not the i2c bus clock, but the clock input of the

 > Yes, what I would expect from a clk-property :)

 >> controller. The function ocores_init initializes the prescaler register of
 >> the controller so that the bus clock equals 100kHz (internal clock
 >> runs at 500kHz):

 > 'clock-frequency' usually describes the I2C bus speed. So, for ocores,
 > it describes speed of the clock for the controller? That would be
 > ouch...

Indeed :/

Looking back in the history, the device tree patch originally used a
custom "clock_khz" property until some guy told him to use
clock-frequency ;)

https://lists.ozlabs.org/pipermail/devicetree-discuss/2010-November/003650.html

As far as I can see I wasn't CC'ed on that patch.

-- 
Bye, Peter Korsgaard
