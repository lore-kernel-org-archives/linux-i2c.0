From: Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v4 4/4] ARM: at91/dt: sama5d2: add i2c gpio pinctrl
Date: Mon, 9 Mar 2020 22:20:38 +0100
Message-ID: <20200309212038.GK3563@piout.net>
References: <20200225155012.22764-1-codrin.ciubotariu@microchip.com>
 <20200225155012.22764-4-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200225155012.22764-4-codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Codrin Ciubotariu <codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Kamel Bouhara <kamel.bouhara-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 25/02/2020 17:50:12+0200, Codrin Ciubotariu wrote:
> From: Kamel Bouhara <kamel.bouhara-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> 
> Add the i2c gpio pinctrls to support the i2c bus recovery
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> [codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org: removed gpio pull-ups]
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> Acked-by: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> ---
> 
> Changes in v4:
>  - added Acked-by tag from Ludovic;
> 
> Changes in v3:
>  - removed gpio pull-ups;
> 
> Changes in v2:
>  - new patch;
> 
>  arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts   | 33 +++++++++++++++++++--
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 33 +++++++++++++++++++--
>  2 files changed, 60 insertions(+), 6 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
