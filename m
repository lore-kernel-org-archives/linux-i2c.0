From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH] i2c: mv64xxx: The n clockdiv factor is 0
 based on sunxi SoCs
Date: Sun, 27 Sep 2015 18:53:03 +0200
Message-ID: <20150927165303.GI31209@lunn.ch>
References: <1443365828-8956-1-git-send-email-hdegoede@redhat.com>
 <560813CF.4000807@schinagl.nl>
Reply-To: andrew-g2DYL2Zd6BY@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJNHL5JSEOBBY6BUCYAKGQENZIRLRY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <560813CF.4000807-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Cc: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Sep 27, 2015 at 06:05:35PM +0200, Olliver Schinagl wrote:
> Hey Hans,
> 
> On 27-09-15 16:57, Hans de Goede wrote:
> >According to the datasheets to n factor for dividing the tclk is
> >2 to the power n on Allwinner SoCs, not 2 to the power n + 1 as it is
> >on other mv64xxx implementations.
> Ah!

Just to be sure, i checked Kirkwood, Armada XP and Armada 370
datasheets. They all say n+1.

> >+	if (of_device_is_compatible(np, "allwinner,sun4i-a10-i2c") ||
> >+	    of_device_is_compatible(np, "allwinner,sun6i-a31-i2c"))

Rather than have to extend this list every so often, how about adding
a helper of_device_is_compatible_vendor(), so you can just have:

> >+	if (of_device_is_compatible_vendor(np, "allwinner")

  Andrew
