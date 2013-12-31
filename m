From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: Openblocks AX3-4 i2c bus lockup
Date: Tue, 31 Dec 2013 17:13:57 +0100
Message-ID: <20131231171357.2b23febf@skate>
References: <20131221164151.GF20115@lunn.ch>
	<CADx9zJDbzUmgHCRn9K=8m_d_uiSAYoW3y_NVfLFiDq4WzS3C0A@mail.gmail.com>
	<52C2A5C8.7040201@free-electrons.com>
	<52C2B889.4030903@free-electrons.com>
	<52C2BD9A.9080303@gmail.com>
	<20131231133333.GV19878@titan.lakedaemon.net>
	<52C2D36C.8020905@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52C2D36C.8020905-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Gregory CLEMENT,

On Tue, 31 Dec 2013 15:23:40 +0100, Gregory CLEMENT wrote:

> My plan is:
> 
> First introducing a new compatible string and handle it in the driver.
> Theses patches will be simple and small enough to be applied on the
> current rc kernel and the stable kernels. I will also add a new dts
> file: armada-xp-a0-openblocks-ax3-4.dts (and maybe introduce adding
> also a armada-xp-common-openblocks-ax3-4.dtsi file). A0 SoCs are no
> more shipped, that's why I try to provide a solution which uses the B0
> SoC by default and which makes the A0 the exception.

I personally don't think it's worth spending time on doing a separate
DT for this, and that we should go directly to the solution that
runtime detects the SoC revision instead.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
