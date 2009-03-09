From: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] i2c: Document the different ways to instantiate i2c devices
Date: Mon, 09 Mar 2009 15:17:00 +0100
Message-ID: <gp38cs$a2i$2@ger.gmane.org>
References: <20090309114520.4e520246@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090309114520.4e520246-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare said the following:
> On popular demand, here comes some documentation about how to
> instantiate i2c devices in the new (standard) i2c device driver
> binding model.
> 
> I have also clarified how the class bitfield lets driver authors
> control which buses are probed in the auto-detect case, and warned
> more loudly against the abuse of this method.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
> Cc: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>

Reads fine,

Acked-by: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
