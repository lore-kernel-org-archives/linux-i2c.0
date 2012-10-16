From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH v3 2/2] i2c: change id to let i2c-at91 work
Date: Tue, 16 Oct 2012 10:39:54 +0200
Message-ID: <20121016083954.GB12801@game.jcrosoft.org>
References: <1350293428-24551-1-git-send-email-voice.shen@atmel.com>
 <1350293428-24551-3-git-send-email-voice.shen@atmel.com>
 <20121015150244.GZ12801@game.jcrosoft.org>
 <507CD0CA.9010006@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <507CD0CA.9010006@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bo Shen <voice.shen@atmel.com>
Cc: broonie@opensource.wolfsonmicro.com, swarren@wwwdotorg.org, devicetree-discuss@lists.ozlabs.org, n.voss@weinmann.de, nicolas.ferre@atmel.com, w.sang@pengutronix.de, linux-i2c@vger.kernel.org, khali@linux-fr.org, manabian@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On 11:13 Tue 16 Oct     , Bo Shen wrote:
> Hi J,
> 
> On 10/15/2012 23:02, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >On 17:30 Mon 15 Oct     , Bo Shen wrote:
> >>The i2c core driver will turn the platform device ID to busnum
> >>When using platfrom device ID as -1, it means dynamically assigned
> >>the busnum. When writing code, we need to make sure the busnum,
> >>and call i2c_register_board_info(int busnum, ...) to register device
> >>if using -1, we do not know the value of busnum
> >>	
> >>In order to solve this issue, set the platform device ID as a fix number
> >>Here using 0 to match the busnum used in i2c_regsiter_board_info()
> >>
> >>Signed-off-by: Bo Shen <voice.shen@atmel.com>
> >>---
> >
> >can you check when this append for the first time to schedule a patch for stable too
> 
> OK. I will resend it and add linux stable into the cc list.
no this not how it work

I ask you to check which patch add the regression and then when this is
applied in the kernel we will request greg to apply it too to the stable

But before do that you MUST foudn the commit responsible

Best Regards,
J.
