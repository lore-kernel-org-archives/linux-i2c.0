From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 3/8] dt-bindings: i2c: iproc: make 'interrupts' optional
Date: Thu, 14 Feb 2019 16:25:33 -0600
Message-ID: <CAL_Jsq+W=+1=Sj8zQu_ECW9UzEiS8Oya8W_0ZQYPGemXC38qfg@mail.gmail.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-4-ray.jui@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190214175725.60462-4-ray.jui@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ray Jui <ray.jui@broadcom.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, Linux I2C <linux-i2c@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 14, 2019 at 11:57 AM Ray Jui <ray.jui@broadcom.com> wrote:
>
> Update the binding document to make the 'interrupts' property optional.
> For certain revisions of the I2C controller (e.g., iProc NIC I2C), I2C
> interrupt is unwired to the interrupt controller. In such case, this
> 'interrupts' property should be left unspecified, and driver will fall
> back to polling mode
>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt        | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
