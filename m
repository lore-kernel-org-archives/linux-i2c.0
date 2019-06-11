From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: i2c: mv64xxx: Add YAML schemas
Date: Tue, 11 Jun 2019 09:33:42 -0600
Message-ID: <CAL_JsqLXFaDsfrzBc6dUwsuBrhWs=w2m-pXjFBdQ_sm685kf2Q@mail.gmail.com>
References: <20190611090309.7930-1-maxime.ripard@bootlin.com>
 <20190611090309.7930-2-maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190611090309.7930-2-maxime.ripard@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Gregory Clement <gregory.clement@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Linux I2C <linux-i2c@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 11, 2019 at 3:03 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Switch the DT binding to a YAML schema to enable the DT validation.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
>
> Changes from v2:
>   - Remove the copy/pasted example and use the one we had before
>
> Changes from v1:
>   - Fix the maintainers
> ---
>  .../devicetree/bindings/i2c/i2c-mv64xxx.txt   |  64 ---------
>  .../bindings/i2c/marvell,mv64xxx-i2c.yaml     | 124 ++++++++++++++++++
>  2 files changed, 124 insertions(+), 64 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
