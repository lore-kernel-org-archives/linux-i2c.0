From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 03/13] dt-bindings: bcm2835-cprman: Add bcm2711 support
Date: Tue, 27 Aug 2019 11:00:25 -0500
Message-ID: <20190827160025.GA13142@bogus>
References: <1565713248-4906-1-git-send-email-wahrenst@gmx.net>
 <1565713248-4906-4-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1565713248-4906-4-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>, Ray Jui <rjui@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>, Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 13 Aug 2019 18:20:38 +0200, Stefan Wahren wrote:
> The new BCM2711 supports an additional clock for the emmc2 block.
> So we need an additional compatible.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Acked-by: Eric Anholt <eric@anholt.net>
> ---
>  Documentation/devicetree/bindings/clock/brcm,bcm2835-cprman.txt | 4 +++-
>  include/dt-bindings/clock/bcm2835.h                             | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
