From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: Let i2c_parent_is_i2c_adapter return the parent
 adapter
Date: Mon, 23 Aug 2010 13:24:54 +0200
Message-ID: <4C725A86.204@gmx.de>
References: <20100823125354.38563c3d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100823125354.38563c3d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare said the following:
> This makes the calling site's code clearer IMHO.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
> ---
> Michael, what do you think? Admittedly this makes the code (very)
> slightly larger, but think the improvement in code clarity justifies it.

Well, at least it overcomes these awful 80 char break adjustments ...

ACK

-- 
KR
Michael
