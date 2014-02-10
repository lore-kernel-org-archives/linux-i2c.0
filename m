From: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>
Subject: Re: [PATCH 11/17] i2c: i2c-ocores: deprecate class based instantiation
Date: Mon, 10 Feb 2014 11:14:47 +0100
Message-ID: <8738jr1dgo.fsf@dell.be.48ers.dk>
References: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
	<1392026654-5343-12-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392026654-5343-12-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> (Wolfram
	Sang's message of "Mon, 10 Feb 2014 11:04:05 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Wolfram" == Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> writes:

 > Warn users that class based instantiation is going away soon in favour
 > of more robust probing and faster bootup times.

 > Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
 > Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
 > ---

 > This patch is a suggestion. Looking for an ack by someone who actually uses
 > the driver.

It's been some time since I last used it, but I never needed the class
based probing, so:

Acked-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>

-- 
Bye, Peter Korsgaard
