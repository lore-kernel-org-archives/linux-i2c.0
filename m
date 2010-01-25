From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c-mpc: add support for the MPC512x processors	from
 Freescale
Date: Mon, 25 Jan 2010 21:54:59 +0100
Message-ID: <4B5E0523.9080701@grandegger.com>
References: <1264408029-5290-1-git-send-email-wg@grandegger.com> <1264408029-5290-2-git-send-email-wg@grandegger.com> <1264408029-5290-3-git-send-email-wg@grandegger.com> <20100125115211.GA5257@pengutronix.de> <4B5D894C.4090001@grandegger.com> <20100125151509.GD5257@pengutronix.de> <4B5DE3FB.10505@grandegger.com> <20100125204833.GB9693@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100125204833.GB9693-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang wrote:
>> overkill to me. I will have a closer look, though. At a minimum I will
>> replace "-1" with "MPC_I2C_PRESERVE_CLOCK".
> 
> Might be also an idea to define it with ~0 (clock is still unsigned). If
> possible, the code checking for those two cases (0 and "-1") should be close
> together. That could be a compromise until more quirks are needed ;)

I just sent v2. Hope it's OK now.

Wolfgang.
