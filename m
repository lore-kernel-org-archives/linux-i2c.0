From: "Voss, Nikolaus" <N.Voss@weinmann.de>
Subject: RE: [PATCH 1/5] i2c: at91: add new fixes for some TWI ip versions
Date: Wed, 22 Aug 2012 08:55:15 +0200
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D090EBE8856@wm021.weinmann.com>
References: <1345559345-13988-1-git-send-email-ludovic.desroches@atmel.com>
 <1345559345-13988-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1345559345-13988-2-git-send-email-ludovic.desroches@atmel.com>
Content-Language: de-DE
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "'ludovic.desroches@atmel.com'" <ludovic.desroches@atmel.com>, "'linux-i2c@vger.kernel.org'" <linux-i2c@vger.kernel.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>
Cc: "'plagnioj@jcrosoft.com'" <plagnioj@jcrosoft.com>, "'nicolas.ferre@atmel.com'" <nicolas.ferre@atmel.com>
List-Id: linux-i2c@vger.kernel.org

Hi Ludovic,

ludovic.desroches@atmel.com wrote on Tuesday, August 21, 2012 4:29 PM
> The at91sam9261 TWI ip version requires also some fixes. The id_entry
> field from the platform device structure has been replaced by the use
> of cpu_is_xxx function to determine when to use these fixes.

I applied your calc_twi_clock() fix using the id_entry stuff instead of
cpu_is_xxx functions as those are deprecated...

I will post the complete series later on. Please test it!

Niko
