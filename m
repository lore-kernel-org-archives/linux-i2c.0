From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 2/3] i2c: davinci: Add PM Runtime Support
Date: Mon, 21 Aug 2017 14:39:56 +0530
Message-ID: <3996b44e-68cd-0a19-c685-64f6345cdf88@ti.com>
References: <20170816221715.15027-1-fcooper@ti.com>
 <20170816221715.15027-3-fcooper@ti.com>
 <20170817162427.izbfsa7xatjxb2aw@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170817162427.izbfsa7xatjxb2aw@ninjato>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>, Franklin S Cooper Jr <fcooper@ti.com>
Cc: devicetree@vger.kernel.org, grygorii.strashko@ti.com, vigneshr@ti.com, Kevin Hilman <khilman@baylibre.com>, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thursday 17 August 2017 09:54 PM, Wolfram Sang wrote:
> On Wed, Aug 16, 2017 at 05:17:14PM -0500, Franklin S Cooper Jr wrote:
>> 66AK2G has I2C instances that are not apart of the ALWAYS_ON power domain
>> like other Keystone 2 SoCs and OMAPL138. Therefore, pm_runtime
>> is required to insure the power domain used by the specific I2C instance is
>> properly turned on along with its functional clock.
>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> 
> I'd need a review from the driver maintainers here. Which are Sekhar
> Nori and Kevin Hilman(?) according to MAINTAINERS. Is that still
> correct?

I just finished the review (sent the comments). Thanks for the reminder!

Also, tested the patches using i2cdetect and suspend/resume on OMAP-L138
LCDK board.

Regards,
Sekhar
