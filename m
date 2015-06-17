From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] i2c: busses: i2c-bcm2835: S-Register clear reserved bits
Date: Tue, 16 Jun 2015 19:34:36 -0600
Message-ID: <5580CEAC.6070109@wwwdotorg.org>
References: <1434469259-6474-1-git-send-email-linux_wi@tinag.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434469259-6474-1-git-send-email-linux_wi-ADq4ffItWIY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 06/16/2015 09:40 AM, Silvan Wicki wrote:
> The Datasheet mentions on page 31 that the bits 10-31 must be read as
> don't care and written as 0.
> https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
> 
> We cannot guarantee that we reed bits 10-31 as always 0 (becuase the
> datasheet says read as don't care). We clear the bits with a bitmask to
> prevent writing back unknown data at the reserved bits.

I guess that's true.
Acked-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
