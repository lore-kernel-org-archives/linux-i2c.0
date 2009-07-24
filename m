From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH] i2c-s3c2410: s3c24xx_i2c_init: don't clobber IICLC value
Date: Fri, 24 Jul 2009 10:33:51 +0200
Message-ID: <87ljmewkcw.fsf@macbook.be.48ers.dk>
References: <1247862817-17106-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1247862817-17106-1-git-send-email-jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org> (Peter Korsgaard's message of "Fri\, 17 Jul 2009 22\:33\:37 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Peter" == Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org> writes:

 Peter> s3c24xx_i2c_init() was overwriting the IICLC value set just
 Peter> above in s3c24xx_i2c_clockrate() with zero, effectively
 Peter> disabling the platform line control setting.

ping?

-- 
Bye, Peter Korsgaard
