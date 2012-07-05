From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH] i2c i.MX: Fix divider table
Date: Thu, 5 Jul 2012 17:23:47 +0300
Message-ID: <20120705142347.GF2093@sapphire.tkos.co.il>
References: <1341493826-13861-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1341493826-13861-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org, kernel@pengutronix.de, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org

Hi Sascha,

On Thu, Jul 05, 2012 at 03:10:26PM +0200, Sascha Hauer wrote:
> + * These values (mostly) do not match the ones in the datasheet because
> + * measurements have shown that the values are wrong. This was tested
> + * on i.MX1 and i.MX53, so it shoud be safe to assume that the SoCs in

s/shoud/should/

> + * between behave the same.
>   */

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
