From: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>
Subject: Re: [PATCH 09/16] i2c: i2c-ocores: Drop class based scanning to improve bootup time
Date: Thu, 10 Jul 2014 16:32:21 +0200
Message-ID: <874mypp9my.fsf@dell.be.48ers.dk>
References: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
	<1404992799-3705-10-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1404992799-3705-10-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> (Wolfram
	Sang's message of "Thu, 10 Jul 2014 13:46:29 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Wolfram" == Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> writes:

 > This driver has been flagged to drop class based instantiation. The removal
 > improves boot-up time and is unneeded for embedded controllers. Users have been
 > warned to switch for some time now, so we can actually do the removal. Keep the
 > DEPRECATED flag, so the core can inform users that the behaviour finally
 > changed now. After another transition period, this flag can go, too.
 > While we are here, remove the indentation for the array setup because
 > such things always break after some time.

 > Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Acked-by: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>

-- 
Bye, Peter Korsgaard
