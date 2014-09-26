From: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for AMD I2C controller
Date: Fri, 26 Sep 2014 09:20:20 +0530
Message-ID: <5424E27C.2090302@synopsys.com>
References: <1411032367-20274-1-git-send-email-mika.westerberg@linux.intel.com> <1411032367-20274-2-git-send-email-mika.westerberg@linux.intel.com> <20140920093633.GG1612@katana> <20140922091207.GJ1786@lahna.fi.intel.com> <20140922122905.GA13321@ab42.lan> <C2D7FE5348E1B147BCA15975FBA230753C5DA425@IN01WEMBXA.internal.synopsys.com> <20140922140020.GB1786@lahna.fi.intel.com> <C2D7FE5348E1B147BCA15975FBA230753C5DA47D@IN01WEMBXA.internal.synopsys.com> <20140922172251.GA30685@ab42.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140922172251.GA30685-7oYq3qWSd+k@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Chrisitian,

On Monday 22 September 2014 10:53 PM, Christian Ruppert wrote:
> If there is no designware i2c in any of your platforms, simply ignore
> my message. From my point of view there is no need to move "select
> COMMON_CLK" up to the ARC architecture level.

I still ended up moving COMMON_CLK out of tb10x to arch/arc - due to consolidation
of .init_machine() callbacks - from platform to arc core.

Give linux-next a spin (perhaps later today as I just pushed a build error in that
area).

You'll like the almost empty platform file :-)

-Vineet
