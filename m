From: Paulius Zaleckas <paulius.zaleckas-Ft0m5Q12RQ9xBelEqimL3w@public.gmane.org>
Subject: Re: [PATCH] i2c: Let new-style drivers implement attach_adapter
Date: Wed, 15 Apr 2009 09:57:29 +0300
Message-ID: <49E58559.2000505@teltonika.lt>
References: <20090410155103.3cbdaf1e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090410155103.3cbdaf1e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <public-khali-PUYAD+kWke1g9hUCZPvPmw-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>
Cc: Linux I2C <public-linux-i2c-u79uwXL29TY76Z2rM5mHXA-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>, David Brownell <public-dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>, Johannes Berg <public-johannes-cdvu00un1VgdHxzADdlk8Q-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



Jean Delvare wrote:
> While it isn't the way the standard device binding model works, it is
> OK for new-style drivers to implement attach_adapter. It may help
> convert the renaming legacy drivers to new style drivers faster.

s/renaming/remaining

> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
> Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
