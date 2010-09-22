From: Yegor Yefremov <yegor_sub1-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org>
Subject: Re: [PATCH v2] fix i2c_pca_pf_waitforcompletion() return value
Date: Wed, 22 Sep 2010 10:54:02 +0200
Message-ID: <4C99C42A.7080501@visionsystems.de>
References: <4C9877C3.30106@visionsystems.de> <20100921210448.GA14796@pengutronix.de>
Reply-To: yegor_sub1-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100921210448.GA14796-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

 Hello Wolfram,

> Hmm, I think I'd prefer a centralized exit point. What about this? I think it
> might be easier to read. Only compile tested, though. The final patch needs to
> be applied to the isa version, too. BTW, good debugging there, fixing this old
> issue you reported. Thanks a lot!

Everything is working as expected. I'll send the whole patch for both isa and platform flavor. I think we should then change the patch name to something like:

fix PCA waitforcompletion() return value

Best regards,
Yegor
