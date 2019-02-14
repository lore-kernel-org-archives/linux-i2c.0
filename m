From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 6/8] dt-bindings: i2c: iproc: add "brcm, iproc-nic-i2c"
 compatible string
Date: Thu, 14 Feb 2019 16:26:21 -0600
Message-ID: <CAL_JsqJ2sFc=K5tezmdcjLT9v7_5QFZ1F-azMdsXyjf=t7Zycw@mail.gmail.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-7-ray.jui@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190214175725.60462-7-ray.jui@broadcom.com>
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

On Thu, Feb 14, 2019 at 11:58 AM Ray Jui <ray.jui@broadcom.com> wrote:
>
> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>
> Update iProc I2C binding document to add new compatible string
> "brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
> also added that allows configuration of the host view into the APE's
> address for "brcm,iproc-nic-i2c"
>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
