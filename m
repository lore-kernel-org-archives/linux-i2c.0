From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCHv3 1/6] i2c: sunxi: Add Allwinner A1X i2c driver
Date: Wed, 12 Jun 2013 10:11:06 +0200
Message-ID: <20130612081106.GA16699@lukather>
References: <1369648843-1640-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369648843-1640-2-git-send-email-maxime.ripard@free-electrons.com>
 <20130605133945.GA2934@katana>
 <20130605213144.GB14209@lukather>
 <20130611182121.GA3376@katana>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBHO24CGQKGQEWYRZMQI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20130611182121.GA3376@katana>
List-Post: <http://groups.google.com/group/linux-sunxi/post?hl=en-GB>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en-GB>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi?hl=en-GB>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Tue, Jun 11, 2013 at 08:21:22PM +0200, Wolfram Sang wrote:
> The thing is: If there is a bug/errata found in one driver, it goes
> unnoticed that it probably should be fixed in the other, too. This is
> why sharing logic is a good thing from a maintenance view.

Yes, I definitely understand that.

> Register offsets are annoying, but one can handle them. There are
> examples in the kernel tree. If some registers are totally different
> they often can be encapsulated in specific functions processing them.
> 
> So, I'd like to ask you if you can prepare a list of what would be
> needed to merge this support into mv64xxx? Then I get a better picture
> of what way to go. Can you do this?

I had some time to work on this, I sent you the patches. Except for the
register offset parts, the logic of the driver itself needed no
modifications, so the only "big" change is to pass the register
structure somehow.

Anyway, I just sent to you the patches I had.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
