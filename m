From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: change id to let i2c-at91 work
Date: Tue, 16 Oct 2012 13:10:27 +0200
Message-ID: <20121016111027.GE12801@game.jcrosoft.org>
References: <1350293428-24551-1-git-send-email-voice.shen@atmel.com>
 <1350293428-24551-3-git-send-email-voice.shen@atmel.com>
 <20121015150244.GZ12801@game.jcrosoft.org>
 <507CD0CA.9010006@atmel.com>
 <20121016083954.GB12801@game.jcrosoft.org>
 <507D361C.6020403@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <507D361C.6020403-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
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
To: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 18:25 Tue 16 Oct     , Bo Shen wrote:
> Hi J,
> 
> On 10/16/2012 16:39, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >On 11:13 Tue 16 Oct     , Bo Shen wrote:
> >>Hi J,
> >>
> >>On 10/15/2012 23:02, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>>On 17:30 Mon 15 Oct     , Bo Shen wrote:
> >>>>The i2c core driver will turn the platform device ID to busnum
> >>>>When using platfrom device ID as -1, it means dynamically assigned
> >>>>the busnum. When writing code, we need to make sure the busnum,
> >>>>and call i2c_register_board_info(int busnum, ...) to register device
> >>>>if using -1, we do not know the value of busnum
> >>>>	
> >>>>In order to solve this issue, set the platform device ID as a fix number
> >>>>Here using 0 to match the busnum used in i2c_regsiter_board_info()
> >>>>
> >>>>Signed-off-by: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> >>>>---
> >>>
> >>>can you check when this append for the first time to schedule a patch for stable too
> >>
> >>OK. I will resend it and add linux stable into the cc list.
> >no this not how it work
> >
> >I ask you to check which patch add the regression and then when this is
> >applied in the kernel we will request greg to apply it too to the stable
> 
> The code is using id = -1 appear 4 years ago. And after dig, I don't
> find which patch cause this the regression.
so use git bisect to find the commit responsible

Best Regards,
J.
