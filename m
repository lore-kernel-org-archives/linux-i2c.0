From: Yegor Yefremov <yegor_sub1-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org>
Subject: Re: [PATCH] fix i2c_pca_pf_waitforcompletion() return value
Date: Tue, 21 Sep 2010 15:59:45 +0200
Message-ID: <4C98BA51.3000209@visionsystems.de>
References: <4C9725F8.1080200@visionsystems.de> <20100921054150.GA29281@pengutronix.de>
Reply-To: yegor_sub1-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100921054150.GA29281-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


> Thanks for reporting. In deed, this needs to be corrected. However, I think we
> should clean up the code some more and get rid of the initialization of ret
> altogether (and hopefully make it more readable with this). Do you have time
> for this, otherwise I'll have a look later.
>

This is a fix of a problem discussed in this thread http://www.spinics.net/lists/linux-i2c/msg02861.html.

Best regards,
Yegor
