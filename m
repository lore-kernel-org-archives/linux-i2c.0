From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 5/5] hwmon: (lm90) Add SMBus alert support
Date: Sat, 13 Feb 2010 18:11:55 -0800
Message-ID: <201002131811.55619.david-b@pacbell.net>
References: <20100213230438.31fd0fd7@hyperion.delvare> <20100213231116.1d3ad806@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100213231116.1d3ad806-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Saturday 13 February 2010, Jean Delvare wrote:
> At this point this is more of a proof-of-concept, we don't do anything
> terribly useful on SMBus alert: we simply log the event. But this could
> later evolve into libsensors signaling so that user-space applications
> can take an appropriate action.

Yeah, this is a case where it's a *GOOD THING* to let that
particular camel stick its nose into the tent ... ;)

Polling for alerts is kind of sub-optimal, and that's the
best that's been possible until now.

- Dave
