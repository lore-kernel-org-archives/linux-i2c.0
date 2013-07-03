From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v10] i2c-designware: make SDA hold time configurable
Date: Wed, 3 Jul 2013 17:26:41 +0200
Message-ID: <201307031726.42167.arnd@arndb.de>
References: <20130625163902.GA2973@katana> <20130703145918.GE3929@ab42.lan>
 <F7C43F8B2814514CA05F3436BC68046EF379F0@039-SN2MPN1-011.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <F7C43F8B2814514CA05F3436BC68046EF379F0-RL0Hj/+nBVCMXPU/2EZmt64g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Stehle Vincent-B46079 <B46079-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 03 July 2013, Stehle Vincent-B46079 wrote:
> > From: Christian Ruppert [mailto:christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org]
> (..)
> > Although this doesn't explicitly state what the function returns to me
> > this sounds more like the quotient is returned rather than the remainder?
> 
> Hi,
> 
> Yes div_u64() returns the quotient.
> 
> It is defined in linux/math64.h as:
> 
>   static inline u64 div_u64(u64 dividend, u32 divisor)
>   {
>           u32 remainder;
>           return div_u64_rem(dividend, divisor, &remainder);
>   }
> 
> The remainder is probably fully optimized out.

Ah, you are right, sorry for the confusion on my part.

I thought you had used do_div() rather than div_u64().
Everything's fine then, feel free to add my

Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

to your patch.

	Arnd
