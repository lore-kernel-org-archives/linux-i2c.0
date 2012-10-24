From: "Peter Korsgaard" <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: mux: Add dt support to i2c-mux-gpio driver
Date: Wed, 24 Oct 2012 13:45:58 +0200
Message-ID: <87objsqeix.fsf@thor.barco.com>
References: <1350910413-23925-1-git-send-email-maxime.ripard@free-electrons.com><1350910413-23925-2-git-send-email-maxime.ripard@free-electrons.com><87liexrmoz.fsf@thor.barco.com> <5087A8E5.8050103@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <5087A8E5.8050103-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> (Maxime Ripard's message of"Wed, 24 Oct 2012 10:37:57 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, brian-ZKiFAVwZFM2FeswfMrDH8w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "MR" == Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> writes:

Hi,

MR> +* Standard I2C mux properties. See mux.txt in this directory.
MR> +* I2C child bus nodes. See mux.txt in this directory.
MR> +
MR> +Optional properties:
MR> +- idle-state: value to set to the muxer when idle. When no value is
>> 
>> How about 'bitmask defining mux state when idle' instead?

MR> Since the array documented as using the bitmasks in the platform_data
MR> and described as an array of bitmasks is called "values", and the file
MR> mux.txt talks about "numbers" to put into reg, won't this be confusing
MR> to have three names for the exact same thing?

Yeah, the mess is less than perfect. To my defense I did use bitmask in
the platform data documentation:

@values: Array of bitmasks of GPIO settings (low/high) for each position
@idle: Bitmask to write to MUX when idle or GPIO_I2CMUX_NO_IDLE if not used

But ok, I don't feel strongly about it.


>> Why this change? I don't see why it is needed and the patch would be a
>> lot easier to review without all the s/.data/->data/ noise.

MR> Ah yes, since mux is already allocated using kcalloc, we don't need to
MR> do it for data as well. I will remove it.

Ok, great.

-- 
Sorry about disclaimer - It's out of my control.
Bye, Peter Korsgaard


DISCLAIMER:
Unless indicated otherwise, the information contained in this message is privileged and confidential, and is intended only for the use of the addressee(s) named above and others who have been specifically authorized to receive it. If you are not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this message and/or attachments is strictly prohibited. The company accepts no liability for any damage caused by any virus transmitted by this email. Furthermore, the company does not warrant a proper and complete transmission of this information, nor does it accept liability for any delays. If you have received this message in error, please contact the sender and delete the message. Thank you.
